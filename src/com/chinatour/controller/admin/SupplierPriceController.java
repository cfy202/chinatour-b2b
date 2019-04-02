package com.chinatour.controller.admin;

import java.math.BigDecimal;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.FileInfo.FileType;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AirticketItems;
import com.chinatour.entity.CurrencyType;
import com.chinatour.entity.Dept;
import com.chinatour.entity.EuropeCustomerFee;
import com.chinatour.entity.EuropeTourPrice;
import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.entity.HotelPriceInfo;
import com.chinatour.entity.InsurancePriceInfo;
import com.chinatour.entity.InvoiceMail;
import com.chinatour.entity.Order;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.SupPriceInfoRel;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierOfAgent;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.entity.SupplierPriceForOrderExcle;
import com.chinatour.entity.SupplierPriceInfo;
import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.entity.Tour;
import com.chinatour.service.AdminService;
import com.chinatour.service.AirticketItemsService;
import com.chinatour.service.CurrencyTypeService;
//import com.chinatour.service.DataFactoryService;
import com.chinatour.service.DeptService;
import com.chinatour.service.EuropeCustomerFeeService;
import com.chinatour.service.EuropeTourPriceService;
import com.chinatour.service.FileService;
import com.chinatour.service.FlightPriceInfoService;
import com.chinatour.service.HotelPriceInfoService;
import com.chinatour.service.InsurancePriceInfoService;
import com.chinatour.service.InvoiceAndCreditService;
import com.chinatour.service.InvoiceToPdfService;
import com.chinatour.service.OrderService;
import com.chinatour.service.PayCostRecordsService;
import com.chinatour.service.RateOfCurrencyService;
import com.chinatour.service.SendMailService;
import com.chinatour.service.SupPriceInfoRelService;
import com.chinatour.service.SupplierCheckService;
import com.chinatour.service.SupplierOfAgentService;
import com.chinatour.service.SupplierOfOrderService;
import com.chinatour.service.SupplierPriceForOrderService;
import com.chinatour.service.SupplierPriceInfoService;
import com.chinatour.service.SupplierPriceRemarkService;
import com.chinatour.service.SupplierPriceService;
import com.chinatour.service.TourService;
import com.chinatour.service.TourTypeService;
import com.chinatour.service.VenderService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.CustomerOrderVO;
import com.chinatour.vo.EuropeCustomerFeeVO;
import com.chinatour.vo.EuropeTourPriceVO;
import com.chinatour.vo.SupplierOfAgentVO;
import com.google.gson.Gson;
import com.intuit.ipp.services.DataService;

/**
 * 团账单
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:58:12
 * @revision 3.0
 */
@Controller
@RequestMapping("/admin/supplierPrice")
public class SupplierPriceController extends BaseController {

	@Resource(name = "adminServiceImpl") 
	private AdminService adminService;

	@Resource(name = "supplierPriceServiceImpl")
	private SupplierPriceService supplierPriceService;
	
	@Resource(name = "supPriceInfoRelServiceImpl")
	private SupPriceInfoRelService supPriceInfoRelService;
	
	@Resource(name = "orderServiceImpl")
	private OrderService orderService;

	@Resource(name = "supplierCheckServiceImpl")
	private SupplierCheckService supplierCheckService;
	
	@Resource(name = "supplierOfAgentServiceImpl")
	private SupplierOfAgentService supplierOfAgentService;
	
	@Resource(name = "supplierPriceInfoServiceImpl")
	private SupplierPriceInfoService supplierPriceInfoService;

	@Resource(name = "tourServiceImpl")
	private TourService tourService;
	
	@Resource(name = "supplierPriceRemarkServiceImpl")
	private SupplierPriceRemarkService supplierPriceRemarkService;
	
	@Resource(name = "rateOfCurrencyServiceImpl")
	private RateOfCurrencyService rateOfCurrencyService;
	
	@Resource(name = "deptServiceImpl")
	private DeptService deptService;
	
	@Resource(name = "currencyTypeServiceImpl")
	private CurrencyTypeService currencyTypeService;
	
	@Resource(name = "venderServiceImpl")
	private VenderService venderService;
	
	@Resource(name = "payCostRecordsServiceImpl")
	private PayCostRecordsService payCostRecordsService;
	
	@Resource(name = "invoiceAndCreditServiceImpl")
	private InvoiceAndCreditService invoiceAndCreditService;
	
	@Resource(name = "hotelPriceInfoServiceImpl")
	private HotelPriceInfoService hotelPriceInfoService;
	
	@Resource(name = "flightPriceInfoServiceImpl")
	private FlightPriceInfoService flightPriceInfoService;
	
	@Resource(name = "insurancePriceInfoServiceImpl")
	private InsurancePriceInfoService insurancePriceInfoService;
	
	@Resource(name = "supplierOfOrderServiceImpl")
	private SupplierOfOrderService supplierOfOrderService;
	
	@Resource(name = "tourTypeServiceImpl")
	private TourTypeService tourTypeService;
	
	@Resource(name = "supplierPriceForOrderServiceImpl")
	private SupplierPriceForOrderService supplierPriceForOrderService;
	
	@Resource(name = "europeTourPriceServiceImpl")
	private EuropeTourPriceService europeTourPriceService;
	
	@Resource(name = "fileServiceImpl")
	private FileService fileService;
	
	@Resource(name = "airticketItemsServiceImpl")
	private AirticketItemsService airticketItemsService;
	
	@Resource(name = "europeCustomerFeeServiceImpl")
	private EuropeCustomerFeeService europeCustomerFeeService;
	@Autowired
	private InvoiceToPdfService invoiceToPdfService;
	@Autowired
	private SendMailService sendMailService;
	/*@Autowired
	private DataFactoryService dataFactoryService;*/
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/orderInfoList", method = RequestMethod.GET)
	public String orderInfoList(ModelMap model) {
		model.addAttribute("menuId", "404");
		return "/admin/orderSupplier/orderInfoList";
	}

	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/orderInfoList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> orderInfoList(Pageable pageable, Tour tour) {
		Map<String, Object> map = new HashMap<String, Object>();
		tour.setUserId(adminService.getCurrent().getId());
		Page<Tour> page = supplierPriceService.findPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**OP Group录账单
	 * 查询所有
	 */
	@RequestMapping(value = "/orderInfoListGroup", method = RequestMethod.GET)
	public String orderInfoListGroup(ModelMap model) {
		model.addAttribute("menuId", "414");
		return "/admin/orderSupplier/orderInfoListGroup";
	}

	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/orderInfoListGroup", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> orderInfoListGroup(Pageable pageable, Tour tour) {
		Map<String, Object> map = new HashMap<String, Object>();
		tour.setUserId(adminService.getCurrent().getId());
		Page<Tour> page = supplierPriceService.findPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 跳转 酒店 ；地接 ；机票 ；保险 ；账单List
	 */
	@RequestMapping(value = "/searchSupplier", method = RequestMethod.GET)
	public String searchSupplier(ModelMap model, Tour tour, String type) {
		model.addAttribute("menuId", "404");
		model.addAttribute("tour",tour);
		SupPriceInfoRel supPriceInfoRel= new SupPriceInfoRel();
		supPriceInfoRel.setTourId(tour.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(type));
		model.addAttribute("supPriceInfoRelList",supPriceInfoRelService.find(supPriceInfoRel));
		model.addAttribute("supplierPrice",supplierPriceService.findByTourId(tour.getTourId()));
		if (type.equals("1")) {
			return "/admin/orderSupplier/orderSupplierList";
		} else if (type.equals("2")) {
			return "/admin/orderSupplier/orderHotelList";
		} else if (type.equals("3")) {
			return "/admin/orderSupplier/orderFlightList";
		} else {
			return "/admin/orderSupplier/orderInsuranceList";
		}
	}
	/**
	 * 账单审核明细
	 * 
	 * accCheck 用于判断是从那个页面跳转来
	 * 
	 */
	@RequestMapping(value = "/opTotalCheck", method = RequestMethod.GET)
	public String opTotalCheck(ModelMap model,Tour tour,String accCheck) {
		if(accCheck!=null&&accCheck.equals("502")){
			model.addAttribute("menuId", "502");
		}else{
			model.addAttribute("menuId", "404");
		}
		SupplierCheck supplierCheck=new SupplierCheck();
		supplierCheck.setTourId(tour.getTourId());
		model.addAttribute("supplierPrice",supplierPriceService.findByTourId(tour.getTourId()));
		model.addAttribute("supplierCheckList",supplierCheckService.findCheckAndTaxOfOrder(supplierCheck));
		return "/admin/orderSupplier/opCheckInfo";
	}
	
	/**
	 * 账单审核明细
	 * 
	 * accCheck 用于判断是从那个页面跳转来
	 * 
	 */
	@RequestMapping(value = "/opTotalCheckGroup", method = RequestMethod.GET)
	public String opTotalCheckGroup(ModelMap model,Tour tour,String accCheck) {
		if(accCheck!=null&&accCheck.equals("502")){
			model.addAttribute("menuId", "502");
		}else{
			model.addAttribute("menuId", "414");
		}
		SupplierCheck supplierCheck=new SupplierCheck();
		supplierCheck.setTourId(tour.getTourId());
		model.addAttribute("supplierPrice",supplierPriceService.findByTourId(tour.getTourId()));
		model.addAttribute("supplierCheckList",supplierCheckService.findCheckAndTaxOfOrder(supplierCheck));
		return "/admin/orderSupplier/opCheckInfoGroup";
	}
	/**
	 * OP总账单
	 */
	@RequestMapping(value = "/totalBillOfTour", method = RequestMethod.GET)
	public String totalBillOfTour(ModelMap model,Tour tour) {
		model.addAttribute("menuId", "404");
		SupplierPrice supplierPrice=supplierPriceService.findByTourId(tour.getTourId());	
		if (supplierPrice != null) {
			//每个Agent收入合计（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			
			//总计
			BigDecimal totalFee= new BigDecimal(0.00);
			//查找团下的Agent
			List<SupPriceInfoRel> supPriceInfoRelList=supPriceInfoRelService.findSupplierByTourId(tour.getTourId());
			for(int i=0; i<supPriceInfoRelList.size();i++){
				SupPriceInfoRel supPriceInfoRel=supPriceInfoRelList.get(i);
				List<SupplierOfAgent> supplierOfAgentList = supPriceInfoRel.getSupplierOfAgentList();
				
				//合计
				for (int j = 0; j < supplierOfAgentList.size(); j++) {
					sum=sum.add(supplierOfAgentList.get(j).getSum());
				}
				//总计
				if (supPriceInfoRel.getType() != 4) {
					totalFee=totalFee.add(sum);
				}
			}
			
			//计算agent团下的费用
			List<SupplierCheck> supplierCheckList=SumOfAgent(tour.getTourId(),supplierPrice.getSupplierPriceId());
			
			SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark(); 
			supplierPriceRemark.setTourId(tour.getTourId());
			supplierPriceRemark.setIsDel(0);
			//账单变更单页面数据
			List<SupplierPriceRemark>supplierPriceRemarkList = supplierPriceRemarkService.find(supplierPriceRemark);
			//查看账单变更单数据
			List<SupplierPriceRemark> supplierPriceRemarkCheckList = supplierPriceRemarkService.findSupplierPriceRemark(supplierPriceRemark);
			
			//本位币
			String Symbol="￥";
			Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
			if(dept!=null&&dept.getCurrencyTypeId()!=null){
				CurrencyType currencyType=currencyTypeService.findById(dept.getCurrencyTypeId());
				Symbol=currencyType.getSymbol();
			}
			model.addAttribute("Symbol", Symbol);
			//当前用户
			Admin admin=new Admin();
			admin.setId(adminService.getCurrent().getId());
			admin.setUsername(adminService.getCurrent().getUsername());
			Gson gson = new Gson();
			model.addAttribute("admin", admin);
			model.addAttribute("tour", tour);
			List<Order> ordersList=orderService.findByTourId(tour.getTourId());
			model.addAttribute("orderList", gson.toJson(ordersList));//级联选择
			model.addAttribute("orderListS", ordersList);//页面显示
			model.addAttribute("supplierPrice", supplierPrice);
			model.addAttribute("supplierCheckList", supplierCheckList);
			model.addAttribute("supPriceInfoRelList", supPriceInfoRelList);
			model.addAttribute("supplierPriceRemarkList", supplierPriceRemarkList);
			model.addAttribute("supplierPriceRemarkCheckList", supplierPriceRemarkCheckList);
		}
		
		return "/admin/orderSupplier/totalBillOfTour";
	}	
	/**
	 * OP总账单
	 */
	@RequestMapping(value = "/totalBillOfTourGroup", method = RequestMethod.GET)
	public String totalBillOfTourGroup(ModelMap model,Tour tour) {
		model.addAttribute("menuId", "414");
		SupplierPrice supplierPrice=supplierPriceService.findByTourId(tour.getTourId());	
		if (supplierPrice != null) {
			//每个Agent收入合计（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			
			//总计
			BigDecimal totalFee= new BigDecimal(0.00);
			//查找团下的Agent
			List<SupPriceInfoRel> supPriceInfoRelList=supPriceInfoRelService.findSupplierByTourId(tour.getTourId());
			for(int i=0; i<supPriceInfoRelList.size();i++){
				SupPriceInfoRel supPriceInfoRel=supPriceInfoRelList.get(i);
				List<SupplierOfAgent> supplierOfAgentList = supPriceInfoRel.getSupplierOfAgentList();
				
				//合计
				for (int j = 0; j < supplierOfAgentList.size(); j++) {
					sum=sum.add(supplierOfAgentList.get(j).getSum());
				}
				//总计
				if (supPriceInfoRel.getType() != 4) {
					totalFee=totalFee.add(sum);
				}
			}
			
			//计算agent团下的费用
			List<SupplierCheck> supplierCheckList=SumOfAgent(tour.getTourId(),supplierPrice.getSupplierPriceId());
			
			SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark(); 
			supplierPriceRemark.setTourId(tour.getTourId());
			supplierPriceRemark.setIsDel(0);
			//账单变更单页面数据
			List<SupplierPriceRemark>supplierPriceRemarkList = supplierPriceRemarkService.find(supplierPriceRemark);
			//查看账单变更单数据
			List<SupplierPriceRemark> supplierPriceRemarkCheckList = supplierPriceRemarkService.findSupplierPriceRemark(supplierPriceRemark);
			
			//本位币
			String Symbol="￥";
			Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
			if(dept!=null&&dept.getCurrencyTypeId()!=null){
				CurrencyType currencyType=currencyTypeService.findById(dept.getCurrencyTypeId());
				Symbol=currencyType.getSymbol();
			}
			model.addAttribute("Symbol", Symbol);
			//当前用户
			Admin admin=new Admin();
			admin.setId(adminService.getCurrent().getId());
			admin.setUsername(adminService.getCurrent().getUsername());
			Gson gson = new Gson();
			model.addAttribute("admin", admin);
			model.addAttribute("tour", tour);
			List<Order> ordersList=orderService.findByTourId(tour.getTourId());
			model.addAttribute("orderList", gson.toJson(ordersList));//级联选择
			model.addAttribute("orderListS", ordersList);//页面显示
			model.addAttribute("supplierPrice", supplierPrice);
			model.addAttribute("supplierCheckList", supplierCheckList);
			model.addAttribute("supPriceInfoRelList", supPriceInfoRelList);
			model.addAttribute("supplierPriceRemarkList", supplierPriceRemarkList);
			model.addAttribute("supplierPriceRemarkCheckList", supplierPriceRemarkCheckList);
		}
		
		return "/admin/orderSupplier/totalBillOfTourGroup";
	}	
	/**
	 * 删除
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(ModelMap model,SupPriceInfoRel supPriceInfoRel,Tour tour,String type) {
		supPriceInfoRel = supPriceInfoRelService.findById(supPriceInfoRel.getSupPriceInfoRelId());
		supPriceInfoRelService.deleteSupplier(supPriceInfoRel);
		model.addAttribute("tourId",tour.getTourId());
		model.addAttribute("tourCode",tour.getTourCode());
		model.addAttribute("type",type);
		return "redirect:searchSupplier.jhtml";
	}
	/**
	 * OP Group录账单
	 * @param model
	 * @param supPriceInfoRel
	 * @param tour
	 * @param type
	 * @return
	 */
	@RequestMapping(value = "/deleteGroup", method = RequestMethod.GET)
	public String deleteGroup(ModelMap model,SupPriceInfoRel supPriceInfoRel,Tour tour,String type) {
		supPriceInfoRel = supPriceInfoRelService.findById(supPriceInfoRel.getSupPriceInfoRelId());
		supPriceInfoRelService.deleteSupplier(supPriceInfoRel);
		model.addAttribute("tourId",tour.getTourId());
		model.addAttribute("tourCode",tour.getTourCode());
		model.addAttribute("type",type);
		return "redirect:searchSupplierGroup.jhtml";
	}
	
	/**
	 * op修改
	 * 修改账单完成状态
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ModelMap model,SupplierPrice supplierPrice,Tour tour,RedirectAttributes redirectAttributes) {
		tour = tourService.findById(tour.getTourId());
		if(tour==null){
			addFlashMessage(redirectAttributes, ERROR_MESSAGE);
		}
		SupplierPrice supplierPriceS = supplierPriceService.findByTourId(tour.getTourId());
		if (supplierPriceS != null) {
			supplierPriceS.setRemark(supplierPrice.getRemark());
			supplierPriceS.setSubRemark(supplierPrice.getSubRemark());
			supplierPriceS.setDayNum(supplierPrice.getDayNum());
			supplierPriceS.setNationality(supplierPrice.getNationality());
			supplierPriceS.setTourDept(supplierPrice.getTourDept());
			supplierPriceS.setAccompany(supplierPrice.getAccompany());
			supplierPriceS.setCompleteState(supplierPrice.getCompleteState());
			supplierPriceService.update(supplierPriceS);
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}
		return "redirect:orderInfoList.jhtml";
	}
	/**
	 * Op Group 录账单
	 * 修改账单完成状态
	 * @return
	 */
	@RequestMapping(value = "/updateGroup", method = RequestMethod.POST)
	public String updateGroup(ModelMap model,SupplierPrice supplierPrice,Tour tour,RedirectAttributes redirectAttributes) {
		tour = tourService.findById(tour.getTourId());
		if(tour==null){
			addFlashMessage(redirectAttributes, ERROR_MESSAGE);
		}
		SupplierPrice supplierPriceS = supplierPriceService.findByTourId(tour.getTourId());
		if (supplierPriceS != null) {
			supplierPriceS.setRemark(supplierPrice.getRemark());
			supplierPriceS.setSubRemark(supplierPrice.getSubRemark());
			supplierPriceS.setDayNum(supplierPrice.getDayNum());
			supplierPriceS.setNationality(supplierPrice.getNationality());
			supplierPriceS.setTourDept(supplierPrice.getTourDept());
			supplierPriceS.setAccompany(supplierPrice.getAccompany());
			supplierPriceS.setCompleteState(supplierPrice.getCompleteState());
			supplierPriceService.update(supplierPriceS);
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}
		return "redirect:orderInfoListGroup.jhtml";
	}
	/**
	 * 修改变更单
	 * @return
	 */
	@RequestMapping(value = "/billChange", method = RequestMethod.POST)
	public  @ResponseBody Map<String, Object>  billChange(Tour tour) {
			Map<String, Object> map = new HashMap<String, Object>();
			tour = tourService.findById(tour.getTourId());
			SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark(); 
			supplierPriceRemark.setTourId(tour.getTourId());
			supplierPriceRemark.setIsDel(0);
			//账单变更单
			List<SupplierPriceRemark>supplierPriceRemarkList = supplierPriceRemarkService.find(supplierPriceRemark);
			//团账单
			SupplierPrice supplierPrice=supplierPriceService.findByTourId(tour.getTourId());
			SupplierCheck supplierCheck=new SupplierCheck(); 
			supplierCheck.setSupplierPriceId(supplierPrice.getSupplierPriceId());
			List<SupplierCheck> supplierCheckList = supplierCheckService.findUserInfo(supplierCheck);
			map.put("supplierPriceRemarkList", supplierPriceRemarkList);
			map.put("supplierPrice", supplierPrice);
			map.put("tour",tour);
			map.put("supplierCheckList", supplierCheckList);
			return map;
	}
	/**
	 * 添加变更单
	 * @return
	 */
	@RequestMapping(value = "/saveBillChange", method = RequestMethod.POST)
	public String saveBillChange(SupplierOfAgentVO supplierOfAgentVO,Tour tour,RedirectAttributes redirectAttributes) {
		for (int i = 0; i < supplierOfAgentVO.getSupplierPriceRemarkList().size(); i++) {
			tour.setTourId(supplierOfAgentVO.getSupplierPriceRemarkList().get(i).getTourId());
			supplierOfAgentVO.getSupplierPriceRemarkList().get(i).setSprCheck(0);
		}
		supplierPriceRemarkService.saveList(supplierOfAgentVO.getSupplierPriceRemarkList());
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:totalBillOfTour.jhtml?tourId="+tour.getTourId()+"&tourCode="+tour.getTourCode()+"";
	}
	
	/**
	 * 删除变更单
	 * @return
	 */
	@RequestMapping(value = "/deleteBillChange", method = RequestMethod.POST)
	public @ResponseBody String deleteBillChange( SupplierPriceRemark supplierPriceRemark) {
		try {
			supplierPriceRemark = supplierPriceRemarkService.findById(supplierPriceRemark.getSupplierPriceRemarkId());
			supplierPriceRemark.setIsDel(1);
			supplierPriceRemark.setEidtTime(new Date());
			supplierPriceRemarkService.update(supplierPriceRemark);
		} catch (Exception e) {
			return"ERROR";
		}
		return "SUCCESS";
	}
	

	/**
	 *  会计审核，记账，本部门
	 */
	@RequestMapping(value = "/accountantTourList", method = RequestMethod.GET)
	public String accountantTourList(ModelMap model) {
		model.addAttribute("menuId", "502");
		return "/admin/finance/accountant/tourListInfo";
	}

	/**
	 * 会计审核，记账，本部门
	 * 
	 * @param pageable
	 * @param supplierPrice
	 * @return
	 */
	@RequestMapping(value = "/accountantTourList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> accountantTourList(Pageable pageable, SupplierPrice supplierPrice) {
		Map<String, Object> map = new HashMap<String, Object>();
		supplierPrice.setDeptId(adminService.getCurrent().getDeptId());
		supplierPrice.setCompleteState(1);
		Page<SupplierPrice> page = supplierPriceService.findAccPage(supplierPrice, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * Group
	 *  会计审核，记账，本部门
	 */
	@RequestMapping(value = "/accGroupTourList", method = RequestMethod.GET)
	public String accGroupTourList(ModelMap model) {
		model.addAttribute("menuId", "511");
		return "/admin/finance/accountant/groupTourListInfo";
	}

	/**
	 * Group
	 * 会计审核，记账，本部门
	 * 
	 * @param pageable
	 * @param supplierPrice
	 * @return
	 */
	@RequestMapping(value = "/accGroupTourList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> accGroupTourList(Pageable pageable, SupplierPrice supplierPrice) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		//supplierPrice.setDeptId(adminService.getCurrent().getDeptId());
		supplierPrice.setCompleteState(1);
		//默认 为0 用于初始值
		/*BigDecimal bigDecimal= new BigDecimal(0.00);
		
		SupplierPrice supplierPriceS = supplierPriceService.findSumSupplierOfTourOfAcc(supplierPrice);
		supplierPrice.setTotalPeople(supplierPriceS != null ? supplierPriceS.getTotalPeople() : 0);
		supplierPrice.setSupplierCost(supplierPriceS != null ? supplierPriceS.getSupplierCost() : bigDecimal);
		supplierPrice.setSupplierPrice(supplierPriceS != null ? supplierPriceS.getSupplierPrice() : bigDecimal);

		SupplierPrice supplierPriceSS = supplierPriceService.findBillChangeSumSupplierOfTourOfAcc(supplierPrice);
		supplierPrice.setSupplierDifPrice(supplierPriceSS != null ? supplierPriceSS.getSupplierDifPrice() : bigDecimal);
		supplierPrice.setSupplierDifCost(supplierPriceSS != null ? supplierPriceSS.getSupplierDifCost() : bigDecimal);
		*/
		String groupIdString = adminService.getCurrent().getGroupId();
		supplierPrice.setGroupId(groupIdString);
		Page<SupplierPrice> page = supplierPriceService.findForAccGroupPage(supplierPrice, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		//map.put("supplierPrice", supplierPrice);
		return map;
	}
	
	/**
	 * 计算agent团下总费用和小计
	 * @param tourId
	 * @return
	 */
	public List<SupplierCheck> SumOfAgent(String tourId,String supplierPriceId){
		SupplierCheck supplierCheck=new SupplierCheck();
		supplierCheck.setSupplierPriceId(supplierPriceId);
		List<SupplierCheck> supplierCheckList=supplierCheckService.findUserInfo(supplierCheck);

		/**
		 * agent合计
		*/
		for (int i = 0; i < supplierCheckList.size(); i++) {
			SupplierOfAgent supplierOfAgentS = new SupplierOfAgent();
			supplierOfAgentS.setTourId(tourId);
			supplierOfAgentS.setUserId(supplierCheckList.get(i).getUserIdOfAgent());
			
			//默认 为0 用于初始值
			BigDecimal bigDecimal= new BigDecimal(0.00);
			
			// 团下一个agent的小计
			BigDecimal subtotalOfAgent= new BigDecimal(0.00);
			subtotalOfAgent = supplierOfAgentService.findSumOfAgentAndTourExceptInsurance(supplierOfAgentS);
			supplierCheckList.get(i).setSubtotalOfAgent(subtotalOfAgent == null ? bigDecimal : subtotalOfAgent);

			// 团下一个agent的合计
			BigDecimal totalFeeOfAgent= new BigDecimal(0.00);
			totalFeeOfAgent = supplierOfAgentService.findSumOfAgentAndTour(supplierOfAgentS);
			supplierCheckList.get(i).setTotalFeeOfAgent(totalFeeOfAgent == null ? bigDecimal : totalFeeOfAgent);
			
			// 团下一个agent根据订单汇率的合计
			SupplierOfAgent soa = supplierOfAgentService.findSumUSARateOfAgentAndTour(supplierOfAgentS);
			supplierCheckList.get(i).setTotalRateFeeOfAgent(soa == null ? bigDecimal : soa.getSum());
			supplierCheckList.get(i).setTotalUSARateFeeOfAgent(soa == null ? bigDecimal : soa.getUsaSum());
			
			//保险总计
			BigDecimal insuranceTotalFee = new BigDecimal(0.00);
			insuranceTotalFee = supplierOfAgentService.findInsuranceTotalFeeOfAgentAndTour(supplierOfAgentS);
			supplierCheckList.get(i).setTotalFeeOfInsurance(insuranceTotalFee == null ? bigDecimal : insuranceTotalFee);
		}
		return supplierCheckList;
	}
	
	/**
	 *   跳转会计审核账单页面
	 */
	@RequestMapping(value = "/accCheckAppend", method = RequestMethod.GET)
	public String accCheckAppend(ModelMap model,Tour tour) {
		model.addAttribute("menuId", "502");
		
		// 查找制表人
		tour.setUserName(adminService.findById(tourService.findById(tour.getTourId()).getUserId()).getUsername());
		SupplierPrice supplierPrice=supplierPriceService.findByTourId(tour.getTourId());	
		if (supplierPrice != null) {
			//每个Agent收入合计（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			
			//总计
			BigDecimal totalFee= new BigDecimal(0.00);
			//查找团下的Agent
			List<SupPriceInfoRel> supPriceInfoRelList=supPriceInfoRelService.findSupplierByTourId(tour.getTourId());
			for(int i=0; i<supPriceInfoRelList.size();i++){
				SupPriceInfoRel supPriceInfoRel=supPriceInfoRelList.get(i);
				List<SupplierOfAgent> supplierOfAgentList = supPriceInfoRel.getSupplierOfAgentList();
				
				//合计
				for (int j = 0; j < supplierOfAgentList.size(); j++) {
					sum=sum.add(supplierOfAgentList.get(j).getSum());
				}
				//总计
				if (supPriceInfoRel.getType() != 4) {
					totalFee=totalFee.add(sum);
				}
			}
			
			//保存团总费用
			tour.setSumFee(totalFee);
			
			//计算agent团下的费用
			List<SupplierCheck> supplierCheckList=SumOfAgent(tour.getTourId(),supplierPrice.getSupplierPriceId());
			
			SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark(); 
			supplierPriceRemark.setTourId(tour.getTourId());
			supplierPriceRemark.setIsDel(0);
			//查看账单变更单数据
			List<SupplierPriceRemark> supplierPriceRemarkCheckList = supplierPriceRemarkService.findSupplierPriceRemark(supplierPriceRemark);
			
			//本位币
			String Symbol="￥";
			Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
			if(dept!=null&&dept.getCurrencyTypeId()!=null){
				CurrencyType currencyType=currencyTypeService.findById(dept.getCurrencyTypeId());
				Symbol=currencyType.getSymbol();
			}
			model.addAttribute("Symbol", Symbol);
			//当前用户
			Admin admin=new Admin();
			admin.setId(adminService.getCurrent().getId());
			admin.setUsername(adminService.getCurrent().getUsername());
			
			model.addAttribute("admin", admin);
			model.addAttribute("tour",tour);
			model.addAttribute("supplierPrice", supplierPrice);
			model.addAttribute("supplierCheckList", supplierCheckList);
			model.addAttribute("supPriceInfoRelList", supPriceInfoRelList);
			model.addAttribute("supplierPriceRemarkCheckList", supplierPriceRemarkCheckList);
		}
		return "/admin/finance/accountant/AccCheck";
	}
	
	/**
	 *  财务账单变更单审核
	 */
	@RequestMapping(value = "/accAuditBillChange", method = RequestMethod.POST)
	public String accAuditBillChange(SupplierOfAgentVO supplierOfAgentVO,
			RedirectAttributes redirectAttributes) {
		List<SupplierPriceRemark> supplierPriceRemarkList = supplierOfAgentVO
				.getSupplierPriceRemarkList();
		if (supplierPriceRemarkList != null&& supplierPriceRemarkList.size() > 0) {
			for (SupplierPriceRemark spr : supplierPriceRemarkList) {
				if (spr.getSupplierPriceRemarkId() != null) {
					spr = supplierPriceRemarkService.findById(spr.getSupplierPriceRemarkId());
					//判断是收入还是支出   收入设置 3   需要agent继续     支出 设置1 全部通过
					if (spr.getType()==1&&spr.getSprCheck() == 0) {
						spr.setSprCheck(3);
					}else if(spr.getType()==2&&spr.getSprCheck() == 0){
						spr.setSprCheck(1);
					}else{
						continue;
					}
					spr.setAccCheckTime(new Date());
					supplierPriceRemarkService.update(spr);
					
				}
			}
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}
		return "redirect:accountantTourList.jhtml";
	}
	
	/**
	 * 会计审核账单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/accCheck", method = RequestMethod.POST)
	public String accCheck(ModelMap model,Tour tour,SupplierPrice supplierPrice) {
			// 查找团下的Agent
			SupplierPrice supplierPriceS = supplierPriceService.findByTourId(tour.getTourId());
			if (supplierPriceS != null) {
				supplierPriceS.setCheckUserId(adminService.getCurrent().getId());
				supplierPriceS.setCheckRemark(supplierPrice.getCheckRemark());
				supplierPriceS.setAccCheck(supplierPrice.getAccCheck());
				supplierPriceS.setCheckTime(new Date());

				SupplierCheck supplierCheckS = new SupplierCheck();
				supplierCheckS.setSupplierPriceId(supplierPriceS.getSupplierPriceId());
				List<SupplierCheck> supplierCheckList = supplierCheckService.find(supplierCheckS);
				// 会计审核 如果是二次审核，账单的状态AllCheck仍未修改状态，一次审核，根据优先级排列
				supplierPriceS.setAllCheck(1);
				// 判断未审核的
				for (int i = 0; i < supplierCheckList.size(); i++) {
					if (supplierCheckList.get(i).getCheckOfAgent() == 0 || supplierPrice.getAccCheck() == 0) {
						supplierPriceS.setAllCheck(0);
						break;
					}
					
				}

				// 判断未通过的
				for (int i = 0; i < supplierCheckList.size(); i++) {
					if (supplierCheckList.get(i).getCheckOfAgent() == 2 || supplierPrice.getAccCheck() == 2) {
						supplierPriceS.setAllCheck(2);
						break;
					}
				}

				supPriceInfoRelService.updateSupplier(supplierPriceS, null, null, supplierCheckList, null, null, null, null, null,null);
			}

			model.addAttribute("tourId",tour.getTourId());
			return "redirect:accCheckAppend.jhtml";
		
	}

	/**
	 *  agnet审核，记账，本部门
	 */
	@RequestMapping(value = "/agentTourList", method = RequestMethod.GET)
	public String agentTourList(ModelMap model) {
		Admin admin = adminService.getCurrent();
		int sumForAgent = europeTourPriceService.findSumForAgent(admin.getId());
		model.addAttribute("sumForAgent", sumForAgent);
		model.addAttribute("menuId", "501");
		return "/admin/finance/accountant/tourCheckOfAgentList";
	}
	
	/**
	 * agent审核，记账，本部门
	 * 
	 * @param pageable
	 * @param supplierPrice
	 * @return
	 */
	@RequestMapping(value = "/agentTourList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agentTourList(Pageable pageable, SupplierPrice supplierPrice) {
		Map<String, Object> map = new HashMap<String, Object>();
		supplierPrice.setUserIdOfAgent(adminService.getCurrent().getId());
		Page<SupplierPrice> page=supplierPriceService.findAgentPage(supplierPrice, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 *  跳转agent审核账单页面
	 */
	@RequestMapping(value = "/agentOrderCheck", method = RequestMethod.GET)
	public String agentOrderCheck(ModelMap model,Tour tour) {
		model.addAttribute("menuId", "501");
		// 查找团下的Agentd
		SupplierPrice supplierPrice = supplierPriceService.findByTourId(tour.getTourId());
		Order order=new Order();
		order.setTourId(tour.getTourId());
		order.setUserId(adminService.getCurrent().getId());
		
		//查找团下的Agent
		List<Order> agentOfOrderList  = orderService.findUserOfOrder(order);
		
		//每个Agent收入合计（应收美国收入）
		BigDecimal sum= new BigDecimal(0.00);
		
		//查询团下agent的供应商信息		*有问题*
		List<SupPriceInfoRel> supPriceInfoRelList=supPriceInfoRelService.findSupplierByTourId(tour.getTourId());
		for(int i=0; i<supPriceInfoRelList.size();i++){
			SupPriceInfoRel supPriceInfoRel=supPriceInfoRelList.get(i);
			List<SupplierOfAgent> AgentList = supPriceInfoRel.getSupplierOfAgentList();
			
			//agent 账单 费用
			List<SupplierOfAgent> supplierOfAgentList =new ArrayList<SupplierOfAgent>();
			
			// 计算合计
			for (int j = 0; j < AgentList.size(); j++) {
				//查出当前agent的账单
				if(adminService.getCurrent().getId().equals(AgentList.get(j).getUserId())){
					supplierOfAgentList.add(AgentList.get(j));
					sum=sum.add(AgentList.get(j).getSum());
				}
			}
			supPriceInfoRel.setSum(sum);
			supPriceInfoRel.setSupplierOfAgentList(supplierOfAgentList);
		}

		// 查找汇率
		String groupId=tour.getGroupId();
		tour = tourService.findById(tour.getTourId());
		tour.setGroupId(groupId);
		Admin admin=new Admin();
		if(tour!=null){
			admin = adminService.findById(tour.getUserId());
		}
		
		
		//查询当前用户(agent)的账单记录
		SupplierCheck supplierCheckS = new SupplierCheck();
		supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
		supplierCheckS.setUserIdOfAgent(adminService.getCurrent().getId());
		List<SupplierCheck> supplierCheckList = supplierCheckService.findUserInfo(supplierCheckS);
		
		// 团下一个agent根据订单汇率的合计
		RateOfCurrency rateOfCurrency =new RateOfCurrency();
		
		//账单变更单
		SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark();
		List<SupplierPriceRemark> supplierPriceRemarkCheckList=new ArrayList<SupplierPriceRemark>();
		
		
		BigDecimal bigDecimal= new BigDecimal(0.00);
		
		// 循环计算团下一个agent的合计
		for(SupplierCheck sc : supplierCheckList){
			rateOfCurrency = rateOfCurrencyService.findById(sc.getRateOfCurrencyId());
			SupplierOfAgent supplierOfAgentS = new SupplierOfAgent();
			supplierOfAgentS.setTourId(tour.getTourId());
			supplierOfAgentS.setUserId(sc.getUserIdOfAgent());
			
			// 团下一个agent的合计
			BigDecimal totalFeeOfAgent= new BigDecimal(0.00);
			totalFeeOfAgent = supplierOfAgentService.findSumOfAgentAndTour(supplierOfAgentS);
			sc.setTotalFeeOfAgent(totalFeeOfAgent == null ? bigDecimal : totalFeeOfAgent);
			
			// 团下一个agent根据订单汇率的合计
			SupplierOfAgent soa = supplierOfAgentService.findSumUSARateOfAgentAndTour(supplierOfAgentS);
			sc.setTotalRateFeeOfAgent(soa == null ? bigDecimal : soa.getSum());
			sc.setTotalUSARateFeeOfAgent(soa == null ? bigDecimal : soa.getUsaSum());
			
			//账单变更单
			supplierPriceRemark.setSupplierCheckId(sc.getSupplierCheckId());
			supplierPriceRemark.setTourId(tour.getTourId());
			supplierPriceRemark.setIsDel(0);
			supplierPriceRemarkCheckList.addAll(supplierPriceRemarkService.findAgentTax(supplierPriceRemark));
		}
		
		if (admin != null) {
			// 数据源币种
			rateOfCurrency.setCurrencyId(currencyTypeService.findById(deptService.findById(admin.getDeptId()).getCurrencyTypeId()).getSymbol());
			// 转换当前部门币种
			rateOfCurrency.setToCurrencyId(currencyTypeService.findById(deptService.findById(adminService.getCurrent().getDeptId()).getCurrencyTypeId()).getSymbol());
		}
		
		model.addAttribute("tour",tour);
		model.addAttribute("supplierPrice",supplierPrice);
		model.addAttribute("supplierCheckList",supplierCheckList);
		model.addAttribute("rateOfCurrency",rateOfCurrency);
		model.addAttribute("supPriceInfoRelList",supPriceInfoRelList);
		model.addAttribute("agentOfOrderList",agentOfOrderList);
		model.addAttribute("supplierPriceRemarkCheckList", supplierPriceRemarkCheckList);
		return "/admin/finance/accountant/agentCheck";
	}
	
	/**
	 *  打印 agent审核账单页面
	 */
	@RequestMapping(value = "/printAgentCheck", method = RequestMethod.GET)
	public String printAgentCheck(ModelMap model,Tour tour) {
		// 查找团下的Agentd
		SupplierPrice supplierPrice = supplierPriceService.findByTourId(tour.getTourId());
		Order order=new Order();
		order.setTourId(tour.getTourId());
		order.setUserId(adminService.getCurrent().getId());
		
		//查找团下的Agent
		List<Order> agentOfOrderList  = orderService.findUserOfOrder(order);
		
		//每个Agent收入合计（应收美国收入）
		BigDecimal sum= new BigDecimal(0.00);
		
		//查询团下agent的供应商信息		*有问题*
		List<SupPriceInfoRel> supPriceInfoRelList=supPriceInfoRelService.findSupplierByTourId(tour.getTourId());
		for(int i=0; i<supPriceInfoRelList.size();i++){
			SupPriceInfoRel supPriceInfoRel=supPriceInfoRelList.get(i);
			List<SupplierOfAgent> AgentList = supPriceInfoRel.getSupplierOfAgentList();
			
			//agent 账单 费用
			List<SupplierOfAgent> supplierOfAgentList =new ArrayList<SupplierOfAgent>();
			
			// 计算合计
			for (int j = 0; j < AgentList.size(); j++) {
				//查出当前agent的账单
				if(adminService.getCurrent().getId().equals(AgentList.get(j).getUserId())){
					supplierOfAgentList.add(AgentList.get(j));
					sum=sum.add(AgentList.get(j).getSum());
				}
			}
			supPriceInfoRel.setSum(sum);
			supPriceInfoRel.setSupplierOfAgentList(supplierOfAgentList);
		}

		// 查找汇率
		tour = tourService.findById(tour.getTourId());
		Admin admin=new Admin();
		if(tour!=null){
			admin = adminService.findById(tour.getUserId());
		}
		
		
		//查询当前用户(agent)的账单记录
		SupplierCheck supplierCheckS = new SupplierCheck();
		supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
		supplierCheckS.setUserIdOfAgent(adminService.getCurrent().getId());
		List<SupplierCheck> supplierCheckList = supplierCheckService.findUserInfo(supplierCheckS);
		
		// 团下一个agent根据订单汇率的合计
		RateOfCurrency rateOfCurrency =new RateOfCurrency();
		
		//账单变更单
		SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark();
		List<SupplierPriceRemark> supplierPriceRemarkCheckList=new ArrayList<SupplierPriceRemark>();
		
		
		BigDecimal bigDecimal= new BigDecimal(0.00);
		
		// 循环计算团下一个agent的合计
		for(SupplierCheck sc : supplierCheckList){
			rateOfCurrency = rateOfCurrencyService.findById(sc.getRateOfCurrencyId());
			SupplierOfAgent supplierOfAgentS = new SupplierOfAgent();
			supplierOfAgentS.setTourId(tour.getTourId());
			supplierOfAgentS.setUserId(sc.getUserIdOfAgent());
			
			// 团下一个agent的合计
			BigDecimal totalFeeOfAgent= new BigDecimal(0.00);
			totalFeeOfAgent = supplierOfAgentService.findSumOfAgentAndTour(supplierOfAgentS);
			sc.setTotalFeeOfAgent(totalFeeOfAgent == null ? bigDecimal : totalFeeOfAgent);
			
			// 团下一个agent根据订单汇率的合计
			SupplierOfAgent soa = supplierOfAgentService.findSumUSARateOfAgentAndTour(supplierOfAgentS);
			sc.setTotalRateFeeOfAgent(soa == null ? bigDecimal : soa.getSum());
			sc.setTotalUSARateFeeOfAgent(soa == null ? bigDecimal : soa.getUsaSum());
			
			//账单变更单
			supplierPriceRemark.setSupplierCheckId(sc.getSupplierCheckId());
			supplierPriceRemark.setTourId(tour.getTourId());
			supplierPriceRemark.setIsDel(0);
			supplierPriceRemarkCheckList.addAll(supplierPriceRemarkService.findAgentTax(supplierPriceRemark));
		}
		
		if (admin != null) {
			// 数据源币种
			rateOfCurrency.setCurrencyId(currencyTypeService.findById(deptService.findById(admin.getDeptId()).getCurrencyTypeId()).getSymbol());
			// 转换当前部门币种
			rateOfCurrency.setToCurrencyId(currencyTypeService.findById(deptService.findById(adminService.getCurrent().getDeptId()).getCurrencyTypeId()).getSymbol());
		}
		
		model.addAttribute("tour",tour);
		model.addAttribute("supplierPrice",supplierPrice);
		model.addAttribute("supplierCheckList",supplierCheckList);
		model.addAttribute("rateOfCurrency",rateOfCurrency);
		model.addAttribute("supPriceInfoRelList",supPriceInfoRelList);
		model.addAttribute("agentOfOrderList",agentOfOrderList);
		model.addAttribute("supplierPriceRemarkCheckList", supplierPriceRemarkCheckList);
		return "/admin/finance/accountant/agentCheckPrint";
	}
	
	/**
	 *  agent账单审核
	 */
	@RequestMapping(value = "/agentCheck", method = RequestMethod.POST)
	public String agentCheck(Tour tour,SupplierCheck supplierCheck) {
		Admin admin=adminService.getCurrent();
		synchronized (supplierCheckService)
		{
			// 查找团下的Agent
			SupplierPrice supplierPrice = supplierPriceService.findByTourId(tour.getTourId());
			if (supplierPrice != null) {
				SupplierCheck supplierCheckS = new SupplierCheck();
				supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
				List<SupplierCheck>supplierCheckList = supplierCheckService.find(supplierCheckS);

				// 判断未审核的
				for (int i = 0; i < supplierCheckList.size(); i++) {
					if (supplierCheckList.get(i).getUserIdOfAgent().equals(admin.getId())) {
						supplierCheckList.get(i).setCheckOfAgent(supplierCheck.getCheckOfAgent());
						break;
					}
				}

				supplierPrice.setAllCheck(1);
				// 判断未审核的
				for (int i = 0; i < supplierCheckList.size(); i++) {
					if (supplierCheckList.get(i).getCheckOfAgent() == 0 || supplierPrice.getAccCheck() == 0) {
						supplierPrice.setAllCheck(0);
						break;
					}
				}

				// 判断未通过的
				for (int i = 0; i < supplierCheckList.size(); i++) {
					if (supplierCheckList.get(i).getCheckOfAgent() == 2 || supplierPrice.getAccCheck() == 2) {
						supplierPrice.setAllCheck(2);
						break;
					}
				}


				supplierCheckS.setUserIdOfAgent(admin.getId());
				supplierCheckList = supplierCheckService.find(supplierCheckS);
				for (int i = 0; i < supplierCheckList.size(); i++) {
					supplierCheckList.get(i).setCheckOfAgent(supplierCheck.getCheckOfAgent());
					supplierCheckList.get(i).setRemarkOfAgent(supplierCheck.getRemarkOfAgent());
				}

				
				// 存放系统添加的支出
				List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();

				// 如果Agent全部审核  则 录入全部agent成本
				if (supplierCheck.getCheckOfAgent() == 1&&supplierPrice.getAllCheck()==1&&supplierPrice.getInvoiceState()!=1) {

					SupPriceInfoRel supPriceInfoRel = new SupPriceInfoRel();
					supPriceInfoRel.setTourId(tour.getTourId());
					
					//查询团下的所有账单成本
					List<SupPriceInfoRel> supPriceInfoRelList = supPriceInfoRelService.findSupplierOfOrderOfTour(supPriceInfoRel);
					
					//循环录入成本账单
					for (SupPriceInfoRel supPriceInfoRelS : supPriceInfoRelList) {
						PayCostRecords payCostRecords = new PayCostRecords();
						payCostRecords.setId(UUIDGenerator.getUUID());
						payCostRecords.setOrderId(supPriceInfoRelS.getOrderId());
						
						BigDecimal bg = supPriceInfoRelS.getSum().multiply(supPriceInfoRelS.getRateUp()).divide(supPriceInfoRelS.getRateDown(),2);
						payCostRecords.setSum(bg.setScale(2, BigDecimal.ROUND_HALF_UP));
						payCostRecords.setWay(supPriceInfoRelS.getSupplierName());
						
						payCostRecords.setTime(new Date());
						payCostRecords.setType(supPriceInfoRelS.getType());
						payCostRecords.setStatus(4);//系统审核
						payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.BILLREMARKS);
						if (supPriceInfoRelS.getType() == 2) {
							payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.HOTELPRICE + supPriceInfoRelS.getSupplierName());
							payCostRecords.setItem(Constant.HOTEL);
						} else if (supPriceInfoRelS.getType() == 3) {
							payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.FLIGHTPRICE + supPriceInfoRelS.getSupplierName());
							payCostRecords.setItem(Constant.FLIGHT);
						} else if (supPriceInfoRelS.getType() == 1) {
							payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.SUPPLIERPRICE + supPriceInfoRelS.getSupplierName());
							payCostRecords.setItem(Constant.CHINAPRICE);
						} else if (supPriceInfoRelS.getType() == 4) {
							payCostRecords.setWay(Constant.INSURANCE);
							payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.INSURANCEPRICE);
							payCostRecords.setItem(Constant.CHINAPRICE);
						}
						//payCostRecords.setSupId(supPriceInfoRelS.getSupId());
						payCostRecords.setPayOrCost(2);
						/*if(!admin.getDeptId().equals(supplierPrice.getDeptId())){
							//系统自动录入账单将西安视为别的部门的vender
							Vender vender = new Vender();
							vender.setDeptId(admin.getDeptId());
							//vender.setEntId(user.getEntId());
							vender.setName(Constant.XIAN_OFFICENAME);
							vender.setIsDel(0);
							List<Vender> venderListS = venderService.find(vender);
							if(venderListS != null && venderListS.size() != 0){
								vender = venderListS.get(0);
							}else {
								vender.setVenderId(UUIDGenerator.getUUID());
								venderService.save(vender);
							}
							payCostRecords.setVenderId(vender.getVenderId());
						}*/
						
						if(!payCostRecords.getSum().equals(BigDecimal.ZERO)){
							payCostRecordsList.add(payCostRecords);
						}
						
					}
				}

				supPriceInfoRelService.updateSupplierCheck(supplierPrice, supplierCheckList, payCostRecordsList);
				//自动发Invoice
				if (supplierPrice.getAllCheck() == 1 && supplierPrice.getInvoiceState() == 0 ) {
					Tour tour1 = tourService.findById(supplierPrice.getTourId());
					supplierPrice.setArriveDateTime(tour1.getArriveDateTime());
					// 判断团下agent是否已全部审核通过，通过则发出Invoice
					SupplierCheck supCheck = new SupplierCheck();
					supCheck.setSupplierPriceId(supplierPrice.getSupplierPriceId());
					List<SupplierCheck> supCheckListTemp=supplierCheckService.queryOfDept(supCheck);
					//发invoice
					supplierCheckService.billInvoice(null, supplierPrice,supCheckListTemp);
					supplierPrice.setInvoiceState(1);
					supplierPriceService.update(supplierPrice);
						
				}
			}
			}
		if(tour.getGroupId()==null){
			return "redirect:agentTourList.jhtml";
		}else{
			return "redirect:groupTourList.jhtml";
		}
		
	}
	
	/**
	 *  agent 审核 账单变更单
	 */
	@RequestMapping(value = "/agentAuditBillChange", method = RequestMethod.POST)
	public String agentAuditBillChange(ModelMap model, Tour tour,
			SupplierOfAgentVO supplierOfAgentVO,
			SupplierPriceRemark supplierPriceRemark,
			RedirectAttributes redirectAttributes) {
		Tour tourTemp = tourService.findById(tour.getTourId());
		Admin op = adminService.findById(tourTemp.getUserId()); 
		String tourId = null;
		List<SupplierPriceRemark> supplierPriceRemarkList = supplierOfAgentVO.getSupplierPriceRemarkList();
		//判断是否有未审核变更单
		if (supplierPriceRemarkList != null&& supplierPriceRemarkList.size() > 0) {
			for(SupplierPriceRemark spr : supplierPriceRemarkList){
					if(spr != null&&spr.getSupplierPriceRemarkId()!=null){
						spr = supplierPriceRemarkService.findById(spr.getSupplierPriceRemarkId());
						if(spr.getSprCheck() != null && spr.getSprCheck() == 3){
							spr.setSprCheck(supplierPriceRemark.getSprCheck());
							spr.setInvoiceState(0);
							supplierPriceRemarkService.update(spr);
						}
						tourId=spr.getTourId();
					}
			}
					
			supplierPriceRemark.setTourId(tourId);
			supplierPriceRemark.setType(1);
			supplierPriceRemark.setIsDel(0);
			//supplierPriceRemark.setSprCheck(0);
			supplierPriceRemark.setInvoiceState(0);
			
			//一个账单 下所有变更单 
			List<SupplierPriceRemark> supplierPriceRemarkListTemp=supplierPriceRemarkService.findSupplierPriceRemark(supplierPriceRemark);
				
			//判断所有变更单是否全部审核通过 是 为true 否 为 false
			boolean checekTemp=true;
			for(int i=0;i<supplierPriceRemarkListTemp.size();i++){
				if(supplierPriceRemarkListTemp.get(i).getSprCheck()!=1){
					checekTemp=false;
				}
			}
			//全部审核通过 ， 订单均摊变更单成本
			SupplierPriceRemark sk = new SupplierPriceRemark();
			// 存放系统添加的支出
			List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
			
			//checekTemp 是否全部审核通过
			if(checekTemp){
				//全部审核通过发invoice
				supplierCheckService.billCheckInvoice(op, tourId, supplierPriceRemarkList);
				
				for(int a=0;a<supplierPriceRemarkListTemp.size();a++){
					sk=supplierPriceRemarkService.findRateById(supplierPriceRemarkListTemp.get(a).getSupplierPriceRemarkId());
					Order o = new Order();
					o.setTourCode(sk.getTourCode());
					o.setTourId(sk.getTourId());
					List<Order> orderList = orderService.find(o);
					BigDecimal n = new BigDecimal(orderList.size());
					BigDecimal total = sk.getUsaDifferenceSum();
					PayCostRecords payCostRecords = new PayCostRecords();
					payCostRecords.setId(UUIDGenerator.getUUID());
					payCostRecords.setOrderId(sk.getOrderId());
					payCostRecords.setWay(Constant.CHECKBILLCHANGE);
					
					payCostRecords.setTime(new Date());
					payCostRecords.setType(9); //代表变更单录入
					payCostRecords.setPayOrCost(2); //代表成本
					payCostRecords.setStatus(4);//系统审核
					payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.AUTOCHECKBILL);
					payCostRecords.setRemark(Constant.SYSTEMPINPUT+Constant.CHECKBILLINFO);
					payCostRecords.setItem(Constant.CHECKBILLCHANGE);
					
					BigDecimal balance = total;
					balance=balance.setScale(2, BigDecimal.ROUND_HALF_UP);
					payCostRecords.setSum(balance);//四舍五入
					
					payCostRecordsList.add(payCostRecords);
				}
				if(payCostRecordsList.size()!=0){
					for(PayCostRecords item:payCostRecordsList){
						payCostRecordsService.save(item);
					}
				}
			}
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}
		return "redirect:agentOrderCheck.jhtml?tourId="+tour.getTourId();
	}
	
	/**
	 * 异步获取账单信息
	 * @param pageable
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> edit(String tourId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("supplierPrice", supplierPriceService.findByTourId(tourId));
		return map;
	}
	/**
	 * OP Group录账单
	 * @param tourId
	 * @return
	 */
	@RequestMapping(value = "/editGroup", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> editGroup(String tourId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("supplierPrice", supplierPriceService.findByTourId(tourId));
		return map;
	}
	/**
	 * 打印账单
	 * @return
	 * tour  团
	 * id 判断需要打印那个页面
	 */
	@RequestMapping(value="/printTotalBill",method=RequestMethod.GET)
	public String printTotalBill(Model model,Tour tour,String did) {
		model.addAttribute("menuId", "404");
		SupplierPrice supplierPrice=supplierPriceService.findByTourId(tour.getTourId());	
		if (supplierPrice != null) {
			//每个Agent收入合计（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			
			//总计
			BigDecimal totalFee= new BigDecimal(0.00);
			//查找团下的Agent
			List<SupPriceInfoRel> supPriceInfoRelList=supPriceInfoRelService.findSupplierByTourId(tour.getTourId());
			for(int i=0; i<supPriceInfoRelList.size();i++){
				SupPriceInfoRel supPriceInfoRel=supPriceInfoRelList.get(i);
				List<SupplierOfAgent> supplierOfAgentList = supPriceInfoRel.getSupplierOfAgentList();
				
				//合计
				for (int j = 0; j < supplierOfAgentList.size(); j++) {
					sum=sum.add(supplierOfAgentList.get(j).getSum());
				}
				//总计
				if (supPriceInfoRel.getType() != 4) {
					totalFee=totalFee.add(sum);
				}
			}
			
			//计算agent团下的费用
			List<SupplierCheck> supplierCheckList=SumOfAgent(tour.getTourId(),supplierPrice.getSupplierPriceId());
			
			SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark(); 
			supplierPriceRemark.setTourId(tour.getTourId());
			supplierPriceRemark.setIsDel(0);
			//账单变更单页面数据
			List<SupplierPriceRemark>supplierPriceRemarkList = supplierPriceRemarkService.findSupplierPriceRemark(supplierPriceRemark);
			
			//本位币
			String Symbol="￥";
			Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
			if(dept!=null&&dept.getCurrencyTypeId()!=null){
				CurrencyType currencyType=currencyTypeService.findById(dept.getCurrencyTypeId());
				Symbol=currencyType.getSymbol();
			}
			model.addAttribute("Symbol", Symbol);
			//当前用户
			Admin admin=new Admin();
			admin.setId(adminService.getCurrent().getId());
			admin.setUsername(adminService.getCurrent().getUsername());
			model.addAttribute("did", did);
			model.addAttribute("admin", admin);
			List<Order> ordersList=orderService.findByTourId(tour.getTourId());
			model.addAttribute("orderListS", ordersList);//页面显示
			model.addAttribute("tour", tour);
			model.addAttribute("supplierPrice", supplierPrice);
			model.addAttribute("supplierCheckList", supplierCheckList);
			model.addAttribute("supPriceInfoRelList", supPriceInfoRelList);
			model.addAttribute("supplierPriceRemarkList", supplierPriceRemarkList);
		}
		return "/admin/orderSupplier/printTotalBill";
	}
	/**
	 * agent 查看酒店 ，地接详情
	 */
	@RequestMapping(value = "/detailBill", method = RequestMethod.GET)
	public String detailBill(ModelMap model, Tour tour,SupPriceInfoRel supPriceInfoRel) {
		model.addAttribute("menuId", "501");
		model.addAttribute("tour",tour);
		String userId=adminService.getCurrent().getId();
		supPriceInfoRel=supPriceInfoRelService.findById(supPriceInfoRel.getSupPriceInfoRelId());
		model.addAttribute("supPriceInfoRel",supPriceInfoRel);
		SupplierPrice supplierPrice=supplierPriceService.findByTourId(tour.getTourId());
		supplierPrice.setAccCheck(3);//如果为3  页面就没有修改权限
		supplierPrice.setAllCheck(3);//
		model.addAttribute("supplierPrice",supplierPrice);
		if (supPriceInfoRel.getType()==1) {//跳转地接页面
			SupplierPriceInfo supplierPriceInfo =new SupplierPriceInfo();
			supplierPriceInfo.setUserId(userId);
			supplierPriceInfo.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
			model.addAttribute("supplierList" , supplierPriceInfoService.findSupplierAndCustomer(supplierPriceInfo));
			return "/admin/orderSupplier/orderSupplierUpdate";
		} else if (supPriceInfoRel.getType()==2) {//跳转酒店页面
			HotelPriceInfo hotelPriceInfo =new HotelPriceInfo();
			hotelPriceInfo.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
			hotelPriceInfo.setUserId(userId);
			model.addAttribute("hotelList" , hotelPriceInfoService.findHotelAndCustomer(hotelPriceInfo));
			return "/admin/orderSupplier/orderHotelUpdate";
		} else if (supPriceInfoRel.getType()==3) {//跳转航班页面
			FlightPriceInfo flightPriceInfo =new FlightPriceInfo();
			flightPriceInfo.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
			flightPriceInfo.setUserId(userId);
			model.addAttribute("flightList" , flightPriceInfoService.findFlightAndCustomer(flightPriceInfo));
			return "/admin/orderSupplier/orderFlightUpdate";
		} else {//跳转保险页面
			InsurancePriceInfo insurancePriceInfo = new InsurancePriceInfo();
			insurancePriceInfo.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
			insurancePriceInfo.setUserId(userId);
			model.addAttribute("InsuranceList" ,
			insurancePriceInfoService.findInsuranceAndCustomer(insurancePriceInfo));
			return "/admin/orderSupplier/orderInsuranceUpdate";
		}
	}
	
	/**
	 *  agent账单审核
	 */
	@RequestMapping(value = "/checkTour", method = RequestMethod.GET)
	public void agentSupplierPriceCheck() {
		synchronized (supplierCheckService)
		{
			Integer CheckOfAgent=1;
			// 查找团下的Agent
			List<SupplierPrice> supplierPriceList = supplierPriceService.findCheckSupplierPriceTour();
			for (SupplierPrice supplierPrice : supplierPriceList) {
				if (supplierPrice != null) {
					SupplierCheck supplierCheckS = new SupplierCheck();
					supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
					List<SupplierCheck>supplierCheckList = supplierCheckService.find(supplierCheckS);
	
					// 判断未审核的
					for (int i = 0; i < supplierCheckList.size(); i++) {
						if (supplierCheckList.get(i).getUserIdOfAgent().equals(supplierPrice.getUserId())) {
							supplierCheckList.get(i).setCheckOfAgent(CheckOfAgent);
							break;
						}
					}
	
					supplierPrice.setAllCheck(1);
					// 判断未审核的
					for (int i = 0; i < supplierCheckList.size(); i++) {
						if (supplierCheckList.get(i).getCheckOfAgent() == 0 || supplierPrice.getAccCheck() == 0) {
							supplierPrice.setAllCheck(0);
							break;
						}
					}
	
					// 判断未通过的
					for (int i = 0; i < supplierCheckList.size(); i++) {
						if (supplierCheckList.get(i).getCheckOfAgent() == 2 || supplierPrice.getAccCheck() == 2) {
							supplierPrice.setAllCheck(2);
							break;
						}
					}
	
	
					supplierCheckS.setUserIdOfAgent(supplierPrice.getUserId());
					supplierCheckList = supplierCheckService.find(supplierCheckS);
					for (int i = 0; i < supplierCheckList.size(); i++) {
						supplierCheckList.get(i).setCheckOfAgent(CheckOfAgent);
						supplierCheckList.get(i).setRemarkOfAgent("系统自动审核");
					}
	
					
					// 存放系统添加的支出
					List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
	
					// 如果Agent全部审核  则 录入全部agent成本
					if (CheckOfAgent == 1&&supplierPrice.getAllCheck()==1) {
	
						SupPriceInfoRel supPriceInfoRel = new SupPriceInfoRel();
						supPriceInfoRel.setTourId(supplierPrice.getTourId());
						
						//查询团下的所有账单成本
						List<SupPriceInfoRel> supPriceInfoRelList = supPriceInfoRelService.findSupplierOfOrderOfTour(supPriceInfoRel);
						
						//循环录入成本账单
						for (SupPriceInfoRel supPriceInfoRelS : supPriceInfoRelList) {
							PayCostRecords payCostRecords = new PayCostRecords();
							payCostRecords.setId(UUIDGenerator.getUUID());
							payCostRecords.setOrderId(supPriceInfoRelS.getOrderId());
							
							BigDecimal bg = supPriceInfoRelS.getSum().multiply(supPriceInfoRelS.getRateUp()).divide(supPriceInfoRelS.getRateDown(),2);
							payCostRecords.setSum(bg.setScale(2, BigDecimal.ROUND_HALF_UP));
							payCostRecords.setWay(supPriceInfoRelS.getSupplierName());
							
							payCostRecords.setTime(new Date());
							payCostRecords.setType(supPriceInfoRelS.getType());
							payCostRecords.setStatus(4);//系统审核
							payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.BILLREMARKS);
							if (supPriceInfoRelS.getType() == 2) {
								payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.HOTELPRICE + supPriceInfoRelS.getSupplierName());
								payCostRecords.setItem(Constant.HOTEL);
							} else if (supPriceInfoRelS.getType() == 3) {
								payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.FLIGHTPRICE + supPriceInfoRelS.getSupplierName());
								payCostRecords.setItem(Constant.FLIGHT);
							} else if (supPriceInfoRelS.getType() == 1) {
								payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.SUPPLIERPRICE + supPriceInfoRelS.getSupplierName());
								payCostRecords.setItem(Constant.CHINAPRICE);
							} else if (supPriceInfoRelS.getType() == 4) {
								payCostRecords.setWay(Constant.INSURANCE);
								payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.INSURANCEPRICE);
								payCostRecords.setItem(Constant.CHINAPRICE);
							}
							payCostRecords.setPayOrCost(2);
							
							if(!payCostRecords.getSum().equals(BigDecimal.ZERO)){
								payCostRecordsList.add(payCostRecords);
							}
							
						}
					}
	
					supPriceInfoRelService.updateSupplierCheck(supplierPrice, supplierCheckList, payCostRecordsList);
					//自动发Invoice
					if (supplierPrice.getAllCheck() == 1 && supplierPrice.getInvoiceState() == 0 ) {
						Tour tour1 = tourService.findById(supplierPrice.getTourId());
						supplierPrice.setArriveDateTime(tour1.getArriveDateTime());
						// 判断团下agent是否已全部审核通过，通过则发出Invoice
						SupplierCheck supCheck = new SupplierCheck();
						supCheck.setSupplierPriceId(supplierPrice.getSupplierPriceId());
						List<SupplierCheck> supCheckListTemp=supplierCheckService.queryOfDept(supCheck);
						//发invoice
						supplierCheckService.billInvoice(null, supplierPrice,supCheckListTemp);
						supplierPrice.setInvoiceState(1);
						supplierPriceService.update(supplierPrice);
							
					}
				}
			}
		}
	}
	

	@RequestMapping(value = "/accCheckAll", method = RequestMethod.POST)
	public String accCheckAll(String[] tourIds,RedirectAttributes redirectAttributes) {
			// 查找团下的Agent
		for (String tourId : tourIds) {
			SupplierPrice supplierPriceS = supplierPriceService.findByTourId(tourId);
			if (supplierPriceS != null) {
				supplierPriceS.setCheckUserId(adminService.getCurrent().getId());
				//supplierPriceS.setCheckRemark(supplierPrice.getCheckRemark());
				supplierPriceS.setAccCheck(1);
				supplierPriceS.setCheckTime(new Date());

				SupplierCheck supplierCheckS = new SupplierCheck();
				supplierCheckS.setSupplierPriceId(supplierPriceS.getSupplierPriceId());
				List<SupplierCheck> supplierCheckList = supplierCheckService.find(supplierCheckS);
				// 会计审核 如果是二次审核，账单的状态AllCheck仍未修改状态，一次审核，根据优先级排列
				supplierPriceS.setAllCheck(1);
				// 判断未审核的
				for (int i = 0; i < supplierCheckList.size(); i++) {
					if (supplierCheckList.get(i).getCheckOfAgent() == 0 ) {
						supplierPriceS.setAllCheck(0);
						break;
					}
					
				}

				// 判断未通过的
				for (int i = 0; i < supplierCheckList.size(); i++) {
					if (supplierCheckList.get(i).getCheckOfAgent() == 2 ) {
						supplierPriceS.setAllCheck(2);
						break;
					}
				}

				supPriceInfoRelService.updateSupplier(supplierPriceS, null, null, supplierCheckList, null, null, null, null, null,null);
			}
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:accountantTourList.jhtml";
		
	}
	
	/**
	 * 第一步
	 * 欧洲团账单列表
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/billListForEurope", method = RequestMethod.GET)
	public String tourListForEurope(Model model){
		model.addAttribute("menuId", 413);
		model.addAttribute("userName", adminService.getCurrent().getUsername());
		return  "/admin/orderSupplier/billListForEurope";
	}
	
	/**
	 * 欧洲团账单列表
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/billListForEurope", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> tourListForEurope(Pageable pageable,EuropeTourPrice europeTourPrice){
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = adminService.getCurrent();
		europeTourPrice.setDeptIdForTour(admin.getDeptId());
		Page<EuropeTourPrice> page = europeTourPriceService.findPage(europeTourPrice, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	

	/**
	 * 第二部 进入录账单详情页面
	 * 欧洲团录账单详情页面、op（申请）结算页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/settleForOPPage", method=RequestMethod.GET)
	public String settleForOP(String id,Model model){
		Dept dept = deptService.findById(adminService.getCurrent().getDeptId());
		CurrencyType currencyType = currencyTypeService.findById(dept.getCurrencyTypeId());
		Tour tour = tourService.findById(id);
		EuropeTourPrice europeTourPrice = new EuropeTourPrice();
		europeTourPrice.setTourId(id);
		int flag = 1;  //判断所有的是否都已到op结算状态
		int settleFlag = 0;
		List<EuropeTourPrice> costList = new ArrayList<EuropeTourPrice>();
		List<EuropeTourPrice> europeTourPriceList = europeTourPriceService.find(europeTourPrice);
		//如果账单未录入也同样不显示结算按钮
		if(europeTourPriceList.size()==0){
			flag = 0;
		}
		for(EuropeTourPrice europe:europeTourPriceList){
			if(europe.getPayOrCost()==0||europe.getPayOrCost()==3){
				if(europe.getPayOrCost()==0&&europe.getCompleteState()!=3){
					flag=0;
				}
				costList.add(europe);
			}else{
				if(europe.getCompleteState()!=2){
					flag=0;
				}
			}
			if(europe.getCompleteState()>=4){//当状态大于等于4时不能出现增加和保存按钮
				settleFlag = 1;
			}else{
				
				settleFlag = 0;
			}
		}
		List<Order> orderList = orderService.findByTourId(id);
		List<Order> orderWithEuropeList = new ArrayList<Order>();
			for(EuropeTourPrice otp:costList){
				for(Order order:orderList){
					if(order.getId().equals(otp.getOrderId())||order.getState()==4||order.getState()==5||order.getState()==7){
						orderWithEuropeList.add(order);
					}
				}
			}
			orderList.removeAll(orderWithEuropeList);
		model.addAttribute("tour", tour);
		model.addAttribute("europeTourPriceList", europeTourPriceList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("flag", flag);
		model.addAttribute("settleFlag", settleFlag);
		model.addAttribute("currencyType", currencyType);
		model.addAttribute("menuId", 413);
		return "/admin/orderSupplier/settleForOP";
		}
	
	
	/**
	 * 欧洲团保存账单信息
	 * @param europeTourPriceVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveEurope", method=RequestMethod.POST)
	public String saveEurope(EuropeTourPriceVO europeTourPriceVO,Model model){
					Tour tour = tourService.findById(europeTourPriceVO.getTourId());
					List<EuropeTourPrice> europeTourPriceList = europeTourPriceVO.getEuropeTourPriceList();
					for(EuropeTourPrice europeTourPrice:europeTourPriceList){
						if(europeTourPrice.getReceivableAmount()!=null){
							europeTourPrice.setEuropeTourPriceId(UUIDGenerator.getUUID());
							europeTourPrice.setTourCode(tour.getTourCode());
							europeTourPrice.setTourId(tour.getTourId());
							europeTourPrice.setDeptIdForTour(tour.getDeptId());
							europeTourPrice.setUserIdForTour(tour.getUserId());
							europeTourPrice.setCompleteState(1);
							RateOfCurrency rateOfCurrency = new RateOfCurrency();
							if(europeTourPrice.getPayOrCost()==0){
								Dept dept = deptService.findById(europeTourPrice.getDeptIdForTour());
								Dept toDept = deptService.findById(europeTourPrice.getDeptIdForOrder());
								rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
								rateOfCurrency.setToCurrencyId(toDept.getCurrencyTypeId());
								rateOfCurrency = rateOfCurrencyService.find(rateOfCurrency).get(0);
								europeTourPrice.setRateOfCurrencyId(rateOfCurrency.getId());
								europeTourPrice.setActualCostForTour(europeTourPrice.getReceivableAmount().divide(rateOfCurrency.getUsRate(), 2));
							}else{
								Dept dept = deptService.findById(europeTourPrice.getDeptIdForTour());
								Dept toDept = deptService.findById(europeTourPrice.getDeptIdForTour());
								rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
								rateOfCurrency.setToCurrencyId(toDept.getCurrencyTypeId());
								rateOfCurrency = rateOfCurrencyService.find(rateOfCurrency).get(0);
								europeTourPrice.setRateOfCurrencyId(rateOfCurrency.getId());
								europeTourPrice.setActualCostForTour(europeTourPrice.getReceivableAmount().divide(rateOfCurrency.getUsRate(), 2));
							}
							if(europeTourPrice.getVenderId()==null||europeTourPrice.getVenderId()==""){
								europeTourPrice.setVenderName("");
							}
							europeTourPriceService.save(europeTourPrice);
						}
					}
					tour.setState(1);
					tourService.update(tour);
			return "redirect:settleForOPPage.jhtml?id="+tour.getTourId();
		}
	
	/**
	 * 删除cost
	 * @param id
	 * @param tourId
	 * @return
	 */
	@RequestMapping(value="/delEuropeTourPrice", method=RequestMethod.GET)
	public String delEuropeTourPrice(String id,String tourId){
		europeTourPriceService.delete(id);
		return "redirect:settleForOPPage.jhtml?id="+tourId;
	}
	@RequestMapping(value="/billAgentOrderListForEurope", method=RequestMethod.GET)
	public @ResponseBody Map<String,Object> billAgentOrderListForEurope(String tourId){
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = adminService.getCurrent();
		EuropeTourPrice europeTourPrice = new EuropeTourPrice();
		europeTourPrice.setUserIdForOrder(admin.getId());
		europeTourPrice.setTourId(tourId);
		List<EuropeTourPrice> europeTourPriceList = europeTourPriceService.find(europeTourPrice);
		map.put("europeTourPriceList", europeTourPriceList);
		return map;
	}
		
		/**
		 * op财务审核（团）支出页
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveCostForOP", method = RequestMethod.GET)
		public String approveCostForOP(Model model,EuropeTourPrice europeTourPrice){
			model.addAttribute("menuId", 519);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			if(europeTourPrice!=null){
				if(europeTourPrice.getTourCode()!=null&&europeTourPrice.getTourCode().equals("null")){europeTourPrice.setTourCode(null);};
				if(europeTourPrice.getLineName()!=null&&europeTourPrice.getLineName().equals("null")){europeTourPrice.setLineName(null);};
				if(europeTourPrice.getUserName()!=null&&europeTourPrice.getUserName().equals("null")){europeTourPrice.setUserName(null);};
				if(europeTourPrice.getVenderName()!=null&&europeTourPrice.getVenderName().equals("null")){europeTourPrice.setVenderName(null);};
				if(europeTourPrice.getInvoiceNo()!=null&&europeTourPrice.getInvoiceNo().equals("null")){europeTourPrice.setInvoiceNo(null);};
			}
			model.addAttribute("europeTourPrice", europeTourPrice);
			return  "/admin/orderSupplier/approveCostForOP";
		}
		
		
		@RequestMapping(value="/approveCostForOP", method=RequestMethod.POST)
		public @ResponseBody Map<String,Object> approveCostForOP(Pageable pageable,EuropeTourPrice europeTourPrice){
			Admin admin = adminService.getCurrent();
			Map<String, Object> map = new HashMap<String, Object>();
			europeTourPrice.setPayOrCost(1);
			europeTourPrice.setDeptIdForTour(admin.getDeptId());
			Page<EuropeTourPrice> page = europeTourPriceService.findForAgentPage(europeTourPrice, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		
		/**
		 * op 财务审核（订单）收入页
		 * @param pageable
		 * @param europeTourPrice
		 * @return
		 */
		@RequestMapping(value="/approveIncomeForOP", method = RequestMethod.GET)
		public String approveIncomeForOP(Model model){
			model.addAttribute("menuId", 519);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			return  "/admin/orderSupplier/approveIncomeForOP";
		}
		
		@RequestMapping(value="/approveIncomeForOP", method=RequestMethod.POST)
		public @ResponseBody Map<String,Object> approveIncomeForOP(Pageable pageable,EuropeTourPrice europeTourPrice){
			Admin admin = adminService.getCurrent();
			Map<String, Object> map = new HashMap<String, Object>();
			europeTourPrice.setPayOrCost(0);
			europeTourPrice.setDeptIdForTour(admin.getDeptId());
			Page<EuropeTourPrice> page = europeTourPriceService.findForOPAccPage(europeTourPrice, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 * 录欧洲团变更单
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveRevisedForOP", method=RequestMethod.GET)
		public String approveRevisedForOP(Model model){
			model.addAttribute("menuId", 519);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			return  "/admin/orderSupplier/approveRevisedForOP";
		}
		
		@RequestMapping(value="/approveRevisedForOP", method=RequestMethod.POST)
		public @ResponseBody Map<String,Object> approveRevisedForOP(Pageable pageable,EuropeTourPrice europeTourPrice){
			Admin admin = adminService.getCurrent();
			Map<String, Object> map = new HashMap<String, Object>();
			europeTourPrice.setPayOrCost(3);
			europeTourPrice.setDeptIdForTour(admin.getDeptId());
			Page<EuropeTourPrice> page = europeTourPriceService.findForOPAccPage(europeTourPrice, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 * op财务审核通过（团）支出以及变更单审核
		 * @param europeTourPrice
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveCostPassForOP", method=RequestMethod.POST)
		public String approveCostPassForOP(EuropeTourPrice europeTourPrice,int flag,Model model){
			String[] europeTourPriceIds = europeTourPrice.getEuropeTourPriceId().split(",");
		    String remark = europeTourPrice.getApproveRemarkOPAcc();
		    for(int i=0;i<europeTourPriceIds.length;i++){
		    	EuropeTourPrice etp = new EuropeTourPrice();
		    	etp.setEuropeTourPriceId(europeTourPriceIds[i]);
		    	etp.setApproveRemarkOPAcc(remark);
		    	etp.setCompleteState(2);
				europeTourPriceService.update(etp);
		    }	
		    if(europeTourPrice.getVenderName()!=null){
		    	europeTourPrice.setVenderName(europeTourPrice.getVenderName().replace("&", "%26"));
		    }
		    if(flag==3){//如果flag为3则为变更单审核
		    	return "redirect:approveRevisedForOP.jhtml";
		    }
				return "redirect:approveCostForOP.jhtml?tourCode="+europeTourPrice.getTourCode()+"&lineName="+europeTourPrice.getLineName()+"&userName="+europeTourPrice.getUserName()+"&venderName="+europeTourPrice.getVenderName()+"&invoiceNo="+europeTourPrice.getInvoiceNo();
			}
		
		/**
		 * op财务审核通过（订单）收入,待agent审核完成之后审核并发送invoice，将状态置为3
		 * @param europeTourPrice
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveBillChangePassForOP", method=RequestMethod.POST)
		public String approveBillChangePassForOP(EuropeTourPrice europeTourPrice,Model model){
			    String[] europeTourPriceIds = europeTourPrice.getEuropeTourPriceId().split(",");
			    String remark = europeTourPrice.getApproveRemarkOPAcc();
			    for(int i=0;i<europeTourPriceIds.length;i++){
					europeTourPrice = europeTourPriceService.findById(europeTourPriceIds[i]);
					if(!europeTourPrice.getDeptIdForOrder().equals(europeTourPrice.getDeptIdForTour())){
						europeTourPriceService.billInvoice(europeTourPrice);
					}
					europeTourPrice.setApproveRemarkOPAcc(remark);
					europeTourPrice.setCompleteState(3);
					europeTourPriceService.update(europeTourPrice);
			    }
				return "redirect:approveRevisedForOP.jhtml";
			}
		
		/**
		 * op财务审核通过（订单）收入,待agent审核完成之后审核并发送invoice，将状态置为3
		 * @param europeTourPrice
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveIncomePassForOP", method=RequestMethod.POST)
		public String approveIncomePassForOP(EuropeTourPrice europeTourPrice,Model model){
			    String[] europeTourPriceIds = europeTourPrice.getEuropeTourPriceId().split(",");
			    String remark = europeTourPrice.getApproveRemarkOPAcc();
			    for(int i=0;i<europeTourPriceIds.length;i++){
					EuropeCustomerFee europeCustomerFee = new EuropeCustomerFee();
					europeCustomerFee.setEuropeTourPriceId(europeTourPriceIds[i]);
					List<EuropeCustomerFee> europeCustomerFeeList =  europeCustomerFeeService.find(europeCustomerFee);
					for(EuropeCustomerFee ecf:europeCustomerFeeList){
						ecf.setState(3);
						europeCustomerFeeService.update(ecf);
					}
					europeTourPrice = europeTourPriceService.findById(europeTourPriceIds[i]);
					if(!europeTourPrice.getDeptIdForOrder().equals(europeTourPrice.getDeptIdForTour())){
						europeTourPriceService.billInvoice(europeTourPrice);
					}
					europeTourPrice.setApproveRemarkOPAcc(remark);
					europeTourPrice.setCompleteState(3);
					europeTourPriceService.update(europeTourPrice);
					
			    }
				return "redirect:approveIncomeForOP.jhtml";
			}
		
		/**
		 * agent审核账单页
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveForAgent", method = RequestMethod.GET)
		public String approveForAgent(Model model){
			Admin admin = adminService.getCurrent();
			int sumForAgent = europeTourPriceService.findSumForAgent(admin.getId());
			model.addAttribute("sumForAgent", sumForAgent);
			model.addAttribute("menuId", 501);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			return  "/admin/orderSupplier/approveForAgent";
		}
		
		@RequestMapping(value="/approveForAgent", method=RequestMethod.POST)
		public @ResponseBody Map<String,Object> approveForAgent(Pageable pageable,EuropeTourPrice europeTourPrice){
			Map<String, Object> map = new HashMap<String, Object>();
			Admin admin = adminService.getCurrent();
			europeTourPrice.setUserIdForOrder(admin.getId());
			europeTourPrice.setPayOrCost(0);
			Page<EuropeTourPrice> page = europeTourPriceService.findForAgentPage(europeTourPrice, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 * agent审核账单页
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveRevisedForAgent", method = RequestMethod.GET)
		public String approveRevisedForAgent(Model model){
			Admin admin = adminService.getCurrent();
			int sumForAgent = europeTourPriceService.findSumForAgent(admin.getId());
			model.addAttribute("sumForAgent", sumForAgent);
			model.addAttribute("menuId", 501);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			return  "/admin/orderSupplier/approveRevisedForAgent";
		}
		
		@RequestMapping(value="/approveRevisedForAgent", method=RequestMethod.POST)
		public @ResponseBody Map<String,Object> approveRevisedForAgent(Pageable pageable,EuropeTourPrice europeTourPrice){
			Map<String, Object> map = new HashMap<String, Object>();
			Admin admin = adminService.getCurrent();
			europeTourPrice.setUserIdForOrder(admin.getId());
			europeTourPrice.setPayOrCost(3);
			Page<EuropeTourPrice> page = europeTourPriceService.findForAgentPage(europeTourPrice, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 * 欧洲团agent审核变更单
		 * @param europeTourPrice
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approveRevisedPassForAgent", method=RequestMethod.POST)
		public String approveRevisedPassForAgent(EuropeTourPrice europeTourPrice,Model model){
			String[] europeTourPriceIds = europeTourPrice.getEuropeTourPriceId().split(",");
		    String remark = europeTourPrice.getApproveRemarkAgent();
		    for(int i=0;i<europeTourPriceIds.length;i++){
		    	EuropeTourPrice etp = new EuropeTourPrice();
		    	etp.setEuropeTourPriceId(europeTourPriceIds[i]);
		    	etp.setApproveRemarkOPAcc(remark);
		    	etp.setCompleteState(2);
				europeTourPriceService.update(etp);
				PayCostRecords payCostRecords = new PayCostRecords();
				payCostRecords.setId(UUIDGenerator.getUUID());
				EuropeTourPrice etpForRate = europeTourPriceService.findById(europeTourPrice.getEuropeTourPriceId());
				payCostRecords.setOrderId(etpForRate.getOrderId());
				RateOfCurrency rateOfCurrency = rateOfCurrencyService.findById(etpForRate.getRateOfCurrencyId());
				payCostRecords.setSum(etpForRate.getReceivableAmount().multiply(rateOfCurrency.getRateUp()).divide(rateOfCurrency.getRateDown(),2));
				//payCostRecords.setWay("机票");
				//payCostRecords.setCode(sp.getCode());
				payCostRecords.setTime(new Date());
				payCostRecords.setType(6);
				payCostRecords.setStatus(4);//系统审核
				payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.AUTOCHECKBILL);
				payCostRecords.setRemark(Constant.SYSTEMPINPUT+Constant.CHECKBILLINFO);
				payCostRecords.setItem(Constant.CHECKBILLCHANGE);
				payCostRecords.setPayOrCost(2);
				payCostRecordsService.save(payCostRecords);
		    }	
		    if(europeTourPrice.getGroupId()==null){
		    	return "redirect:approveRevisedForAgent.jhtml";
			}else{
				return "redirect:approveRevisedForGroup.jhtml";
			}
		    	
			}
		/**
		 * agent审核收入，审核完成等待op财务审核之后发invoice，将状态置为2
		 * @param europeTourPrice
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/approvePassForAgent", method=RequestMethod.POST)
		public String approvePassForAgent(EuropeTourPrice etp,Model model){
			String[] europeTourPriceIds = etp.getEuropeTourPriceId().split(",");
			for(int i=0;i<europeTourPriceIds.length;i++){
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setEuropeTourPriceId(europeTourPriceIds[i]);
			EuropeCustomerFee europeCustomerFee = new EuropeCustomerFee();
			europeCustomerFee.setEuropeTourPriceId(europeTourPriceIds[i]);
			List<EuropeCustomerFee> europeCustomerFeeList =  europeCustomerFeeService.find(europeCustomerFee);
			for(EuropeCustomerFee ecf:europeCustomerFeeList){
				ecf.setState(2);
				europeCustomerFeeService.update(ecf);
			} 
				europeTourPrice.setApproveRemarkAgent(etp.getApproveRemarkAgent());
				europeTourPrice.setCompleteState(2);
				europeTourPriceService.update(europeTourPrice);
				PayCostRecords payCostRecords = new PayCostRecords();
				payCostRecords.setId(UUIDGenerator.getUUID());
				EuropeTourPrice etpForRate = europeTourPriceService.findById(europeTourPrice.getEuropeTourPriceId());
				payCostRecords.setOrderId(etpForRate.getOrderId());
				RateOfCurrency rateOfCurrency = rateOfCurrencyService.findById(etpForRate.getRateOfCurrencyId());
				payCostRecords.setSum(etpForRate.getReceivableAmount().multiply(rateOfCurrency.getRateUp()).divide(rateOfCurrency.getRateDown(),2));
				//payCostRecords.setWay("机票");
				payCostRecords.setTime(new Date());
				payCostRecords.setType(5);
				payCostRecords.setStatus(4);//系统审核
				payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.BILLREMARKS);
				payCostRecords.setRemark(Constant.SYSTEMPINPUT +"Europe Tour");
				payCostRecords.setItem(Constant.TOURCOST);
				payCostRecords.setPayOrCost(2);
				payCostRecordsService.save(payCostRecords);
			}
				if(etp.getGroupId()==null){
					return "redirect:approveForAgent.jhtml";
				}else{
					return "redirect:approveForGroup.jhtml";
				}
			}
		
		
		//OP、财务结算
		@RequestMapping(value="/settle", method=RequestMethod.GET)
		public String settle(EuropeTourPriceVO europeTourPriceVO,Model model){
			Dept dept = deptService.findById(adminService.getCurrent().getDeptId());
			CurrencyType currencyType = currencyTypeService.findById(dept.getCurrencyTypeId());
			List<EuropeTourPrice> europeTourPriceList = europeTourPriceVO.getEuropeTourPriceList();
			for(EuropeTourPrice europeTourPrice:europeTourPriceList){
				europeTourPrice.setCompleteState(6);
				europeTourPriceService.update(europeTourPrice);
			}
			model.addAttribute("currencyType", currencyType);
			model.addAttribute("menuId", 517);
				return "redirect:billListForEurope.jhtml";
			}
					
		
		/**
		 * OP财务结算页
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/settleForAccOP", method = RequestMethod.GET)
		public String settleForAccOP(Model model){
			model.addAttribute("menuId", 518);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			return  "/admin/orderSupplier/settleForAccOP";
		}
		
		@RequestMapping(value="/settleForAccOP", method=RequestMethod.POST)
		public @ResponseBody Map<String,Object> settleForAccOP(Pageable pageable,EuropeTourPrice europeTourPrice){
			Map<String,Object> map = new HashMap<String,Object>();
			Admin admin = adminService.getCurrent();
			europeTourPrice.setDeptIdForTour(admin.getDeptId());
			Page<EuropeTourPrice> page = europeTourPriceService.findPage(europeTourPrice, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 * op财务结算详情页
		 * @param model
		 * @param tourId
		 * @return
		 */
		@RequestMapping(value="/settleForOP", method = RequestMethod.GET)
		public String settleForOP(Model model,String tourId){
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setTourId(tourId);
			
			List<EuropeTourPrice> europeTourPriceList = europeTourPriceService.find(europeTourPrice);
			for(EuropeTourPrice etp:europeTourPriceList){
				etp.setCompleteState(4);
				europeTourPriceService.update(etp);
			}
			model.addAttribute("menuId", 413);
			return  "redirect:billListForEurope.jhtml";
		}
		
		/**
		 * op财务结算详情页
		 * @param model
		 * @param tourId
		 * @return
		 */
		@RequestMapping(value="/settleForAccOPInfomation", method = RequestMethod.GET)
		public String settleForAccOPInfomation(Model model,String tourId){
			Tour tour = tourService.findById(tourId);
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setTourId(tourId);
			List<EuropeTourPrice> europeTourPriceList = europeTourPriceService.find(europeTourPrice);
			int flag = 0;
			if(europeTourPriceList!=null&&europeTourPriceList.size()!=0){
				for(EuropeTourPrice etp:europeTourPriceList){
					if(etp.getCompleteState()==4){
						flag=1;
					}else{
						flag=0;
					}
				}
			}
			model.addAttribute("europeTourPriceList", europeTourPriceList);
			model.addAttribute("menuId", 518);
			model.addAttribute("tour", tour);
			model.addAttribute("flag", flag);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			return  "/admin/orderSupplier/settleForAccOPInfomation";
		}
		
		
		/**
		 * op财务结算
		 * @param model
		 * @param tourId
		 * @return
		 */
		@RequestMapping(value="/settleForAccOPPass", method = RequestMethod.GET)
		public String settleForAccOPPass(Model model,String tourId){
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setTourId(tourId);
			
			List<EuropeTourPrice> europeTourPriceList = europeTourPriceService.find(europeTourPrice);
			for(EuropeTourPrice etp:europeTourPriceList){
				etp.setCompleteState(5);
				europeTourPriceService.update(etp);
			}
			model.addAttribute("menuId", 518);
			return "redirect:settleForAccOPInfomation.jhtml?tourId="+tourId;
		}
		
		/**
		 op结算变更单
		 */
		@RequestMapping(value="/settleBillChangeForAccOPPass", method = RequestMethod.GET)
		public String settleBillChangeForAccOPPass(Model model,String orderId){
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setOrderId(orderId);
			europeTourPrice.setPayOrCost(3);
			List<EuropeTourPrice> europeTourPriceList = europeTourPriceService.find(europeTourPrice);
			for(EuropeTourPrice etp:europeTourPriceList){
				etp.setCompleteState(4);
				europeTourPriceService.update(etp);
			}
			model.addAttribute("menuId", 413);
			return "redirect:customerList.jhtml?orderId="+orderId;
		}
		
		/**
		 * 订单下的客人列表
		 * @param orderId
		 * @param model
		 * @return
		 */
		@RequestMapping(value="/customerList",method=RequestMethod.GET)
		public String customerList(String orderId,Model model){
			List<EuropeCustomerFee> europecustomerFeeList = europeCustomerFeeService.findCustomerWithFee(orderId);
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setOrderId(orderId);
			europeTourPrice.setPayOrCost(3);
			List<EuropeTourPrice> billChangeList = europeTourPriceService.find(europeTourPrice) ;
			int isShowForSettle = 1;
			if(billChangeList.size()>0){
				for(EuropeTourPrice europeTourPriceForChange:billChangeList){
					if(europeTourPriceForChange.getCompleteState()!=3){
						isShowForSettle = 0;
					}
				}
			}else{
				isShowForSettle=0;
			}
			Order order = orderService.findById(orderId);
			Tour tour = tourService.findById(order.getTourId());
			Dept dept = deptService.findById(tour.getDeptId());//op所在部门
			Dept toDept = deptService.findById(order.getDeptId());//agent所在部门
			RateOfCurrency rateOfCurrency = new RateOfCurrency();
			rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
			rateOfCurrency.setToCurrencyId(toDept.getCurrencyTypeId());
			rateOfCurrency = rateOfCurrencyService.find(rateOfCurrency).get(0);
			model.addAttribute("europecustomerFeeList", europecustomerFeeList);
			model.addAttribute("orderId", orderId);
			model.addAttribute("orderNo", order.getOrderNo());
			model.addAttribute("tourId",tour.getTourId());
			model.addAttribute("tourCode",tour.getTourCode());
			model.addAttribute("userIdForOrder", order.getUserId());
			model.addAttribute("userIdForTour", tour.getUserId());
			model.addAttribute("deptIdForOrder", order.getDeptId());
			model.addAttribute("deptIdForTour", tour.getDeptId());
			model.addAttribute("rateOfCurrencyId", rateOfCurrency.getId());
			model.addAttribute("billChangeList", billChangeList);
			model.addAttribute("isShowForSettle", isShowForSettle);
			model.addAttribute("menuId", 413);
			model.addAttribute("flag", europecustomerFeeList.get(0).getState()==null?0:europecustomerFeeList.get(0).getState());
			return "/admin/orderSupplier/customerList";
		}
		
		/**
		 * 保存变更单（欧洲团）
		 * @return
		 */
		@RequestMapping(value="/saveBillChangeForEurope",method=RequestMethod.POST)
		public String saveBillChangeForEurope(EuropeTourPrice europeTourPrice){
				europeTourPrice.setEuropeTourPriceId(UUIDGenerator.getUUID());
				europeTourPrice.setPayOrCost(3);
				europeTourPrice.setCompleteState(1);
				europeTourPriceService.save(europeTourPrice);
				return "redirect:customerList?orderId="+europeTourPrice.getOrderId();
			}
		
		/**
		 * 录入订单下每个客人的费用
		 * @param europeCustomerFeeVO
		 * @return
		 */
		@RequestMapping(value="/saveEuropecustomerFee",method=RequestMethod.POST) 
		public String saveEuropecustomerFee(EuropeCustomerFeeVO europeCustomerFeeVO,Model model){
			BigDecimal amount = new BigDecimal(0.00);
			EuropeTourPrice europeTourprice = europeCustomerFeeVO.getEuropeTourPrice();
			europeTourprice.setEuropeTourPriceId(UUIDGenerator.getUUID());
			List<EuropeCustomerFee> europecustomerFeeList = europeCustomerFeeVO.getEuropeCustomerFeeList();
			RateOfCurrency rateOfCurrency = rateOfCurrencyService.findById(europecustomerFeeList.get(0).getRateOfCurrencyId());
			for(EuropeCustomerFee europecustomerFee:europecustomerFeeList){
				if(europecustomerFee.getEnterCurrency()==null){
					europecustomerFee.setEnterCurrency(new BigDecimal(0.00)); 
				}
				europecustomerFee.setEuropeTourPriceId(europeTourprice.getEuropeTourPriceId());
				europecustomerFee.setEuropeCustomerFeeId(UUIDGenerator.getUUID());
				europecustomerFee.setState(1);//费用已录状态
				europecustomerFee.setAmount(europecustomerFee.getEnterCurrency().multiply(rateOfCurrency.getRateUp()).divide(rateOfCurrency.getRateDown(),2));
				europecustomerFee.setDollar(europecustomerFee.getEnterCurrency().divide(rateOfCurrency.getUsRate(),2));
				amount = amount.add(europecustomerFee.getEnterCurrency());
				europeCustomerFeeService.save(europecustomerFee);
			}
			europeTourprice.setReceivableAmount(amount);
			europeTourprice.setCompleteState(1);
			europeTourPriceService.save(europeTourprice);
			Tour tour = tourService.findById(europeTourprice.getTourId());
			tour.setState(1);
			tourService.update(tour);
			model.addAttribute("menuId", 413);
			return "redirect:customerList?orderId="+europeTourprice.getOrderId();
		}
		
		/**
		 * 修改每个订单下的客人费用
		 * @param europeCustomerFee
		 * @param model
		 * @return 
		 */
		@RequestMapping(value="/updateEuropeCustomerFee",method=RequestMethod.POST)
		public String updateEuropeCustomerFee(EuropeCustomerFee europeCustomerFee,Model model){
			europeCustomerFeeService.update(europeCustomerFee);
			europeCustomerFee = europeCustomerFeeService.findById(europeCustomerFee.getEuropeCustomerFeeId());
			BigDecimal totalEnterCurrency = new BigDecimal(0.00);
			EuropeCustomerFee europeCustomerFeeTemp = new EuropeCustomerFee();
			europeCustomerFeeTemp.setEuropeTourPriceId(europeCustomerFee.getEuropeTourPriceId());
			List<EuropeCustomerFee> europeCustomerFeeList = europeCustomerFeeService.find(europeCustomerFeeTemp);
			for(EuropeCustomerFee ecf:europeCustomerFeeList){
				totalEnterCurrency = totalEnterCurrency.add(ecf.getEnterCurrency());
			}
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setEuropeTourPriceId(europeCustomerFeeList.get(0).getEuropeTourPriceId());
			europeTourPrice.setReceivableAmount(totalEnterCurrency);
			europeTourPriceService.update(europeTourPrice);
			model.addAttribute("menuId", 413);
			return "redirect:customerList?orderId="+europeCustomerFeeList.get(0).getOrderId();
		}
		
		@RequestMapping(value="/updateEuropeTourPrice",method=RequestMethod.POST)
		public String updateEuropeTourPrice(EuropeTourPrice europeTourPrice,Model model){
			europeTourPriceService.update(europeTourPrice);
			model.addAttribute("menuId", 413);
			return "redirect:settleForOPPage?id="+europeTourPrice.getTourId();
		}
		
		//agent审核详情页面
		@RequestMapping(value="/approveInfoForAgent",method=RequestMethod.GET)
		public String approveInfoForAgent(String id,int flag,Model model){
			EuropeTourPrice europeTourPrice = europeTourPriceService.findById(id);
			List<EuropeCustomerFee> europecustomerFeeList = europeCustomerFeeService.findCustomerWithFee(europeTourPrice.getOrderId());
			model.addAttribute("europeTourPrice", europeTourPrice);
			model.addAttribute("europecustomerFeeList", europecustomerFeeList);
			model.addAttribute("flag", flag);
			model.addAttribute("menuId", 501);
			return "/admin/orderSupplier/approveInfoForAgent";
			
		}
		//财务审核income详情页面
		@RequestMapping(value="/approveInfoForAcc",method=RequestMethod.GET)
		public String approveInfoForAcc(String id,int flag,Model model){
			EuropeTourPrice europeTourPrice = europeTourPriceService.findById(id);
			List<EuropeCustomerFee> europecustomerFeeList = europeCustomerFeeService.findCustomerWithFee(europeTourPrice.getOrderId());
			EuropeTourPrice europeTourPriceTemp = new EuropeTourPrice();
			europeTourPriceTemp.setOrderId(europeTourPrice.getOrderId());
			europeTourPriceTemp.setPayOrCost(3);
			List<EuropeTourPrice> billChangeList = europeTourPriceService.find(europeTourPriceTemp);
			model.addAttribute("europeTourPrice", europeTourPrice);
			model.addAttribute("billChangeList", billChangeList);
			model.addAttribute("europecustomerFeeList", europecustomerFeeList);
			model.addAttribute("flag", flag);
			model.addAttribute("menuId", 519);
			return "/admin/orderSupplier/approveInfoForAcc";
		}
		
		//打印结算页面
		@RequestMapping(value="/printSettlePage",method=RequestMethod.GET)
		public String printSettlePage(String tourId,Model model){
			Tour tour = tourService.findById(tourId);
			EuropeTourPrice europeTourPrice = new EuropeTourPrice();
			europeTourPrice.setTourId(tourId);
			List<EuropeTourPrice> europeTourPriceList = europeTourPriceService.find(europeTourPrice);
			model.addAttribute("europeTourPriceList", europeTourPriceList);
			model.addAttribute("menuId", 518);
			model.addAttribute("tour", tour);
			model.addAttribute("userName", adminService.getCurrent().getUsername());
			return "/admin/orderSupplier/printSettlePage";
		}
	
		//给机票录账单
	@RequestMapping(value = "/billForOrder", method = RequestMethod.GET)
	public String billForOrder(ModelMap model,String orderId) {
		Order order = orderService.findById(orderId);
		model.addAttribute("orderNo",order.getOrderNo());
		model.addAttribute("menuId", "413");
		return "/admin/orderSupplier/billForOrder"; 
	}
	
	@RequestMapping(value = "/saveBillForFlightTicket", method = RequestMethod.POST)
	public String saveBillForFlightTicket(Model model,SupplierPriceForOrder supplierPriceForOrder) {
		supplierPriceForOrder.setSupplierPriceForOrderId(UUIDGenerator.getUUID());
		supplierPriceForOrderService.save(supplierPriceForOrder);
		return "redirect:/admin/supplierPrice/orderBillList.jhtml";
	}
	
	//机票账单（op财务审核账单）
	@RequestMapping(value = "/ticketList", method = RequestMethod.GET)
	public String accCheckForTicket(ModelMap model) {
		model.addAttribute("menuId", "515");
		return "/admin/orderSupplier/ticketList";
	}

	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/ticketList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> ticketList(Pageable pageable, SupplierPriceForOrder supplierPriceForOrder) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = adminService.getCurrent();
		supplierPriceForOrder.setDeptId(admin.getDeptId());
		Page<SupplierPriceForOrder> page = supplierPriceForOrderService.findPage(supplierPriceForOrder, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(supplierPriceForOrderService.findAirPepole(supplierPriceForOrder));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	//批量审核机票
	@RequestMapping(value = "/AdultTicketAll", method = RequestMethod.POST)
	public String AdultTicketAll(ModelMap model, String[] approveStatusId,
			String menuId, RedirectAttributes redirectAttributes) {
		List<SupplierPriceForOrder> supplierPriceForOrderList = new ArrayList<SupplierPriceForOrder>();
		for(String id:approveStatusId){
			if(id!=null&&id!=""){
				SupplierPriceForOrder sp=supplierPriceForOrderService.findById(id);
				supplierPriceForOrderList.add(sp);
				if(sp.getAgentId()!=""){
				/** 此处添加机票部门强制审核状态为New和状态为approved的账单 */
				if(sp.getApproveStatus()==0){
					sp.setApproveStatus(1);
				}
				Dept dept=deptService.findById(adminService.findById(sp.getUserId()).getDeptId());//op
				Admin admin=adminService.findById(sp.getAgentId());
				Dept toDept=deptService.findById(admin.getDeptId());
				RateOfCurrency rc=rateOfCurrencyService.findById(sp.getRateOfCurrencyId());
				BigDecimal bill=sp.getAmount().subtract(sp.getCharge());
					if(sp.getApproveStatus()==1){
						boolean b=supplierCheckService.billInvoice(dept, toDept, sp.getRateOfCurrencyId(),bill, bill.divide(rc.getUsRate(),2), admin.getUsername(),sp.getInvoiceNum(),sp.getDate());
						if(b){
							if(sp.getTempValue02()!=null&&sp.getTempValue02()!=""){
								//添加账单成本
								PayCostRecords payCostRecords = new PayCostRecords();
								payCostRecords.setId(UUIDGenerator.getUUID());
								payCostRecords.setOrderId(sp.getTempValue02());
								payCostRecords.setSum(bill);
								payCostRecords.setWay("机票");
								payCostRecords.setCode(sp.getCode());
								payCostRecords.setVenderId(sp.getVenderId());
								payCostRecords.setTime(new Date());
								payCostRecords.setType(3);
								payCostRecords.setStatus(4);//系统审核
								payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.BILLREMARKS);
								payCostRecords.setRemark(Constant.SYSTEMPINPUT + sp.getInvoiceNo()+"Air Ticket");
								payCostRecords.setItem(Constant.FLIGHT);
								payCostRecords.setPayOrCost(2);
								payCostRecordsService.save(payCostRecords);
							}
							sp.setApproveStatus(2);
							supplierPriceForOrderService.update(sp);
						}
					}
				}else{
					sp.setApproveStatus(2);
					supplierPriceForOrderService.update(sp);
				}
			}
		}
		/*if(supplierPriceForOrderList!=null&&supplierPriceForOrderList.size()>0){
			dataFactoryService.airTicToQb(supplierPriceForOrderList);
		}*/
		return "/admin/orderSupplier/ticketList";
	}
	
	
	/**
	 * op财务审核    审核状态：0-初始状态 ，1-通过，2-未通过
	 */
	public String accCheckForOp(String supplierPriceForOrderIds,int isPass,String accRemarkOfOp){
		
		return supplierPriceForOrderIds;
	}
	/**
	 * 添加机票
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addBill", method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", "515");
		model.addAttribute("deptList", deptService.findAll());
		return "/admin/orderSupplier/add";
	}
	/**
	 * 保存d
	 * 
	 * @param 
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save( SupplierPriceForOrder supplierPriceForOrder, RedirectAttributes redirectAttributes) {
		Admin admin = adminService.getCurrent();
		if(supplierPriceForOrder.getType()==0&&supplierPriceForOrder.getAgentId()!=null){
			//查找本部门的汇率
			RateOfCurrency rateOfCurrency=new RateOfCurrency();
			Dept dept=deptService.findById(admin.getDeptId());
			rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
			Admin adminS=adminService.findById(supplierPriceForOrder.getAgentId());
			Dept deptS=deptService.findById(adminS.getDeptId());
			rateOfCurrency.setToCurrencyId(deptS.getCurrencyTypeId());
			rateOfCurrency.setIsAvailable(0);// 0 可 用
			List<RateOfCurrency> rateOfCurrencyList = rateOfCurrencyService.find(rateOfCurrency);
			
			if (rateOfCurrencyList.size()>0) {
				supplierPriceForOrder.setRateOfCurrencyId(rateOfCurrencyList.get(0).getId());
			}
		}
		supplierPriceForOrder.setSupplierPriceForOrderId(UUIDGenerator.getUUID());
		List<AirticketItems> airticketItemsList=supplierPriceForOrder.getAirticketItemsList();
		String str="";//航班号
		BigDecimal net=new BigDecimal(0.00);//应付费用
		BigDecimal selling=new BigDecimal(0.00);//应收费用
		BigDecimal charge=new BigDecimal(0.00);//应收费用
		BigDecimal total=new BigDecimal(0.00);
		BigDecimal tax=new BigDecimal(0.00);
		for (AirticketItems airticketItems : airticketItemsList) {
			if(airticketItems.getTicketNo()!=null){
				str=str+","+airticketItems.getTicketNo();
			}else{
				airticketItems.setTicketNo("");
			}
			if(airticketItems.getNet()!=null){
				net=net.add(airticketItems.getNet());
			}else{
				airticketItems.setNet(new BigDecimal(0.00));
			}
			if(airticketItems.getTotal()!=null){
				total=total.add(airticketItems.getTotal());
			}else{
				airticketItems.setTotal(new BigDecimal(0.00));
			}
			if(airticketItems.getTax()!=null){
				tax=tax.add(airticketItems.getTax());
			}else{
				airticketItems.setTax(new BigDecimal(0.00));
			}
			if(airticketItems.getSelling()!=null){
				selling=selling.add(airticketItems.getSelling());
			}else{
				airticketItems.setSelling(new BigDecimal(0.00));
			}
			if(airticketItems.getCharge()!=null){
				charge=charge.add(airticketItems.getCharge());
			}else{
				airticketItems.setCharge(new BigDecimal(0.00));
			}
			airticketItems.setItemsId(UUIDGenerator.getUUID());
			airticketItems.setSupplierpricefororderId(supplierPriceForOrder.getSupplierPriceForOrderId());
		}
		if(str!=""){
			str=str.substring(1);
		}
		airticketItemsService.batchSave(airticketItemsList);
		supplierPriceForOrder.setTicketNo(str);
		supplierPriceForOrder.setOperatorFee(total);
		supplierPriceForOrder.setNet(net);
		supplierPriceForOrder.setAmount(selling);
		supplierPriceForOrder.setCharge(charge);
		supplierPriceForOrder.setUserId(admin.getId());
		supplierPriceForOrder.setUserName(admin.getUsername());
		supplierPriceForOrder.setDeptId(admin.getDeptId());
		supplierPriceForOrderService.save(supplierPriceForOrder);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:ticketList.jhtml";
	}
	/**
	 * 修改
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editBill",method = RequestMethod.GET)
	public String editBill(String id, Model model) {
		SupplierPriceForOrder sp=supplierPriceForOrderService.findById(id);
		Admin agent=new Admin();
		if(sp.getAgentId()!=null&&sp.getAgentId()!=""){
			agent=adminService.findById(sp.getAgentId());
		}
		model.addAttribute("menuId", 515);
		model.addAttribute("agent", agent);
		model.addAttribute("deptList", deptService.findAll());
		model.addAttribute("itemsList", airticketItemsService.findByOrderId(id));
		model.addAttribute("supplierPriceForOrder", supplierPriceForOrderService.findById(id));
		return "/admin/orderSupplier/edit";
	}
	
	/**
	 * 根据传来的GroupLine对象进行更新操作
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value="/updateBill",method = RequestMethod.POST)
	public String updateBill(SupplierPriceForOrder supplierPriceForOrder, RedirectAttributes redirectAttributes,String menuId) {
		List<AirticketItems> airticketItemsList=supplierPriceForOrder.getAirticketItemsList();
		String str="";//航班号
		BigDecimal net=new BigDecimal(0.00);//应付费用
		BigDecimal selling=new BigDecimal(0.00);//应收费用
		BigDecimal charge=new BigDecimal(0.00);//应收费用
		BigDecimal total=new BigDecimal(0.00);
		BigDecimal tax=new BigDecimal(0.00);
		for (AirticketItems airticketItems : airticketItemsList) {
			if(airticketItems.getTicketNo()!=null){
				str=str+","+airticketItems.getTicketNo();
			}else{
				airticketItems.setTicketNo("");
			}
			if(airticketItems.getNet()!=null){
				net=net.add(airticketItems.getNet());
			}else{
				airticketItems.setNet(new BigDecimal(0.00));
			}
			if(airticketItems.getTotal()!=null){
				total=total.add(airticketItems.getTotal());
			}else{
				airticketItems.setTotal(new BigDecimal(0.00));
			}
			if(airticketItems.getTax()!=null){
				tax=tax.add(airticketItems.getTax());
			}else{
				airticketItems.setTax(new BigDecimal(0.00));
			}
			if(airticketItems.getSelling()!=null){
				selling=selling.add(airticketItems.getSelling());
			}else{
				airticketItems.setSelling(new BigDecimal(0.00));
			}
			if(airticketItems.getCharge()!=null){
				charge=charge.add(airticketItems.getCharge());
			}else{
				airticketItems.setCharge(new BigDecimal(0.00));
			}
			if(airticketItems.getItemsId()!=null){
				airticketItemsService.update(airticketItems);
			}else{
				airticketItems.setItemsId(UUIDGenerator.getUUID());
				airticketItems.setSupplierpricefororderId(supplierPriceForOrder.getSupplierPriceForOrderId());
				airticketItemsService.save(airticketItems);
			}
			
		}
		if(str!=""){
			str=str.substring(1);
		}
		SupplierPriceForOrder s=supplierPriceForOrderService.findById(supplierPriceForOrder.getSupplierPriceForOrderId());
		
		if(supplierPriceForOrder.getAgentId()!=null && s.getAgentId()!="" && !supplierPriceForOrder.getAgentId().equals(s.getAgentId())){
			Admin admin = adminService.getCurrent();
			RateOfCurrency rateOfCurrency=new RateOfCurrency();
			Dept dept=deptService.findById(admin.getDeptId());
			rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
			Admin adminS=adminService.findById(supplierPriceForOrder.getAgentId());
			Dept deptS=deptService.findById(adminS.getDeptId());
			rateOfCurrency.setToCurrencyId(deptS.getCurrencyTypeId());
			rateOfCurrency.setIsAvailable(0);// 0 可 用
			List<RateOfCurrency> rateOfCurrencyList = rateOfCurrencyService.find(rateOfCurrency);
			
			if (rateOfCurrencyList.size()>0) {
				supplierPriceForOrder.setRateOfCurrencyId(rateOfCurrencyList.get(0).getId());
			}
		}
		supplierPriceForOrder.setTicketNo(str);
		supplierPriceForOrder.setNet(net);
		supplierPriceForOrder.setOperatorFee(total);
		supplierPriceForOrder.setAmount(selling);
		supplierPriceForOrder.setCharge(charge);
		supplierPriceForOrderService.update(supplierPriceForOrder);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:ticketList.jhtml";
	}
	/**
	 * agent审核
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/agentTicketCheck",method = RequestMethod.GET)
	public String agentTicketCheck(String id, Model model) {
		model.addAttribute("menuId", 516);
		// 汇率的合计
		RateOfCurrency rateOfCurrency =new RateOfCurrency();
		SupplierPriceForOrder sp=supplierPriceForOrderService.findById(id);
		rateOfCurrency=rateOfCurrencyService.findById(sp.getRateOfCurrencyId());
		// 数据源币种
		Dept dept=deptService.findById(adminService.findById(sp.getAgentId()).getDeptId());
		rateOfCurrency.setCurrencyId(currencyTypeService.findById(deptService.findById(adminService.getCurrent().getDeptId()).getCurrencyTypeId()).getSymbol());
		// 转换当前部门币种
		rateOfCurrency.setToCurrencyId(currencyTypeService.findById(deptService.findById(dept.getDeptId()).getCurrencyTypeId()).getSymbol());
		model.addAttribute("supplierPriceForOrder", sp);
		model.addAttribute("rateOfCurrency", rateOfCurrency);
		return "/admin/orderSupplier/agentTicketCheck";
	}
	/**
	 * 财务审核
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/accTicketCheck",method = RequestMethod.GET)
	public String accTicketCheck(String id, Model model) {
		model.addAttribute("menuId", 516);
		// 汇率的合计
		RateOfCurrency rateOfCurrency =new RateOfCurrency();
		SupplierPriceForOrder sp=supplierPriceForOrderService.findById(id);
		rateOfCurrency=rateOfCurrencyService.findById(sp.getRateOfCurrencyId());
		// 数据源币种
		Dept dept=deptService.findById(adminService.findById(sp.getAgentId()).getDeptId());
		rateOfCurrency.setCurrencyId(currencyTypeService.findById(deptService.findById(adminService.getCurrent().getDeptId()).getCurrencyTypeId()).getSymbol());
		// 转换当前部门币种
		rateOfCurrency.setToCurrencyId(currencyTypeService.findById(deptService.findById(dept.getDeptId()).getCurrencyTypeId()).getSymbol());
		model.addAttribute("supplierPriceForOrder", sp);
		model.addAttribute("rateOfCurrency", rateOfCurrency);
		return "/admin/orderSupplier/accTicketCheck";
	}
	/**
	 * 上传
	 * @param file 上传文件
	 * @param id 
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(MultipartFile file, SupplierPriceForOrder supplierPriceForOrder,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
	
		String fileString= fileService.uploadLocal(FileType.tourQuotePath,file);
		if(fileString!=null){
			supplierPriceForOrder.setUploadUrl(fileString);
			supplierPriceForOrderService.update(supplierPriceForOrder);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:ticketList.jhtml";
	}
	/**
	 * 下载
	 * 
	 * @author
	 * @date
	 * @param attachment
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/download")
	public ModelAndView download(HttpServletRequest request,
			HttpServletResponse response,String id) throws Exception {
		
		SupplierPriceForOrder sp=supplierPriceForOrderService.findById(id);
		String downLoadPath =sp.getUploadUrl();
		String contentType = "application/octet-stream";
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	/**
	 * 航班机票
	 * 删除
	 */
	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String del(SupplierPriceForOrder supplierPriceForOrder,String menuId,
			RedirectAttributes redirectAttributes) {
		if(supplierPriceForOrder.getSupplierPriceForOrderId()!=null){
			supplierPriceForOrder.setIsDel(1);//1代表删除 取消
			supplierPriceForOrderService.update(supplierPriceForOrder);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:ticketList.jhtml";
	}
	/**
	 * agent审核通过 
	 * @return
	 */
	@RequestMapping(value="/agentTicketCheckChange",method = RequestMethod.POST)
	public String agentTicketCheckChange(SupplierPriceForOrder supplierPriceForOrder, RedirectAttributes redirectAttributes) {
		SupplierPriceForOrder sp=supplierPriceForOrderService.findById(supplierPriceForOrder.getSupplierPriceForOrderId());
		//Dept dept=deptService.findById(adminService.findById(sp.getUserId()).getDeptId());//op
		//Admin admin=adminService.findById(sp.getAgentId());
		//Dept toDept=deptService.findById(admin.getDeptId());
		//RateOfCurrency rc=rateOfCurrencyService.findById(sp.getRateOfCurrencyId());
//		BigDecimal bill=sp.getAmount().subtract(sp.getCharge());
//		if(sp.getTempValue02()!=null&&sp.getTempValue02()!=""){
//			//添加账单成本
//			PayCostRecords payCostRecords = new PayCostRecords();
//			payCostRecords.setId(UUIDGenerator.getUUID());
//			payCostRecords.setOrderId(sp.getTempValue02());
//			payCostRecords.setSum(bill);
//			payCostRecords.setWay("机票");
//			payCostRecords.setCode(sp.getCode());
//			payCostRecords.setVenderId(sp.getVenderId());
//			payCostRecords.setTime(new Date());
//			payCostRecords.setType(3);
//			payCostRecords.setStatus(4);//系统审核
//			payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.BILLREMARKS);
//			payCostRecords.setRemark(Constant.SYSTEMPINPUT + sp.getInvoiceNo()+"Air Ticket");
//			payCostRecords.setItem(Constant.FLIGHT);
//			payCostRecords.setPayOrCost(2);
//			payCostRecordsService.save(payCostRecords);
//		}
		
		//对账(对账功能放在了财务在agent审核后再次通过后发送对账)
		//supplierCheckService.billInvoice(dept, toDept, sp.getRateOfCurrencyId(),bill, bill.divide(rc.getUsRate(),2), admin.getUsername(),sp.getInvoiceNo(),sp.getDate());
		supplierPriceForOrderService.update(supplierPriceForOrder);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:ticketAgentCheckList.jhtml";
	}
	
	//机票账单（财务审核账单）
	@RequestMapping(value = "/ticketAccCheckList", method = RequestMethod.GET)
	public String ticketAccCheckList(ModelMap model) {
		model.addAttribute("menuId", "516");
		return "/admin/orderSupplier/ticketAccCheckList";
	}
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/ticketAccCheckList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> ticketAccCheckList(Pageable pageable, SupplierPriceForOrder supplierPriceForOrder) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = adminService.getCurrent();
		supplierPriceForOrder.setDeptId(admin.getDeptId());
		//supplierPriceForOrder.setType(0);//Agent
		Page<SupplierPriceForOrder> page = supplierPriceForOrderService.findPage(supplierPriceForOrder, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(supplierPriceForOrderService.findAirPepole(supplierPriceForOrder));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	//机票账单（财务审核账单）
	@RequestMapping(value = "/ticketAgentCheckList", method = RequestMethod.GET)
	public String ticketAgentCheckList(ModelMap model) {
		model.addAttribute("menuId", "517");
		return "/admin/orderSupplier/ticketAgentCheckList";
	}
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/ticketAgentCheckList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> ticketAgentCheckList(Pageable pageable, SupplierPriceForOrder supplierPriceForOrder) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = adminService.getCurrent();
		supplierPriceForOrder.setAgentId(admin.getId());
		supplierPriceForOrder.setType(0);//Agent
		Page<SupplierPriceForOrder> page = supplierPriceForOrderService.findPage(supplierPriceForOrder, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * export 导出 统计
	 * @return
	 */
	@RequestMapping(value="/excelForAir",method=RequestMethod.GET)  
    public ModelAndView excelForAir(SupplierPriceForOrder supplierPriceForOrder,HttpServletRequest request, HttpServletResponse response) {
		Admin admin = adminService.getCurrent();
		SupplierPriceForOrderExcle ss=new SupplierPriceForOrderExcle();
		supplierPriceForOrder.setDeptId(admin.getDeptId());
		List<SupplierPriceForOrder> airList = supplierPriceForOrderService.airTicekExcle(supplierPriceForOrder);
		ss.setAirList(airList);
		return new ModelAndView(ss);
    }
	/**
	 * export 导出 item
	 * @return
	 */
	@RequestMapping(value="/excelForAirItem",method=RequestMethod.GET)  
    public ModelAndView excelForAirItem(SupplierPriceForOrder supplierPriceForOrder,HttpServletRequest request, HttpServletResponse response) {
		Admin admin = adminService.getCurrent();
		SupplierPriceForOrderExcle ss=new SupplierPriceForOrderExcle();
		supplierPriceForOrder.setDeptId(admin.getDeptId());
		ss.setTemp(1);
		List<SupplierPriceForOrder> airList = supplierPriceForOrderService.airTicekItemExcle(supplierPriceForOrder);
		ss.setAirList(airList);
		return new ModelAndView(ss);
    }
	/**
	 * 上传
	 * @param file 上传文件
	 * @param id 
	 * @param redirectAttributes
	 * @param menuId   判断是非团还是团
	 * @return
	 */
	@RequestMapping(value = "/uploadTourFile", method = RequestMethod.POST)
	public String uploadTourFile(MultipartFile file,SupplierPrice sp,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
	
		String fileString= fileService.uploadLocal(FileType.tourQuotePath,file);
		if(fileString!=null){
			sp.setFileUrl(fileString);
			supplierPriceService.update(sp);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:orderInfoList";
	}
	
	/**
	 * 上传
	 * @param file 上传文件
	 * @param id    Group OP 录账单功能
	 * @param redirectAttributes
	 * @param menuId   判断是非团还是团
	 * @return
	 */
	@RequestMapping(value = "/uploadTourFileGroup", method = RequestMethod.POST)
	public String uploadTourFileGroup(MultipartFile file,SupplierPrice sp,
			HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
	
		String fileString= fileService.uploadLocal(FileType.tourQuotePath,file);
		if(fileString!=null){
			sp.setFileUrl(fileString);
			supplierPriceService.update(sp);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:orderInfoListGroup";
	}
	/**
	 * 下载
	 * 
	 * @author
	 * @date
	 * @param attachment
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/downloadTourFile")
	public ModelAndView downloadTourFile(HttpServletRequest request,
			HttpServletResponse response,String id) throws Exception {
		
		SupplierPrice sp=supplierPriceService.findById(id);
		String downLoadPath =sp.getFileUrl();
		String contentType = "application/octet-stream";
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	/**
	 * 添加机票
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addGroupTicket", method = RequestMethod.GET)
	public String addGroupTicket(Model model) {
		model.addAttribute("menuId", "515");
		model.addAttribute("deptList", deptService.findAll());
		return "/admin/orderSupplier/addGroupTicket";
	}
	
	/**
	 * 异步查询团订单
	 */
	@RequestMapping(value = "/customerListSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> customerListSelect(String tourId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CustomerOrderVO> customerList=supPriceInfoRelService.findCustomerByTourId(tourId);
		for(int i=customerList.size()-1;i>=0;i--){
			if(!customerList.get(i).getTicketType().equals("GIT Ticket")){  
				customerList.remove(i);  
            }   
		}
		map.put("customerList", customerList);
		return map;
	}
	/**
	 * 团票保存
	 * 
	 * @param 
	 * @return
	 */
	@RequestMapping(value = "/saveGit", method = RequestMethod.POST)
	public String saveGit( SupplierPriceForOrder supplierPriceForOrder, RedirectAttributes redirectAttributes,int ticketNo) {
		Admin admin = adminService.getCurrent();
		List<SupplierPriceForOrder> SOrderList=new ArrayList<SupplierPriceForOrder>();
		List<AirticketItems> airticketItemsList=supplierPriceForOrder.getAirticketItemsList();
		if(airticketItemsList==null){
			return "redirect:ticketList.jhtml";
		}
		//给 详情表 添加 机票id
		for (int i=0;i<airticketItemsList.size();i++) {
			String str="";//航班号
			BigDecimal net=new BigDecimal(0.00);//应付费用
			BigDecimal selling=new BigDecimal(0.00);//应收费用
			BigDecimal charge=new BigDecimal(0.00);//应收费用
			
			airticketItemsList.get(i).setItemsId(UUIDGenerator.getUUID());
			SupplierPriceForOrder su=new SupplierPriceForOrder();
			boolean temp=false;
			if(airticketItemsList.get(i).getSupplierpricefororderId()==null){
				su.setSupplierPriceForOrderId(UUIDGenerator.getUUID());
				airticketItemsList.get(i).setSupplierpricefororderId(su.getSupplierPriceForOrderId());
				su.setAgentId(airticketItemsList.get(i).getUserId());
				if(airticketItemsList.get(i).getTicketNo()!=null){
					str=str+","+airticketItemsList.get(i).getTicketNo();
				}else{
					airticketItemsList.get(i).setTicketNo("");
				}
				if(airticketItemsList.get(i).getNet()!=null){
					net=net.add(airticketItemsList.get(i).getNet());
				}else{
					airticketItemsList.get(i).setNet(new BigDecimal(0.00));
				}
				if(airticketItemsList.get(i).getSelling()!=null){
					selling=selling.add(airticketItemsList.get(i).getSelling());
				}else{
					airticketItemsList.get(i).setSelling(new BigDecimal(0.00));
				}
				if(airticketItemsList.get(i).getCharge()!=null){
					charge=charge.add(airticketItemsList.get(i).getCharge());
				}else{
					airticketItemsList.get(i).setCharge(new BigDecimal(0.00));
				}
				su.setTempValue01(airticketItemsList.get(i).getUserName());
				su.setTempValue02(airticketItemsList.get(i).getOrderId());
				su.setTempValue03(airticketItemsList.get(i).getOrderNo());
				temp=true;
			}
			int qty=1;//机票数量
			for (int j=i+1;j<airticketItemsList.size();j++) {
				if(airticketItemsList.get(j).getSupplierpricefororderId()==null
						&&airticketItemsList.get(j).getOrderNo().equals(airticketItemsList.get(i).getOrderNo())){
					airticketItemsList.get(j).setSupplierpricefororderId(airticketItemsList.get(i).getSupplierpricefororderId());
					airticketItemsList.get(i).setItemsId(UUIDGenerator.getUUID());
					if(airticketItemsList.get(j).getTicketNo()!=null){
						str=str+","+airticketItemsList.get(j).getTicketNo();
					}else{
						airticketItemsList.get(j).setTicketNo("");
					}
					if(airticketItemsList.get(j).getNet()!=null){
						net=net.add(airticketItemsList.get(j).getNet());
					}else{
						airticketItemsList.get(j).setNet(new BigDecimal(0.00));
					}
					if(airticketItemsList.get(j).getSelling()!=null){
						selling=selling.add(airticketItemsList.get(j).getSelling());
					}else{
						airticketItemsList.get(j).setSelling(new BigDecimal(0.00));
					}
					if(airticketItemsList.get(j).getCharge()!=null){
						charge=charge.add(airticketItemsList.get(j).getCharge());
					}else{
						airticketItemsList.get(j).setCharge(new BigDecimal(0.00));
					}
					qty+=1;
				}
			}
			//保存机票数据
			if(temp){
				if(str!=""){
					str=str.substring(1);
				}
				su.setTicketNo(str);
				su.setQuantity(qty);
				if(supplierPriceForOrder.getTempValue06().equals("0")){
					su.setTempValue06("0");
				}else{
					su.setTempValue06((net.subtract(charge))+"");
				}
				su.setOperatorFee(net);
				su.setAmount(selling);
				su.setCharge(charge);
				SOrderList.add(su);
			}
			
		}
		
		for(int i=0;i<SOrderList.size();i++){
			SupplierPriceForOrder su=SOrderList.get(i);
			//查找本部门的汇率
			RateOfCurrency rateOfCurrency=new RateOfCurrency();
			Dept dept=deptService.findById(admin.getDeptId());
			rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
			Admin adminS=adminService.findById(su.getAgentId());
			Dept deptS=deptService.findById(adminS.getDeptId());
			rateOfCurrency.setToCurrencyId(deptS.getCurrencyTypeId());
			rateOfCurrency.setIsAvailable(0);// 0 可 用
			List<RateOfCurrency> rateOfCurrencyList = rateOfCurrencyService.find(rateOfCurrency);
			
			if (rateOfCurrencyList.size()>0) {
				su.setRateOfCurrencyId(rateOfCurrencyList.get(0).getId());
			}
			su.setInvoiceNo(supplierPriceForOrder.getInvoiceNo());
			su.setAirline(supplierPriceForOrder.getAirline());
			su.setFlightPnr(supplierPriceForOrder.getFlightPnr());
			su.setCard(supplierPriceForOrder.getCard());
			su.setDate(supplierPriceForOrder.getDate());
			su.setType(0);
			su.setTempValue04(supplierPriceForOrder.getTempValue04());
			su.setTempValue05(supplierPriceForOrder.getTempValue05());
			//su.setTempValue06(supplierPriceForOrder.getTempValue06());
			su.setRemarkOfAgent(supplierPriceForOrder.getRemarkOfAgent());
			su.setVenderId(supplierPriceForOrder.getVenderId());
			su.setSupplierName(supplierPriceForOrder.getSupplierName());
			su.setCode(supplierPriceForOrder.getCode());
			su.setRemark(supplierPriceForOrder.getRemark());
			su.setUserId(admin.getId());
			su.setUserName(admin.getUsername());
			su.setDeptId(admin.getDeptId());
			supplierPriceForOrderService.save(su);
		}
		airticketItemsService.batchSave(airticketItemsList);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:ticketList.jhtml";
	}
	/**
	 * Team账单审核
	 * */
	@RequestMapping(value="/groupTourList",method=RequestMethod.GET)
	public String groupTourList(Model model){
		Admin admin = adminService.getCurrent();
		int sumForAgent = europeTourPriceService.findSumForAgent(admin.getId());
		model.addAttribute("sumForAgent", sumForAgent);
		model.addAttribute("menuId", 521);
		return "/admin/finance/accountant/tourCheckOfGroupList";
	}
	@RequestMapping(value = "/groupTourList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> groupTourList(Pageable pageable, SupplierPrice supplierPrice) {
		Map<String, Object> map = new HashMap<String, Object>();
		supplierPrice.setGroupId(adminService.getCurrent().getGroupId());
		Page<SupplierPrice> page=supplierPriceService.findForAgentGroupPage(supplierPrice, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * agent审核账单页(Team)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/approveForGroup", method = RequestMethod.GET)
	public String approveForGroup(Model model){
		Admin admin = adminService.getCurrent();
		int sumForAgent = europeTourPriceService.findSumForAgent(admin.getId());
		model.addAttribute("sumForAgent", sumForAgent);
		model.addAttribute("menuId", 521);
		model.addAttribute("userName", adminService.getCurrent().getUsername());
		return  "/admin/orderSupplier/approveForGroup";
	}
	
	@RequestMapping(value="/approveForGroup", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> approveForGroup(Pageable pageable,EuropeTourPrice europeTourPrice){
		Map<String, Object> map = new HashMap<String, Object>();
		europeTourPrice.setGroupId(adminService.getCurrent().getGroupId());
		europeTourPrice.setPayOrCost(0);
		Page<EuropeTourPrice> page = europeTourPriceService.findForGroupPage(europeTourPrice, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * agent审核账单页
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/approveRevisedForGroup", method = RequestMethod.GET)
	public String approveRevisedForGroup(Model model){
		Admin admin = adminService.getCurrent();
		int sumForAgent = europeTourPriceService.findSumForAgent(admin.getId());
		model.addAttribute("sumForAgent", sumForAgent);
		model.addAttribute("menuId", 521);
		model.addAttribute("userName", adminService.getCurrent().getUsername());
		return  "/admin/orderSupplier/approveRevisedForGroup";
	}
	
	@RequestMapping(value="/approveRevisedForGroup", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> approveRevisedForGroup(Pageable pageable,EuropeTourPrice europeTourPrice){
		Map<String, Object> map = new HashMap<String, Object>();
		europeTourPrice.setGroupId(adminService.getCurrent().getGroupId());
		europeTourPrice.setPayOrCost(3);
		Page<EuropeTourPrice> page = europeTourPriceService.findForGroupPage(europeTourPrice, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 用于给机票部门录机票账单时检测InvoiceNo是否录入重复
	 * @param invoiceNo
	 * @return
	 */
	@RequestMapping(value="/findByInvoiceNum", method=RequestMethod.POST)
	public @ResponseBody String approveInvoiceNum(String invoiceNo){
		 SupplierPriceForOrder supplierForOrder=supplierPriceForOrderService.findByInvoiceNo(invoiceNo);
		 if(supplierForOrder!=null){
			 return "have";
		 }else{
			 return "hasNot";
		 }
	}
	//产生机票账单的确认单
	@RequestMapping(value = "/invoiceForTicket", method = RequestMethod.GET)  
	public String invoiceForTicket(String id, Model model) {
		model.addAttribute("menuId", 302);
		String destPath = "";
		destPath=invoiceToPdfService.CreateInvoicePdfForTicket(id);
		SupplierPriceForOrder supplierPriceForOrder=supplierPriceForOrderService.findById(id);
		model.addAttribute("destPath", destPath);
		model.addAttribute("invoiceId", supplierPriceForOrder.getSupplierPriceForOrderId());
		model.addAttribute("invoiceNo", supplierPriceForOrder.getInvoiceNum());
		model.addAttribute("iOrV", 1);
		return "/admin/orderSupplier/orderReview";
	}
	/**
	 * 发送邮件
	 * @param 确认单(子单) (op修改之前发送邮件跳转至原页面)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sendMailforTicket", method = RequestMethod.POST)
	public String sendMail(InvoiceMail invoiceMail,RedirectAttributes redirectAttributes) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath(invoiceMail.getDestPath());
		invoiceMail.setDestPath(path);
		sendMailService.senderForAir(invoiceMail);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:invoiceForTicket.jhtml?id=" + invoiceMail.getOrderId()+"&menuId="+invoiceMail.getMenuId();  //跳转至原确认单页面
	}
	/**
	 * 欧洲操作小组功能
	 */
	@RequestMapping(value="/billListForGroup",method = RequestMethod.GET)
	public String billListForGroup(Model model){
		model.addAttribute("menuId", 414);
		return "admin/orderSupplier/orderInfoListGroup";
	}
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/billListForGroup", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> billListForGroup(Pageable pageable, Tour tour) {
		Map<String, Object> map = new HashMap<String, Object>();
		String groupIdString = adminService.getCurrent().getGroupId();
		if(groupIdString==null){
			groupIdString="";
		}
		tour.setGroupId(groupIdString);
		tour.setUserId(adminService.getCurrent().getId());
		Page<Tour> page = supplierPriceService.findPageforGroup(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 跳转 酒店 ；地接 ；机票 ；保险 ；账单List
	 */
	@RequestMapping(value = "/searchSupplierGroup", method = RequestMethod.GET)
	public String searchSupplierGroup(ModelMap model, Tour tour, String type) {
		model.addAttribute("menuId", "414");
		model.addAttribute("tour",tour);
		SupPriceInfoRel supPriceInfoRel= new SupPriceInfoRel();
		supPriceInfoRel.setTourId(tour.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(type));
		model.addAttribute("supPriceInfoRelList",supPriceInfoRelService.find(supPriceInfoRel));
		model.addAttribute("supplierPrice",supplierPriceService.findByTourId(tour.getTourId()));
		if (type.equals("1")) {
			return "/admin/orderSupplier/orderSupplierListGroup";
		} else if (type.equals("2")) {
			return "/admin/orderSupplier/orderHotelListGroup";
		} else if (type.equals("3")) {
			return "/admin/orderSupplier/orderFlightListGroup";
		} else {
			return "/admin/orderSupplier/orderInsuranceListGroup";
		}
	}
	
}

