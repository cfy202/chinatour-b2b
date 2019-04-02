package com.chinatour.controller.admin;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Dept;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.entity.Tour;
import com.chinatour.service.AdminService;
import com.chinatour.service.CustomerOrderRelService;
import com.chinatour.service.CustomerService;
import com.chinatour.service.DeptService;
import com.chinatour.service.OrderService;
import com.chinatour.service.OrdersTotalService;
import com.chinatour.service.PayCostRecordsService;
import com.chinatour.service.SupplierPriceRemarkService;
import com.chinatour.service.SupplierPriceService;
import com.chinatour.service.TourService;
import com.chinatour.service.VenderService;
import com.chinatour.util.CreateOrderTour;
import com.chinatour.vo.SettlementTotalVO;
import com.chinatour.webService.client.GetAccData;
import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

/**
 * 订单收款
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-13 下午2:43:12
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/payCostRecords")
public class PayCostRecordsController extends BaseController implements ServletContextAware {
	
	public static final TemplateHashModel CONSTANT;

	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/orders";

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

	@Resource(name = "payCostRecordsServiceImpl")
	private PayCostRecordsService payCostRecordsService;

	@Autowired
	private AdminService adminService;

	@Resource(name = "orderServiceImpl")
	private OrderService orderService;

	@Resource(name = "tourServiceImpl")
	private TourService tourService;

	@Resource(name = "supplierPriceRemarkServiceImpl")
	private SupplierPriceRemarkService supplierPriceRemarkService;

	@Resource(name = "deptServiceImpl")
	private DeptService deptService;

	@Resource(name = "supplierPriceServiceImpl")
	private SupplierPriceService supplierPriceService;
	
	@Resource(name = "customerOrderRelServiceImpl")
	private CustomerOrderRelService customerOrderRelService;
	
	@Resource(name = "customerServiceImpl")
	private CustomerService customerService;
	
	@Resource(name = "ordersTotalServiceImpl")
	private OrdersTotalService ordersTotalService;
	
	@Resource(name = "getAccData")
	private GetAccData getAccData;
	
	@Autowired
	private VenderService venderService;
	
	
	/** servletContext */
	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
	/**
	 * 查询收入所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(ModelMap model,PayCostRecords pay) {
		//传Null值进入判断
		if(pay.getOrderNo()!=null && pay.getOrderNo().equals("null")){
			pay.setOrderNo(null);
		}
		if(pay.getTourCode()!=null && pay.getTourCode().equals("null")){
			pay.setTourCode(null);
		}
		if(pay.getSum()!=null && pay.getSum().equals("null")){
			pay.setSum(null);
		}
		if(pay.getUserName()!=null && pay.getUserName().equals("null")){
			pay.setUserName(null);
		}
		if(pay.getCode()!=null && pay.getCode().equals("null")){
			pay.setCode(null);
		}
		if(pay.getRemark()!=null && pay.getRemark().equals("null")){
			pay.setRemark(null);
		}
		/*if(pay.getOrderNo().equals("null")){
			pay.setOrderNo(null);
		}*/
		model.addAttribute("pay",pay);
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("menuId", "503");
		return "/admin/finance/orderFinance/list";
	}

	/**
	 * 异步查询收入所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, PayCostRecords payCostRecords) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 插入部门id
		payCostRecords.setDeptIdString(adminService.getCurrent().getDeptId());
		payCostRecords.setPayOrCost(1);
		Page<PayCostRecords> page = payCostRecordsService.findPage(
				payCostRecords, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * Booking Receivable打印功能
	 * @param model
	 * @param payCostRecords
	 * @return
	 */
	@RequestMapping(value = "/findOrderListVOPrintOfPay", method = RequestMethod.GET)
	public String findOrderListVOPrintOfPay(ModelMap model,PayCostRecords payCostRecords) {
		payCostRecords.setDeptIdString(adminService.getCurrent().getDeptId());
		payCostRecords.setPayOrCost(1);
		model.addAttribute("ordersList",payCostRecordsService.findPayOrCostByOrders(payCostRecords));
		model.addAttribute("payorcost", "pay");
		return "/admin/finance/orderFinance/agentOrderStaticsListPrint";
	}
	
	@RequestMapping(value = "/findOrderListVOPrintOfCost", method = RequestMethod.GET)
	public String findOrderListVOPrintOfCost(ModelMap model,PayCostRecords payCostRecords) {
		payCostRecords.setDeptIdString(adminService.getCurrent().getDeptId());
		payCostRecords.setPayOrCost(2);
		model.addAttribute("ordersList",payCostRecordsService.findPayOrCostByOrders(payCostRecords));
		model.addAttribute("payorcost", "cost");
		return "/admin/finance/orderFinance/agentOrderStaticsListPrint";
	}
	/**
	 * 查询支出所有
	 */
	@RequestMapping(value = "/payList", method = RequestMethod.GET)
	public String payList(ModelMap model,PayCostRecords pay) {
		if(pay.getOrderNo()!=null && pay.getOrderNo().equals("null")){
			pay.setOrderNo(null);
		}
		if(pay.getTourCode()!=null && pay.getTourCode().equals("null")){
			pay.setTourCode(null);
		}
		if(pay.getSum()!=null && pay.getSum().equals("null")){
			pay.setSum(null);
		}
		if(pay.getUserName()!=null && pay.getUserName().equals("null")){
			pay.setUserName(null);
		}
		if(pay.getCode()!=null && pay.getCode().equals("null")){
			pay.setCode(null);
		}
		if(pay.getRemark()!=null && pay.getRemark().equals("null")){
			pay.setRemark(null);
		}
		if(pay.getVenderString()!=null && pay.getVenderString().equals("null")){
			pay.setVenderString(null);
		}
		model.addAttribute("pay",pay);
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("menuId", "503");
		return "/admin/finance/orderFinance/payList";
	}

	/**
	 * 异步查询支出所有
	 */
	@RequestMapping(value = "/payList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> payList(Pageable pageable, PayCostRecords payCostRecords) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 插入部门id
		payCostRecords.setDeptIdString(adminService.getCurrent().getDeptId());
		payCostRecords.setPayOrCost(2);
		Page<PayCostRecords> page = payCostRecordsService.findCostForPage(
				payCostRecords, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * Group
	 * 查询收入所有
	 */
	@RequestMapping(value = "/groupList", method = RequestMethod.GET)
	public String groupList(ModelMap model,PayCostRecords pay) {
		if(pay.getOrderNo()!=null && pay.getOrderNo().equals("null")){
			pay.setOrderNo(null);
		}
		if(pay.getTourCode()!=null && pay.getTourCode().equals("null")){
			pay.setTourCode(null);
		}
		if(pay.getSum()!=null && pay.getSum().equals("null")){
			pay.setSum(null);
		}
		model.addAttribute("menuId", "512");
		model.addAttribute("pay", pay);
		return "/admin/finance/orderFinance/groupList";
	}

	/**
	 * Group
	 * 异步查询收入所有
	 */
	@RequestMapping(value = "/groupList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> groupList(Pageable pageable, PayCostRecords payCostRecords) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 插入部门id
		//payCostRecords.setDeptIdString(adminService.getCurrent().getDeptId());
		//查出小组
		String groupIdString = adminService.getCurrent().getGroupId();
		payCostRecords.setGroupId(groupIdString);
		payCostRecords.setPayOrCost(1);
		Page<PayCostRecords> page = payCostRecordsService.findForGroupPage(
				payCostRecords, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * Group
	 * 查询支出所有
	 */
	@RequestMapping(value = "/groupPayList", method = RequestMethod.GET)
	public String groupPayList(ModelMap model,PayCostRecords pay) {
		if(pay.getOrderNo()!=null && pay.getOrderNo().equals("null")){
			pay.setOrderNo(null);
		}
		if(pay.getTourCode()!=null && pay.getTourCode().equals("null")){
			pay.setTourCode(null);
		}
		if(pay.getSum()!=null && pay.getSum().equals("null")){
			pay.setSum(null);
		}
		model.addAttribute("menuId", "512");
		model.addAttribute("pay", pay);
		return "/admin/finance/orderFinance/groupPayList";
	}

	/**
	 * Group
	 * 异步查询支出所有
	 */
	@RequestMapping(value = "/groupPayList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> groupPayList(Pageable pageable, PayCostRecords payCostRecords) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 插入部门id
		//payCostRecords.setDeptIdString(adminService.getCurrent().getDeptId());
		//查出小组
		String groupIdString = adminService.getCurrent().getGroupId();
		payCostRecords.setGroupId(groupIdString);
		payCostRecords.setPayOrCost(2);
		Page<PayCostRecords> page = payCostRecordsService.findForGroupPage(
				payCostRecords, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 查询
	 * 
	 * @param model(传入了tourCode)
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/find", method = RequestMethod.POST)
	public @ResponseBody
	PayCostRecords findById(String id) {
		String tourCode=orderService.findById(payCostRecordsService.findById(id).getOrderId()).getTourCode();
		if(tourCode==""||tourCode==null){
			tourCode="";
		}
		PayCostRecords payCostRecords=payCostRecordsService.findById(id);
		payCostRecords.setTourCode(tourCode);
		return payCostRecords;
	}

	/**
	 * 修改
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public String edit(PayCostRecords pay, String[] recordsId,String temp,String InvoiceNos,String ways,
			String recordString, String munId,RedirectAttributes redirectAttributes) {
		PayCostRecords p=pay;
		p.setCode(InvoiceNos);
		p.setWay(ways);
		if (recordString != null) {
			p.setStatus(1);
			p.setId(recordString);
			p.setApproveDate(new Date());
			payCostRecordsService.update(p);
		} else {
			for (String id : recordsId) {
				pay.setStatus(1);
				pay.setId(id);
				pay.setApproveDate(new Date());
				payCostRecordsService.update(pay);
			}
		}
		if(pay.getSum()!=null){
			if (munId.equals("504")) {//判断是普通页面还是小组页面
				if(temp!=null&&temp.equals("pay")){//判断是收入页面还是支出
					return "redirect:payList.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus()+"&sum="+pay.getSum()+"&userName="+pay.getUserName()+"&code="+pay.getCode()+"&remark="+pay.getRemark()+"&venderString="+pay.getVenderString();
				}
				return "redirect:list.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus()+"&sum="+pay.getSum()+"&userName="+pay.getUserName()+"&code="+pay.getCode()+"&remark="+pay.getRemark();
			}
			if(temp!=null&&temp.equals("pay")){
				return "redirect:groupPayList.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus()+"&sum="+pay.getSum();
			}
			return "redirect:groupList.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus()+"&sum="+pay.getSum();
			
		}
		if (munId.equals("504")) {//判断是普通页面还是小组页面
			if(temp!=null&&temp.equals("pay")){//判断是收入页面还是支出
				return "redirect:payList.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus()+"&userName="+pay.getUserName()+"&code="+pay.getCode()+"&remark="+pay.getRemark()+"&venderString="+pay.getVenderString();
			}
			return "redirect:list.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus()+"&userName="+pay.getUserName()+"&code="+pay.getCode()+"&remark="+pay.getRemark();
		}
		if(temp!=null&&temp.equals("pay")){
			return "redirect:groupPayList.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus();
		}
		return "redirect:groupList.jhtml?orderNo="+pay.getOrderNo()+"&tourCode="+pay.getTourCode()+"&status="+pay.getStatus();
	}

	/**
	 * agent申请结算
	 * 
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/updateOrderOfTourTaxState", method = RequestMethod.POST)
	public String updateOrderOfTourTaxState(String[] orderIds,
			RedirectAttributes redirectAttributes) {
		if (orderIds != null) {
			for (int i = 0; i < orderIds.length; i++) {
				Order order = orderService.findById(orderIds[i]);
				order.setTax(3);// 修改订单结算状态 3申请结算
				order.setCheckTime(new Date());// 保存 财务结算时间
				orderService.update(order);
			}
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:/admin/orders/list.jhtml";
	}

	/**
	 * 会计审核订单结算状态
	 */
	@RequestMapping(value = "/findOrderTaxList", method = RequestMethod.GET)
	public String findOrderTaxList(ModelMap model) {
		model.addAttribute("menuId", "505");
		return "/admin/finance/accountant/orderTaxList";
	}

	/**
	 * 异步跳转会计审核订单结算状态
	 */
	@RequestMapping(value = "/findOrderTaxList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> findOrderTaxList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 插入部门id
		order.setDeptId(adminService.getCurrent().getDeptId());
		Page<Order> page = orderService.findOrderOfTourTaxPage(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 财务结算，结算完成之后系统自动发送5%的操作费
	 * 
	 * @param model
	 * @param id
	 * @return
	 */
	//@RequestMapping(value = "/checkOrderOfTourTax", method = RequestMethod.POST)
	
	/*public String checkOrderOfTourTax(String[] orderIds,String[] supplierPriceRemarkIds,
			RedirectAttributes redirectAttributes) {
		if(orderIds!=null){
			int flag = 0;  //用来判断是否发invoice 0:发invoice 1：不发
			List<Order> orderList = new ArrayList<Order>();  
			List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();  //存放某订单的支出由于收入明细
			Tour tour = new Tour();
			for(String orderId : orderIds){
				Order orders=orderService.findById(orderId);
				tour = tourService.findById(orders.getTourId());
				if((orders.getOrderType()==5)){ //非团订单不发invoice
					flag = 1;
				}
				if(tour != null){
					if(orders.getTax()==3){
						orders.setTax(4); //修改订单结算状态    4结算
						orders.setCheckTime(new Date());// 保存 财务结算时间
						orderService.update(orders);
						
						//orders.setUserId(adminService.getCurrent().getId());
						List<Order> orderLists = orderService.findOrderOfPayOrCost(orders);
						BigDecimal cosTotalSum = new BigDecimal(0.00);
						BigDecimal payTotalSum = new BigDecimal(0.00);
						for (Order ord : orderLists) {
							payCostRecordsList.addAll(ord.getPayCostRecords());
							// 查出团下每个订单的总收入支出
							ord.setType(9);//去除变更单成本
							Order orderProfit = orderService.findOrderProfit(ord);
							
							if(orderProfit!=null&&orderProfit.getCostTotalSum()!=null){
								cosTotalSum = cosTotalSum.add(orderProfit.getCostTotalSum());
							}
							if(orderProfit!=null&&orderProfit.getPayTotalSum()!=null){
								payTotalSum = payTotalSum.add(orderProfit.getPayTotalSum());
							}
						}
						orders.setCostTotalSum(cosTotalSum);
						orders.setPayTotalSum(payTotalSum);
						// 订单利润
						orders.setProfit(orders.getCostTotalSum().subtract(orders.getPayTotalSum()));
						// op利润
						orders.setOpProfit(orders.getProfit().multiply(Constant.OP_PROFIT));
						// agent利润
						orders.setAgentProfit(orders.getProfit().multiply(Constant.AGENT_PROFIT));
						if(flag==0){
							orderList.add(orders);
							orderService.billOrdersProfitCredit(orderList);
						}
					}
				}
			}
			if(supplierPriceRemarkIds!=null){
				this.checkOrderOfTourChangeTax(supplierPriceRemarkIds);
			}
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:/admin/payCostRecords/findOrderTaxList.jhtml";
		
	}
*/
	/**

	 * 会计确认结算变更单发Cridir
	 * @return
	 */
	private void checkOrderOfTourChangeTax(String[] supplierPriceRemarkIds)
	{
		Admin user = adminService.getCurrent();
		if (user != null) {
			
			for(String supplierPriceRemarkId : supplierPriceRemarkIds){
				SupplierPriceRemark supplierPriceRemark=supplierPriceRemarkService.findRateById(supplierPriceRemarkId);
				if(supplierPriceRemark.getSprCheck()==1){
					
				}
			}
		}
	}
	
	/**
	 * 财务 查询收入所有
	 * agent 申请结算
	 * acc 结算
	 * 展示团下总收入
	 *  查询收入所有
	 */
	@RequestMapping(value = "/checkOrderOfTourPofit", method = RequestMethod.GET)
	public String checkOrderOfTourPofit(Order order,ModelMap model,String menuId,String print) {
		if(order.getTourId()==null){
			return ERROR_VIEW;
		}
		List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
		Tour tour = new Tour();
		List<Order> orderList = orderService.findOrderOfPayOrCost(order);
		Order orderS = new Order();
		BigDecimal cosTotalSum = new BigDecimal(0.00);
		BigDecimal payTotalSum = new BigDecimal(0.00);
		for (Order ord : orderList) {
			payCostRecordsList.addAll(ord.getPayCostRecords());

			// 查出团下每个订单的总收入支出
			ord.setType(9);//去除变更单成本
			Order orderProfit = orderService.findOrderProfit(ord);// left join
			if(orderProfit!=null&&orderProfit.getCostTotalSum()!=null){
				cosTotalSum = cosTotalSum.add(orderProfit.getCostTotalSum());
			}
			if(orderProfit!=null&&orderProfit.getPayTotalSum()!=null){
				payTotalSum = payTotalSum.add(orderProfit.getPayTotalSum());
			}
		}
		orderS.setPayTotalSum(payTotalSum);
		orderS.setCostTotalSum(cosTotalSum);
		// 账单变更单页面数据
		List<SupplierPriceRemark> supplierPriceRemarkList = new ArrayList<SupplierPriceRemark>();
		// 判断是否录入账单
		if (tourService.findAllCheckByTourId(order.getTourId()) == null) {
			tour = tourService.findById(order.getTourId());
			// 3表示未录入账单
			tour.setAllCheck(3);

		} else {
			tour = tourService.findAllCheckByTourId(order.getTourId());
			SupplierPriceRemark spr = new SupplierPriceRemark();
			spr.setTourId(order.getTourId());
			spr.setUserId(order.getUserId());
			// 账单变更单页面数据
			supplierPriceRemarkList = supplierPriceRemarkService
					.findAgentTax(spr);

			if (supplierPriceRemarkList.size() != 0) {
				for (int a = 0; a < supplierPriceRemarkList.size(); a++) {
					orderS.setCostTotalSum(orderS.getCostTotalSum().add(
							supplierPriceRemarkList.get(a).getDifferenceSum()));
				}
			}
		}
		Dept toDept = deptService.findById(adminService.findById(
				tour.getUserId()).getDeptId());
		// 利润
		orderS.setProfit(orderS.getPayTotalSum().subtract(
				orderS.getCostTotalSum()));

		// op利润
		orderS.setOpProfit(orderS.getProfit().multiply(Constant.OP_PROFIT));

		// agent利润
		orderS.setAgentProfit(orderS.getProfit().multiply(Constant.AGENT_PROFIT));
		Admin admin = adminService.findById(order.getUserId());
		model.addAttribute("supplierPrice",supplierPriceService.findByTourId(order.getTourId()));
		model.addAttribute("order", orderS);
		model.addAttribute("menuId", menuId);
		model.addAttribute("tour", tour);
		model.addAttribute("payCostRecordsList", payCostRecordsList);
		model.addAttribute("userName", admin.getUsername());
		model.addAttribute("orderList", orderList);
		model.addAttribute("userId", order.getUserId());
		model.addAttribute("dept", deptService.findById(admin.getDeptId()));
		model.addAttribute("supplierPriceRemarkList", supplierPriceRemarkList);
		model.addAttribute("deptName", toDept.getDeptName());
		if(print==null){
			return "/admin/finance/accountant/checkOrderOfTourPofit";
		}else{
			return "/admin/finance/accountant/checkOrderOfTourPofitPrint";
		}
	}
	
	/**
	 * 打印非团队订单结算Profit
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkSingleOrderPofit", method = RequestMethod.GET)
	public String checkSingleOrderPofit(Order order,ModelMap model,String menuId) {
		order = orderService.findById(order.getId());
	/**	CustomerOrderRel customerOrderRel=new CustomerOrderRel();
		customerOrderRel.setOrderId(order.getId());
		customerOrderRel.setIsDel(0);
		List<CustomerOrderRel> customerOrderRelList = customerOrderRelService.find(customerOrderRel);
		List<Customer> customerList=new ArrayList<Customer>();
		Customer customer =new Customer();
		for (int i = 0; i < customerOrderRelList.size(); i++) {
			// 默认第一个客人缴费
			customer.setCustomerId((customerOrderRelList.get(0).getCustomerId());
			customerList = customerService.find(customer);
		}**/
		
		// 查找所有对应订单的缴款信息
		PayCostRecords payCostRecords=new PayCostRecords();
		payCostRecords.setOrderId(order.getId());
		//payCostRecords.setType(9);//去除变更单成本
		List<PayCostRecords> payCostRecordsList = payCostRecordsService.find(payCostRecords);
		
		// 订单利润
		Dept dept = deptService.findById(adminService.getCurrent().getDeptId());
		DecimalFormat df = new DecimalFormat(".00");
		//profit.setOrderId(order.getId());
		//发票金额==共计应收团款
		Order orderS=new Order();
		orderS.setId(order.getId());
		orderS.setType(9);//去除变更单成本
		Order orderProfit = orderService.findOrderProfit(orderS);
		//利润
		order.setProfit(orderProfit.getPayTotalSum().subtract(
				orderProfit.getCostTotalSum()));
		model.addAttribute("order", order);
		model.addAttribute("menuId", "307");
		model.addAttribute("payCostRecordsList", payCostRecordsList);
		return "/admin/finance/accountant/checkSingleOrderPofit";
	}
	
	/**
	 * 总账单
	 * agent 申请结算
	 * 展示团下总收入
	 *  查询收入所有
	 */
	@RequestMapping(value = "/agentSettlementOrdersTotal", method = RequestMethod.GET)
	public String agentSettlementOrdersTotal(ModelMap model,OrdersTotal ordersTotal,String menuId) {
		
		SettlementTotalVO settlementTotalVO=payCostRecordsService.settlementOrdersTotal(ordersTotal);
		List<Dept> deptList=new ArrayList<Dept>();
		Iterator<String> it=settlementTotalVO.getOpUserIdStrings().iterator();
		while(it.hasNext()){
			 deptList.add(deptService.findById(adminService.findById(it.next()).getDeptId()));
		}
		int flag1=0;
		int flag2=0;
		// 判断取消订单
		for (Order order : settlementTotalVO.getOrdList()) {
			if(order.getState()==5||order.getState()==6){
				flag1=1;
			}else{
				flag2=1;
			}
		}
		//判断是否组团
		if (flag1!=1&&flag2!=1&&settlementTotalVO.getTourIdStrings().size() == 0
				&& settlementTotalVO.getOrder().getIsSelfOrganize() != null
				&&(settlementTotalVO.getOrder().getIsSelfOrganize() !=0)) {
			settlementTotalVO.getTour().setAllCheck(2);
		}
		Admin admin = adminService.findById(ordersTotal.getUserId());
		model.addAttribute("menuId",menuId);
		model.addAttribute("order", settlementTotalVO.getOrder());
		model.addAttribute("tour", settlementTotalVO.getTour());
		model.addAttribute("ordersTotal", ordersTotalService.findById(ordersTotal.getOrdersTotalId()));
		model.addAttribute("payCostRecordsList", settlementTotalVO.getPayCostRecordsList());
		model.addAttribute("userName", admin.getUsername());
		model.addAttribute("dept", deptService.findById(admin.getDeptId()));
		model.addAttribute("supplierPriceRemarkList", settlementTotalVO.getSupplierPriceRemarkList());
		model.addAttribute("deptList", deptList);
		model.addAttribute("ordList",settlementTotalVO.getOrdList());
		return "/admin/finance/accountant/agentSettlementOrdersTotal";
	}
	
	/**
	 * 总账单
	 * agent申请结算
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/agentUpdateOrderTotalTaxState", method = RequestMethod.GET)
	public String agentUpdateOrderTotalTaxState(OrdersTotal ordersTotal,RedirectAttributes redirectAttributes) {
		if (ordersTotal != null) {
			ordersTotal.setTax(3);// 修改订单结算状态 3申请结算
			ordersTotal.setCheckTime(new Date());// 保存 agent申请结算时间
			List<Order> orderList=orderService.findByOrdersTotalId(ordersTotal.getOrdersTotalId());
			for (Order order : orderList) {
				order.setTax(3);// 修改订单结算状态 3申请结算
				order.setCheckTime(new Date());
				orderService.update(order);
			}
			ordersTotalService.update(ordersTotal);
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}
		return "redirect:/admin/orders/ordersTotalList.jhtml";
	}
	
	/**
	 * 总账单
	 * 会计审核订单结算状态
	 */
	@RequestMapping(value = "/findOrderTotalTaxList", method = RequestMethod.GET)
	public String findOrderTotalTaxList(ModelMap model) {
		model.addAttribute("menuId", "505");
		return "/admin/finance/accountant/findOrderTotalTaxList";
	}

	/**
	 * 总账单
	 * 异步跳转会计审核订单结算状态
	 */
	@RequestMapping(value = "/findOrderTotalTaxList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> findOrderTotalTaxList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 插入部门id
		order.setDeptId(adminService.getCurrent().getDeptId());
		Page<Order> page = orderService.findOrdersTaxPage(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			Order o=orderService.findSumPepoleAndPayOrCost(order);
			o.setPayCost(new PayCostRecords());
			o.getPayCost().setPayTotalSum(o.getPayTotalSum());
			o.getPayCost().setCostTotalSum(o.getCostTotalSum());
			//o.setPriceExpression(new BigDecimal(0.05));
			page.getContent().add(o);
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 
	 * 总账单 打印
 	 *会计审核订单结算
	 */
	@RequestMapping(value = "/findOrderTotalTaxListPrint", method = RequestMethod.GET)
	public String findOrderTotalTaxListPrint(ModelMap model,Order order) {
		// 插入部门id
		order.setDeptId(adminService.getCurrent().getDeptId());
		List<Order> ordersList= orderService.findOrderTaxPrint(order);
		Order ord=orderService.findSumPepoleAndPayOrCost(order);
		Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
		model.addAttribute("ordersTime", order);
		model.addAttribute("order", ord);
		model.addAttribute("deptName", dept.getDeptName());
		model.addAttribute("ordersList", ordersList);
		return "/admin/finance/accountant/agentOrderStaticsListPrint";
	}
	
	
	/**
	 * Group
	 * 总账单
	 * 会计审核订单结算状态
	 */
	@RequestMapping(value = "/findOrderTotalTaxGroupList", method = RequestMethod.GET)
	public String findOrderTotalTaxGroupList(ModelMap model) {
		model.addAttribute("menuId", "513");
		return "/admin/finance/accountant/findOrderTotalTaxGroupList";
	}

	/**
	 * Group
	 * 总账单
	 * 异步跳转会计审核订单结算状态
	 */
	@RequestMapping(value = "/findOrderTotalTaxGroupList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> findOrderTotalTaxGroupList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 小组id
		//ordersTotal.setDeptId(adminService.getCurrent().getDeptId());
		String groupIdString = adminService.getCurrent().getGroupId();
		order.setGroupId(groupIdString);
		Page<Order> page = orderService.findOrderTaxGroupPage(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			Order o=orderService.findGroupSumPepoleAndPayOrCost(order);
			o.setPayCost(new PayCostRecords());
			o.getPayCost().setPayTotalSum(o.getPayTotalSum());
			o.getPayCost().setCostTotalSum(o.getCostTotalSum());
			page.getContent().add(o);
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * Group
	 * 总账单 打印
 	 *会计审核订单结算
	 */
	@RequestMapping(value = "/findGroupOrderTotalTaxListPrint", method = RequestMethod.GET)
	public String findGroupOrderTotalTaxListPrint(ModelMap model,Order order) {
		// 小组id
		String groupIdString = adminService.getCurrent().getGroupId();
		order.setGroupId(groupIdString);
		List<Order> ordersList= orderService.findGroupOrderTaxPrint(order);
		Order ord=orderService.findGroupSumPepoleAndPayOrCost(order);
		Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
		model.addAttribute("ordersTime", order);
		model.addAttribute("order", ord);
		model.addAttribute("deptName", dept.getDeptName());
		model.addAttribute("ordersList", ordersList);
		return "/admin/finance/accountant/agentOrderStaticsListPrint";
	}
	
	/**
	 * 总账单
	 * agent的财务  结算
	 * 展示团下总收入
	 *  查询收入所有
	 */
	@RequestMapping(value = "/accSettlementOrdersTotal", method = RequestMethod.GET)
	public String accSettlementOrdersTotal(ModelMap model,OrdersTotal ordersTotal) {
		
		SettlementTotalVO settlementTotalVO=payCostRecordsService.settlementOrdersTotal(ordersTotal);
		List<Dept> deptList=new ArrayList<Dept>();
		Iterator<String> it=settlementTotalVO.getOpUserIdStrings().iterator();
		while(it.hasNext()){
			 deptList.add(deptService.findById(adminService.findById(it.next()).getDeptId()));
		}
		Admin admin = adminService.findById(ordersTotal.getUserId());
		model.addAttribute("menuId","505");
		model.addAttribute("order", settlementTotalVO.getOrder());
		model.addAttribute("tour", settlementTotalVO.getTour());
		model.addAttribute("ordersTotal", ordersTotalService.findById(ordersTotal.getOrdersTotalId()));
		model.addAttribute("payCostRecordsList", settlementTotalVO.getPayCostRecordsList());
		model.addAttribute("userName", admin.getUsername());
		model.addAttribute("dept", deptService.findById(admin.getDeptId()));
		model.addAttribute("supplierPriceRemarkList", settlementTotalVO.getSupplierPriceRemarkList());
		model.addAttribute("deptList", deptList);
		model.addAttribute("supplierCheck", settlementTotalVO.getSupplierCheck());
		model.addAttribute("ordList",settlementTotalVO.getOrdList());
		return "/admin/finance/accountant/accSettlementOrdersTotal";
	}
	
	/**
	 * 总账单   //结算完成发5% 操作费
	 * acc
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/accUpdateOrderTotalTaxState", method = RequestMethod.GET)
	public String accUpdateOrderTotalTaxState(OrdersTotal ordersTotal,RedirectAttributes redirectAttributes) {
		//ordersTotal =  ordersTotalService.findById(ordersTotal.getOrdersTotalId());
		if (ordersTotal != null) {
			// 修改订单结算状态 4结算
			ordersTotal.setCheckTime(new Date());// 保存 财务结算时间
			
			SettlementTotalVO settlementTotalVO=payCostRecordsService.settlementOrdersTotal(ordersTotal);
			List<Order> orderList = settlementTotalVO.getOrderList();//agent所有团下下的order利润以及对应团的op
			orderService.billOrdersProfitCredit(ordersTotal, orderList,settlementTotalVO);
			ordersTotal.setTax(4);
			ordersTotalService.update(ordersTotal);
			//如果是非团丁修改结算日期和结算时间  （团结算日期在上面那个方法里）
			if(settlementTotalVO.getSingleOrdersList()!=null){
				List<Order> singleOrdersList=settlementTotalVO.getSingleOrdersList();
				for(Order singleorder:singleOrdersList){
					singleorder.setCheckTime(new Date());
					singleorder.setTax(2);
					orderService.update(singleorder);
				}
			}
			
			for(Order o:settlementTotalVO.getOrdList()){
				if(o.getState()==5||o.getState()==6){
					o.setTax(4);
					orderService.update(o);
				}
			}
			
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}
		return "redirect:/admin/payCostRecords/findOrderTotalTaxList.jhtml";
	}
	
	/**
	 * 总账单
	 * acc结算变更单
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/accBillOrderTotal", method = RequestMethod.POST)
	public String accBillOrderTotal(String[] orderIds,RedirectAttributes redirectAttributes,String toRateOfCurrencyId) {
		orderService.billOrdersChangeProfitCredit(orderIds,toRateOfCurrencyId);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:/admin/payCostRecords/findOrderTotalTaxList.jhtml";
	}
	
	/**
	 * 总账单
	 * 打印结算
	 */
	@RequestMapping(value = "/settlementOrdersTotal", method = RequestMethod.GET)
	public String settlementOrdersTotal(ModelMap model,OrdersTotal ordersTotal) {
		
		SettlementTotalVO settlementTotalVO=payCostRecordsService.settlementOrdersTotal(ordersTotal);
		List<Dept> deptList=new ArrayList<Dept>();
		Iterator<String> it=settlementTotalVO.getOpUserIdStrings().iterator();
		while(it.hasNext()){
			 deptList.add(deptService.findById(adminService.findById(it.next()).getDeptId()));
		}
		Admin admin = adminService.findById(ordersTotal.getUserId());
		model.addAttribute("order", settlementTotalVO.getOrder());
		model.addAttribute("tour", settlementTotalVO.getTour());
		model.addAttribute("ordersTotal", ordersTotalService.findById(ordersTotal.getOrdersTotalId()));
		model.addAttribute("payCostRecordsList", settlementTotalVO.getPayCostRecordsList());
		model.addAttribute("userName", admin.getUsername());
		model.addAttribute("dept", deptService.findById(admin.getDeptId()));
		model.addAttribute("supplierPriceRemarkList", settlementTotalVO.getSupplierPriceRemarkList());
		model.addAttribute("deptList", deptList);
		model.addAttribute("ordList",settlementTotalVO.getOrdList());
		return "/admin/finance/accountant/SettlementOrdersTotalPrint";
	}
	
	/**
	 * 导出excel账单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/explorBill", method = RequestMethod.GET)
	public String explorBill(SupplierPrice supplierPrice,HttpServletRequest request,
			HttpServletResponse response) {
		// 查找团下的Agent
		supplierPrice.setDeptId(adminService.getCurrent().getDeptId());
		supplierPrice.setCompleteState(1);
		List<SupplierPrice> supplierPriceList = supplierPriceService.findBillOfExplor(supplierPrice);
		// 机票
		List<SupplierPrice> supplierPriceListF = supplierPriceService.findBillOfExplorFlight(supplierPrice);
		List<SupplierPrice> supplierPriceListS = new ArrayList<SupplierPrice>();

		supplierPriceListS = supplierPriceService.findOrderBillOfExplorAndDept(supplierPrice);
			

		for (SupplierPrice supplierPriceS : supplierPriceListS) {
			//判断是否是 xian
			if (supplierPriceS.getDeptName().equals(Constant.DEPTNAME)) {
				supplierPriceS.setSupplierPriceList(supplierPriceService.findBillOfTourAndAgent(supplierPriceS));
			}
		}

		List<Dept> deptList = deptService.findCurrencyTypeAll();
		List<SupplierPrice> supplierPriceListOfTour = supplierPriceService.findSupplierOfTourOfOp(supplierPrice);
		// 根据部门查找变更单
		List<SupplierPrice> supplierPriceRemarkDept = supplierPriceService.findSupplierPriceRemarkDept(supplierPrice);
		// 根据地接,酒店等查找变更单
		List<SupplierPrice> SupplierPriceRemarkSupplierName = supplierPriceService.findSupplierPriceRemarkSupplierName(supplierPrice);

		String fname = "";
		fname = "Bill";
		OutputStream os = null;
		try {
			os = response.getOutputStream();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.reset();
		response.setHeader("Content-disposition",
						"attachment;filename=" + fname + ".xls");
		response.setContentType("application/msexcel");
		//String rootPath = servletContext.getRealPath("/");
		String 	rootPath=Constant.UPLOADLOCAL;
		String path = rootPath+ "upload/Files/";
		CreateOrderTour.createOrder(path, supplierPriceList,supplierPriceListF, supplierPriceListS, os, supplierPrice,
				supplierPriceListOfTour, supplierPriceRemarkDept,SupplierPriceRemarkSupplierName, deptList);
		return null;
	}
	/**
	 * 总账单   批量
	 * agent 申请结算
	 */
	@RequestMapping(value = "/agentSettlementAll", method = RequestMethod.POST)
	public String agentSettlementAll(ModelMap model, String[] ordersTotalIds,
			String menuId, RedirectAttributes redirectAttributes) {
		//判断是否有结算成功的
		Boolean message=false;
		for (String id : ordersTotalIds) {
			//查询总订单
			OrdersTotal ordersTotal=ordersTotalService.findById(id);
			if(ordersTotal!=null){
				SettlementTotalVO settlementTotalVO=payCostRecordsService.settlementOrdersTotal(ordersTotal);
				
				//判断是否组团
				if (settlementTotalVO.getTourIdStrings().size() == 0
						&& settlementTotalVO.getOrder().getIsSelfOrganize() != null
						&&(settlementTotalVO.getOrder().getIsSelfOrganize() !=0)) {
					settlementTotalVO.getTour().setAllCheck(2);
				}
				//判断是否有未审核的收入支出 
				Boolean bRet=true;
				for (PayCostRecords payCostRecords : settlementTotalVO.getPayCostRecordsList()) {
					if(payCostRecords.getType()!=9&&(payCostRecords.getStatus()==0||payCostRecords.getStatus()==2)){
						bRet=false;
						break;
					}
				}
				if (bRet && settlementTotalVO.getTour() != null
						&&(settlementTotalVO.getTour().getAllCheck()==null
						|| settlementTotalVO.getTour().getAllCheck() != 2 )
						&& ordersTotal.getTax() == 0
						&& (settlementTotalVO.getTour().getAccCheck()==null||settlementTotalVO.getTour().getAccCheck() != 2)) {
					message=true;
					ordersTotal.setTax(3);// 修改订单结算状态 3申请结算
					ordersTotal.setCheckTime(new Date());// 保存 agent申请结算时间
					List<Order> orderList=orderService.findByOrdersTotalId(ordersTotal.getOrdersTotalId());
					for (Order order : orderList) {
						order.setTax(3);// 修改订单结算状态 3申请结算
						order.setCheckTime(new Date());
						orderService.update(order);
					}
					ordersTotalService.update(ordersTotal);
				}
			}
		}
		//判断是否有结算成功的
		if(message){
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}else{
			addFlashMessage(redirectAttributes, SETTLEMENT_MESSAGE);
		}
		if(menuId!=null&&menuId.equals("303")){
			return "redirect:/admin/orders/list.jhtml";
		}else if(menuId!=null&&menuId.equals("308")){
			return "redirect:/admin/orders/itemGroupList.jhtml";
		}else{
			return "redirect:/admin/orders/viseBookingList.jhtml";
		}
		
	}
	
	/**
	 * 总账单   批量
	 * acc  结算
	 */
	@RequestMapping(value = "/accSettlementAll", method = RequestMethod.POST)
	public String accSettlementAll(ModelMap model, String[] ordersTotalIds,
			String menuId, RedirectAttributes redirectAttributes) {
		//判断是否有结算成功的
		Boolean message=false;
		for (String id : ordersTotalIds) {
			//查询总订单
			OrdersTotal ordersTotal=ordersTotalService.findById(id);
			if(ordersTotal!=null){
				SettlementTotalVO settlementTotalVO=payCostRecordsService.settlementOrdersTotal(ordersTotal);
				//判断是否有未审核的收入支出 
				Boolean bRet=true;
				for (PayCostRecords payCostRecords : settlementTotalVO.getPayCostRecordsList()) {
					if(payCostRecords.getType()!=9&&(payCostRecords.getStatus()==0||payCostRecords.getStatus()==2)){
						bRet=false;
						break;
					}
				}
				if (bRet && ordersTotal.getTax() == 3) {
					message=true;
					// 修改订单结算状态 4结算
					ordersTotal.setCheckTime(new Date());// 保存 财务结算时间
					List<Order> orderList = settlementTotalVO.getOrderList();//agent所有团下下的order利润以及对应团的op
					
					orderService.billOrdersProfitCredit(ordersTotal, orderList,settlementTotalVO);
					ordersTotal.setTax(4);
					ordersTotalService.update(ordersTotal);
					//如果是非团丁修改结算日期和结算时间  （团结算日期在上面那个方法里）
					if(settlementTotalVO.getSingleOrdersList()!=null){
						List<Order> singleOrdersList=settlementTotalVO.getSingleOrdersList();
						for(Order singleorder:singleOrdersList){
							singleorder.setCheckTime(new Date());
							singleorder.setTax(2);
							orderService.update(singleorder);
						}
					}
					
				}
			}
		}
		//判断是否有结算成功的
		if(message){
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		}else{
			addFlashMessage(redirectAttributes, SETTLEMENT_MESSAGE);
		}
		if(menuId!=null&&menuId.equals("505")){
			return "redirect:/admin/payCostRecords/findOrderTotalTaxList.jhtml";
		}else{
			return "redirect:/admin/payCostRecords/findOrderTotalTaxGroupList.jhtml";
		}
		
	}
	
	/**
	 * agent 查看团下自己所有订单
	 * account 查看该订单Agent在该团下的所有订单
	 */
	@RequestMapping(value = "/viewOrdersByTour", method = RequestMethod.GET)
	public String viewOrdersByTour(ModelMap model,String menuId,String tourId,String orderId) {
		Order order=orderService.findById(orderId);
		SettlementTotalVO settlementTotalVO=payCostRecordsService.chackFeeByTourId(order);
		List<Dept> deptList=new ArrayList<Dept>();
		Iterator<String> it=settlementTotalVO.getOpUserIdStrings().iterator();
		while(it.hasNext()){
			 deptList.add(deptService.findById(adminService.findById(it.next()).getDeptId()));
		}
		//判断是否组团
		if (settlementTotalVO.getTourIdStrings().size() == 0
				&& settlementTotalVO.getOrder().getIsSelfOrganize() != null
				&&(settlementTotalVO.getOrder().getIsSelfOrganize() !=0)) {
			settlementTotalVO.getTour().setAllCheck(2);
		}
		model.addAttribute("menuId",menuId);
		model.addAttribute("order", settlementTotalVO.getOrder());
		model.addAttribute("orders", order);
		model.addAttribute("tour", settlementTotalVO.getTour());
		model.addAttribute("orderList", settlementTotalVO.getOrderList());
		model.addAttribute("userName", order.getUserName());
		model.addAttribute("dept", deptService.findById(order.getDeptId()));
		model.addAttribute("supplierPriceRemarkList", settlementTotalVO.getSupplierPriceRemarkList());
		model.addAttribute("deptList", deptList);
		model.addAttribute("ordList",settlementTotalVO.getOrdList());
		return "/admin/finance/accountant/viewTourOrderPC";
	}
	/**
	 * agent 查看团下自己所有订单(account 查看该订单Agent在该团下的所有订单)打印
	 * 
	 */
	@RequestMapping(value = "/viewOrdersByTourPrint", method = RequestMethod.GET)
	public String viewOrdersByTourPrint(ModelMap model,String tourId,String orderId) {
		Order order=orderService.findById(orderId);
		SettlementTotalVO settlementTotalVO=payCostRecordsService.chackFeeByTourId(order);
		List<Dept> deptList=new ArrayList<Dept>();
		Iterator<String> it=settlementTotalVO.getOpUserIdStrings().iterator();
		while(it.hasNext()){
			 deptList.add(deptService.findById(adminService.findById(it.next()).getDeptId()));
		}
		//判断是否组团
		if (settlementTotalVO.getTourIdStrings().size() == 0
				&& settlementTotalVO.getOrder().getIsSelfOrganize() != null
				&&(settlementTotalVO.getOrder().getIsSelfOrganize() !=0)) {
			settlementTotalVO.getTour().setAllCheck(2);
		}
		model.addAttribute("order", settlementTotalVO.getOrder());
		model.addAttribute("orders", order);
		model.addAttribute("tour", settlementTotalVO.getTour());
		model.addAttribute("orderList", settlementTotalVO.getOrderList());
		model.addAttribute("userName", order.getUserName());
		model.addAttribute("dept", deptService.findById(order.getDeptId()));
		model.addAttribute("supplierPriceRemarkList", settlementTotalVO.getSupplierPriceRemarkList());
		model.addAttribute("deptList", deptList);
		model.addAttribute("ordList",settlementTotalVO.getOrdList());
		return "/admin/finance/accountant/viewTourOrderPCPrint";
	}
	
}

