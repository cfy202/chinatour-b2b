/**
 * 
 */
package com.chinatour.controller.admin;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.bsd.RLoginClient;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.CustomerSource;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.InvoiceAndCreditExcle;
import com.chinatour.entity.OptionalExcurition;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.RegionDeptRel;
import com.chinatour.entity.Statistical;
import com.chinatour.entity.StatisticalReportsExcle;
import com.chinatour.entity.StatisticsSheetExcle;
import com.chinatour.entity.Supplier;
import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.entity.SupplierPriceForOrderExcle;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.RegionDeptRelMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.CustomerSourceService;
import com.chinatour.service.DeptService;
import com.chinatour.service.GroupLineService;
import com.chinatour.service.OptionalExcursionService;
import com.chinatour.service.OrdersTotalService;
import com.chinatour.service.RegionService;
import com.chinatour.service.StatisticalService;
import com.chinatour.service.VenderService;
import com.chinatour.service.impl.VenderServiceImpl;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;
/**
 * 统计
 * @copyright   Copyright: 2015  
 * @author Aries
 * @create-time 2015-01-13 上午11:41:50
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/statistical")
public class StatisticalController  extends BaseController{
	

	public static final TemplateHashModel CONSTANT;
	
	static {
		TemplateHashModel constant = null;
		try {
			constant = BeansWrapper.getDefaultInstance().getStaticModels();
			constant = (TemplateHashModel) constant.get("com.chinatour.Constant");
		} catch (TemplateModelException e) {
			e.printStackTrace();
		}
		CONSTANT = constant;
	}
	
	@Resource(name = "ordersTotalServiceImpl")
	private OrdersTotalService totalService;
	@Resource(name="adminServiceImpl")
	private AdminService adminService;
	@Resource(name="statisticalServiceImpl")
	private StatisticalService statisticalService;
	@Resource(name="deptServiceImpl")
	private DeptService deptService; 
	@Resource(name="venderServiceImpl")
	private VenderService venderService;
	@Resource(name="groupLineServiceImpl")
	private GroupLineService groupLineService;
	@Resource(name="customerSourceServiceImpl")
	private CustomerSourceService customerSourceService;
	@Autowired
	private OptionalExcursionService optionalExcursionService;

	/**
	 * 收客统计
	 *根据role查找统计
	 */
	@RequestMapping(value = "/bookingStatistical", method = RequestMethod.GET)
	public String bookingStatistical(Model model,Statistical statistical,String role,String menuId) {
		Admin admin=adminService.getCurrent();
		List<Statistical> statisticalList=new ArrayList<Statistical>();
		Statistical statisticals=new Statistical();
		if(role.equals("CEO")){//CEO查看
			statistical.setRole("CEO");
		}else if(role.equals("Region")){//区域查看
			statistical.setRole("Region");
			statistical.setRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
		}else if(role.equals("Office")){
			statistical.setDeptId(admin.getDeptId());
		}else if(role.equals("Group")){
			statistical.setDeptId(admin.getDeptId());
			statistical.setGroupId(admin.getGroupId());
		}else{//Agent查看统计
			statistical.setUserId(admin.getId());
		}
		if(statistical.getTime()==null){
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			String date=format.format(new Date());
			statistical.setTime(date);//默认当前年
		}
		statistical.setTotal(100);//默认根据年查找统计
		if(role.equals("OP")){
			statisticals=statisticalService.queryBookingStatisticalOPL(statistical);
		}else{
			statisticals=statisticalService.queryBookingStatisticalL(statistical);
		}
		statisticalList.add(statisticals);
		model.addAttribute("statistical", statistical);
		model.addAttribute("statisticalList", statisticalList);
		model.addAttribute("date", statistical.getTime().toString());
		model.addAttribute("role", role);
		model.addAttribute("type","Book");
		model.addAttribute("menuId", menuId);
		model.addAttribute("constant",CONSTANT);
		return "/admin/statistical/statisticalBooking";
	}
	
	/**
	 * 收客统计
	 *根据role查找统计
	 */
	@RequestMapping(value = "/arrivalStatistical", method = RequestMethod.GET)
	public String arrivalStatistical(Model model,Statistical statistical,String role,String menuId) {
		Admin admin=adminService.getCurrent();
		List<Statistical> statisticalList=new ArrayList<Statistical>();
		Statistical statisticals=new Statistical();
		if(role.equals("CEO")){//CEO查看
			statistical.setRole("CEO");
		}else if(role.equals("Region")){//区域查看
			statistical.setRole("Region");
			statistical.setRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
		}else if(role.equals("Office")){
			statistical.setDeptId(admin.getDeptId());
		}else{//Agent查看统计
			statistical.setUserId(admin.getId());
		}
		if(statistical.getTime()==null){
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			String date=format.format(new Date());
			statistical.setTime(date);//默认当前年
		}
		statistical.setTotal(100);//默认根据年查找统计
		if(role.equals("OP")){
			statisticals=statisticalService.queryArrivalStatisticalOPL(statistical);
		}else{
			statisticals=statisticalService.queryArrivalStatisticalL(statistical);
		}
		statisticalList.add(statisticals);
		model.addAttribute("statistical", statistical);
		model.addAttribute("statisticalList", statisticalList);
		model.addAttribute("date", statistical.getTime().toString());
		model.addAttribute("role", role);
		model.addAttribute("type","Arrival");
		model.addAttribute("menuId", menuId);
		model.addAttribute("constant",CONSTANT);
		return "/admin/statistical/statisticalBooking";
	}
	/**
	 * json调用收客统计
	 * */
	@RequestMapping(value="/getBooking",method=RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> getBooking(Statistical statistical,String data) {
		Admin  admin = adminService.getCurrent();
			int people=0;
			double sumMonth=0;
			int arrivalP=0;
			int sum=0;//年总人数
			double sumFee=0;//年总额
			int sumArrival=0;//年总人数
			int t=0;//标识有权限查找
			Subject currentUser = SecurityUtils.getSubject();
			if (currentUser.isPermitted("admin:CEO")) {  
				statistical.setRole("CEO");
				t=1;
			}else if (currentUser.isPermitted("admin:Region")){
				statistical.setRole("Region");
				statistical.setRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				t=1;
			}else if (currentUser.isPermitted("admin:Office")){
				statistical.setRole("Office");
				statistical.setDeptId(admin.getDeptId());
				t=1;
			}else if(currentUser.isPermitted("admin:Group")){
				statistical.setRole("Group");
				statistical.setGroupId(admin.getGroupId());
				t=1;
			}else if (currentUser.isPermitted("admin:Agent")){
				statistical.setRole("Agent");
				statistical.setUserId(admin.getId());
				t=1;
			}
			/*if(data.equals("month")){*/
			//当前月记录
			if(t==1){
				SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
				String date=format.format(new Date());
				statistical.setTime(date);//默认当前年
				List<Statistical> bookingStatisticalList=statisticalService.queryBookingStatistical(statistical);
				if(bookingStatisticalList.size()>0){
					people=bookingStatisticalList.get(0).getSum();//每月人数
					sumMonth=bookingStatisticalList.get(0).getSumFee().doubleValue();
				}
				List<Statistical> arrivalStatisticalList=statisticalService.queryArrivalStatistical(statistical);
				if(arrivalStatisticalList.size()>0){
					arrivalP=arrivalStatisticalList.get(0).getSum();//每月人数
				}
				//当前年统计
				SimpleDateFormat format1=new SimpleDateFormat("yyyy");
				String date1=format1.format(new Date());
				statistical.setTime(date1);//默认当前年
				statistical.setTotal(100);
				bookingStatisticalList=statisticalService.queryBookingStatistical(statistical);
				arrivalStatisticalList=statisticalService.queryArrivalStatistical(statistical);
				
				if(bookingStatisticalList.size()>0){
					for(int i=0;i<bookingStatisticalList.size();i++){
						sum+=bookingStatisticalList.get(i).getSum();
						sumFee+=bookingStatisticalList.get(0).getSumFee().doubleValue();
					}
				}
				if(arrivalStatisticalList.size()>0){
					for(int i=0;i<arrivalStatisticalList.size();i++){
						sumArrival+=arrivalStatisticalList.get(i).getSum();
					}
				}
			}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bookSum",people );//Booking(M)
		map.put("sumMonth", sumMonth);//Booking(M)
		map.put("bookYearSum",sum );//Booking(Y)
		map.put("bookSumFee",sumFee);//Booking(Y)
		map.put("arrivalP",arrivalP);//Arrival(M)
		map.put("sumArrival",sumArrival);//Arrival(Y)
		return map;
	}
	
	/**
	 * 查看收客统计 跳转页面
	 * */
	@RequestMapping(value="/bookingStatisticalCEO",method=RequestMethod.GET)
	public String bookingStatisticalCEO(Model model,String menuId) {
		String role=null;
		Subject currentUser = SecurityUtils.getSubject();
		//划分Agent所有的权限
		if (currentUser.isPermitted("admin:CEO")) {  
			role="CEO";
		}else if (currentUser.isPermitted("admin:Region")){
			role="Region";
		}else if (currentUser.isPermitted("admin:Office")){
			role="Office";
		}else if (currentUser.isPermitted("admin:Group")){
			role="Group";
		}else{
			role="Agent";
		}
		model.addAttribute("menuId", menuId);
		model.addAttribute("role", role);
		return "/admin/statistical/statisticalBook";
	}
	/**
	 * 品牌收客统计
	 * */
	@RequestMapping(value="/bookingForBrand",method=RequestMethod.GET)
	public String bookingForBrand(Model model,String menuId,Statistical statistical,String role){
		Admin admin=adminService.getCurrent();
		List<Statistical> statisticalList=new ArrayList<Statistical>();
		Statistical statisticals=new Statistical();
		String b[]=Constant.BRAND_ITEMS;
		SimpleDateFormat format=new SimpleDateFormat("yyyy");
		if(statistical.getTime()==null){
			statistical.setTime(format.format(new Date()));
		}
		if(role.equals("Office")){
			statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
			model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			for(int i=0;i<b.length;i++){//品牌循环
				statistical.setBrand(b[i]);
				statisticals=statisticalService.queryBookingBrand(statistical);
				statisticalList.add(statisticals);
			}
		}else if(role.equals("Region")){
			List<Dept> deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
			statistical.setRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				for(int i=0;i<b.length;i++){//品牌循环
					statistical.setBrand(b[i]);
					statisticals=statisticalService.queryBookingBrand(statistical);
					statisticalList.add(statisticals);
				}
			model.addAttribute("dept",deptList);
		}else if(role.equals("CEO")){
			Statistical sta=new Statistical();
			for(int i=0;i<b.length;i++){
				statistical.setBrand(b[i]);
				statisticals=statisticalService.queryBookingBrand(statistical);
				statisticalList.add(statisticals);
			}
			model.addAttribute("dept",deptService.findAll());//所有部门
		}else if(role.equals("Group")){//Group
			statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
			statistical.setGroupId(admin.getGroupId());//groupId
			for(int i=0;i<b.length;i++){//品牌循环
				statistical.setBrand(b[i]);
				statisticals=statisticalService.queryBookingBrand(statistical);
				statisticalList.add(statisticals);
			}
			model.addAttribute("dept",deptService.findById(admin.getDeptId()));
		}else{
			statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
			statistical.setUserId(admin.getId());
			for(int i=0;i<b.length;i++){//品牌循环
				statistical.setBrand(b[i]);
				statisticals=statisticalService.queryBookingBrand(statistical);
				statisticalList.add(statisticals);
			}
			model.addAttribute("dept",deptService.findById(admin.getDeptId()));
		}
		model.addAttribute("statistical", statistical);
		model.addAttribute("statisticalList", statisticalList);
		model.addAttribute("menuId", menuId);
		model.addAttribute("constant",CONSTANT);
		model.addAttribute("role", role);
		return "/admin/statistical/bookingBrand";
	}
	/**
	 * 公司收客统计
	 * */
		@RequestMapping(value="/bookingForDept",method=RequestMethod.GET)
		public String bookingForDept(Model model,String menuId,Statistical statistical,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			Statistical statisticals=new Statistical();
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(statistical.getTime()==null){
				statistical.setTime(format.format(new Date()));
			}
			if(statistical.getIsSelfOrganize()!=null && statistical.getIsSelfOrganize()==5){//获取类型  非团订单
				//statistical.setIsSelfOrganize(1);
				statistical.setOrderType(5);
			}else if(statistical.getIsSelfOrganize()!=null && statistical.getIsSelfOrganize()==1){//入境订单
				statistical.setOrderType(10);
			}
			if(role.equals("Office")){//用户所在部门
				statistical.setDeptId(admin.getDeptId());
				statistical.setDeptName(admin.getDeptName());
				statisticals=statisticalService.queryBookingDept(statistical);
				statisticalList.add(statisticals);
			}else if(role.equals("Region")){
				List<Dept> deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				for(int i=0;i<deptList.size();i++){
					statistical.setDeptId(deptList.get(i).getDeptId());
					statistical.setDeptName(deptList.get(i).getDeptName());
					statisticals=statisticalService.queryBookingDept(statistical);
					statisticalList.add(statisticals);
				}
			}else if(role.equals("CEO")){//CEO查看全部部门
				List<Dept> deptList=deptService.findAll();
				for(int i=0;i<deptList.size();i++){
					statistical.setDeptId(deptList.get(i).getDeptId());
					statistical.setDeptName(deptList.get(i).getDeptName());
					statisticals=statisticalService.queryBookingDept(statistical);
					statisticalList.add(statisticals);
				}
			}else if(role.equals("Group")){
				statistical.setDeptId(admin.getDeptId());
				statistical.setDeptName(admin.getDeptName());
				statistical.setGroupId(admin.getGroupId());
				statisticals=statisticalService.queryBookingDept(statistical);
				statisticalList.add(statisticals);
			}else{
				statistical.setDeptId(admin.getDeptId());
				statistical.setDeptName(admin.getDeptName());
				statistical.setUserId(admin.getId());
				statisticals=statisticalService.queryBookingDept(statistical);
				statisticalList.add(statisticals);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("role", role);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("menuId", menuId);
			return "/admin/statistical/bookingDept";
		}
		/**
		 * 同行收客统计
		 * */
		@RequestMapping(value="/bookingForPeer",method=RequestMethod.GET)
		public String bookingForPeer(Model model,String menuId,Vender vender,String role){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			String haveDept=null;//用来权限传值判断
			vender.setRole(role);
			if(vender.getTime()==null&& vender.getYear()==null){
				vender.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(vender.getDeptId()==null){
					haveDept="System val";//用来做标记
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(vender.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(vender.getDeptId()==null){
					haveDept="System val";//用来做标记
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(vender.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				vender.setGroupId(admin.getGroupId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				vender.setUserId(admin.getId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				vender.setDeptId(deptList.get(i).getDeptId());
				List<Vender> venderList=statisticalService.queryBookingPeer(vender);
				if(venderList.size()>0){
					int total=0;
					double pay=0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<venderList.size();a++){
						total+=venderList.get(a).getSum();
						pay+=venderList.get(a).getPay().doubleValue();
						cost+=venderList.get(a).getCost().doubleValue();
						comAmount+=venderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setVenderList(venderList);
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					vender.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(vender.getYear()!=null){
				year=vender.getYear();
			}else{
				year=vender.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("vender", vender);
			return "/admin/statistical/bookingPeer";
		}
		/**
		 * 产品收客统计
		 * */
		@RequestMapping(value="/bookingForProduct",method=RequestMethod.GET)
		public String bookingForProduct(Model model,String menuId,GroupLine groupLine,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			groupLine.setRole(role);
			if(groupLine.getTime()==null && groupLine.getDepartureDate()==null){
				groupLine.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				groupLine.setDeptId(admin.getDeptId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				groupLine.setContactor(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				model.addAttribute("dept", deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				groupLine.setDeptId(admin.getDeptId());
				groupLine.setGroupId(admin.getGroupId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				groupLine.setDeptId(admin.getDeptId());
				groupLine.setUserId(admin.getId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			List<GroupLine> groupLineList=statisticalService.queryBookingProduct(groupLine);
			if(groupLineList.size()>0){
				int total=0;
				double pay=0;
				double cost=0;
				double comAmount=0;
				for(int a=0;a<groupLineList.size();a++){
					total+=groupLineList.get(a).getSum();
					pay+=groupLineList.get(a).getPay().doubleValue();
					cost+=groupLineList.get(a).getCost().doubleValue();
					comAmount+=groupLineList.get(a).getCommonTourFee().doubleValue();
				}
				Statistical statisticals=new Statistical();
				if(groupLine.getDeptId()==null){
					if(role.equals("Region")){
						   statisticals.setDeptName("Region");
					   }else{
						statisticals.setDeptName("CEO");
					   }
				}else{
					statisticals.setDeptName(deptService.findById(groupLine.getDeptId()).getDeptName());
				}
				statisticals.setGroupLineList(groupLineList);
				statisticals.setSum(total);
				statisticals.setCommonTourFee(comAmount);
				statisticals.setProfit(pay-cost);
				statisticalList.add(statisticals);
			}
			
			String year= null;//获取年份
			if(groupLine.getDepartureDate()!=null){
				year=groupLine.getDepartureDate();
			}else{
				year=groupLine.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("groupLine", groupLine);
			return "/admin/statistical/bookingProduct";
		}
		
		/**
		 *查看发客统计 跳转页面
		 * */
		@RequestMapping(value="/arrivalStatisticals",method=RequestMethod.GET)
		public String arrivalStatisticals(Model model,String menuId) {
			String role=null;
			Subject currentUser = SecurityUtils.getSubject();
			if (currentUser.isPermitted("admin:CEO")) {  
				role="CEO";
			}else if (currentUser.isPermitted("admin:Region")){
				role="Region";
			}else if (currentUser.isPermitted("admin:Office")){
				role="Office";
			}else if (currentUser.isPermitted("admin:Group")){
				role="Group";
			}else{
				role="Agent";
			}
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			return "/admin/statistical/statisticalArrival";
		}
		/**
		 * 品牌发客统计
		 * */
		@RequestMapping(value="/arrivalForBrand",method=RequestMethod.GET)
		public String arrivalForBrand(Model model,String menuId,Statistical statistical,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			Statistical statisticals=new Statistical();
			String b[]=Constant.BRAND_ITEMS;
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(statistical.getTime()==null){
				statistical.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				for(int i=0;i<b.length;i++){
					statistical.setBrand(b[i]);
					statisticals=statisticalService.queryArrivalBrand(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				List<Dept> deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				statistical.setRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				for(int i=0;i<b.length;i++){
					statistical.setBrand(b[i]);
					statisticals=statisticalService.queryArrivalBrand(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptList);
			}else if(role.equals("CEO")){
				for(int i=0;i<b.length;i++){
					statistical.setBrand(b[i]);
					statisticals=statisticalService.queryArrivalBrand(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findAll());
			}else if(role.equals("Group")){
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				statistical.setGroupId(admin.getGroupId());
				for(int i=0;i<b.length;i++){
					statistical.setBrand(b[i]);
					statisticals=statisticalService.queryArrivalBrand(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				statistical.setUserId(admin.getId());
				for(int i=0;i<b.length;i++){
					statistical.setBrand(b[i]);
					statisticals=statisticalService.queryArrivalBrand(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			model.addAttribute("statistical", statistical);
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", menuId);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("role", role);
			return "/admin/statistical/arrivalBrand";
		}
		/**
		 * 公司发客统计
		 * */
		@RequestMapping(value="/arrivalForDept",method=RequestMethod.GET)
		public String arrivalForDept(Model model,String menuId,Statistical statistical,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			Statistical statisticals=new Statistical();
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(statistical.getTime()==null){
				statistical.setTime(format.format(new Date()));
			}
			if(statistical.getIsSelfOrganize()!=null && statistical.getIsSelfOrganize()==5){//获取类型  非团订单
				//statistical.setIsSelfOrganize(1);
				statistical.setOrderType(5);
			}else if(statistical.getIsSelfOrganize()!=null && statistical.getIsSelfOrganize()==1){//入境订单
				statistical.setOrderType(10);
			}
			if(role.equals("Office")){//用户所在部门
				statistical.setDeptId(admin.getDeptId());
				statistical.setDeptName(admin.getDeptName());
				statisticals=statisticalService.queryArrivalDept(statistical);
				statisticalList.add(statisticals);
			}else if(role.equals("Region")){
				List<Dept> deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				for(int i=0;i<deptList.size();i++){
					statistical.setDeptId(deptList.get(i).getDeptId());
					statistical.setDeptName(deptList.get(i).getDeptName());
					statisticals=statisticalService.queryArrivalDept(statistical);
					statisticalList.add(statisticals);
				}
			}else if(role.equals("CEO")){//CEO查看全部部门
				List<Dept> deptList=deptService.findAll();
				for(int i=0;i<deptList.size();i++){
					statistical.setDeptId(deptList.get(i).getDeptId());
					statistical.setDeptName(deptList.get(i).getDeptName());
					statisticals=statisticalService.queryArrivalDept(statistical);
					statisticalList.add(statisticals);
				}
			}else if(role.equals("Group")){
				statistical.setDeptId(admin.getDeptId());
				statistical.setDeptName(admin.getDeptName());
				statistical.setGroupId(admin.getGroupId());
				statisticals=statisticalService.queryArrivalDept(statistical);
				statisticalList.add(statisticals);
			}else{
				statistical.setDeptId(admin.getDeptId());
				statistical.setDeptName(admin.getDeptName());
				statistical.setUserId(admin.getId());
				statisticals=statisticalService.queryArrivalDept(statistical);
				statisticalList.add(statisticals);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("role", role);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("menuId", menuId);
			return "/admin/statistical/arrivalDept";
		}
		/**
		 * 同行发客统计
		 * */
		@RequestMapping(value="/arrivalForPeer",method=RequestMethod.GET)
		public String arrivalForPeer(Model model,String menuId,Vender vender,String role){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			String haveDept=null;
			vender.setRole(role);
			if(vender.getTime()==null&& vender.getYear()==null){
				vender.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(vender.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(vender.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(vender.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(vender.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				vender.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				vender.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				vender.setDeptId(deptList.get(i).getDeptId());
				List<Vender> venderList=statisticalService.queryArrivalPeer(vender);
				if(venderList.size()>0){
					int total=0;
					double pay=0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<venderList.size();a++){
						total+=venderList.get(a).getSum();
						pay+=venderList.get(a).getPay().doubleValue();
						cost+=venderList.get(a).getCost().doubleValue();
						comAmount+=venderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setVenderList(venderList);
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					vender.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(vender.getYear()!=null){
				year=vender.getYear();
			}else{
				year=vender.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("vender", vender);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/arrivalPeer";
		}
		/**
		 * 产品发客统计
		 * */
		@RequestMapping(value="/arrivalForProduct",method=RequestMethod.GET)
		public String arrivalForProduct(Model model,String menuId,GroupLine groupLine,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			groupLine.setRole(role);
			if(groupLine.getTime()==null && groupLine.getDepartureDate()==null){
				groupLine.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				groupLine.setDeptId(admin.getDeptId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				groupLine.setContactor(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				model.addAttribute("dept", deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				groupLine.setDeptId(admin.getDeptId());
				groupLine.setGroupId(admin.getGroupId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				groupLine.setDeptId(admin.getDeptId());
				groupLine.setUserId(admin.getId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			List<GroupLine> groupLineList=statisticalService.queryArrivalProduct(groupLine);
			if(groupLineList.size()>0){
				int total=0;
				double pay=0;
				double cost=0;
				double comAmount=0;
				for(int a=0;a<groupLineList.size();a++){
					total+=groupLineList.get(a).getSum();
					pay+=groupLineList.get(a).getPay().doubleValue();
					cost+=groupLineList.get(a).getCost().doubleValue();
					comAmount+=groupLineList.get(a).getCommonTourFee().doubleValue();
				}
				Statistical statisticals=new Statistical();
				if(groupLine.getDeptId()==null){
				   if(role.equals("Region")){
					   statisticals.setDeptName("Region");
				   }else{
					statisticals.setDeptName("CEO");
				   }
				}else{
					statisticals.setDeptName(deptService.findById(groupLine.getDeptId()).getDeptName());
				}
				statisticals.setGroupLineList(groupLineList);
				statisticals.setSum(total);
				statisticals.setCommonTourFee(comAmount);
				statisticals.setProfit(pay-cost);
				statisticalList.add(statisticals);
			}
			String year= null;//获取年份
			if(groupLine.getDepartureDate()!=null){
				year=groupLine.getDepartureDate();
			}else{
				year=groupLine.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("groupLine", groupLine);
			return "/admin/statistical/arrivalProduct";
		}
		/**
		 * 团队订单统计（发客）
		 * */
		@RequestMapping(value="/tourStatistical",method=RequestMethod.GET)
		public String tourStatistical(Model model,String menuId,String role,Order order){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			String haveDept=null;
			order.setOrderType(1);//同行订单
			if(order.getTime()==null&& order.getYear()==null){
				order.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				order.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				order.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				order.setDeptId(deptList.get(i).getDeptId());
				List<Order> orderList=statisticalService.queryTourBooking(order);
				if(orderList.size()>0){
					int total=0;
					double pay =0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<orderList.size();a++){
						total+=orderList.get(a).getTotalPeople();
						pay+=orderList.get(a).getPay().doubleValue();
						cost+=orderList.get(a).getCost().doubleValue();
						comAmount+=orderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setOrderList(orderList);
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					order.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(order.getYear()!=null){
				year=order.getYear();
			}else{
				year=order.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("order", order);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/tourStatistical";
		}
		
		/**
		 * 团队订单统计（发客）
		 * */
		@RequestMapping(value="/financialStatistical",method=RequestMethod.GET)
		public String financialStatistical(Model model,String menuId,String role,Order order){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			String haveDept=null;
			//order.setOrderType(1);//同行订单
			if(order.getTime()==null&& order.getYear()==null){
				order.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				order.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				order.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				order.setDeptId(deptList.get(i).getDeptId());
				List<Order> orderList=statisticalService.queryTourBooking(order);
				if(orderList.size()>0){
					int total=0;
					double pay =0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<orderList.size();a++){
						total+=orderList.get(a).getTotalPeople();
						pay+=orderList.get(a).getPay().doubleValue();
						cost+=orderList.get(a).getCost().doubleValue();
						comAmount+=orderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setOrderList(orderList);
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					order.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(order.getYear()!=null){
				year=order.getYear();
			}else{
				year=order.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("order", order);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/financialStatistical";
		}
		
		/**
		 * 团队订单统计（收客）
		 * */
		@RequestMapping(value="/tourStatisticalB",method=RequestMethod.GET)
		public String tourStatisticalB(Model model,String menuId,String role,Order order){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			String haveDept=null;
			order.setOrderType(1);//同行订单
			if(order.getTime()==null&& order.getYear()==null){
				order.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				order.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				order.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				order.setDeptId(deptList.get(i).getDeptId());
				List<Order> orderList=statisticalService.queryTourBookingB(order);
				if(orderList.size()>0){
					int total=0;
					double pay=0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<orderList.size();a++){
						total+=orderList.get(a).getTotalPeople();
						pay+=orderList.get(a).getPay().doubleValue();
						cost+=orderList.get(a).getCost().doubleValue();
						comAmount+=orderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setOrderList(orderList);
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					order.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(order.getYear()!=null){
				year=order.getYear();
			}else{
				year=order.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("order", order);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/tourStatisticalBooking";
		}
		
		/**
		 * 团队订单统计（收客）
		 * */
		@RequestMapping(value="/financialStatisticalB",method=RequestMethod.GET)
		public String financialStatisticalB(Model model,String menuId,String role,Order order){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			String haveDept=null;
			//order.setOrderType(1);//同行订单
			if(order.getTime()==null&& order.getYear()==null){
				order.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				order.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				order.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				order.setDeptId(deptList.get(i).getDeptId());
				List<Order> orderList=statisticalService.queryTourBookingB(order);
				if(orderList.size()>0){
					int total=0;
					double pay=0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<orderList.size();a++){
						total+=orderList.get(a).getTotalPeople();
						pay+=orderList.get(a).getPay().doubleValue();
						cost+=orderList.get(a).getCost().doubleValue();
						comAmount+=orderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setOrderList(orderList);
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					order.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(order.getYear()!=null){
				year=order.getYear();
			}else{
				year=order.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("order", order);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/financialStatisticalBooking";
		}
		
		/**
		 * 同行订单统计（发客）
		 * */
		@RequestMapping(value="/peerBookStatistical",method=RequestMethod.GET)
		public String peerBookStatistical(Model model,String menuId,String role,Order order){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			Vender vender=new Vender();
			String haveDept=null;
			order.setOrderType(2);//同行订单
			order.setRole(role);//同行订单
			vender.setType(2);//2是供应商，选择除去供应商的方法
			String peerId=order.getPeerId();//用来判断是否从页面传来同行Id
			if(order.getTime()==null&& order.getYear()==null){
				order.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				order.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				order.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				order.setDeptId(deptList.get(i).getDeptId());
				vender.setDeptId(deptList.get(i).getDeptId());
				List<Order> orderList=statisticalService.queryTourBooking(order);//根据同行查找出该同行下所有的订单
				if(orderList.size()>0){
					int total=0;
					double pay =0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<orderList.size();a++){
						total+=orderList.get(a).getTotalPeople();
						pay+=orderList.get(a).getPay().doubleValue();
						cost+=orderList.get(a).getCost().doubleValue();
						comAmount+=orderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setOrderList(orderList);//同行放入对应的部门
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					order.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(order.getYear()!=null){
				year=order.getYear();
			}else{
				year=order.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("order", order);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/peerOrderStatistical";
		}
		/**
		 * 同行订单统计（收客=B--Booking）
		 * */
		@RequestMapping(value="/peerBookBStatistical",method=RequestMethod.GET)
		public String peerBookBStatistical(Model model,String menuId,String role,Order order){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			Vender vender=new Vender();
			String haveDept=null;
			order.setOrderType(2);//同行订单
			order.setRole(role);//同行订单
			vender.setType(2);//2是供应商，选择除去供应商的方法
			String peerId=order.getPeerId();//用来判断是否从页面传来同行Id
			if(order.getTime()==null&& order.getYear()==null){
				order.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				order.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				order.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				order.setDeptId(deptList.get(i).getDeptId());
				vender.setDeptId(deptList.get(i).getDeptId());
				List<Order> orderList=statisticalService.queryTourBookingB(order);//根据同行查找出该同行下所有的订单
				if(orderList.size()>0){
					int total=0;
					double pay=0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<orderList.size();a++){
						total+=orderList.get(a).getTotalPeople();
						pay+=orderList.get(a).getPay().doubleValue();
						cost+=orderList.get(a).getCost().doubleValue();
						comAmount +=orderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setOrderList(orderList);//同行放入对应的部门
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					order.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(order.getYear()!=null){
				year=order.getYear();
			}else{
				year=order.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("order", order);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/peerOrderBooking";
		}
		
		
		/**
		 * 非团队订单统计（收客）
		 * */
		@RequestMapping(value="/otherTourStatistical",method=RequestMethod.GET)
		public String otherTourStatistical(Model model,String menuId,String role,Order order){
			Admin admin =adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			List<Dept> deptList=new ArrayList<Dept>();
			String haveDept=null;
			if(order.getTime()==null&& order.getYear()==null){
				order.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				Dept dept=deptService.findById(admin.getDeptId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept",deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				if(order.getDeptId()==null){
					haveDept="System val";
					deptList=deptService.findAll();
				}else{
					Dept dept=deptService.findById(order.getDeptId());
					deptList.add(dept);
				}
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				Dept dept=deptService.findById(admin.getDeptId());
				order.setGroupId(admin.getGroupId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				Dept dept=deptService.findById(admin.getDeptId());
				order.setUserId(admin.getId());
				deptList.add(dept);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			for(int i=0;i<deptList.size();i++){
				order.setDeptId(deptList.get(i).getDeptId());
				List<Order> orderList=statisticalService.queryOtherTourBooking(order);
				if(orderList.size()>0){
					int total=0;
					double pay=0;
					double cost=0;
					double comAmount=0;
					for(int a=0;a<orderList.size();a++){
						total+=orderList.get(a).getTotalPeople();
						pay+=orderList.get(a).getPay().doubleValue();
						cost+=orderList.get(a).getCost().doubleValue();
						comAmount+=orderList.get(a).getCommonTourFee().doubleValue();
					}
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(deptList.get(i).getDeptName());
					statisticals.setOrderList(orderList);
					statisticals.setSum(total);
					statisticals.setCommonTourFee(comAmount);
					statisticals.setProfit(pay-cost);
					statisticalList.add(statisticals);
					totalSum+=total;
					totalPay+=pay;
					totalCost+=cost;
					totalComAmount+=comAmount;
				}
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			if(role.equals("Region") || role.equals("CEO") ){//如果是Region或CEO  deptId值为空
				if(haveDept!=null){//如果标记不为null 没有deptId前端进入，置空
					order.setDeptId(null);
				}
			}
			String year= null;//获取年份
			if(order.getYear()!=null){
				year=order.getYear();
			}else{
				year=order.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("order", order);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/otherTourStatistical";
		}
		/**
		 * 订单详情（同行，团队）
		 * */
		@RequestMapping(value="/orderDetailsPage",method=RequestMethod.GET)
		public String orderDetailsPage(Model model,String menuId,String role,Order order){
			Admin admin=adminService.getCurrent();
			Order orders=new Order();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			/*//搜索中会有非团订单，非团订单处理
			if(order.getIsSelfOrganize()!=null){
				if(order.getIsSelfOrganize()==5){
					order.setIsSelfOrganize(1);
				}
			}*/
			if(order.getTicketType()==null){
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					orders = statisticalService.detailsCountT(order);
				}else{
					orders = statisticalService.detailsCount(order);
				}
			}else{
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					orders = statisticalService.detailsCountBT(order);
				}else{
					orders = statisticalService.detailsCountB(order);
				}
			}
			Dept dept=new Dept();
			GroupLine groupLine=new GroupLine();
			if(order.getDeptId()!=null){
				dept =deptService.findById(order.getDeptId());
			}
			if(order.getGroupLineId()!=null){
				groupLine =groupLineService.findById(order.getGroupLineId());
			}
			if(order.getUserId()!=null){
				admin =adminService.findById(order.getUserId());
			}
			
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("order", order);
			model.addAttribute("orders", orders);
			model.addAttribute("deptName", dept.getDeptName());
			model.addAttribute("lineName", groupLine.getTourName());
			model.addAttribute("userName",admin.getUsername());
			return "/admin/statistical/tourOrderList";
		}
		/**
		 * 订单详情（同行，团队,Arrival）
		 * */
		@RequestMapping(value="/orderDetails",method=RequestMethod.POST)
		public @ResponseBody Map<String, Object> orderDetails(Pageable pageable,Order order){
			Admin admin=adminService.getCurrent();
			Map<String, Object> map = new HashMap<String, Object>();
			Page<Order> page=new Page<Order>();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			if(order.getTicketType()==null){
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					page = statisticalService.orderDetailsT(order, pageable);
				}else{
					page = statisticalService.orderDetails(order, pageable);
				}
			}else{
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					page = statisticalService.orderDetailsBT(order, pageable);
				}else{
					page = statisticalService.orderDetailsB(order, pageable);
				}
			}
			
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 * 打印统计详情
		 * */
		@RequestMapping(value="/orderDetailsPrint",method=RequestMethod.GET)
		public String orderDetailsPrint(Model model,Order order){
			Admin admin=adminService.getCurrent();
			List<Order> orderList=new ArrayList<Order>();
			Order orders=new Order();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			if(order.getTicketType()==null){
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					orderList = statisticalService.detailsTPrint(order);
					orders = statisticalService.detailsCountT(order);
				}else{
					orderList = statisticalService.detailsPrint(order);
					orders = statisticalService.detailsCount(order);
				}
			}else{
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					orderList = statisticalService.detailsBTPrint(order);
					orders = statisticalService.detailsCountBT(order);
				}else{
					orderList = statisticalService.detailsBPrint(order);
					orders = statisticalService.detailsCountB(order);
				}
			}
			if(order.getGroupLineId()!=null){
				GroupLine groupLine =groupLineService.findById(order.getGroupLineId());
				model.addAttribute("lineName",groupLine.getTourName());
			}
			if(order.getPeerId()!=null){
				Vender vender =venderService.findById(order.getPeerId());
				model.addAttribute("venderName",vender.getName());
			}
			if(order.getDeptId()!=null){
				Dept dept =deptService.findById(order.getDeptId());
				model.addAttribute("deptName",dept.getDeptName());
			}
			//抵达日期2016-01-01 后 不发 5%
			for (Order o : orderList) {
				if(o.getArriveDateTime()!=null&&compareDate(o.getArriveDateTime())){
					o.setPriceExpression(new BigDecimal(0));
				}
			}
			model.addAttribute("orders",orders );
			model.addAttribute("orderList",orderList );
			model.addAttribute("order",order );
			model.addAttribute("adminName",admin.getUsername());
			model.addAttribute("deptName",deptService.findById(admin.getDeptId()).getDeptName());
			return "/admin/statistical/detailsStatisticalPrint";
		}
		/**
		 * 客人来源统计
		 * */
		@RequestMapping(value="/bookingForSource",method=RequestMethod.GET)
		public String bookingForSource(Model model,String menuId,Statistical statistical,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			Statistical statisticals=new Statistical();
			//String b[]=Constant.BRAND_ITEMS;
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(statistical.getTime()==null){
				statistical.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findBookingSource(statistical);
					statisticalList.add(statisticals);	
					
				}
			}else if(role.equals("Region")){
				List<Dept> deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				statistical.setRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
						statisticals=statisticalService.findBookingSource(statistical);
						statisticalList.add(statisticals);
					}
				model.addAttribute("dept",deptList);
			}else if(role.equals("CEO")){
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findBookingSource(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findAll());//所有部门
			}else if(role.equals("Group")){//Group
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				statistical.setGroupId(admin.getGroupId());//groupId
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findBookingSource(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				statistical.setUserId(admin.getId());
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findBookingSource(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			model.addAttribute("statistical", statistical);
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", menuId);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("role", role);
			return "/admin/statistical/bookingSource";
		}
		
		/**
		 * 抵达日期
		 * 客人来源统计
		 * */
		@RequestMapping(value="/arrivalForSource",method=RequestMethod.GET)
		public String arrivalForSource(Model model,String menuId,Statistical statistical,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			Statistical statisticals=new Statistical();
			//String b[]=Constant.BRAND_ITEMS;
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			if(statistical.getTime()==null){
				statistical.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findArrivalSource(statistical);
					statisticalList.add(statisticals);	
					
				}
			}else if(role.equals("Region")){
				List<Dept> deptList=deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());//查找region下所有部门
				statistical.setRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
						statisticals=statisticalService.findArrivalSource(statistical);
						statisticalList.add(statisticals);
					}
				model.addAttribute("dept",deptList);
			}else if(role.equals("CEO")){
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findArrivalSource(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findAll());//所有部门
			}else if(role.equals("Group")){//Group
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				statistical.setGroupId(admin.getGroupId());//groupId
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findArrivalSource(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				statistical.setDeptId(admin.getDeptId());//当前用户的所在公司
				statistical.setUserId(admin.getId());
				List<Statistical> sourceList=statisticalService.findSourceName(statistical);
				for(int i=0;i<sourceList.size();i++){//客人来源循环
					statistical.setSource(sourceList.get(i).getSource());
					statisticals=statisticalService.findArrivalSource(statistical);
					statisticalList.add(statisticals);
				}
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			model.addAttribute("statistical", statistical);
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", menuId);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("role", role);
			return "/admin/statistical/bookingSource";
		}
		/**
		 * 订单详情（同行，团队）
		 * */
		@RequestMapping(value="/sourceDetailsPage",method=RequestMethod.GET)
		public String sourceDetailsPage(Model model,String menuId,String role,Order order){
			Admin admin=adminService.getCurrent();
		
			Dept dept=new Dept();
			GroupLine groupLine=new GroupLine();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			Order orders = statisticalService.detailsCountS(order);
			if(order.getDeptId()!=null){
				dept =deptService.findById(order.getDeptId());
			}
			if(order.getGroupLineId()!=null){
				groupLine =groupLineService.findById(order.getGroupLineId());
			}
			if(order.getUserId()!=null){
				admin =adminService.findById(order.getUserId());
			}
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("order", order);
			model.addAttribute("orders", orders);
			model.addAttribute("deptName", dept.getDeptName());
			model.addAttribute("lineName", groupLine.getTourName());
			model.addAttribute("userName",admin.getUsername());
			return "/admin/statistical/sourceOrderList";
		}
		
		@RequestMapping(value="/sourceDetails",method=RequestMethod.POST)
		public @ResponseBody Map<String, Object> sourceDetails(Pageable pageable,Order order){
			Admin admin=adminService.getCurrent();
			Map<String, Object> map = new HashMap<String, Object>();
			Page<Order> page=new Page<Order>();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			page = statisticalService.sourceDetailsS(order, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
			
		}
		/**
		 * 打印统计详情
		 * */
		@RequestMapping(value="/sourceDetailsPrint",method=RequestMethod.GET)
		public String sourceDetailsPrint(Model model,Order order){
			Admin admin=adminService.getCurrent();
			List<Order> orderList=new ArrayList<Order>();
			Order orders=new Order();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			 orders = statisticalService.detailsCountS(order);
			 orderList = statisticalService.detailsSPrint(order);
			
			if(order.getGroupLineId()!=null){
				GroupLine groupLine =groupLineService.findById(order.getGroupLineId());
				model.addAttribute("lineName",groupLine.getTourName());
			}
			if(order.getPeerId()!=null){
				Vender vender =venderService.findById(order.getPeerId());
				model.addAttribute("venderName",vender.getName());
			}
			if(order.getDeptId()!=null){
				Dept dept =deptService.findById(order.getDeptId());
				model.addAttribute("deptName",dept.getDeptName());
			}
			model.addAttribute("orders",orders );
			model.addAttribute("orderList",orderList );
			model.addAttribute("order",order );
			model.addAttribute("adminName",admin.getUsername());
			model.addAttribute("deptName",deptService.findById(admin.getDeptId()).getDeptName());
			return "/admin/statistical/detailsStatisticalPrint";
		}
		/**
		 * export 导出 统计
		 * @return
		 */
		@RequestMapping(value="/ExcelForStatistics",method=RequestMethod.GET)  
	    public ModelAndView ExcelForStatistics(InvoiceAndCredit invoiceAndCredit,HttpServletRequest request, HttpServletResponse response,Order order) {
			Admin admin = adminService.getCurrent();
			List<Order> orderList=new ArrayList<Order>();
			Order orders=new Order();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			if(order.getTicketType()==null){
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					orderList = statisticalService.detailsTPrint(order);
					orders = statisticalService.detailsCountT(order);
				}else{
					orderList = statisticalService.detailsPrint(order);
					orders = statisticalService.detailsCount(order);
				}
			}else{
				if(order.getGroupLineId()!=null||order.getBrand()!=null){
					orderList = statisticalService.detailsBTPrint(order);
					orders = statisticalService.detailsCountBT(order);
				}else{
					orderList = statisticalService.detailsBPrint(order);
					orders = statisticalService.detailsCountB(order);
				}
			}
			if(order.getGroupLineId()!=null){
				GroupLine groupLine =groupLineService.findById(order.getGroupLineId());
				//model.addAttribute("lineName",groupLine.getTourName());
			}
			if(order.getPeerId()!=null){
				Vender vender =venderService.findById(order.getPeerId());
				//model.addAttribute("venderName",vender.getName());
			}
			if(order.getDeptId()!=null){
				Dept dept =deptService.findById(order.getDeptId());
				//model.addAttribute("deptName",dept.getDeptName());
			}
			//model.addAttribute("orders",orders );
			//model.addAttribute("orderList",orderList );
			//model.addAttribute("order",order );
			//model.addAttribute("adminName",admin.getUsername());
			//model.addAttribute("deptName",deptService.findById(admin.getDeptId()).getDeptName());
			StatisticsSheetExcle ss=new StatisticsSheetExcle();
			ss.setOrderList(orderList);
			return new ModelAndView(ss);
	    }
		/**
		 *机票统计 跳转页面
		 * */
		@RequestMapping(value="/airStatisticals",method=RequestMethod.GET)
		public String airStatisticals(Model model) {
			model.addAttribute("menuId", 1111);
			return "/admin/statistical/statisticalAir";
		}
		/**
		 * 机票统计
		 * */
		@RequestMapping(value="/agentStatistical",method=RequestMethod.GET)
		public String agentStatistical(Model model,SupplierPriceForOrder so,String role){
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			List<SupplierPriceForOrder> sfList=new ArrayList<SupplierPriceForOrder>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(so.getTime()==null&& so.getYear()==null){
				so.setTime(format.format(new Date()));
			}
			so.setType(0);
			List<SupplierPriceForOrder> soList=statisticalService.queryFlight(so);
			
			//页面底部 total 合计
			int totalSum=0;
			double totalPay=0;
			double totalCost=0;
			double totalComAmount=0;
			
			int total=0;
			double amount=0;
			double operatorFee=0;
			for(int j=0;j<soList.size();j++){
				SupplierPriceForOrder sf=soList.get(j);
				total+=sf.getQuantity();
				amount+=sf.getAmount().doubleValue();
				operatorFee+=sf.getOperatorFee().doubleValue();
				sfList.add(sf);
				if(soList.size()>(j+1)&&sf.getDeptName()!=null&&!sf.getDeptName().equals(soList.get(j+1).getDeptName())&&j!=0||j==(soList.size()-1)){
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(sf.getDeptName());
					statisticals.setFlightList(sfList);
					statisticals.setSum(total);
					statisticals.setProfit(amount-operatorFee);
					statisticalList.add(statisticals);
					 total=0;
					 amount=0;
					 operatorFee=0;
					 sfList=new ArrayList<SupplierPriceForOrder>();
				}
				totalSum+=sf.getQuantity();
				totalPay+=Double.valueOf(sf.getTempValue06()).doubleValue();
				totalCost+=(sf.getAmount().subtract(sf.getCharge())).doubleValue();
				totalComAmount+=(sf.getAmount().subtract(sf.getOperatorFee())).doubleValue();
				
			}
			Statistical statistical=new Statistical();
			statistical.setSum(totalSum);
			statistical.setTotalPay(totalPay);
			statistical.setTotalCost(totalCost);
			statistical.setCommonTourFee(totalComAmount);
			
			String year= null;//获取年份
			if(so.getYear()!=null){
				year=so.getYear();
			}else{
				year=so.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("statistical", statistical);
			model.addAttribute("menuId", "1111");
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("dept", deptService.findAll());
			model.addAttribute("so", so);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/agentStatistical";
		}
		/**
		 * 机票详情
		 * */
		@RequestMapping(value="/ticketList",method=RequestMethod.GET)
		public String ticketList(Model model,String role,SupplierPriceForOrder so){
			SupplierPriceForOrder sf=statisticalService.ticketCount(so);
			model.addAttribute("menuId", "1111");
			model.addAttribute("so", so);
			model.addAttribute("sf", sf);
			return "/admin/statistical/ticketList";
		}
		/**
		 * 机票详情
		 * */
		@RequestMapping(value="/ticketListPage",method=RequestMethod.POST)
		public @ResponseBody Map<String, Object> ticketListPage(Pageable pageable,SupplierPriceForOrder so){
			Map<String, Object> map = new HashMap<String, Object>();
			Page<SupplierPriceForOrder> page=statisticalService.ticketPage(so, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		/**
		 * 机票统计
		 * */
		@RequestMapping(value="/retailStatistical",method=RequestMethod.GET)
		public String retailStatistical(Model model,SupplierPriceForOrder so,String role){
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			List<SupplierPriceForOrder> sfList=new ArrayList<SupplierPriceForOrder>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(so.getTime()==null&& so.getYear()==null){
				so.setTime(format.format(new Date()));
			}
			so.setType(1);
			List<SupplierPriceForOrder> soList=statisticalService.queryFlight(so);

			int total=0;
			double amount=0;
			double operatorFee=0;
			for(int j=0;j<soList.size();j++){
				SupplierPriceForOrder sf=soList.get(j);
				total+=sf.getQuantity();
				amount+=sf.getAmount().doubleValue();
				operatorFee+=sf.getOperatorFee().doubleValue();
				sfList.add(sf);
				if(soList.size()>(j+1)&&sf.getDeptName()!=null&&!sf.getDeptName().equals(soList.get(j+1).getDeptName())&&j!=0||j==(soList.size()-1)){
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(sf.getDeptName());
					statisticals.setFlightList(sfList);
					statisticals.setSum(total);
					statisticals.setProfit(amount-operatorFee);
					statisticalList.add(statisticals);
					 total=0;
					 amount=0;
					 operatorFee=0;
					 sfList=new ArrayList<SupplierPriceForOrder>();
				}
			}
			
			String year= null;//获取年份
			if(so.getYear()!=null){
				year=so.getYear();
			}else{
				year=so.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", "1111");
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("dept", deptService.findAll());
			model.addAttribute("so", so);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/retailStatistical";
		}
		/**
		 * 机票统计
		 * */
		@RequestMapping(value="/agencyStatistical",method=RequestMethod.GET)
		public String agencyStatistical(Model model,SupplierPriceForOrder so,String role){
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			List<SupplierPriceForOrder> sfList=new ArrayList<SupplierPriceForOrder>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(so.getTime()==null&& so.getYear()==null){
				so.setTime(format.format(new Date()));
			}
			so.setType(2);
			List<SupplierPriceForOrder> soList=statisticalService.queryFlight(so);
			
			int total=0;
			double amount=0;
			double operatorFee=0;
			for(int j=0;j<soList.size();j++){
				SupplierPriceForOrder sf=soList.get(j);
				total+=sf.getQuantity();
				amount+=sf.getAmount().doubleValue();
				operatorFee+=sf.getOperatorFee().doubleValue();
				sfList.add(sf);
				if(soList.size()>(j+1)&&sf.getDeptName()!=null&&!sf.getDeptName().equals(soList.get(j+1).getDeptName())&&j!=0||j==(soList.size()-1)){
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(sf.getDeptName());
					statisticals.setFlightList(sfList);
					statisticals.setSum(total);
					statisticals.setProfit(amount-operatorFee);
					statisticalList.add(statisticals);
					 total=0;
					 amount=0;
					 operatorFee=0;
					 sfList=new ArrayList<SupplierPriceForOrder>();
				}
			}
			
			String year= null;//获取年份
			if(so.getYear()!=null){
				year=so.getYear();
			}else{
				year=so.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", "1111");
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("dept", deptService.findAll());
			model.addAttribute("so", so);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/agencyStatistical";
		}
		
		/**
		 * 机票航空公司统计
		 * */
		@RequestMapping(value="/airlineStatistical",method=RequestMethod.GET)
		public String airlineStatistical(Model model,SupplierPriceForOrder so,String role){
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			List<SupplierPriceForOrder> sfList=new ArrayList<SupplierPriceForOrder>();
			so.setDeptId(null);
			if(so.getArrivalBeginningDate()==null){
				so.setArrivalBeginningDate(new Date());
			}
			if(so.getArrivalEndingDate()==null){
				so.setArrivalEndingDate(new Date());
			}
			
			so.setType(3);
			List<SupplierPriceForOrder> soList=statisticalService.queryFlightAirline(so);
			
			int total=0;
			double amount=0;
			double operatorFee=0;
			for(int j=0;j<soList.size();j++){
				SupplierPriceForOrder sf=soList.get(j);
				total+=sf.getQuantity();
				amount+=sf.getAmount().doubleValue();
				operatorFee+=sf.getOperatorFee().doubleValue();
				sfList.add(sf);
				if(soList.size()>(j+1)&&sf.getDeptName()!=null&&!sf.getDeptName().equals(soList.get(j+1).getDeptName())&&j!=0||j==(soList.size()-1)){
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(sf.getDeptName());
					statisticals.setFlightList(sfList);
					statisticals.setSum(total);
					statisticals.setProfit(amount-operatorFee);
					statisticalList.add(statisticals);
					 total=0;
					 amount=0;
					 operatorFee=0;
					 sfList=new ArrayList<SupplierPriceForOrder>();
				}
			}
			
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", "1111");
			model.addAttribute("role", role);
			model.addAttribute("dept", deptService.findAll());
			model.addAttribute("so", so);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/airlineStatistical";
		}
		
		/**
		 * 机票航空公司统计
		 * */
		@RequestMapping(value="/airlineStatisticalBooking",method=RequestMethod.GET)
		public String airlineStatisticalBooking(Model model,SupplierPriceForOrder so,String role){
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			List<SupplierPriceForOrder> sfList=new ArrayList<SupplierPriceForOrder>();
			so.setDeptId(null);
			if(so.getBeginningDate()==null){
				so.setBeginningDate(new Date());
			}
			if(so.getEndingDate()==null){
				so.setEndingDate(new Date());
			}
			
			so.setType(3);
			List<SupplierPriceForOrder> soList=statisticalService.queryFlightAirline(so);
			
			int total=0;
			double amount=0;
			double operatorFee=0;
			for(int j=0;j<soList.size();j++){
				SupplierPriceForOrder sf=soList.get(j);
				total+=sf.getQuantity();
				amount+=sf.getAmount().doubleValue();
				operatorFee+=sf.getOperatorFee().doubleValue();
				sfList.add(sf);
				if(soList.size()>(j+1)&&sf.getDeptName()!=null&&!sf.getDeptName().equals(soList.get(j+1).getDeptName())&&j!=0||j==(soList.size()-1)){
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(sf.getDeptName());
					statisticals.setFlightList(sfList);
					statisticals.setSum(total);
					statisticals.setProfit(amount-operatorFee);
					statisticalList.add(statisticals);
					 total=0;
					 amount=0;
					 operatorFee=0;
					 sfList=new ArrayList<SupplierPriceForOrder>();
				}
			}
			
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", "1111");
			model.addAttribute("role", role);
			model.addAttribute("dept", deptService.findAll());
			model.addAttribute("so", so);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/airlineStatisticalBooking";
		}
		
		/**
		 * 机票统计
		 * */
		@RequestMapping(value="/venderStatistical",method=RequestMethod.GET)
		public String venderStatistical(Model model,SupplierPriceForOrder so,String role){
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			List<SupplierPriceForOrder> sfList=new ArrayList<SupplierPriceForOrder>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			if(so.getTime()==null&& so.getYear()==null){
				so.setTime(format.format(new Date()));
			}
			so.setType(2);
			List<SupplierPriceForOrder> soList=statisticalService.queryFlightbyVender(so);
			
			int total=0;
			double amount=0;
			double operatorFee=0;
			for(int j=0;j<soList.size();j++){
				SupplierPriceForOrder sf=soList.get(j);
				total+=sf.getQuantity();
				amount+=sf.getAmount().doubleValue();
				operatorFee+=sf.getOperatorFee().doubleValue();
				sfList.add(sf);
				if(soList.size()>(j+1)&&sf.getDeptName()!=null&&!sf.getDeptName().equals(soList.get(j+1).getDeptName())&&j!=0||j==(soList.size()-1)){
					Statistical statisticals=new Statistical();
					statisticals.setDeptName(sf.getDeptName());
					statisticals.setFlightList(sfList);
					statisticals.setSum(total);
					statisticals.setProfit(amount-operatorFee);
					statisticalList.add(statisticals);
					 total=0;
					 amount=0;
					 operatorFee=0;
					 sfList=new ArrayList<SupplierPriceForOrder>();
				}
			}
			
			String year= null;//获取年份
			if(so.getYear()!=null){
				year=so.getYear();
			}else{
				year=so.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", "1111");
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("dept", deptService.findAll());
			model.addAttribute("so", so);
			model.addAttribute("constant",CONSTANT);
			return "/admin/statistical/venderStatistical";
		}
		/**
		 * 机票打印
		 * */
		@RequestMapping(value="/ticketStatisticalPrint",method=RequestMethod.GET)
		public String ticketStatisticalPrint(Model model,SupplierPriceForOrder so){
			Admin admin=adminService.getCurrent();
			SupplierPriceForOrder sf=statisticalService.ticketCount(so);
			List<SupplierPriceForOrder> airList = statisticalService.findForStatisticalPrint(so);
			Dept dept =deptService.findById(admin.getDeptId());
			Vender vender=venderService.findById(so.getAgency());
			model.addAttribute("adminName",admin.getUsername());
			model.addAttribute("deptName",dept.getDeptName());
			model.addAttribute("menuId", "1111");
			model.addAttribute("vender", vender);
			model.addAttribute("sf", sf);
			model.addAttribute("so", so);
			model.addAttribute("airList", airList);
			return "/admin/statistical/ticketStatisticalPrint";
		}
		/**
		 * export 导出 item
		 * @return
		 */
		@RequestMapping(value="/excelForAirItem",method=RequestMethod.GET)  
	    public ModelAndView excelForAirItem(SupplierPriceForOrder supplierPriceForOrder,HttpServletRequest request, HttpServletResponse response) {
			SupplierPriceForOrderExcle ss=new SupplierPriceForOrderExcle();
			ss.setTemp(1);
			List<SupplierPriceForOrder> airList = statisticalService.findForStatisticalPrint(supplierPriceForOrder);
			ss.setAirList(airList);
			return new ModelAndView(ss);
	    }
	    /** 
	     * 比较两个日期之间的大小 
	     *  
	     * @param d1 
	     * @param d2 
	     * @return 前者大于后者返回true 反之false 
	     */  
	    public boolean compareDate(Date d2) {  
	        Calendar c1 = Calendar.getInstance();  
	        Calendar c2 = Calendar.getInstance();  
	        c2.set(2015,11,31);// 月份 0 开始计算
	        c1.setTime(d2);  
	      
	        int result = c1.compareTo(c2);  
	        if (result > 0)  
	            return true;  
	        else  
	            return false;  
	    }  
	    /**
		 * 自选项收客按下单时间统计
		 * */
		@RequestMapping(value="/bookingForOptional",method=RequestMethod.GET)
		public String bookingForOptional(Model model,String menuId,OptionalExcurition opExcurition,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			opExcurition.setRole(role);
			if(opExcurition.getTime()==null && opExcurition.getDepartureDate()==null){
				opExcurition.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				opExcurition.setDeptId(admin.getDeptId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				opExcurition.setContactor(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				model.addAttribute("dept", deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				opExcurition.setDeptId(admin.getDeptId());
				opExcurition.setGroupId(admin.getGroupId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				opExcurition.setDeptId(admin.getDeptId());
				opExcurition.setUserId(admin.getId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			List<OptionalExcurition> optionalList=statisticalService.queryBookingOptional(opExcurition);
			if(optionalList.size()>0){
				int total=0;
				double pay=0;
				double cost=0;
				double comAmount=0;
				for(int a=0;a<optionalList.size();a++){
					total+=optionalList.get(a).getSum();
					pay+=optionalList.get(a).getPay().doubleValue();
					cost+=optionalList.get(a).getCost().doubleValue();
					comAmount+=optionalList.get(a).getCommonTourFee().doubleValue();
				}
				Statistical statisticals=new Statistical();
				if(opExcurition.getDeptId()==null){
					if(role.equals("Region")){
						   statisticals.setDeptName("Region");
					   }else{
						statisticals.setDeptName("CEO");
					   }
				}else{
					statisticals.setDeptName(deptService.findById(opExcurition.getDeptId()).getDeptName());
				}
				statisticals.setOptionalExcuritions(optionalList);
				statisticals.setSum(total);
				statisticals.setCommonTourFee(comAmount);
				statisticals.setProfit(pay-cost);
				statisticalList.add(statisticals);
			}
			
			String year= null;//获取年份
			if(opExcurition.getDepartureDate()!=null){
				year=opExcurition.getDepartureDate();
			}else{
				year=opExcurition.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("optional", opExcurition);
			return "/admin/statistical/bookingOptional";
		}
		/**
		 * 订单详情（同行，团队）
		 * */
		@RequestMapping(value="/orderDetailsOptional",method=RequestMethod.GET)
		public String orderDetailsOptional(Model model,String menuId,String role,Order order){
			Admin admin=adminService.getCurrent();
			Order orders=new Order();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			/*//搜索中会有非团订单，非团订单处理
			if(order.getIsSelfOrganize()!=null){
				if(order.getIsSelfOrganize()==5){
					order.setIsSelfOrganize(1);
				}
			}*/
			if(order.getTicketType()!=null){
				if(order.getOptionalId()!=null){
					orders = statisticalService.detailsCountOptional(order);
				}
			}else{
					orders = statisticalService.detailsCountOptionalForArrival(order);
			}
			
			Dept dept=new Dept();
			OptionalExcurition optionalExcurition =new OptionalExcurition();
			if(order.getDeptId()!=null){
				dept =deptService.findById(order.getDeptId());
			}
			if(order.getOptionalId()!=null){
				optionalExcurition =optionalExcursionService.findById(order.getOptionalId());
			}
			if(order.getUserId()!=null){
				admin =adminService.findById(order.getUserId());
			}
			
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("order", order);
			model.addAttribute("orders", orders);
			model.addAttribute("deptName", dept.getDeptName());
			model.addAttribute("lineName", optionalExcurition.getName());
			model.addAttribute("userName",admin.getUsername());
			return "/admin/statistical/optionalOrderList";
		}
		/**
		 * 订单详情（同行，团队,Arrival）
		 * */
		@RequestMapping(value="/orderDetailsByOptional",method=RequestMethod.POST)
		public @ResponseBody Map<String, Object> orderDetailsByOptional(Pageable pageable,Order order){
			Admin admin=adminService.getCurrent();
			Map<String, Object> map = new HashMap<String, Object>();
			Page<Order> page=new Page<Order>();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			if(order.getTicketType()!=null){
				page = statisticalService.orderDetailsByOptional(order, pageable);
			}else{
				page = statisticalService.ArrivalDetailsByOptional(order, pageable);
			}
				
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		/**
		 * 打印统计详情
		 * */
		@RequestMapping(value="/orderDetailsPrintForOptional",method=RequestMethod.GET)
		public String orderDetailsPrintForOptional(Model model,Order order){
			Admin admin=adminService.getCurrent();
			List<Order> orderList=new ArrayList<Order>();
			Order orders=new Order();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			if(order.getTicketType()!=null){
				if(order.getOptionalId()!=null||order.getBrand()!=null){
					orderList = statisticalService.detailsOptionalPrint(order);
					orders = statisticalService.detailsCountOptional(order);
				}
			}else{
				orderList = statisticalService.detailsOptionalPrintForArrival(order);
				orders = statisticalService.detailsCountOptionalForArrival(order);
			}

			if(order.getOptionalId()!=null){
				OptionalExcurition optional =optionalExcursionService.findById(order.getOptionalId());
				model.addAttribute("lineName",optional.getName());
			}
			if(order.getPeerId()!=null){
				Vender vender =venderService.findById(order.getPeerId());
				model.addAttribute("venderName",vender.getName());
			}
			if(order.getDeptId()!=null){
				Dept dept =deptService.findById(order.getDeptId());
				model.addAttribute("deptName",dept.getDeptName());
			}
			//抵达日期2016-01-01 后 不发 5%
			for (Order o : orderList) {
				if(o.getArriveDateTime()!=null&&compareDate(o.getArriveDateTime())){
					o.setPriceExpression(new BigDecimal(0));
				}
			}
			model.addAttribute("orders",orders );
			model.addAttribute("orderList",orderList );
			model.addAttribute("order",order );
			model.addAttribute("adminName",admin.getUsername());
			model.addAttribute("deptName",deptService.findById(admin.getDeptId()).getDeptName());
			return "/admin/statistical/detailsStatisticalPrint";
	}
		/**
		 * export 导出 统计
		 * @return
		 */
		@RequestMapping(value="/ExcelForStatisticsForOptional",method=RequestMethod.GET)  
	    public ModelAndView ExcelForStatisticsForOptional(InvoiceAndCredit invoiceAndCredit,HttpServletRequest request, HttpServletResponse response,Order order) {
			Admin admin = adminService.getCurrent();
			List<Order> orderList=new ArrayList<Order>();
			Order orders=new Order();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
			if(order.getTicketType()!=null){
				if(order.getOptionalId()!=null||order.getBrand()!=null){
					orderList = statisticalService.detailsOptionalPrint(order);
				}
			}else{
				orderList = statisticalService.detailsOptionalPrintForArrival(order);
			}
			if(order.getPeerId()!=null){
				Vender vender =venderService.findById(order.getPeerId());
				//model.addAttribute("venderName",vender.getName());
			}
			if(order.getDeptId()!=null){
				Dept dept =deptService.findById(order.getDeptId());
				//model.addAttribute("deptName",dept.getDeptName());
			}
			//model.addAttribute("orders",orders );
			//model.addAttribute("orderList",orderList );
			//model.addAttribute("order",order );
			//model.addAttribute("adminName",admin.getUsername());
			//model.addAttribute("deptName",deptService.findById(admin.getDeptId()).getDeptName());
			StatisticsSheetExcle ss=new StatisticsSheetExcle();
			ss.setOrderList(orderList);
			return new ModelAndView(ss);
	}
	    /**
		 * 自选项收客按抵达日期时间统计
		 * */
		@RequestMapping(value="/ArrivalForOptional",method=RequestMethod.GET)
		public String ArrivalForOptional(Model model,String menuId,OptionalExcurition opExcurition,String role){
			Admin admin=adminService.getCurrent();
			List<Statistical> statisticalList=new ArrayList<Statistical>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM");
			opExcurition.setRole(role);
			if(opExcurition.getTime()==null && opExcurition.getDepartureDate()==null){
				opExcurition.setTime(format.format(new Date()));
			}
			if(role.equals("Office")){
				opExcurition.setDeptId(admin.getDeptId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else if(role.equals("Region")){
				opExcurition.setContactor(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
				model.addAttribute("dept", deptService.findDeptByRegionId(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId()));
			}else if(role.equals("CEO")){
				model.addAttribute("dept", deptService.findAll());
			}else if(role.equals("Group")){
				opExcurition.setDeptId(admin.getDeptId());
				opExcurition.setGroupId(admin.getGroupId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}else{
				opExcurition.setDeptId(admin.getDeptId());
				opExcurition.setUserId(admin.getId());
				model.addAttribute("dept",deptService.findById(admin.getDeptId()));
			}
			List<OptionalExcurition> optionalList=statisticalService.queryArrivalOptional(opExcurition);
			if(optionalList.size()>0){
				int total=0;
				double pay=0;
				double cost=0;
				double comAmount=0;
				for(int a=0;a<optionalList.size();a++){
					total+=optionalList.get(a).getSum();
					pay+=optionalList.get(a).getPay().doubleValue();
					cost+=optionalList.get(a).getCost().doubleValue();
					comAmount+=optionalList.get(a).getCommonTourFee().doubleValue();
				}
				Statistical statisticals=new Statistical();
				if(opExcurition.getDeptId()==null){
					if(role.equals("Region")){
						   statisticals.setDeptName("Region");
					   }else{
						statisticals.setDeptName("CEO");
					   }
				}else{
					statisticals.setDeptName(deptService.findById(opExcurition.getDeptId()).getDeptName());
				}
				statisticals.setOptionalExcuritions(optionalList);
				statisticals.setSum(total);
				statisticals.setCommonTourFee(comAmount);
				statisticals.setProfit(pay-cost);
				statisticalList.add(statisticals);
			}
			
			String year= null;//获取年份
			if(opExcurition.getDepartureDate()!=null){
				year=opExcurition.getDepartureDate();
			}else{
				year=opExcurition.getTime().substring(0, 4);
			}
			model.addAttribute("statisticalList", statisticalList);
			model.addAttribute("menuId", menuId);
			model.addAttribute("role", role);
			model.addAttribute("year", year);
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("optional", opExcurition);
			return "/admin/statistical/arrivalOptional";
	}
		 /**
		  * Optional tour按抵达日期统计
		  */
		@RequestMapping(value="/ArrivalDetailsByOptional",method=RequestMethod.POST)
		public @ResponseBody Map<String, Object> ArrivalDetailsByOptional(Pageable pageable,Order order){
			Admin admin=adminService.getCurrent();
			Map<String, Object> map = new HashMap<String, Object>();
			Page<Order> page=new Page<Order>();
			//region 和 group特殊
			if(order.getRole().equals("Region")){
				order.setContact(deptService.findRegionByDeptId(admin.getDeptId()).get(0).getRegionId());
			}else if(order.getRole().equals("Group")){
				order.setGroupId(admin.getGroupId());
			}
				page = statisticalService.orderDetailsByOptional(order, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 *跳转统计报表导出页面
		 * */
		@RequestMapping(value="/statisticalReports",method=RequestMethod.GET)
		public String statisticalReports(Model model,Statistical statistical) {
			Admin admin=adminService.getCurrent();
			Subject currentUser = SecurityUtils.getSubject();
			String role="";
			if (currentUser.isPermitted("admin:Office")){
				statistical.setDeptId(admin.getDeptId());
				role="Office";
			}else if (currentUser.isPermitted("admin:Agent")){
				statistical.setAgent(admin.getUsername());
				role="Agent";
			}
			ArrayList<String>  year = new ArrayList<String> (); 
			for(int n=0;n<Integer.parseInt(statistical.getDate())-Integer.parseInt(statistical.getTime())+1;n++){
				String y=String.valueOf(Integer.parseInt(statistical.getTime())+n);
				year.add(y);
			}
			model.addAttribute("deptList", statisticalService.queryStatisticalReportDept(statistical));
			model.addAttribute("statisticalList", statisticalService.getStatisticalReport(statistical,year));
			model.addAttribute("adminList", adminService.findAllOfDeptName());
			model.addAttribute("statistical",statistical);
			model.addAttribute("year",year);
			model.addAttribute("role",role);
			model.addAttribute("dept", deptService.findAll());
			model.addAttribute("constant",CONSTANT);
			model.addAttribute("menuId", 1112);
			return "/admin/statistical/statisticalReports";
		}
		
		/**
		  * 统计报表导出
		  *//*
		@RequestMapping(value="/reportsExport",method=RequestMethod.POST) 
	    public ModelAndView reportsExport(Statistical statistical,HttpServletRequest request, HttpServletResponse response) {
			StatisticalReportsExcle sr=new StatisticalReportsExcle();
			sr.setType(statistical.getIsSystem());
			List<Statistical> statisticalList = statisticalService.getAllStasticAccountList(statistical);
			sr.setStatisticalList(statisticalList);
			sr.setStatistical(statistical);
			sr.setDeptList(statisticalService.queryStatisticalReportDept(statistical));
			return new ModelAndView(sr);
	    }*/
}
