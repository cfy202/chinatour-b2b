/**
 * 
 */
package com.chinatour.controller.admin;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.AccountRecord;
import com.chinatour.entity.AccountRecordExcle;
import com.chinatour.entity.AcountRecordDetailExcel;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AdminRegion;
import com.chinatour.entity.CurrencyType;
import com.chinatour.entity.Dept;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.InvoiceAndCreditExcle;
import com.chinatour.entity.InvoiceAndCreditItems;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.Region;
import com.chinatour.entity.RegionDeptRel;
import com.chinatour.entity.StasticAccount;
import com.chinatour.entity.Tour;
import com.chinatour.service.AdminRegionService;
import com.chinatour.service.AdminService;
import com.chinatour.service.CurrencyTypeService;
//import com.chinatour.service.DataFactoryService;
import com.chinatour.service.DeptService;
import com.chinatour.service.InvoiceAndCreditItemsService;
import com.chinatour.service.InvoiceAndCreditService;
import com.chinatour.service.RateOfCurrencyService;
import com.chinatour.service.RegionService;
import com.chinatour.service.TourService;
import com.chinatour.util.UUIDGenerator;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;



/**
 * 财务
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-8 下午5:08:42
 * @revision  3.0
 */
@Controller
@RequestMapping("/admin/invoiceAndCredit")
public class InvoiceAndCreditController extends BaseController {
	
	public static final TemplateHashModel CONSTANT;
	
	static {
		TemplateHashModel constant = null;
		try {
			constant = BeansWrapper.getDefaultInstance().getStaticModels();
			constant = (TemplateHashModel)constant.get("com.chinatour.Constant");
		} catch (TemplateModelException e) {
			e.printStackTrace();
		}
		CONSTANT = constant;
	}
	
	
	@Resource(name = "invoiceAndCreditServiceImpl")
	private InvoiceAndCreditService invoiceAndCreditService;
	@Resource(name="deptServiceImpl")
	private DeptService deptService;
	@Resource(name="adminServiceImpl")
	private AdminService adminService;
	@Resource(name="rateOfCurrencyServiceImpl")
	private RateOfCurrencyService rateOfCurrencyService;
	@Resource(name="tourServiceImpl")
	private TourService tourService;
	@Resource(name = "invoiceAndCreditItemsServiceImpl")
	private InvoiceAndCreditItemsService invoiceAndCreditItemsService;
	@Resource(name = "adminRegionServiceImpl")
	private AdminRegionService adminRegionService;
	@Resource(name = "regionServiceImpl")
	private RegionService regionService;
	@Resource(name = "currencyTypeServiceImpl")
	private CurrencyTypeService currencyTypeService;
	/*@Autowired
	private DataFactoryService dataFactoryService;*/
	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/account";
	/**
	 * 对账功能列表
	 * */
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String list(Model model) {
		Admin admin = adminService.getCurrent();
		Dept dept = deptService.findById(admin.getDeptId());
		//查询其他部门未审核对账
		InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
		invoiceAndCredit.setBillToDeptId(dept.getDeptId());
		/*List<InvoiceAndCredit> otherinvoiveAndCredit =  .find(invoiceAndCredit);
		List<InvoiceAndCredit> InvoiceAndCreditForDis = new ArrayList<InvoiceAndCredit>();
		for(InvoiceAndCredit InvoiceAndCredit:otherinvoiveAndCredit){
			if(InvoiceAndCredit.getConfirmStatus().equals("NEW")||InvoiceAndCredit.getConfirmStatus().equals("NEWAUTO")){
				InvoiceAndCreditForDis.add(InvoiceAndCredit);
			}invoiceAndCreditService
		}*/
		int othercount=invoiceAndCreditService.findCount(invoiceAndCredit);
		//查询本部门未审核对账
		InvoiceAndCredit invoiceAndCredit1 = new InvoiceAndCredit();
		invoiceAndCredit1.setDeptId(admin.getDeptId());
		/*List<InvoiceAndCredit> invoiveAndCreditList =  invoiceAndCreditService.find(invoiceAndCredit1);
		List<InvoiceAndCredit> disInvoiceAndCreditForSelf = new ArrayList<InvoiceAndCredit>();
		for(InvoiceAndCredit InvoiceAndCredit:invoiveAndCreditList){
			if(InvoiceAndCredit.getConfirmStatus().equals("NEW")||InvoiceAndCredit.getConfirmStatus().equals("NEWAUTO")){
				disInvoiceAndCreditForSelf.add(InvoiceAndCredit);
			}
		}*/ 
		int selfcount=invoiceAndCreditService.findCount(invoiceAndCredit1);
		CurrencyType currency = currencyTypeService.findById(dept.getCurrencyTypeId());
		model.addAttribute("menuId", "506");
		model.addAttribute("dept", dept);
		model.addAttribute("currency", currency);
		model.addAttribute("disapproveForMount", Integer.toString(othercount));
		model.addAttribute("disapproveForMountForSelf", Integer.toString(selfcount));
		return BaseTemplateURL + "/invoiceAndCreditList";
	}

	/**
	 * 查找本部门账目
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, InvoiceAndCredit invoiceAndCredit,Model model) {
		Admin admin=adminService.getCurrent();
		Map<String, Object> map = new HashMap<String, Object>();
		invoiceAndCredit.setDeptId(admin.getDeptId());
		Page<InvoiceAndCredit> page = invoiceAndCreditService.findPage(invoiceAndCredit,pageable);
		for(int i=0;i<page.getContent().size();i++){
			SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM");
			String date=dateFormat.format(page.getContent().get(i).getMonth());
			Date dateConvert = null;
			try {
				dateConvert = dateFormat.parse(date);
				page.getContent().get(i).setMonth(dateConvert);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		if(page.getContent().size()>0){
			InvoiceAndCredit ic = invoiceAndCreditService.querySum(invoiceAndCredit);
			page.getContent().add(ic);
		}
		Dept dept=deptService.findById(admin.getDeptId());
		map.put("deptId", dept.getId());
		map.put("deptName", dept.getDeptName());
		return map;
	}
	/**
	 * 跳转添加页面
	 * */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model){
		Admin admin = adminService.getCurrent();
		Dept dept = deptService.findById(admin.getDeptId());
		//查出除本部门以外的所有部门
		List<Dept> depts = deptService.findAll();
		depts.remove(dept);
		model.addAttribute("otherDepts", depts);
		//查找出最大业务编码
		model.addAttribute("businessNoMax",invoiceAndCreditService.getBusinessNo(admin.getDeptId()));
		//model.addAttribute("tour",tourService.findAll());
		model.addAttribute("menuId", "506");
		model.addAttribute("deptId", admin.getDeptId());
		return BaseTemplateURL + "/addInvoiceAndCredit";
	}
	/**
	 * 保存对账信息
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public String save(InvoiceAndCredit invoiceAndCredit) throws ParseException{
		Admin admin = adminService.getCurrent();
		invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
		invoiceAndCredit.setDeptId(admin.getDeptId());
		/*String a=invoiceAndCredit.getMonth().replaceAll("\\-", "");*/
		/*SimpleDateFormat simpleDateFormat=new SimpleDateFormat("EEE MMM z yyy");
		String month=simpleDateFormat.format(invoiceAndCredit.getMonth());*/
		if(invoiceAndCredit.getIfBeginningValue()==3){//调账数据库值和添加一样
			invoiceAndCredit.setIfBeginningValue(1);
		}
		//修改数据（保留两位小数）
		BigDecimal entryCurreny = invoiceAndCredit.getEnterCurrency();
		BigDecimal dollar = invoiceAndCredit.getDollar();
		invoiceAndCredit.setEnterCurrency(entryCurreny.setScale(2,BigDecimal.ROUND_HALF_UP));
		invoiceAndCredit.setDollar(dollar.setScale(2,BigDecimal.ROUND_HALF_UP));
		invoiceAndCredit.setCreateDate(new Date());
		Tour tour =new Tour();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
		tour.setTourCode(invoiceAndCredit.getTourCode());
		tour=tourService.findByTourCode(tour.getTourCode());
		if(tour!=null){
			invoiceAndCredit.setTourId(tour.getTourId());
		}
		invoiceAndCredit.setConfirmStatus("NEW");
		invoiceAndCredit.setIsAuto(0);
		invoiceAndCredit.setPrefix(deptService.findById(admin.getDeptId()).getDeptName());
		invoiceAndCredit.setBillToReceiver(deptService.findById(invoiceAndCredit.getBillToDeptId()).getDeptName());
		invoiceAndCreditService.save(invoiceAndCredit);
		return "redirect:list.jhtml";
		
	}
	/**
	 * 修改跳转
	 * */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public String edit(Model model,String id){
		Admin admin=adminService.getCurrent();
		InvoiceAndCredit invoiceAndCredit=new InvoiceAndCredit();
		invoiceAndCredit=invoiceAndCreditService.findById(id);
		List<Dept> depts = deptService.findAll();
		depts.remove(deptService.findById(id));
		RateOfCurrency rateOfCurrency=new RateOfCurrency();//获取汇率
		//rateOfCurrency.setId(invoiceAndCredit.getRateOfCurrencyId());
		//rateOfCurrency=rateOfCurrencyService.getRate(rateOfCurrency);
		rateOfCurrency=rateOfCurrencyService.findById(invoiceAndCredit.getRateOfCurrencyId());
		List<InvoiceAndCreditItems> itemsList=invoiceAndCreditItemsService.queryByInvoiceAndCreditId(id);
		if(itemsList==null){
			itemsList = new ArrayList<InvoiceAndCreditItems>();
		}
		for(int i=0;i<itemsList.size();i++){
				//每个明细添加转换后的金额
			BigDecimal afterA=new BigDecimal(itemsList.get(i).getAmount().doubleValue()*rateOfCurrency.getRateUp().doubleValue()/rateOfCurrency.getRateDown().doubleValue());
			itemsList.get(i).setAfteramount(afterA.setScale(2,BigDecimal.ROUND_HALF_UP));
		}
		
		
		Dept dept=deptService.findById(admin.getDeptId());
		model.addAttribute("deptName", dept.getDeptName());
		model.addAttribute("dept",deptService.findById(invoiceAndCredit.getBillToDeptId()));
		model.addAttribute("invoiceAndCredit",invoiceAndCredit);
		model.addAttribute("listInvoiceAndCreditItems",itemsList);
		model.addAttribute("rateOfCurrency",rateOfCurrency);
		model.addAttribute("listBillDept",depts);
		model.addAttribute("menuId", "506");
		return BaseTemplateURL + "/editInvoiceAndCredit";
	}
	/**
	 * 保存修改的对账信息
	 * */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public String update(InvoiceAndCredit invoiceAndCredit){
		Tour tour =new Tour();
		tour.setTourCode(invoiceAndCredit.getTourCode());
		tour=tourService.findByTourCode(tour.getTourCode());
		if(tour!=null){
			invoiceAndCredit.setTourId(tour.getTourId());
		}
		invoiceAndCredit.setConfirmStatus("NEW");
		invoiceAndCredit.setIsAuto(0);
		invoiceAndCreditService.update(invoiceAndCredit);
		return "redirect:list.jhtml";
	}
	/**
	 * json调用汇率 
	 * */
	@RequestMapping(value="/getRate",method=RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> getRate(String toDeptId) {
		Admin  admin = adminService.getCurrent();
		Dept toDept=deptService.findById(toDeptId);				  //获取本部门id
		Dept adminDept=deptService.findById(admin.getDeptId());   //获取对方部门id
		RateOfCurrency r= new RateOfCurrency();
		r.setToCurrencyId(toDept.getCurrencyTypeId());
		r.setCurrencyId(adminDept.getCurrencyTypeId());
		r.setIsAvailable(0);
		RateOfCurrency rateOfCurrency = rateOfCurrencyService.getRate(r);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rateOfCurrencyId",rateOfCurrency.getId());
		map.put("rateUp", rateOfCurrency.getRateUp());
		map.put("rateDown", rateOfCurrency.getRateDown());
		map.put("usRate", rateOfCurrency.getUsRate());
		return map;
		
			
	}
	/**
	 * 查找其他部门对账数据
	 * @author Aries
	 * */
	@RequestMapping(value="/otherList",method=RequestMethod.GET)
	public String otherList(String deptIdFor, String elementForDataTable,Model model) {
		Admin admin=adminService.getCurrent();
		Dept dept=deptService.findById(deptIdFor);
		List<Dept> deptList=deptService.findAll();
		InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
		invoiceAndCredit.setBillToDeptId(admin.getDeptId());
		/*List<InvoiceAndCredit> otherinvoiveAndCredit =  invoiceAndCreditService.find(invoiceAndCredit);
		List<InvoiceAndCredit> InvoiceAndCreditForDis = new ArrayList<InvoiceAndCredit>();
		for(InvoiceAndCredit InvoiceAndCredit:otherinvoiveAndCredit){
			if(InvoiceAndCredit.getConfirmStatus().equals("NEW")||InvoiceAndCredit.getConfirmStatus().equals("NEWAUTO")){
				InvoiceAndCreditForDis.add(InvoiceAndCredit);
			}
		}*/
		int othercount=invoiceAndCreditService.findCount(invoiceAndCredit);
		
		for(Dept deptForDis:deptList){
			InvoiceAndCredit invoiceAndCre = new InvoiceAndCredit();
			invoiceAndCre.setBillToDeptId(admin.getDeptId());
			invoiceAndCre.setDeptId(deptForDis.getDeptId());
			/*List<InvoiceAndCredit> otherinvoiveAndCreditForOne =  invoiceAndCreditService.find(invoiceAndCre);
			List<InvoiceAndCredit> InvoiceAndCreditForDi = new ArrayList<InvoiceAndCredit>();
			for(InvoiceAndCredit InvoiceAndCredit:otherinvoiveAndCreditForOne){
				if(InvoiceAndCredit.getConfirmStatus().equals("NEW")||InvoiceAndCredit.getConfirmStatus().equals("NEWAUTO")){
					InvoiceAndCreditForDi.add(InvoiceAndCredit);
				}
			}*/
			int deptcount=invoiceAndCreditService.findCount(invoiceAndCre);
			deptForDis.setDeptForInvoiceAndCredit(Integer.toString(deptcount));
		}
		
		//查询本部门未审核对账
		InvoiceAndCredit invoiceAndCredit1 = new InvoiceAndCredit();
		invoiceAndCredit1.setDeptId(admin.getDeptId());
		/*List<InvoiceAndCredit> invoiveAndCreditList =  invoiceAndCreditService.find(invoiceAndCredit1);
		List<InvoiceAndCredit> disInvoiceAndCreditForSelf = new ArrayList<InvoiceAndCredit>();
		for(InvoiceAndCredit InvoiceAndCredit:invoiveAndCreditList){
			if(InvoiceAndCredit.getConfirmStatus().equals("NEW")||InvoiceAndCredit.getConfirmStatus().equals("NEWAUTO")){
				disInvoiceAndCreditForSelf.add(InvoiceAndCredit);
			}
		}*/
		int selfcount=invoiceAndCreditService.findCount(invoiceAndCredit1);
		model.addAttribute("menuId", "506");
		model.addAttribute("deptId", admin.getDeptId());
		model.addAttribute("elementForDataTable", elementForDataTable);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptFor", dept);
		model.addAttribute("disapproveForMount", Integer.toString(othercount));
		model.addAttribute("disapproveForMountForSelf", Integer.toString(selfcount));
		return BaseTemplateURL + "/invoiceAndCreditOtherList";
	}
	/**
	 * 查找其他部门数据
	 * @author Aries
	 * */
	@RequestMapping(value = "/otherList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> otherList(Pageable pageable, InvoiceAndCredit invoiceAndCredit,Model model,String deptId) {
		Admin admin=adminService.getCurrent();
		Map<String, Object> map = new HashMap<String, Object>();
		if(deptId!=null){//手动选取查看的部门对账数据
			invoiceAndCredit.setDeptId(deptId);
			invoiceAndCredit.setBillToDeptId(admin.getDeptId());
			Page<InvoiceAndCredit> page = invoiceAndCreditService.findPage(invoiceAndCredit,pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			if(page.getContent().size()>0){
				InvoiceAndCredit ic = invoiceAndCreditService.querySum(invoiceAndCredit);
				page.getContent().add(ic);
			}
			map.put("data", page.getContent());
			Dept dept=deptService.findById(admin.getDeptId());
			map.put("deptName", dept.getDeptName());
		}else{
			List<Dept> deptList=deptService.findAll();
			Dept deptS=deptList.get(0);//随机获取一个部门
			if(deptS.getDeptId().equals(admin.getDeptId())){
				deptS=deptList.get(1);//如果是本部门就换取其他部门
			}
			invoiceAndCredit.setDeptId(deptS.getDeptId());
			Page<InvoiceAndCredit> page = invoiceAndCreditService.findPage(invoiceAndCredit,pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			if(page.getContent().size()>0){
				InvoiceAndCredit ic = invoiceAndCreditService.querySum(invoiceAndCredit);
				page.getContent().add(ic);
			}
			map.put("data", page.getContent());
			Dept dept=deptService.findById(admin.getDeptId());
			map.put("page", pageable);
			map.put("invoiceAndCredit", invoiceAndCredit);
			map.put("deptName", dept.getDeptName());
		}
		return map;
	}
	
	/**
	 * 修改跳转
	 * */
	@RequestMapping(value="/infoById",method=RequestMethod.GET)
	public String infoById(Model model,String id){
		InvoiceAndCredit invoiceAndCredit=new InvoiceAndCredit();
		invoiceAndCredit=invoiceAndCreditService.findById(id);
		RateOfCurrency rateOfCurrency=new RateOfCurrency();//获取汇率
		rateOfCurrency=rateOfCurrencyService.findById(invoiceAndCredit.getRateOfCurrencyId());
		List<InvoiceAndCreditItems> itemsList=invoiceAndCreditItemsService.queryByInvoiceAndCreditId(id);
		if(itemsList==null){
			itemsList = new ArrayList<InvoiceAndCreditItems>();
		}
			for(int i=0;i<itemsList.size();i++){
				//每个明细添加转换后的金额
				BigDecimal afterA=new BigDecimal(itemsList.get(i).getAmount().doubleValue()*rateOfCurrency.getRateUp().doubleValue()/rateOfCurrency.getRateDown().doubleValue());
				itemsList.get(i).setAfteramount(afterA.setScale(2,BigDecimal.ROUND_HALF_UP));
			}
		
		
		Dept dept=deptService.findById(invoiceAndCredit.getDeptId());//查看的部门
		model.addAttribute("deptName", dept.getDeptName());
		model.addAttribute("dept",deptService.findById(invoiceAndCredit.getBillToDeptId()));
		model.addAttribute("invoiceAndCredit",invoiceAndCredit);
		model.addAttribute("listInvoiceAndCreditItems",itemsList);
		model.addAttribute("rateOfCurrency",rateOfCurrency);
		model.addAttribute("menuId", "506");
		return BaseTemplateURL + "/invoiceAndCreditOtherInfo";
	}
	
	/**
	 * 修改跳转
	 * */
	@RequestMapping(value="/infoByIdForAjax",method=RequestMethod.GET)
	public 
	@ResponseBody
	Map<String,Object> infoByIdForAjax(String id){
		Map<String,Object> map = new HashMap<String,Object>();
		InvoiceAndCredit invoiceAndCredit=new InvoiceAndCredit();
		invoiceAndCredit=invoiceAndCreditService.findById(id);
		RateOfCurrency rateOfCurrency=new RateOfCurrency();//获取汇率
		rateOfCurrency=rateOfCurrencyService.findById(invoiceAndCredit.getRateOfCurrencyId());
		List<InvoiceAndCreditItems> itemsList=invoiceAndCreditItemsService.queryByInvoiceAndCreditId(id);
		if(itemsList==null){
			itemsList = new ArrayList<InvoiceAndCreditItems>();
		}
			for(int i=0;i<itemsList.size();i++){
				//每个明细添加转换后的金额
				BigDecimal afterA=new BigDecimal(itemsList.get(i).getAmount().doubleValue()*rateOfCurrency.getRateUp().doubleValue()/rateOfCurrency.getRateDown().doubleValue());
				itemsList.get(i).setAfteramount(afterA.setScale(2,BigDecimal.ROUND_HALF_UP));
			}
		
		
		Dept dept=deptService.findById(invoiceAndCredit.getDeptId());//查看的部门
		map.put("deptName", dept.getDeptName());
		map.put("dept",deptService.findById(invoiceAndCredit.getBillToDeptId()));
		map.put("invoiceAndCredit",invoiceAndCredit);
		map.put("listInvoiceAndCreditItems",itemsList);
		map.put("rateOfCurrency",rateOfCurrency);
		map.put("menuId", "506");
		return map;
	}
	/**
	 * 删除对账信息
	 * @author Aries
	 * */
	@RequestMapping(value="/del",method=RequestMethod.GET)
	public String del(String invoiceAndCreditId){
		List<InvoiceAndCreditItems> items=invoiceAndCreditItemsService.queryByInvoiceAndCreditId(invoiceAndCreditId);
		if(items!=null){
			for(int i=0;i<items.size();i++){
				invoiceAndCreditItemsService.delete(items.get(i).getItemsId());
			}
		}
		invoiceAndCreditService.delete(invoiceAndCreditId);
		return "redirect:list.jhtml";
	}
	/**
	 * 删除对账信息
	 * @author Aries
	 * */
	@RequestMapping(value="/delItems",method=RequestMethod.GET)
	public String delItems(String invoiceAndCreditId,String invoiceAndCreditItemsId){
		InvoiceAndCredit invoiceAndCredit=new InvoiceAndCredit();
		invoiceAndCredit=invoiceAndCreditService.findById(invoiceAndCreditId);
		InvoiceAndCreditItems invoiceAndCreditItems=new InvoiceAndCreditItems();
		invoiceAndCreditItems=invoiceAndCreditItemsService.findById(invoiceAndCreditItemsId);
		//更改总值
		invoiceAndCredit.setEnterCurrency(new BigDecimal(invoiceAndCredit.getEnterCurrency().doubleValue()-invoiceAndCreditItems.getAmount().doubleValue()));
		invoiceAndCredit.setDollar(new BigDecimal(invoiceAndCredit.getDollar().doubleValue()-invoiceAndCreditItems.getDollarAmount().doubleValue()));
		invoiceAndCreditItemsService.delete(invoiceAndCreditItemsId);//删除明细记录
		invoiceAndCreditService.update(invoiceAndCredit);
		return "redirect:edit?id="+invoiceAndCreditId;
	}
	/**
	 * 审核（批量审核）
	 * @author Aries
	 * */
	@RequestMapping(value="/verify",method=RequestMethod.POST)
	public 
	@ResponseBody
	Map<String, Object> verify(String[] invoiceAndCreditId,String rem,String deptIdFor,String pass,Model model,RedirectAttributes redirectAttributes){
		Admin admin = adminService.getCurrent();
		Map<String, Object> map = new HashMap<String, Object>();
		String message = "approve successfully";
		List<InvoiceAndCredit> listInvoiceAndCreditTemp = new ArrayList<InvoiceAndCredit>();
		InvoiceAndCredit invoiceAndCredit=new InvoiceAndCredit();
		if(pass.equals("1")){
			pass="REJECT";
		}else{
			pass="CONFIRMSEND";
		}
		if(invoiceAndCreditId!=null){
			for(String invoiceAndCreditIds:invoiceAndCreditId){
				invoiceAndCredit=invoiceAndCreditService.findById(invoiceAndCreditIds);
				if(rem!=null){
					invoiceAndCredit.setConfirmRemarks(rem);
				}
				if (invoiceAndCredit != null) {
					if(pass.equals("CONFIRMSEND")){
						if(invoiceAndCredit.getConfirmStatus().equals("NEWAUTO")){
							invoiceAndCredit.setConfirmStatus("CONFIRMSEND");
						}else{
							invoiceAndCredit.setConfirmStatus(pass);
						}
					}else{
						invoiceAndCredit.setConfirmStatus(pass);
					}
					//invoiceAndCredit.setConfirmRemarks(invoiceAndCredit.getConfirmRemarks());
					List<InvoiceAndCreditItems> itemsList=invoiceAndCreditItemsService.queryByInvoiceAndCreditId(invoiceAndCreditIds);
					invoiceAndCredit.setListInvoiceAndCreditItems(itemsList);
					listInvoiceAndCreditTemp.add(invoiceAndCredit);
				}
				/*if(admin.getId().equals(Constant.USERFORACC[0])||admin.getId().equals(Constant.USERFORACC[1])||admin.getId().equals(Constant.USERFORACC[2])){
					InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
					invoiceAndCreditTemp.setInvoiceAndCreditId(invoiceAndCreditIds);
					invoiceAndCreditTemp.setApproveDate(new Date());
					invoiceAndCreditService.update(invoiceAndCreditTemp);
					try{
						dataFactoryService.getInvoice(invoiceAndCredit);
						message = "approve successfully,transfer successfully";
					}catch(Exception e){
						invoiceAndCreditTemp.setIsSuccess(1);
						invoiceAndCreditService.update(invoiceAndCreditTemp);
						message = "approve successfully,transfer unsuccessfully";
					}
				}else{
					InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
					invoiceAndCreditTemp.setInvoiceAndCreditId(invoiceAndCreditIds);
					invoiceAndCreditTemp.setApproveDate(new Date());
					invoiceAndCreditService.update(invoiceAndCreditTemp);
					try{
						dataFactoryService.createInvoice(invoiceAndCredit);
						message = "approve successfully,transfer successfully";
					}catch(Exception e){
						invoiceAndCreditTemp.setIsSuccess(1);
						invoiceAndCreditService.update(invoiceAndCreditTemp);
						message = "approve successfully,transfer unsuccessfully";
					}
				}*/
			}
		}
		invoiceAndCreditService.verifyMulty(listInvoiceAndCreditTemp);
		map.put("message", message);
		map.put("invoiceAndCreditList", listInvoiceAndCreditTemp);
		return map;
	}
	/**
	 * 单个审核
	 * @author Aries
	 * */
	@RequestMapping(value="/verifyDeptId",method=RequestMethod.POST)
	public 
	@ResponseBody
	Map<String,Object> verifyDeptId(String invoiceAndCreditId,String remark,String passForOnly,RedirectAttributes redirectAttributes){
		Map<String,Object> map = new HashMap<String,Object>();
		String message = "approve successfully";
		List<InvoiceAndCredit> listInvoiceAndCreditTemp = new ArrayList<InvoiceAndCredit>();
		InvoiceAndCredit invoiceAndCredit=new InvoiceAndCredit();
		if(passForOnly=="1"){
			passForOnly="REJECT";//拒绝
		}else{
			passForOnly="CONFIRMSEND";//通过
		}
		if(invoiceAndCreditId!=null){
				invoiceAndCredit=invoiceAndCreditService.findById(invoiceAndCreditId);
				if(remark!=null){
					invoiceAndCredit.setConfirmRemarks(remark);
				}
				if (invoiceAndCredit != null) {
					if(passForOnly.equals("CONFIRMSEND")){
						if(invoiceAndCredit.getConfirmStatus().equals("NEWAUTO")){
							invoiceAndCredit.setConfirmStatus("CONFIRMSEND");
						}else{
							invoiceAndCredit.setConfirmStatus(passForOnly);
						}
					}else{
						invoiceAndCredit.setConfirmStatus(passForOnly);
					}
					invoiceAndCredit.setConfirmRemarks(invoiceAndCredit.getConfirmRemarks());
					List<InvoiceAndCreditItems> itemsList=invoiceAndCreditItemsService.queryByInvoiceAndCreditId(invoiceAndCreditId);
					invoiceAndCredit.setListInvoiceAndCreditItems(itemsList);
					listInvoiceAndCreditTemp.add(invoiceAndCredit);
				}
		}
		invoiceAndCreditService.verifyMulty(listInvoiceAndCreditTemp);
		/*Admin admin = adminService.getCurrent();
		if(admin.getId().equals(Constant.USERFORACC[0])||admin.getId().equals(Constant.USERFORACC[1])||admin.getId().equals(Constant.USERFORACC[2])){
			InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
			invoiceAndCreditTemp.setInvoiceAndCreditId(invoiceAndCreditId);
			invoiceAndCreditTemp.setApproveDate(new Date());
			invoiceAndCreditService.update(invoiceAndCreditTemp);
			try{
				dataFactoryService.getInvoice(invoiceAndCredit);
				message = "approve successfully,transfer successfully";
			}catch(Exception e){
				invoiceAndCreditTemp.setIsSuccess(1);
				invoiceAndCreditService.update(invoiceAndCreditTemp);
				message = "approve successfully,transfer unsuccessfully";
			}
		}else{
			InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
			invoiceAndCreditTemp.setInvoiceAndCreditId(invoiceAndCreditId);
			invoiceAndCreditTemp.setApproveDate(new Date());
			invoiceAndCreditService.update(invoiceAndCreditTemp);
			try{
				dataFactoryService.createInvoice(invoiceAndCredit);
				message = "approve successfully,transfer successfully";
			}catch(Exception e){
				invoiceAndCreditTemp.setIsSuccess(1);
				invoiceAndCreditService.update(invoiceAndCreditTemp);
				message = "approve successfully,transfer unsuccessfully";
			}
		}*/
		map.put("message", message);
		return map;
	}
	/**
	 * 部门往来账
	 * */
	@RequestMapping(value="/accountRecordMgt",method=RequestMethod.GET)
	public String accountRecordMgt(String toDeptId,Model model) {
		Admin admin=adminService.getCurrent();
		// 查询出非本部门的其他部门列表
		Dept tempDept = new Dept();
		tempDept.setDeptId(admin.getDeptId());
		Dept dept = new Dept();
		dept = deptService.findById(admin.getDeptId());
		AccountRecord accountRecord=new AccountRecord();
		accountRecord.setDeptId(dept.getDeptId());
		List<String> years = new ArrayList<String>();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
		String currentYear = simpleDateFormat.format(new Date());
		for(int i=2013;i<=Integer.parseInt(currentYear);i++){
			years.add(Integer.toString(i));
		}
		if (accountRecord.getYear()== null
				|| accountRecord.getYear() == "") {
			accountRecord.setYear(simpleDateFormat.format(new Date()));
		}
		List<StasticAccount> listStasticAccount = invoiceAndCreditService.getStasticAccountList(accountRecord);
		model.addAttribute("listStasticAccount", listStasticAccount);
		model.addAttribute("dept", dept);
		model.addAttribute("depts", deptService.findAll());
		model.addAttribute("years",years);
		model.addAttribute("menuId", "508");
		return BaseTemplateURL + "/invoiceAndCreditDept";
	}
	/*
	 * 根据年份获取部门对账数据
	 * 
	 */
	@RequestMapping(value="/accountRecordMgtByYear",method=RequestMethod.GET)
	public 
		@ResponseBody
	Map<String,Object> accountRecordMgtByYear(String year) {
		Admin admin=adminService.getCurrent();
		Dept dept = new Dept();
		dept = deptService.findById(admin.getDeptId());
		AccountRecord accountRecord=new AccountRecord();
		accountRecord.setDeptId(dept.getDeptId());
		accountRecord.setYear(year);
		List<String> years = new ArrayList<String>();
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
		String currentYear = simpleDateFormat.format(new Date());;
		for(int i=2013;i<=Integer.parseInt(currentYear);i++){
			years.add(Integer.toString(i));
		}
		if (accountRecord.getYear()== null
				|| accountRecord.getYear() == "") {
			accountRecord.setYear(simpleDateFormat.format(new Date()));
		}
		List<StasticAccount> listStasticAccount = invoiceAndCreditService.getStasticAccountList(accountRecord);
		Map<String,Object> map = new HashMap<String,Object>();  
		map.put("listStasticAccount", listStasticAccount);
		map.put("dept", dept);
		map.put("depts", deptService.findAll());
		map.put("years",years);
		return map;
	}
	
	
	/**
	 * 全公司往来账管理
	 */
	@RequestMapping(value="/globalAccountRecordMgt",method=RequestMethod.GET)
	public String globalAccountRecordMgt(Model model) {
			Admin admin=adminService.getCurrent();
			// 查询出非本部门的其他部门列表
			Dept tempDept = new Dept();
			tempDept.setDeptId(admin.getDeptId());
			Dept dept = new Dept();
			dept = deptService.findById(admin.getDeptId());
			AccountRecord accountRecord=new AccountRecord();
			accountRecord.setDeptId(dept.getDeptId());
			List<String> years = new ArrayList<String>();
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
			String currentYear = simpleDateFormat.format(new Date());;
			for(int i=2013;i<=Integer.parseInt(currentYear);i++){
				years.add(Integer.toString(i));
			}
			if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
				accountRecord.setYear(currentYear);
			}
			List<StasticAccount> listStasticAccount = invoiceAndCreditService.getAllStasticAccountList(accountRecord);
			//查询所有部门
			List<Dept> depts = deptService.findAll();
			model.addAttribute("listStasticAccount", listStasticAccount);
			model.addAttribute("menuId", "507");
			//本部门
			model.addAttribute("dept", dept);
			//全部部门
			model.addAttribute("depts", depts);
			model.addAttribute("years",years);
			model.addAttribute("currentYear", currentYear);
			return BaseTemplateURL + "/invoiceAndCreditMgt";
	}
	
	/**
	 *  打印全公司往来账管理
	 */
	@RequestMapping(value="/printGlobalAccountRecordMgt",method=RequestMethod.POST)
	public String printGlobalAccountRecordMgt(Model model,AccountRecord accountRecord) {
		Admin admin = adminService.getCurrent();
		String userName = admin.getUsername();
		if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
			accountRecord.setYear(simpleDateFormat.format(new Date()));
		}
		List<StasticAccount> listStasticAccount = invoiceAndCreditService.getStasticAccountList(accountRecord);
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		String date = simpleDateFormat.format(new Date());
		String dept = deptService.findById(accountRecord.getDeptId()).getDeptName();
		model.addAttribute("userName", userName);
		model.addAttribute("date", date);
		model.addAttribute("dept", dept);
		model.addAttribute("years", accountRecord.getYear());
		model.addAttribute("listStasticAccount",listStasticAccount);
		return BaseTemplateURL + "/printGlobalAccountRecordMgt";
	}
	
	@RequestMapping(value="/globalAccountRecordMgtByYear",method=RequestMethod.GET)
	public@ResponseBody
	Map<String,Object> globalAccountRecordMgtByYear(String deptId, String year,Model model) {
		AccountRecord accountRecord = new AccountRecord();
		accountRecord.setDeptId(deptId);
		accountRecord.setYear(year);
		if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
				SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
				accountRecord.setYear(simpleDateFormat.format(new Date()));
			}
			List<StasticAccount> listStasticAccount = invoiceAndCreditService.getAllStasticAccountList(accountRecord);
			//查询所有部门
			List<Dept> depts = deptService.findAll();
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("listStasticAccount", listStasticAccount);
			//本部门
			map.put("dept",deptService.findById(accountRecord.getDeptId()));
			//全部部门
			map.put("depts", depts);
			return map;
	}
	
	/**
	 * 全公司往来账管理(region)
	 */
	@RequestMapping(value="/globalAccountRecordMgtForRegion",method=RequestMethod.GET)
	public String globalAccountRecordMgtForRegion(String toDeptId,Model model) {
			Admin admin=adminService.getCurrent();
			// 查询出非本部门的其他部门列表
			Dept tempDept = new Dept();
			tempDept.setDeptId(admin.getDeptId());
			Dept dept = new Dept();
			dept = deptService.findById(admin.getDeptId());
			AccountRecord accountRecord=new AccountRecord();
			accountRecord.setDeptId(dept.getDeptId());
			List<String> years = new ArrayList<String>();
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
			String currentYear = simpleDateFormat.format(new Date());;
			for(int i=2013;i<=Integer.parseInt(currentYear);i++){
				years.add(Integer.toString(i));
			}
			if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
				accountRecord.setYear(currentYear);
			}
			List<StasticAccount> listStasticAccount = invoiceAndCreditService.getAllStasticAccountList(accountRecord);
			//查询该区域下所有部门
			AdminRegion adminRegion = adminRegionService.findByAdminId(admin.getId());
			if(adminRegion==null){
				model.addAttribute("menuId", "507");
				return BaseTemplateURL + "/invoiceAndCreditMgtForRegionWithoutDept";
			}
			Region region = regionService.findRegionForDept(adminRegion.getRegionId());
			List<RegionDeptRel> regionDeptRels = region.getRegionDeptRel();
			List<Dept> depts = new ArrayList<Dept>();
				for(RegionDeptRel regionDeptRel:regionDeptRels){
					depts.add(regionDeptRel.getDept());
				}
			model.addAttribute("listStasticAccount", listStasticAccount);
			model.addAttribute("menuId", "507");
			//本部门
			model.addAttribute("dept", dept);
			//全部部门
			model.addAttribute("depts", depts);
			model.addAttribute("years",years);
			return BaseTemplateURL + "/invoiceAndCreditMgt";
	}
	
	
	@RequestMapping(value="/globalAccountRecordMgtForRegionByYear",method=RequestMethod.GET)
	public@ResponseBody
	Map<String,Object> globalAccountRecordMgtForRegionByYear(String deptId, String year,Model model) {
		Admin admin=adminService.getCurrent();
		AccountRecord accountRecord = new AccountRecord();
		accountRecord.setDeptId(deptId);
		accountRecord.setYear(year);
		if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
				SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
				accountRecord.setYear(simpleDateFormat.format(new Date()));
			}
			List<StasticAccount> listStasticAccount = invoiceAndCreditService.getAllStasticAccountList(accountRecord);
			//查询该区域下所有部门
			AdminRegion adminRegion = adminRegionService.findByAdminId(admin.getId());
			Region region = regionService.findRegionForDept(adminRegion.getRegionId());
			List<RegionDeptRel> regionDeptRels = region.getRegionDeptRel();
			List<Dept> depts = new ArrayList<Dept>();
			for(RegionDeptRel regionDeptRel:regionDeptRels){
				depts.add(regionDeptRel.getDept());
			}
			//查询所有部门
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("listStasticAccount", listStasticAccount);
			//本部门
			map.put("dept",deptService.findById(accountRecord.getDeptId()));
			//全部部门
			map.put("depts", depts);
			return map;
	}
	/**
	 * 显示往来账目明细
	 * 
	 * @return
	 */
	@RequestMapping(value="/detailAccount",method=RequestMethod.GET)
	public String showDeptDetails(String menuId,String deptId,String toDeptId ,String year,String month,Model model) {
			Dept dept = deptService.findById(deptId);
			Dept toDept = deptService.findById(toDeptId);
			AccountRecord accountRecord = new AccountRecord();
			accountRecord.setDeptId(deptId);
			accountRecord.setYear(year);
			accountRecord.setBillToDeptId(toDeptId);
			//accountRecord.setIfBeginningValue(1);
			List<String> years = new ArrayList<String>();
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
			String currentYear = simpleDateFormat.format(new Date());
			SimpleDateFormat simpleDateFormatForMonth=new SimpleDateFormat("yyyy-MM");
			String currentMonth = simpleDateFormatForMonth.format(new Date());
			if(month!=null&&month.length()!=0){
				currentMonth = month;
			}
			for(int i=2013;i<=Integer.parseInt(currentYear);i++){
				years.add(Integer.toString(i));
			}
			if (accountRecord.getYear() == null|| accountRecord.getYear() == ""||accountRecord.getYear().length()<7) {
				accountRecord.setYear(currentYear);
			}
			List<AccountRecord> listAccountRecord = invoiceAndCreditService.searchAccount(accountRecord);
			List<AccountRecord> listAccountRecordForShow = new ArrayList<AccountRecord>();
			for(AccountRecord ar:listAccountRecord){
				/*if(ar.getInvoiceAndCreditId()!=null&&ar.getInvoiceAndCreditId().length()!=0){
					String invoiceId = ar.getInvoiceAndCreditId();
					InvoiceAndCredit invoice = invoiceAndCreditService.findById(invoiceId);
					ar.setBusinessName(invoice.getPrefix());
				}*/
				if(ar.getMonth().equals(currentMonth)){
					listAccountRecordForShow.add(ar);
				}
			}
			model.addAttribute("Symbol",currencyTypeService.findById(dept.getCurrencyTypeId()).getSymbol());
			model.addAttribute("symbolTo",currencyTypeService.findById(toDept.getCurrencyTypeId()).getSymbol());
			model.addAttribute("listStasticAccount",listAccountRecord);
			model.addAttribute("listAccountRecordForShow",listAccountRecordForShow);
			model.addAttribute("dept",dept);
			model.addAttribute("toDept",toDept);
			model.addAttribute("years",years);
			model.addAttribute("menuId", menuId);
			
			return BaseTemplateURL+"/detailAccount";
	}
	
	/**
	 * 显示往来账目明细（ajax选择年份）
	 * 
	 * @return
	 */
	@RequestMapping(value="/detailAccountForYear",method=RequestMethod.GET)
	public@ResponseBody 
	Map<String,Object> showDeptDetailsForYear(String deptId,String toDeptId,String year) {
			Dept dept = deptService.findById(deptId);
			Dept toDept = deptService.findById(toDeptId);
			AccountRecord accountRecord = new AccountRecord();
			accountRecord.setDeptId(deptId);
			accountRecord.setBillToDeptId(toDeptId);
			accountRecord.setYear(year.substring(0, 4));
			if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
				SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
				accountRecord.setYear(simpleDateFormat.format(new Date()));
			}
			List<AccountRecord> listAccountRecord = invoiceAndCreditService.searchAccount(accountRecord);
			List<AccountRecord> listAccountRecordForShow = new ArrayList<AccountRecord>();
			for(AccountRecord ar:listAccountRecord){
				/*if(ar.getInvoiceAndCreditId()!=null&&ar.getInvoiceAndCreditId().length()!=0){
					String invoiceId = ar.getInvoiceAndCreditId();
					InvoiceAndCredit invoice = invoiceAndCreditService.findById(invoiceId);
					ar.setBusinessName(invoice.getPrefix());
				}*/
				if(ar.getMonth().equals(year)){
					listAccountRecordForShow.add(ar);
				}
			}
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("symbol",currencyTypeService.findById(dept.getCurrencyTypeId()).getSymbol());
			map.put("symbolTo",currencyTypeService.findById(toDept.getCurrencyTypeId()).getSymbol());
			map.put("listAccountRecordForShow",listAccountRecordForShow);
			map.put("dept",dept);
			map.put("toDept",toDept);
			return map;
	}
	
	
	
	/**
	 * 打印往来账明细
	 * @return
	 */
	/*@RequestMapping(value="/detailAccountPrint",method=RequestMethod.POST)
	public String printDeptDetails(AccountRecord accountRecord,Model model) {
		Dept dept = deptService.findById(accountRecord.getDeptId());
		Dept toDept = deptService.findById(accountRecord.getBillToDeptId());
		accountRecord.setIfBeginningValue(1);
		accountRecord.setYear(accountRecord.getYear());
		
		List<AccountRecord> listAccountRecord = invoiceAndCreditService.searchAccount(accountRecord);
			if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
				SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
				accountRecord.setYear(simpleDateFormat.format(new Date()));
			}
			model.addAttribute("Symbol",currencyTypeService.findById(dept.getCurrencyTypeId()).getSymbol());
			model.addAttribute("listStasticAccount",listAccountRecord);
			model.addAttribute("dept",dept);
			model.addAttribute("toDept",toDept);
			model.addAttribute("user",adminService.getCurrent());
			model.addAttribute("menuId", "507");
			return BaseTemplateURL+"/detailAccountPrint";
	}*/
	
	/**
	 * export往来账为excle
	 * @return
	 */
	@RequestMapping(value="/jxlExcelForIcm",method=RequestMethod.POST)  
    public ModelAndView jxlExcelForIcm(AccountRecord accountRecord,HttpServletRequest request, HttpServletResponse response) {       
		//AccountRecord accountRecord=new AccountRecord();
		//accountRecord.setDeptId(deptId);
		if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
			accountRecord.setYear(simpleDateFormat.format(new Date()));
		}
		List<StasticAccount> listStasticAccount = invoiceAndCreditService.getStasticAccountList(accountRecord);
		AccountRecordExcle excle = new AccountRecordExcle();
		excle.setAccs(listStasticAccount);
		return new ModelAndView(excle);  
    }  
	
	
	/**
	 * export对账(本部门)excle
	 * @return
	 */
	@RequestMapping(value="/jxlExcelForIc",method=RequestMethod.POST)  
    public ModelAndView jxlExcelForIc(InvoiceAndCredit invoiceAndCredit,HttpServletRequest request, HttpServletResponse response) {
		Admin admin = adminService.getCurrent();
		invoiceAndCredit.setDeptId(admin.getDeptId());
		List<InvoiceAndCredit> listInvoiceAndCredit = invoiceAndCreditService.find(invoiceAndCredit);
		InvoiceAndCredit invoiceAndCreditSum = invoiceAndCreditService.querySum(invoiceAndCredit);
		InvoiceAndCreditExcle excle = new InvoiceAndCreditExcle();
		excle.setInvoiceAndCredits(listInvoiceAndCredit);
		excle.setInvoiceAndCreditSum(invoiceAndCreditSum);
		return new ModelAndView(excle);  
    }
	
	/**
	 * 打印本部门对账
	 */
	
	@RequestMapping(value="/printForIc",method=RequestMethod.POST)  
    public String printForIc(InvoiceAndCredit invoiceAndCredit,Model model) {
		Admin admin = adminService.getCurrent();
		invoiceAndCredit.setDeptId(admin.getDeptId());
		List<InvoiceAndCredit> listInvoiceAndCredit = invoiceAndCreditService.find(invoiceAndCredit);
		//InvoiceAndCreditExcle excle = new InvoiceAndCreditExcle();
		//excle.setInvoiceAndCredits(listInvoiceAndCredit);
		model.addAttribute("listInvoiceAndCredit",listInvoiceAndCredit);
		return BaseTemplateURL+"/printForIc";  
    }
	
	/**
	 * export对账其他部门excle
	 * @return
	 */
	@RequestMapping(value="/jxlExcelForOtherIc",method=RequestMethod.POST)  
    public ModelAndView jxlExcelForOtherIc(InvoiceAndCredit invoiceAndCredit,HttpServletRequest request, HttpServletResponse response) {
		Admin admin = adminService.getCurrent();
		invoiceAndCredit.setBillToDeptId(admin.getDeptId());
		List<InvoiceAndCredit> listInvoiceAndCredit = invoiceAndCreditService.find(invoiceAndCredit);
		InvoiceAndCredit invoiceAndCreditSum = invoiceAndCreditService.querySum(invoiceAndCredit);
		InvoiceAndCreditExcle excle = new InvoiceAndCreditExcle();
		excle.setInvoiceAndCredits(listInvoiceAndCredit);
		excle.setInvoiceAndCreditSum(invoiceAndCreditSum);
		return new ModelAndView(excle);  
    }  
	
	/**
	 * export对账其他部门excle
	 * @return
	 */
	@RequestMapping(value="/printForOtherIc",method=RequestMethod.POST)  
    public String printForOtherIc(InvoiceAndCredit invoiceAndCredit,Model model) {
		Admin admin = adminService.getCurrent();
		invoiceAndCredit.setBillToDeptId(admin.getDeptId());
		List<InvoiceAndCredit> listInvoiceAndCredit = invoiceAndCreditService.find(invoiceAndCredit);
		model.addAttribute("listInvoiceAndCredit", listInvoiceAndCredit);
		return BaseTemplateURL+"/printForOtherIc";    
    }  
	
	/**
	 * export对账明细excle
	 * @return
	 */
	@RequestMapping(value="/jxlExcelFordetailAccount",method=RequestMethod.POST)  
    public ModelAndView jxlExcelFordetailAccount(AccountRecord accountRecord,HttpServletRequest request, HttpServletResponse response) {
		String sMonth = accountRecord.getStartMonth();
		String eMonth = accountRecord.getEndMonth();
		Dept dept = deptService.findById(accountRecord.getDeptId());
		Dept toDept = deptService.findById(accountRecord.getBillToDeptId());
		Admin admin = adminService.getCurrent();
		if (accountRecord.getYear() == null|| accountRecord.getYear() == "") {
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy");
			accountRecord.setYear(simpleDateFormat.format(new Date()));
		}
		List<AccountRecord> listAccountRecord = invoiceAndCreditService.searchAccount(accountRecord);
		accountRecord.setStartMonth(sMonth);
		accountRecord.setEndMonth(eMonth);
		/*for(AccountRecord ar:listAccountRecord){
			if(ar.getInvoiceAndCreditId()!=null&&ar.getInvoiceAndCreditId().length()!=0){
				String invoiceId = ar.getInvoiceAndCreditId();
				InvoiceAndCredit invoice = invoiceAndCreditService.findById(invoiceId);
				ar.setBusinessName(invoice.getPrefix());
			}
		}*/
		AccountRecord accYearly = invoiceAndCreditService.querySumYearly(accountRecord);
		AcountRecordDetailExcel excle = new AcountRecordDetailExcel();
		excle.setAccountRecords(listAccountRecord);
		excle.setStartMonth(accountRecord.getStartMonth());
		excle.setEndMonth(accountRecord.getEndMonth());
		excle.setExcleName("accountRecordDetailInfromation.xls");
		excle.setDept(dept.getDeptName());
		excle.setTodept(toDept.getDeptName());
		excle.setExcleForDept(dept.getDeptName());
		excle.setExcleForAdmin(admin.getUsername());
		excle.setAccountRecordYearly(accYearly);
		return new ModelAndView(excle);  
    } 
	
	/**
	 * 异步查询团
	 */
	@RequestMapping(value = "/listSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelect(Tour tour) {
		List<Tour> tourList = tourService.findList(tour);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tourList", tourList);
		return map;
	}
	
	/**
	 * 打印对账明细
	 */
	@RequestMapping(value="/printForDetail",method=RequestMethod.GET)  
	public String  printForDetail(String invoiceAndCreditId,Model model){
		InvoiceAndCredit invoiceAndCredit = invoiceAndCreditService.findById(invoiceAndCreditId);
		List<InvoiceAndCreditItems> invoiceAndCreditItemsList = invoiceAndCreditItemsService.queryByInvoiceAndCreditId(invoiceAndCreditId);
		RateOfCurrency rateOfCurrency=new RateOfCurrency();//获取汇率
		rateOfCurrency=rateOfCurrencyService.findById(invoiceAndCredit.getRateOfCurrencyId());
		//List<InvoiceAndCreditItems> itemsList=invoiceAndCreditItemsService.queryByInvoiceAndCreditId(invoiceAndCreditId);
		if(invoiceAndCreditItemsList==null){
			invoiceAndCreditItemsList = new ArrayList<InvoiceAndCreditItems>();
		}
		for(int i=0;i<invoiceAndCreditItemsList.size();i++){
				//每个明细添加转换后的金额
			BigDecimal afterA=new BigDecimal(invoiceAndCreditItemsList.get(i).getAmount().doubleValue()*rateOfCurrency.getRateUp().doubleValue()/rateOfCurrency.getRateDown().doubleValue());
			invoiceAndCreditItemsList.get(i).setAfteramount(afterA.setScale(2,BigDecimal.ROUND_HALF_UP));
		}
		DecimalFormat df = new DecimalFormat("#.00");
		BigDecimal exchangeDoller = new BigDecimal(invoiceAndCredit.getEnterCurrency().doubleValue()*rateOfCurrency.getRateUp().doubleValue()/rateOfCurrency.getRateDown().doubleValue());
		String exchangeDollerString = df.format(exchangeDoller);
		model.addAttribute("invoiceAndCredit",invoiceAndCredit);
		model.addAttribute("invoiceAndCreditItemsList",invoiceAndCreditItemsList);
		model.addAttribute("rateOfCurrency",rateOfCurrency);
		model.addAttribute("exchangeDoller",exchangeDollerString);
		return BaseTemplateURL+"/printForDetail";
	}
	
	@RequestMapping(value="/queryDeptForBegVal",method=RequestMethod.GET)
	public@ResponseBody 
	Map<String,List<Dept>> queryDeptForBegVal(String deptId) {
			List<Dept> deptList = invoiceAndCreditService.queryDeptForBegVal(deptId);
			Map<String,List<Dept>> map = new HashMap<String,List<Dept>>();
			map.put("deptList",deptList);
			return map;
	}
}