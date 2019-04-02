package com.chinatour.controller.admin;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.DateEditor;
import com.chinatour.FileInfo.FileType;
import com.chinatour.Message;
import com.chinatour.Message.Type;
import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.CustomerSource;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.Invoice;
import com.chinatour.entity.InvoiceMail;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderFeeItems;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.PeerUser;
import com.chinatour.entity.PrePostHotel;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.State;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.TourType;
import com.chinatour.entity.Vender;
import com.chinatour.service.AdminService;
import com.chinatour.service.BrandService;
import com.chinatour.service.CityService;
import com.chinatour.service.CountryService;
import com.chinatour.service.CustomerOrderRelService;
import com.chinatour.service.CustomerService;
import com.chinatour.service.CustomerSourceService;
import com.chinatour.service.DeptService;
import com.chinatour.service.ExportInvoiceForWordService;
import com.chinatour.service.ExportVoucherForWordService;
import com.chinatour.service.FileService;
import com.chinatour.service.GroupLineService;
import com.chinatour.service.InvoiceToPdfService;
import com.chinatour.service.LanguageService;
import com.chinatour.service.NationalityService;
import com.chinatour.service.OptionalExcursionService;
import com.chinatour.service.OrderFeeItemsService;
import com.chinatour.service.OrderRemarkService;
import com.chinatour.service.OrderService;
import com.chinatour.service.OrderToPdfService;
import com.chinatour.service.OrdersTotalService;
import com.chinatour.service.PayCostRecordsService;
import com.chinatour.service.PeerUserService;
import com.chinatour.service.PrePostHotelService;
import com.chinatour.service.ReceivableInfoOfOrderService;
import com.chinatour.service.SendMailService;
import com.chinatour.service.StateService;
import com.chinatour.service.SupplierPriceService;
import com.chinatour.service.TOrderReceiveItemService;
import com.chinatour.service.TourInfoForOrderService;
import com.chinatour.service.TourService;
import com.chinatour.service.TourTypeService;
import com.chinatour.service.VenderService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.PayCostEditVO;
import com.chinatour.vo.ProductVO;
import com.chinatour.vo.SingleOrdersVO;
import com.chinatour.vo.TourOrderListVO;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

/**
 * @copyright Copyright: 2014
 * @author Pis
 * @create-time 下午2:38:35
 * @reversion 3.0
 */
@Controller
@RequestMapping("/admin/orders")
public class OrdersController extends BaseController {

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

	/**
	 * 将页面提交的日期字符串转换成日期类型对象
	 * 
	 * @param request
	 * @param binder
	 * @throws Exception
	 */
	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
		binder.registerCustomEditor(Date.class, new DateEditor(true));
	}
	
	@RequestMapping(value = "/cancelOrdersTotal", method = RequestMethod.GET)
	public String cancelOrdersTotal(String ordersTotalId){
		return "";
	}
	
	@RequestMapping(value = "/recoverOrdersTotal", method = RequestMethod.GET)
	public String recoverOrdersTotal(String ordersTotalId){
		return "";
	}
	
	/**
	 * 子订单列表
	 * ItemList
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String tourList(ModelMap model,Order order) {
		model.addAttribute("menuId", "303");
		model.addAttribute("order", order);
		return BaseTemplateURL + "/tourOrderList";
	}
	/**
	 * 同行子订单列表（Agency）
	 * ItemList
	 */
	@RequestMapping(value = "/listAgency", method = RequestMethod.GET)
	public String listAgency(ModelMap model,Order order) {
		model.addAttribute("menuId", "321");
		model.addAttribute("order", order);
		return BaseTemplateURL + "/agencyOrderList";
	}
	/**
	 * 同行子订单列表（Agency）
	 * ItemList
	 */
	@RequestMapping(value = "/listWeb", method = RequestMethod.GET)
	public String listWeb(ModelMap model,Order order) {
		List<Admin> agentList=adminService.findAllOfDeptName();
		model.addAttribute("menuId", "322");
		model.addAttribute("order", order);
		model.addAttribute("agentList", agentList);
		return BaseTemplateURL + "/webOrderList";
	}
	
	/**
	 * 同行子订单列表（Group）
	 * ItemList
	 */
	@RequestMapping(value = "/listWebGroup", method = RequestMethod.GET)
	public String listWebGroupc(ModelMap model,Order order) {
		List<Admin> agentList=adminService.findAllOfDeptName();
		model.addAttribute("menuId", "323");
		model.addAttribute("order", order);
		model.addAttribute("agentList", agentList);
		return BaseTemplateURL + "/webGroupOrderList";
	}
	
	/**
	 * 查询收入所有
	 */
	@RequestMapping(value = "/payCostList", method = RequestMethod.GET)
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
		/*if(pay.getOrderNo().equals("null")){
			pay.setOrderNo(null);
		}*/
		model.addAttribute("pay",pay);
		model.addAttribute("menuId", "321");
		return  BaseTemplateURL + "/list";
	}

	/**
	 * 异步查询收入所有
	 */
	@RequestMapping(value = "/payCostList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, PayCostRecords payCostRecords) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin = adminService.getCurrent();
		// 插入username
		payCostRecords.setUserName(admin.getUsername());
		payCostRecords.setPayOrCost(1);
		Page<PayCostRecords> page = payCostRecordsService.findPage(
				payCostRecords, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
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
		model.addAttribute("pay",pay);
		model.addAttribute("menuId", "321");
		return BaseTemplateURL + "/payList";
	}

	/**
	 * 异步查询支出所有
	 */
	@RequestMapping(value = "/payList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> payList(Pageable pageable, PayCostRecords payCostRecords) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Admin admin = adminService.getCurrent();
		// 插入username
		payCostRecords.setUserName(admin.getUsername());
		payCostRecords.setPayOrCost(2);
		Page<PayCostRecords> page = payCostRecordsService.findPage(
				payCostRecords, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	* 子订单列表
	 * ItemList
	 * 查出所有订单 页面判断自组和非自组
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/tourList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tourList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		//order.setIsSelfOrganize(0);
		if(order.getOrderNoIn()==null){//没有值是ERP订单，有值是Web订单
			order.setUserId(adminService.getCurrent().getId());
		}
		Page<TourOrderListVO> page = orderService.findTourOrderListVO(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			TourOrderListVO o=orderService.findOrderSumPepole(order);
			o.setPayCost(new PayCostRecords());
			o.getPayCost().setPayTotalSum(o.getPayTotalSum());
			o.getPayCost().setCostTotalSum(o.getCostTotalSum());
			page.getContent().add(o);
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 为填写出签日期，送签日期，销签日期
	 * 设立的bookingList
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/viseBookingList", method = RequestMethod.GET)
	public String viseBookingList(Model model){
		model.addAttribute("menuId", "320");
		return BaseTemplateURL + "/viseBookingList";
	}
	
	@RequestMapping(value = "/viewOrdersInfo", method = RequestMethod.GET)
	public String viewOrdersInfo(Model model,String id){
		model.addAttribute("menuId", "320");
		Order order = orderService.findById(id);
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(id);
		/*TourType tourType = tourTypeService.findById(order.getTourTypeId());
		order.setTourTypeId(tourType.getTypeName());*/
		model.addAttribute("order", order);
		model.addAttribute("tourInfoForOrder", tourInfoForOrder);
		model.addAttribute("orderRemarkList", orderRemarkService.findRemarkByOrderId(id));
		model.addAttribute("customerOrderRelList", customerOrderRelService.findNotDelCustomerByOrderId(id));
		return BaseTemplateURL + "/viewOrdersInfo";
	}
	
	@RequestMapping(value = "/fillTicketInfo", method = RequestMethod.GET)
	public String fillTicketInfo(Model model,String id){
		model.addAttribute("menuId", "320");
		model.addAttribute("productVO", orderService.loadProduct(id));
		return BaseTemplateURL + "/fillTicketInfo";
	}
	
	@RequestMapping(value = "/submitTicketInfo",method = RequestMethod.POST)
	public String submitTicketInfo(Order order){
		orderService.update(order);
		return "redirect:viseBookingList.jhtml";
	}
	
	/**
	 * 异步获取bookingList的数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/viseList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> viseList(Pageable pageable,Order order){
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Order> page = orderService.findPage(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 
	 * ietm list 打印
	 */
	@RequestMapping(value = "/findTourOrderListVOPrint", method = RequestMethod.GET)
	public String findTourOrderListVOPrint(ModelMap model,Order order) {
		// 插入部门id
		order.setUserId(adminService.getCurrent().getId());
		List<Order> ordersList= orderService.findTourOrderListVOPrint(order);
		//抵达日期2016-01-01 后 不发 5%
		for (Order o : ordersList) {
			if(o.getArriveDateTime()!=null&&compareDate(o.getArriveDateTime())){
				o.setPriceExpression(new BigDecimal(0));
			}
		}
		Order ord=orderService.findAgentSumPayOrCost(order);
		Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
		model.addAttribute("ordersTime", order);
		model.addAttribute("order", ord);
		model.addAttribute("deptName", dept.getDeptName());
		model.addAttribute("ordersList", ordersList);
		return "/admin/finance/accountant/agentOrderStaticsListPrint";
	}
	
	/**
	 * 团订单修改页面(添加了查找customer_order_rel的roomtype)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/tourOrderEdit", method = RequestMethod.GET)
	public String loadTourOrder(Model model, String id) {
		Map<String, Object> result = ordersTotalService.findTotalOrder(orderService.findById(id).getOrdersTotalId());
		ProductVO productVO = orderService.loadProduct(id);
		//查找出B2B订单里面的费用明细
		List<OrderFeeItems> orderFeeItemsList=orderFeeItemsService.findByOrderId(id);
		model.addAttribute("menuId", "301"); 
		model.addAttribute("tourTypeList", tourTypeService.findByBrand(productVO.getOrder().getBrand()));
		model.addAttribute("tourType", tourTypeService.findById(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLineList", groupLineService.findByTourTypeId(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLine", groupLineService.findById(productVO.getTourInfoForOrder().getGroupLineId()));
		model.addAttribute("ordersTotal", ordersTotalService.findById(productVO.getOrder().getOrdersTotalId()));
		model.addAttribute("customerList", ordersTotalService.findCustomersByOrderId(productVO.getOrdersTotalId()));
		model.addAttribute("productVO", productVO);
		model.addAttribute("orderFeeItemsList", orderFeeItemsList);
		model.addAttribute("orderRemark",orderRemarkService.findRemarkByOrderId(productVO.getOrdersTotalId()));
		model.addAttribute("customerOrderRelList", (List<CustomerOrderRel>)result.get("customerOrderRelList"));
		PrePostHotel prePostHotel=new PrePostHotel();
		prePostHotel.setOrderId(id);
		model.addAttribute("prePostHotel", prePostHotelService.findByOrderId(prePostHotel));
		model.addAttribute("optionalist", optionalExcursionService.findAll());
		return BaseTemplateURL + "/editProduct";
	}
	
	
	
	@RequestMapping(value = "/tourOrderEditNew", method = RequestMethod.GET)
	public String loadTourOrderNew(Model model, String id) {
		Map<String, Object> result = ordersTotalService.findTotalOrder(orderService.findById(id).getOrdersTotalId());
		ProductVO productVO = orderService.loadProduct(id);
		//查找出B2B订单里面的费用明细
		List<OrderFeeItems> orderFeeItemsList=orderFeeItemsService.findByOrderId(id);
		model.addAttribute("menuId", "301"); 
		model.addAttribute("tourTypeList", tourTypeService.findByBrand(productVO.getOrder().getBrand()));
		model.addAttribute("tourType", tourTypeService.findById(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLineList", groupLineService.findByTourTypeId(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLine", groupLineService.findById(productVO.getTourInfoForOrder().getGroupLineId()));
		model.addAttribute("ordersTotal", ordersTotalService.findById(productVO.getOrder().getOrdersTotalId()));
		model.addAttribute("customerList", ordersTotalService.findCustomersByOrderId(productVO.getOrdersTotalId()));
		model.addAttribute("productVO", productVO);
		model.addAttribute("orderFeeItemsList", orderFeeItemsList);
		model.addAttribute("orderRemark",orderRemarkService.findRemarkByOrderId(productVO.getOrdersTotalId()));
		model.addAttribute("customerOrderRelList", (List<CustomerOrderRel>)result.get("customerOrderRelList"));
		return BaseTemplateURL + "/editProductNew";
	}
	
	/**
	 * 根据团队类型加载产品信息
	 */
	@RequestMapping(value = "/loadGroupLineForOptions", method = RequestMethod.POST)
	public @ResponseBody List<GroupLine> loadGroupLineForOptions(String tourTypeId){
		return groupLineService.findByTourTypeId(tourTypeId);
	}
	
	/**
	 * 修改团订单
	 * 
	 * @param model
	 * @param productVO
	 * @param deleteItemIds
	 * @return
	 */
	@RequestMapping(value = "/tourOrderUpdate",method = RequestMethod.POST)
	public String editTourOrder(Model model,ProductVO productVO,String[] deleteItemIds){
		orderService.updateProduct(productVO, deleteItemIds);
		model.addAttribute("menuId", "301");
		return "redirect:edit.jhtml?ordersTotalId=" + orderService.findById(productVO.getOrdersTotalId()).getOrdersTotalId() ;
	}
	/**
	 * 修改团订单
	 * 
	 * @param model
	 * @param productVO
	 * @param deleteItemIds
	 * @return
	 */
	@RequestMapping(value = "/tourOrderUpdateNew",method = RequestMethod.POST)
	public String editTourOrderNew(Model model,ProductVO productVO,String[] deleteItemIds){
		orderService.updateProductNew(productVO, deleteItemIds);
		model.addAttribute("menuId", "301");
		return "redirect:edit.jhtml?ordersTotalId=" + orderService.findById(productVO.getOrdersTotalId()).getOrdersTotalId() ;
	}

	/**
	 * 自组订单列表页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/singleList", method = RequestMethod.GET)
	public String singleList(Model model) {
		model.addAttribute("menuId", "307");
		return BaseTemplateURL + "/singleOrderList";
	}

	/**
	 * 自组列表页面异步获取数据
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/singleList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, Order order) {
		order.setIsSelfOrganize(1);
		Map<String, Object> map = new HashMap<String, Object>();
		Page<TourOrderListVO> page = orderService.findTourOrderListVO(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 非团订单修改页面
	 * 
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/singleOrderEdit", method = RequestMethod.GET)
	public String loadSingleTour(Model model,String id){
		model.addAttribute("menuId", "301");
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("singleOrdersVO", orderService.loadSingleProduct(id));
		return BaseTemplateURL + "/editSingleProduct";
	}
	
	/**
	 * 非团订单修改
	 * 
	 * @param singleOrdersVO
	 * @return
	 */
	@RequestMapping(value="/singleOrderUpdate", method = RequestMethod.POST)
	public String editSingleTour(SingleOrdersVO singleOrdersVO,RedirectAttributes redirectAttributes){
		orderService.updateSingleProduct(singleOrdersVO);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:edit.jhtml?menuId=302&ordersTotalId="+singleOrdersVO.getOrdersTotalId();
	}

	/**
	 * 总订单列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/ordersTotalList", method = RequestMethod.GET)
	public String totalOrderList(Model model) {
		//List<Admin> agentList=adminService.findAllOfDeptName();
		//model.addAttribute("agentList", agentList);
		model.addAttribute("menuId", "302");
		model.addAttribute("constant", CONSTANT);
		return BaseTemplateURL + "/ordersTotalList";
	}

	/**
	 * 总订单列表异步获取数据
	 * 
	 * @param pageable
	 * @param ordersTotal
	 * @return
	 */
	@RequestMapping(value = "/ordersTotalList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> totalOrderList(Pageable pageable, OrdersTotal ordersTotal) {
		Map<String, Object> map = new HashMap<String, Object>();
		//String groupIdString = adminService.getCurrent().getGroupId();
		Page<OrdersTotal> page;

		// 判断是否分组 groupIdString 为空未分组
		//if (groupIdString == null) {
		ordersTotal.setUserId(adminService.getCurrent().getId());
		page = ordersTotalService.findPage(ordersTotal, pageable);
		/*} else {
			ordersTotal.setGroupId(groupIdString);
			page = ordersTotalService.findForGrouPage(ordersTotal, pageable);
		}*/
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
//		if(page.getContent().size()>0){
//			page.getContent().add(ordersTotalService.findOrderTotalSumPepole(ordersTotal));
//		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 总订单列表异步获取数据
	 * 
	 * @param pageable
	 * @param ordersTotal
	 * @return
	 */
	@RequestMapping(value = "/getSumPeople", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getSumPeople( OrdersTotal ordersTotal) {
		Map<String, Object> map = new HashMap<String, Object>();
		OrdersTotal sumPeople = ordersTotalService.findOrderTotalSumPepole(ordersTotal);
		map.put("ordersTotal",sumPeople );
		return map;
	}


	/**
	 * 添加总订单页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) {
		CustomerSource customerSource = new CustomerSource();
		customerSource.setDeptId(adminService.getCurrent().getDeptId());
		model.addAttribute("venderList", venderService.findAllPeer());
		model.addAttribute("cityList", cityService.findAll());
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("customerSourceList", customerSourceService.find(customerSource));
		model.addAttribute("menuId", "301");
		return BaseTemplateURL + "/add";
	}

	/**
	 * 异步获取同行信息
	 * 
	 * @param companyId
	 * @return
	 */
	@RequestMapping(value = "/getVender", method = RequestMethod.POST)
	public @ResponseBody Vender getVender(String companyId) {
		return venderService.findById(companyId);
	}
	
	/**
	 * 异步获取客人来源
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getCustomerSource", method = RequestMethod.POST)
	public @ResponseBody List<CustomerSource> getCustomerSource(CustomerSource customerSource){
		return customerSourceService.find(customerSource);
	}

	/**
	 * 保存总订单
	 * 
	 * @param model
	 * @param ordersTotal
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String saveTotalOrder(Model model, OrdersTotal ordersTotal) {
		ordersTotal = ordersTotalService.saveTotalOrder(ordersTotal);
		return "redirect:edit.jhtml?ordersTotalId=" + ordersTotal.getOrdersTotalId() + "&menuId=301";
	}

	/**
	 * 编辑总订单页面
	 * 
	 * @param model
	 * @param ordersTotalId
	 * @param menuId 判断哪个页面跳转的
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String editTotalOrder(Model model, String ordersTotalId,String menuId) {
		
		//加载OrdersTotal对象和CustomerOrderRelList(包含Customer)
		Map<String, Object> result = ordersTotalService.findTotalOrder(ordersTotalId);
		
		//加载总订单下的子订单列表
		OrdersTotal ordersTotal = (OrdersTotal)result.get("ordersTotal");
		Order order = new Order();
		order.setOrdersTotalId(ordersTotalId);
		List<Order> orderList = orderService.findChildOrderList(ordersTotalId);
		
		//加载总订单下所有子订单的收入和支出，统计未取消子订单的总收入和支出
		List<PayCostEditVO> pVoList = new ArrayList<PayCostEditVO>();
		BigDecimal sumPay = new BigDecimal(0.0);
		BigDecimal sumCost = new BigDecimal(0.0);
		if(orderList.size()>0){
			for(Order or : orderList){
				PayCostEditVO pVO=orderService.findPayCostByOrderId(or.getId());
				if(or.getState() <= 3 || or.getState() == 7){
					sumPay = sumPay.add(pVO.getSumPay());
					sumCost = sumCost.add(pVO.getSumCost());
				}
				pVoList.add(pVO);
			}
		}
		CustomerSource customerSource = new CustomerSource();
		customerSource.setDeptId(adminService.getCurrent().getDeptId());
		model.addAttribute("customerSourceList", customerSourceService.find(customerSource));
		model.addAttribute("menuId", menuId);
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("languageList", languageService.findAll());
		model.addAttribute("nationality", nationalityService.findAll());
		model.addAttribute("venderList", venderService.findAllPeer());
		model.addAttribute("cityList", cityService.findAll());
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("childOrderList", orderList);
		model.addAttribute("payCostList", pVoList);
		model.addAttribute("ordersTotal", ordersTotal);
		model.addAttribute("sumPay", sumPay);
		model.addAttribute("sumCost", sumCost);
		model.addAttribute("customerOrderRelList", (List<CustomerOrderRel>)result.get("customerOrderRelList"));
		model.addAttribute("stateList", stateService.findByCountryId(ordersTotal.getCountryId()));
		return BaseTemplateURL + "/edit";
	}
	/**
	 * 下载导入客人模板文件
	 */
	@RequestMapping(value = "download")
	public ModelAndView download(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String downLoadPath ="/upload/tourQuote/201507/importCustomerExample.xls";
		String contentType = "application/octet-stream";
		/*if(downLoadPath.isEmpty()){
			return null;
		}*/
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	
	/**
	 * 修改总订单信息
	 * 
	 * @param ordersTotal
	 * @return
	 */
	@RequestMapping(value = "/updateOrdersTotal", method = RequestMethod.POST)
	public @ResponseBody String editTotalOrder(OrdersTotal ordersTotal) {
		ordersTotalService.updateOrdersTotal(ordersTotal);
		return "success";
	}
	
	/**
	 * 增加客人时检查客人名称是否重复
	 * 
	 * @return
	 */
	@RequestMapping(value = "/checkCustomerName", method = RequestMethod.POST)
	public @ResponseBody String checkCustomerName(CustomerOrderRel customerOrderRel){
		boolean isExist = ordersTotalService.checkCustomerName(customerOrderRel.getCustomer());
		if(isExist == true){
			return "exist";
		}else{
			return "notExist";
		}
	}

	/**
	 * 总订单添加客人
	 * 
	 * @param customer
	 * @param ordersTotalId
	 * @return
	 */
	@RequestMapping(value = "/addCustomer", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addCustomer(CustomerOrderRel customerOrderRel) {
		PeerUser peerUser=peerUserService.getCurrent();//如果是同行用户添加人数，子订单和总订单人数都要加一
		if(peerUser!=null){
			OrdersTotal ordersTotal=ordersTotalService.findById(customerOrderRel.getOrdersTotalId());
			ordersTotal.setTotalPeople(ordersTotal.getTotalPeople()+1);
			ordersTotalService.update(ordersTotal);
		}
		return ordersTotalService.addCustomer(customerOrderRel);
	}
	
	/**
	 * 总订单添加客人
	 * 
	 * @param customer
	 * @param ordersTotalId
	 * @return
	 */
	@RequestMapping(value = "/addCustomerForSelection", method = RequestMethod.POST)
	public String addCustomerForSelection(RedirectAttributes redirectAttributes,String customerIds,String ordersTotalId) {
		String[] customerIdList = customerIds.split(",");
		for(int i=0;i<customerIdList.length;i++){
			int maxCustomerOrderNo = customerOrderRelService.findMaxCustomerOrderNoByOrdersTotalId(ordersTotalId);
			CustomerOrderRel customerOrderRel = new CustomerOrderRel();
			customerOrderRel.setId(UUIDGenerator.getUUID());
			customerOrderRel.setCustomerId(customerIdList[i]);
			customerOrderRel.setOrdersTotalId(ordersTotalId);
			customerOrderRel.setRoomNumber(0);
			customerOrderRel.setContactFlag(0);//客人在总订单下的状态
			customerOrderRel.setGuestRoomType("Twin Bed");
			customerOrderRel.setCustomerOrderNo(maxCustomerOrderNo + 1);//客人在子订单下的编号
			ordersTotalService.addCustomerForSelect(customerOrderRel);
		} 
			addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		 return "redirect:edit.jhtml?ordersTotalId=" +ordersTotalId+"&menuId="+302;
	}

	/**
	 * 获取客人可组房的客人
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getRoommates", method = RequestMethod.POST)
	public @ResponseBody List<CustomerOrderRel> getRoommates(String ordersTotalId, String guestRoomType) {
		return ordersTotalService.getRoommates(ordersTotalId, guestRoomType);
	}

	/**
	 * 根据房号获取可组房的客人
	 * 
	 * @param ordersTotalId
	 * @param guestRoomType
	 * @param roomNumber
	 * @return
	 */
	@RequestMapping(value = "/getRoommatesWithRoomNumber", method = RequestMethod.POST)
	public @ResponseBody List<CustomerOrderRel> getRoommatesWithRoomNumber(String ordersTotalId, String guestRoomType, int roomNumber) {
		return ordersTotalService.getRoommatesWithRoomNumber(ordersTotalId, guestRoomType, roomNumber);
	}

	/**
	 * 根据customerOrderRelId获取客人信息
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/loadCustomer", method = RequestMethod.POST)
	public @ResponseBody CustomerOrderRel loadCustomer(String id) {
		return customerOrderRelService.findWithCustomerById(id);
	}

	/**
	 * 修改客人信息
	 * 
	 * @param customerOrderRel
	 * @return
	 */
	@RequestMapping(value = "/updateCustomer", method = RequestMethod.POST)
	public @ResponseBody String updateCustomer(CustomerOrderRel customerOrderRel) {
		ordersTotalService.updateCustomer(customerOrderRel);
		return "";
	}
	
	/**
	 * 异步删除客人
	 * 
	 * @param customerOrderRelId
	 * @return
	 */
	@RequestMapping(value = "/deleteCustomer", method = RequestMethod.POST)
	public @ResponseBody String deleteCustomer(String customerOrderRelId){
		String result = orderService.cancelCustomer(customerOrderRelId);
		if("".equals(result)){
			return "success";
		}else if("all".equals(result)){
			return "all";
		}
		return "";
	}
	
	/**
	 * 异步恢复客人
	 * 
	 * @param customerOrderRelId
	 * @return
	 */
	@RequestMapping(value = "/recoverCustomer", method = RequestMethod.POST)
	public @ResponseBody String recoverCustomer(String customerOrderRelId){
		String result = orderService.recoverCustomer(customerOrderRelId);
		if("".equals(result)){
			return "success";
		}else if("all".equals(result)){
			return "all";
		}
		return "";
	}
	/**
	 * 异步同行支付申请
	 * */
	@RequestMapping(value="/agencyPay",method=RequestMethod.POST)
	public @ResponseBody String agencyPay(String orderId,Integer state){
		Order order=orderService.findById(orderId);
		order.setCostState(state);
		orderService.update(order);
		return"success";
	}
	
	/**
	 * 异步更改Agent
	 * */
	@RequestMapping(value="/changeUser",method=RequestMethod.POST)
	public @ResponseBody String changeUser(String orderId,String userId){
		Admin admin = adminService.findById(userId);
		Order order=orderService.findById(orderId);
		order.setUserId(admin.getId());
		order.setUserName(admin.getUsername());
		orderService.update(order);
		OrdersTotal ot=ordersTotalService.findById(order.getOrdersTotalId());
		ot.setUserId(admin.getId());
		ot.setAgent(admin.getUsername());
		ordersTotalService.update(ot);
		return"success";
	}
	
	/**
	 * 异步更改Agent,仅限未走团的订单
	 * */
	@RequestMapping(value="/changeUserT",method=RequestMethod.POST)
	public @ResponseBody String changeUserT(String ordersTotalId,String userId){
		Admin admin = adminService.findById(userId);
		List<Order> orderList = orderService.findChildOrderList(ordersTotalId);
		int flag=0;
		for(Order order:orderList){
			if(!order.getTourId().equals(" ") || order.getTourId()!=null){
				if(supplierPriceService.findByTourId(order.getTourId())!=null){
					flag=1; //已录入团账单，不能转团
				};
			}
		}
		if(flag!=1){
			OrdersTotal ot=ordersTotalService.findById(ordersTotalId);
			ot.setUserId(admin.getId());
			ot.setAgent(admin.getUsername());
			ot.setDeptId(admin.getDeptId());
			ordersTotalService.update(ot);
			for(Order order:orderList){
				order.setUserId(admin.getId());
				order.setUserName(admin.getUsername());
				order.setDeptId(admin.getDeptId());
				order.setTourTypeId(null);
				orderService.update(order);
			}
			return"success";
		}else{
			return"failure";
		}
	}
	
	/**
	 * 异步取消订单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/asynchronousCancelOrder", method = RequestMethod.POST)
	public @ResponseBody String ordersTotalCancelOrder(String orderId){
		orderService.cancelOrder(orderId);
		return "success";
	}
	
	/**
	 * 异步恢复订单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/asynchronousRecoverOrder", method = RequestMethod.POST)
	public @ResponseBody String ordersTotalRecoverOrder(String orderId){
		orderService.recoverOrder(orderId);
		return "success";
	}
	
	/**
	 * 添加入境产品
	 * 
	 * @param model
	 * @param ordersTotalId
	 * @return
	 */
	@RequestMapping(value="/otherBooking",method = RequestMethod.GET)
	public String otherBooking(Model model, String ordersTotalId){
		model.addAttribute("menuId", "301");
		model.addAttribute("ordersTotalId", ordersTotalId);
		model.addAttribute("ordersTotal", ordersTotalService.findById(ordersTotalId));
		model.addAttribute("constant", CONSTANT);
		return BaseTemplateURL + "/otherBooking";
	}
	/**
	 * 添加入境产品
	 * 
	 * @param model
	 * @param ordersTotalId
	 * @return
	 */
	@RequestMapping(value="/supplierBooking",method = RequestMethod.GET)
	public String supplierBooking(Model model, String ordersTotalId){
		TourType tourType =new TourType();
		tourType.setBrand("文景假期");
		tourType.setType(15);
		tourType.setIsDel(0);
		List<TourType> list=tourTypeService.findByt(tourType);
		model.addAttribute("menuId", "301");
		model.addAttribute("ordersTotalId", ordersTotalId);
		model.addAttribute("tourTypeList", list);
		return BaseTemplateURL + "/addProductSupplier";
	}
	/**
	 * 保存非团订单
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addSingleProduct",method = RequestMethod.POST)
	public String saveSingleProduct(Model model,SingleOrdersVO singleOrdersVO,RedirectAttributes redirectAttributes){
		orderService.saveSingleProduct(singleOrdersVO);
		return "redirect:edit.jhtml?menuId=301&ordersTotalId=" + singleOrdersVO.getOrdersTotalId();
	}

	/**
	 * 添加出境产品
	 * 
	 * @param model
	 * @param ordersTotalId
	 * @return
	 */
	@RequestMapping(value = "/tourBooking", method = RequestMethod.GET)
	public String tourBooking(Model model, String ordersTotalId) {
		model.addAttribute("menuId", "301");
		model.addAttribute("ordersTotalId", ordersTotalId); 
		String operater=groupLineService.operaterList("chinatour");
		String[] op=null;
		String[] ve=null;
		if(operater!=null){
			op=operater.split(",");
			GroupLine g=new GroupLine();
			g.setOperater(op[0]);
			g.setBrand("chinatour");
			String vender=groupLineService.venderList(g);
			if(vender!=null){
				ve=vender.split(",");
			}
		}
		
		model.addAttribute("operaterList", op);
		model.addAttribute("venderList",ve);
		List<TourType> tourTypeList=tourTypeService.findByBrand("chinatour");
		List<TourType> typeList=new ArrayList<TourType>();
		TourType tourType=new TourType();
		for(int i=0;i<tourTypeList.size();i++){
			if(tourTypeList.get(i).getTypeName().indexOf("独立团")>0){
				tourType=tourTypeList.get(i);
				typeList.add(tourType);
			}
		}
		model.addAttribute("tourTypeList", tourTypeList);
		model.addAttribute("tourType", typeList);
		return BaseTemplateURL + "/addProductChinatour";
	}
	
	/**
	 * 添加出境产品
	 * 
	 * @param model
	 * @param ordersTotalId
	 * @return
	 */
	@RequestMapping(value = "/tourBookingT", method = RequestMethod.GET)
	public String tourBookingT(Model model, String ordersTotalId) {
		model.addAttribute("menuId", "301");
		model.addAttribute("ordersTotalId", ordersTotalId); 
		String operater=groupLineService.operaterAllList();
		String venter=groupLineService.venderAllList();
		String[] op=null;
		String[] ve=null;
		if(operater!=null){
			String[] op1=operater.split(",");
			String op2=null;
			for(int a=0;a<op1.length;a++){
				if(!op1[a].equals("")){
					if(a!=0){
						op2=op2+","+op1[a];
					}else{
						op2=op1[a];
					}
				}
			}
			op=op2.split(",");
		}
		if(venter!=null){
			String[] ve1=venter.split(",");
			String ve2=null;
			for(int a=0;a<ve1.length;a++){
				if(!ve1[a].equals("")){
					if(a!=0){
						ve2=ve2+","+ve1[a];
						}else{
							ve2=ve1[a];
						}
				}
			}
			ve=ve2.split(",");
		}
		
		model.addAttribute("brandList",brandService.findAll());
		model.addAttribute("operaterList", op);
		model.addAttribute("venderList",ve);
		return BaseTemplateURL + "/addProduct";
	}
	/**
	 * 异步获取
	 * */
	@RequestMapping(value="/selectTourType", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> selectTourType(String brand){
		Map<String, Object> map=new HashMap<String, Object>();
		List<TourType> tourTypeList=tourTypeService.findByBrand(brand);
		List<TourType> typeList=new ArrayList<TourType>();
		for(int i=0;i<tourTypeList.size();i++){
			if(tourTypeList.get(i).getTypeName().indexOf("独立团")>0){
				typeList.add(tourTypeList.get(i));
			}
		}
		map.put("tourTypeList", typeList);
		return map;
	}
	

	/**
	 * 不同品牌的产品页面之间相互流转
	 * 
	 * @param brand
	 * @return
	 */
	@RequestMapping(value = "/groupLine", method = RequestMethod.GET)
	public String groupLine(Model model, String brand, String ordersTotalId) {
		String operater=groupLineService.operaterList(brand);
		String[] op=null;
		String[] ve=null;
		if(operater!=null){
			op=operater.split(",");
			GroupLine g=new GroupLine();
			g.setOperater(op[0]);
			g.setBrand(brand);
			String vender=groupLineService.venderList(g);
			if(vender!=null){
				ve=vender.split(",");
			}
		}
		List<TourType> tourTypeList=tourTypeService.findByBrand(brand);
		List<TourType> typeList=new ArrayList<TourType>();
		TourType tourType=new TourType();
		for(int i=0;i<tourTypeList.size();i++){
			if(tourTypeList.get(i).getTypeName().indexOf("独立团")>0){
				tourType=tourTypeList.get(i);
				typeList.add(tourType);
			}
		}
		model.addAttribute("tourTypeList", tourTypeList);
		model.addAttribute("tourType", typeList);
		model.addAttribute("menuId", "301");
		model.addAttribute("ordersTotalId", ordersTotalId);
		model.addAttribute("operaterList", op);
		model.addAttribute("venderList",ve);
		/*model.addAttribute("tourTypeList", tourTypeService.findByBrand(brand));*/
		if ("chinatour".equals(brand)) {
			return BaseTemplateURL + "/addProductChinatour";
		} else if ("文景假期".equals(brand)) {
			return BaseTemplateURL + "/addProductWenjing";
		} else if ("InterTrips".equals(brand)) {
			return BaseTemplateURL + "/addProductNexusHoliday";
		} else if ("中国美".equals(brand)) {
			return BaseTemplateURL + "/addProductChinaBeauty";
		} else {
			return BaseTemplateURL + "/addProductInbound";
		} 
	}

	/**
	 * 独立团保存产品
	 * 
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value="/saveIndependentProduct", method = RequestMethod.POST)
	public @ResponseBody String saveIndependentProduct(GroupLine groupLine){
		return groupLineService.saveIndependentProduct(groupLine);
	} 
	
	/**
	 * 产品列表页面异步获取数据
	 * 
	 * @param pageable
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value = "/groupLineList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> groupLineList(Pageable pageable, GroupLine groupLine, String brand) {
		Map<String, Object> map = new HashMap<String, Object>();
		/*查找供应商，提供供应商在操作中心的列表*/
		String[] ve=null;
		GroupLine g=new GroupLine();
		g.setOperater(groupLine.getOperater());
		g.setBrand(groupLine.getBrand());
		String vender=groupLineService.venderList(g);
		if(vender!=null){
			ve=vender.split(",");
		}
		groupLine.setBrand(brand);
		Page<GroupLine> page = groupLineService.findPage(groupLine, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		map.put("vender", ve);
		return map;
	}
	
	/**
	 * 产品列表页面异步获取数据
	 * 
	 * @param pageable
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value = "/groupLineTList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> groupLineTList(Pageable pageable, GroupLine groupLine) {
		Map<String, Object> map = new HashMap<String, Object>();
		/*查找供应商，提供供应商在操作中心的列表*/
		GroupLine g=new GroupLine();
		g.setOperater(groupLine.getOperater());
		g.setBrand(groupLine.getBrand());
		Page<GroupLine> page = groupLineService.findPage(groupLine, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 填写产品信息页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/bookProduct", method = RequestMethod.GET)
	public String bookProduct(Model model, String ordersTotalId, String groupLineId, String brand, String singleType,String isSelfOrganize) {
		model.addAttribute("menuId", "301");
		model.addAttribute("ordersTotalId", ordersTotalId);
		model.addAttribute("ordersTotal", ordersTotalService.findById(ordersTotalId));
		model.addAttribute("brand", brand);
		if(isSelfOrganize!=null){
			model.addAttribute("isSelfOrganize", isSelfOrganize);
		}else{
			model.addAttribute("isSelfOrganize", 0);
		}

		if(groupLineId == null){
		//(单订)单订情况下，获取tourTypeList供选择
			model.addAttribute("tourTypeList", tourTypeService.findByBrand(brand));
			model.addAttribute("singleType", singleType);
		}else{
		//品牌团或者入境团
		//如果groupline的departureDate有多个时间就用departureDateArray传输到页面，是一个就用departureDate传输到页面
			GroupLine groupLine = groupLineService.findById(groupLineId);
			model.addAttribute("groupLine", groupLine);
			String departureDate = groupLine.getDepartureDate();
			if(departureDate != null && departureDate.length() != 0){
				String[] departureDates = departureDate.split(",");
				if(departureDates.length == 1){
					model.addAttribute("departureDate", departureDate);
				}
			}
		}
		model.addAttribute("customerList", ordersTotalService.findCustomersByOrdersTotalId(ordersTotalId));
		model.addAttribute("optionalist", optionalExcursionService.findAll());
		return BaseTemplateURL + "/bookTourProduct";
	}
	
	 /* 填写产品信息页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/bookProductNew", method = RequestMethod.GET)
	public String bookProductNew(Model model, String ordersTotalId, String groupLineId, String brand, String singleType,String isSelfOrganize) {
		model.addAttribute("menuId", "301");
		model.addAttribute("ordersTotalId", ordersTotalId);
		model.addAttribute("ordersTotal", ordersTotalService.findById(ordersTotalId));
		model.addAttribute("brand", brand);
		if(isSelfOrganize!=null){
			model.addAttribute("isSelfOrganize", isSelfOrganize);
		}else{
			model.addAttribute("isSelfOrganize", 0);
		}

		if(groupLineId == null){
		//(单订)单订情况下，获取tourTypeList供选择
			model.addAttribute("tourTypeList", tourTypeService.findByBrand(brand));
			model.addAttribute("singleType", singleType);
		}else{
		//品牌团或者入境团
		//如果groupline的departureDate有多个时间就用departureDateArray传输到页面，是一个就用departureDate传输到页面
			GroupLine groupLine = groupLineService.findById(groupLineId);
			model.addAttribute("groupLine", groupLine);
			String departureDate = groupLine.getDepartureDate();
			if(departureDate != null && departureDate.length() != 0){
				String[] departureDates = departureDate.split(",");
				if(departureDates.length == 1){
					model.addAttribute("departureDate", departureDate);
				}
			}
		}
		model.addAttribute("customerList", ordersTotalService.findCustomersByOrdersTotalId(ordersTotalId));
		return BaseTemplateURL + "/bookTourProductNew";
	}

	/**
	 * 新增产品
	 */
	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
	public String save(ProductVO productVO,RedirectAttributes redirectAttributes) {
		orderService.saveProduct(productVO);
		return "redirect:edit.jhtml?menuId=301&ordersTotalId=" + productVO.getOrdersTotalId();
	}
	/**
	 * 新增产品
	 */
	@RequestMapping(value = "/addProductNew", method = RequestMethod.POST)
	public String saveNew(ProductVO productVO) {
		orderService.saveProductNew(productVO);
		return "redirect:edit.jhtml?menuId=301&ordersTotalId=" + productVO.getOrdersTotalId();
	}
	
	/**
	 * 取消订单
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/cencelOrder", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		orderService.cancelOrder(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 恢复订单
	 * 
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/recoverOrder", method = RequestMethod.GET)
	public String recover(String id, RedirectAttributes redirectAttributes) {
		orderService.recoverOrder(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据国家ID异步获取州信息
	 * 
	 * @param countryId
	 * @return
	 */
	@RequestMapping(value = "/states", method = RequestMethod.POST)
	public @ResponseBody Map<String, String> getStatesByCountryId(String countryId) {
		Map<String, String> stateIdAndNames = new HashMap<String, String>();
		List<State> states = stateService.findByCountryId(countryId);
		for (State state : states) {
			stateIdAndNames.put(state.getId(), state.getStateName());
		}
		return stateIdAndNames;
	}

	/**
	 * 根据团队类别ID异步获取线路信息
	 * 
	 * @param tourTypeId
	 * @return
	 */
	@RequestMapping(value = "/groupLines", method = RequestMethod.POST)
	public @ResponseBody Map<String, GroupLine> getGroupLinesByTourTypeId(String tourTypeId) {
		Map<String, GroupLine> groupLineMap = new HashMap<String, GroupLine>();
		List<GroupLine> groupLineList = groupLineService.findByTourTypeId(tourTypeId);
		for (GroupLine groupLine : groupLineList) {
			groupLineMap.put(groupLine.getId(), groupLine);
		}
		return groupLineMap;
	}

	/**
	 * 
	 * 
	 * @param orderId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editPayCost", method = RequestMethod.GET)
	public String loadPayCost(String id, Model model,String menuId,String totalId) {
		model.addAttribute("menuId", menuId);
		model.addAttribute("order", orderService.findById(id));
		model.addAttribute("payCost", orderService.findPayCostByOrderId(id));
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("totalId", totalId);
		model.addAttribute("venderList", venderService.findAllSupplier());
		return "/admin/order/payCostEdit";
	}

	/**
	 * 收入支出异步删除
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deletePayCost", method = RequestMethod.POST)
	public @ResponseBody String deletePayCost(String id) {
		payCostRecordsService.delete(id);
		return "OK";
	}

	/**
	 * 修改团订单收入支出
	 * 
	 * @param tourOrderPayCostVO
	 * @return
	 */
	@RequestMapping(value = "/updatePayCost", method = RequestMethod.POST)
	public String updatePayCost(PayCostEditVO payCostEditVO,String totalId) {
		String id=payCostEditVO.getOrderId();
		orderService.updatePayCost(payCostEditVO);
		if(totalId.equals("pay")){
			return "redirect:editPayCost?id="+id+"&totalId=pay";
		}else{
			return "redirect:edit?menuId=302&ordersTotalId="+totalId;
		}
	}

	/**
	 * 团订单客人查看页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/customers", method = RequestMethod.GET)
	public String customer(String id, Model model,String menuId) {
		model.addAttribute("menuId",menuId );
		model.addAttribute("orderId", id);
		return "/admin/order/customerList";
	}

	/**
	 * 团订单客人查看页面异步获取数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/customerList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> customerList(Pageable pageable, String orderId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Customer> page = orderService.findCustomerPagesByOrderId(pageable, orderId);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 客人添加页面
	 * 
	 * @param orderId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/addCustomer", method = RequestMethod.GET)
	public String addCustomer(String orderId, Model model) {
		model.addAttribute("menuId", "301");
		model.addAttribute("orderId", orderId);
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("languageList", languageService.findAll());
		return "/admin/order/addCustomer";
	}

	/**
	 * 查看订单确认单(pdf)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/orderReview", method = RequestMethod.GET)  //op修改之后
	public String orderReview(String id, Model model) {
		model.addAttribute("menuId", "303");
		Order order = orderService.findById(id);
		Admin agent = adminService.getCurrent();
		Invoice Invoice = new Invoice();
		Invoice.setOrder(order);
		Invoice.setAgent(agent);
		String destPath = orderToPdfService.createPdf(Invoice);
		List<CustomerOrderRel> customerOrderRels = customerOrderRelService.findByOrderId(id);
		List<Customer> customers = new ArrayList<Customer>();
		for (CustomerOrderRel customerOrderRel : customerOrderRels) {
			customers.add(customerService.findById(customerOrderRel.getCustomerId()));
		}
		model.addAttribute("destPath", destPath);
		model.addAttribute("iOrV", "2");
		model.addAttribute("customers", customers);
		model.addAttribute("order", order);
		model.addAttribute("orderId", id);
		return "/admin/order/orderReview";
	}
	
	//产生子单的确认单
	@RequestMapping(value = "/invoiceForChild", method = RequestMethod.GET)  
	public String invoiceForChild(String id, Model model) {
		model.addAttribute("menuId", 302);
		Order order = orderService.findById(id);
		OrdersTotal ordersTotal=ordersTotalService.findById(order.getOrdersTotalId());
		Admin agent = adminService.getCurrent();
		Invoice Invoice = new Invoice();
		Invoice.setOrder(order);
		Invoice.setAgent(agent);
		String destPath = "";
		String temp = ""; //判断  1 团  非团
		/*'wenjing' 品牌是wenjing的订单属于有供应商的非团订单，应查看非团invoce */
		if(order.getOrderType()!=5&&order.getIsSelfOrganize()==1&&!order.getBrand().equals("wenjing")){
			destPath = invoiceToPdfService.createSelfInvoicePdfForChild(id);
		}else{
			temp="1";
//			Admin admin=adminService.getCurrent();
			//将Li Yi的账号开放新功能
			if(ordersTotal.getWr().equals("wholeSale")){
				destPath = invoiceToPdfService.CreateInvoicePdfForReviseWholeSale(id);
			}else{
				destPath = invoiceToPdfService.CreateInvoicePdfForRevise(id,order,ordersTotal);
			}
//			else{
//				destPath = invoiceToPdfService.createInvoicePdfForChild(id);
//			}
		}
		String tourCode = "";
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(id);
		Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
		String at = "";
		if(arriveTime!=null){
			at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
		}
		lineName=tourInfoForOrder.getLineName()+"("+at+")";
		if(order.getTourCode()!=null&&order.getTourCode().length()!=0){
			tourCode = order.getTourCode();
		}
		model.addAttribute("destPath", destPath);
		model.addAttribute("lineName", lineName);
		model.addAttribute("iOrV", 1);
		model.addAttribute("temp", temp);
		model.addAttribute("order", order);
		model.addAttribute("tourCode", tourCode);
		model.addAttribute("orderId", id);
		return "/admin/order/orderReview";
	}
	
	
	/**
	 * 产生invoice(pdf)-->OrderTotal
	 * @return
	 */
	@RequestMapping(value = "/createInvoiceToPdf", method = RequestMethod.POST)
	public String createInvoiceToPdf(Model model,String totalId,String menuId,String logo){
		OrdersTotal order = ordersTotalService.findById(totalId);
		String destPath = "";
		List<Order> orderList = orderService.findChildOrderList(totalId);
		if(orderList.get(0).getOrderType()!=5&&orderList.get(0).getIsSelfOrganize()==1&&!orderList.get(0).getBrand().equals("wenjing")){
			destPath = invoiceToPdfService.createInvoiceForSelf(totalId, logo);
		}else{
			destPath = invoiceToPdfService.createInvoicePdf(totalId,logo);
		}
		String tourCode = "";
		for(Order orders:orderList){
			tourCode+=orders.getTourCode();
		}
		
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0;i<orderList.size();i++){
			TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(orderList.get(i).getId());
			Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
			String at = "";
			if(arriveTime!=null){
				at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
				tourCode = orderList.get(i).getTourCode();
			}
			if(orderList.size()==1){
				lineName+=tourInfoForOrder.getLineName()+"("+at+")";
				tourCode = orderList.get(i).getTourCode();
			}else{
				if(i==orderList.size()-1){
					lineName+=tourInfoForOrder.getLineName()+"("+at+")";
					tourCode = orderList.get(i).getTourCode();
				}else{
					lineName+=tourInfoForOrder.getLineName()+"("+at+",)";
					tourCode = orderList.get(i).getTourCode()+",";
				}
				
			}
			
		}
		model.addAttribute("destPath", destPath);
		model.addAttribute("menuId", menuId);
		model.addAttribute("iOrV", "1");
		model.addAttribute("order", order);
		model.addAttribute("ordersTotalId", totalId);
		model.addAttribute("lineName", lineName);
		model.addAttribute("tourCode", tourCode);
		model.addAttribute("logo", logo);
		return "/admin/order/invoiceToPdf";
	}
	
	
	/**
	 * 产生invoice(pdf)//邮件发送完成之后跳转(总单)
	 * @return
	 */
	@RequestMapping(value = "/toInvoiceToPdf", method = RequestMethod.GET)
	public String toInvoiceToPdf(Model model,String totalId,String menuId,String logo){
		String destPath = invoiceToPdfService.createInvoicePdf(totalId,logo);
		OrdersTotal order = ordersTotalService.findById(totalId);
		model.addAttribute("destPath", destPath);
		model.addAttribute("menuId", menuId);
		model.addAttribute("iOrV", 1);
		model.addAttribute("order", order);
		model.addAttribute("ordersTotalId", totalId);
		return "/admin/order/invoiceToPdf";
		
	}
	
	
	/**
	 * 产生invoice(pdf)
	 * @return
	 */
	@RequestMapping(value = "/createInvoiceTo", method = RequestMethod.GET)
	public String createInvoiceTo(Model model,String totalId,String menuId,String logo){
		String destPath = invoiceToPdfService.createInvoicePdf(totalId,logo);
		OrdersTotal order = ordersTotalService.findById(totalId);
		model.addAttribute("destPath", destPath);
		model.addAttribute("menuId", menuId);
		model.addAttribute("ordersTotalId", totalId);
		model.addAttribute("order", order);
		return "/admin/order/invoiceToPdf";
		
	}
	
	/**
	 * 产生invoice(pdf)op修改之前的确认单
	 * @return
	 */
	@RequestMapping(value = "/createOldPdf", method = RequestMethod.GET)
	public String createOldPdf(Model model,String id,String menuId){
		String destPath = orderToPdfService.createOldPdf(id);
		Order order = orderService.findById(id);
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(id);
		Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
		String at = "";
		String tourCode = "";
		if(order.getTourCode()!=null&&order.getTourCode().length()!=0){
		  tourCode = order.getTourCode();
		}
		if(arriveTime!=null){
			at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
		}
		lineName=tourInfoForOrder.getLineName()+"("+at+")";
		model.addAttribute("destPath", destPath);
		model.addAttribute("menuId", menuId);
		model.addAttribute("lineName", lineName);
		model.addAttribute("orderId", id);
		model.addAttribute("order", order);
		model.addAttribute("tourCode", tourCode);
		model.addAttribute("iOrV", 2);
		return "/admin/order/orderReview";
		
	}
	
	/**
	 * 产生invoice(pdf)op修改之前的确认单
	 * @return
	 */
	@RequestMapping(value = "/createOldPdfOfOpConfirm", method = RequestMethod.GET)
	public String createOldPdfOfOpConfirm(Model model,String id,String menuId){
		String destPath = orderToPdfService.createOldPdfOfOpConfirm(id);
		Order order = orderService.findById(id);
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(id);
		Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
		String at = "";
		String tourCode = "";
		if(order.getTourCode()!=null&&order.getTourCode().length()!=0){
		  tourCode = order.getTourCode();
		}
		if(arriveTime!=null){
			at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
		}
		lineName=tourInfoForOrder.getLineName()+"("+at+")";
		model.addAttribute("destPath", destPath);
		model.addAttribute("menuId", menuId);
		model.addAttribute("lineName", lineName);
		model.addAttribute("orderId", id);
		model.addAttribute("order", order);
		model.addAttribute("tourCode", tourCode);
		model.addAttribute("iOrV", 2);
		return "/admin/order/orderReviewForOp";
		
	}
	
	/**
	 * 发送邮件
	 * @param 确认单(子单) (op修改之前发送邮件跳转至原页面)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sendMail", method = RequestMethod.POST)
	public String sendMail(InvoiceMail invoiceMail,RedirectAttributes redirectAttributes) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath(invoiceMail.getDestPath());
		List<Customer> customerList= ordersTotalService.findCustomersByOrdersTotalId(invoiceMail.getOrdersTotalId());
		invoiceMail.setItInfo(customerList.get(0).getLastName()+" "+customerList.get(0).getFirstName()+" "+customerList.get(0).getMiddleName());
		invoiceMail.setDestPath(path);
		sendMailService.sender(invoiceMail);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		if(invoiceMail.getIOrV()==1){
			return "redirect:invoiceForChild.jhtml?id=" + invoiceMail.getOrderId()+"&menuId="+invoiceMail.getMenuId();
		}
		return "redirect:createOldPdf.jhtml?id=" + invoiceMail.getOrderId()+"&menuId="+invoiceMail.getMenuId();  //跳转至原确认单页面
	}
	
	/**
	 * 发送邮件
	 * @param 确认单(子单) (op修改之前发送邮件跳转至原页面)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sendMailForOpConfirm", method = RequestMethod.POST)
	public String sendMailForOp(InvoiceMail invoiceMail,RedirectAttributes redirectAttributes) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath(invoiceMail.getDestPath());
		invoiceMail.setDestPath(path);
		sendMailService.senderForOpConfirm(invoiceMail);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		if(invoiceMail.getIOrV()==1){
			return "redirect:invoiceForChild.jhtml?id=" + invoiceMail.getOrderId()+"&menuId="+invoiceMail.getMenuId();
		}if("1".equals(invoiceMail.getItInfo())){
			return "redirect:createOldPdfOfOpConfirm.jhtml?id=" + invoiceMail.getOrderId()+"&menuId="+invoiceMail.getMenuId();  //跳转至原确认单页面
		}
		return "redirect:createOldPdf.jhtml?id=" + invoiceMail.getOrderId()+"&menuId="+invoiceMail.getMenuId();  //跳转至原确认单页面
	}
	/**
	 * 发送邮件
	 * @param invoiceMail(总单)--->invoice
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sendMailForOrdersTotal", method = RequestMethod.POST)
	public String sendMailForOrdersTotal(InvoiceMail invoiceMail,RedirectAttributes redirectAttributes) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath(invoiceMail.getDestPath());
		List<Customer> customerList= ordersTotalService.findCustomersByOrdersTotalId(invoiceMail.getOrdersTotalId());
		invoiceMail.setItInfo(customerList.get(0).getLastName()+" "+customerList.get(0).getFirstName()+" "+customerList.get(0).getMiddleName());
		invoiceMail.setDestPath(path);
		sendMailService.sender(invoiceMail);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:toInvoiceToPdf.jhtml?totalId="+invoiceMail.getOrdersTotalId()+"&logo="+invoiceMail.getLogo()+"&menuId=302";//跳转至pdf页面
	}
	
	/**
	 * 发送邮件
	 * @param invoiceMail(总单edit booking页面)
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sendMailForEditPage", method = RequestMethod.POST)
	public String sendMailForEditPage(InvoiceMail invoiceMail,RedirectAttributes redirectAttributes) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath(invoiceMail.getDestPath());
		List<Customer> customerList= ordersTotalService.findCustomersByOrdersTotalId(invoiceMail.getOrdersTotalId());
		invoiceMail.setItInfo(customerList.get(0).getLastName()+" "+customerList.get(0).getFirstName()+" "+customerList.get(0).getMiddleName());
		invoiceMail.setDestPath(path);
		sendMailService.sender(invoiceMail);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:ordersTotalList.jhtml";
	}
	
	@RequestMapping(value = "/sendMailForChild", method = RequestMethod.POST)
	public String sendMailForChild(InvoiceMail invoiceMail,RedirectAttributes redirectAttributes) throws Exception {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String path = request.getSession().getServletContext().getRealPath(invoiceMail.getDestPath());
		List<Customer> customerList= ordersTotalService.findCustomersByOrdersTotalId(invoiceMail.getOrdersTotalId());
		invoiceMail.setItInfo(customerList.get(0).getLastName()+" "+customerList.get(0).getFirstName()+" "+customerList.get(0).getMiddleName());
		invoiceMail.setDestPath(path);
		sendMailService.sender(invoiceMail);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:createOldPdf.jhtml?id=" + invoiceMail.getOrderId() + "&menuId=301";
	}

	/**
	 * region查看订单列表
	 */
	@RequestMapping(value = "/regionList", method = RequestMethod.GET)
	public String regionList(ModelMap model) {
		model.addAttribute("menuId", 305);
		return "/admin/order/regionList";
	}

	/**
	 * region查看订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/regionList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> regionList(Pageable pageable, OrdersTotal ordersTotal) {
		Map<String, Object> map = new HashMap<String, Object>();
		ordersTotal.setUserId(adminService.getCurrent().getId());
		Page<OrdersTotal> page = ordersTotalService.findOrderOfRegionList(ordersTotal, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(ordersTotalService.findRegionOrderTotalSumPepole(ordersTotal));
		}
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * CEO查看所以订单列表
	 */
	@RequestMapping(value = "/findAllOrderList", method = RequestMethod.GET)
	public String findAllOrderList(ModelMap model) {
		model.addAttribute("menuId", "304");
		return "/admin/order/allOrderList";
	}

	/**
	 * CEO查看所以订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/findAllOrderList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> findAllOrderList(Pageable pageable, OrdersTotal ordersTotal) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<OrdersTotal> page = ordersTotalService.findPage(ordersTotal, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(ordersTotalService.findOrderTotalSumPepole(ordersTotal));
		}
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * Office查看本部门订单列表
	 */
	@RequestMapping(value = "/findAllOrderForDeptList", method = RequestMethod.GET)
	public String findAllOrderForDeptList(ModelMap model) {
		model.addAttribute("menuId", "306");
		return "/admin/order/allOrderForDeptList";
	}

	/**
	 * Office查看本部门订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/findAllOrderForDeptList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> findAllOrderForDeptList(Pageable pageable, OrdersTotal ordersTotal) {
		Map<String, Object> map = new HashMap<String, Object>();
		ordersTotal.setDeptId(adminService.getCurrent().getDeptId());
		Page<OrdersTotal> page = ordersTotalService.findPage(ordersTotal, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(ordersTotalService.findOrderTotalSumPepole(ordersTotal));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	
	/**
	 * 订单查看
	 * 
	 * @return
	 */
	@RequestMapping(value = "/findOrderInfo", method = RequestMethod.GET)
	public String findOrderInfo(Model model, String id,String menuId) {
		model.addAttribute("menuId", menuId);
		model.addAttribute("tourTypeList", tourTypeService.findAll());
		model.addAttribute("customerList", ordersTotalService.findCustomersByOrdersTotalId(orderService.findById(id).getOrdersTotalId()));
		ProductVO productVO=orderService.loadProduct(id);
		model.addAttribute("groupLine", groupLineService.findById(productVO.getTourInfoForOrder().getGroupLineId()));
		model.addAttribute("productVO", productVO);
		return BaseTemplateURL + "/orderInfo";
	}
	
	/**
	 * 订单子订单获取异步获取数据
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/orderChildList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> orderChildList(Pageable pageable, Order order,String ordersTotalId) {
		Map<String, Object> map = new HashMap<String, Object>();
		order.setOrdersTotalId(ordersTotalId);
		Page<TourOrderListVO> page = orderService.findTourOrderListVO(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 修改PayCostRecords
	 **/
	@RequestMapping(value = "/editPayCostRecords", method = RequestMethod.GET)
	public String editPayCostRecords(Model model, String id,String totalId) {
		PayCostRecords payCostRecords=payCostRecordsService.findById(id);
		model.addAttribute("order", orderService.findById(payCostRecords.getOrderId()));
		model.addAttribute("payCostRecords",payCostRecords);
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("totalId", totalId);
		model.addAttribute("venderList", venderService.findAllSupplier());
		return "/admin/order/editPayCost";
	}

	/**
	 * Group查看订单列表
	 */
	@RequestMapping(value = "/groupList", method = RequestMethod.GET)
	public String groupList(ModelMap model) {
		List<Admin> agentList=adminService.findAllOfDeptName();
		model.addAttribute("agentList", agentList);
		model.addAttribute("menuId", "307");
		return "/admin/order/groupList";
	}

	/**
	 * Group查看订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/groupList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> groupList(Pageable pageable, OrdersTotal ordersTotal) {
		Map<String, Object> map = new HashMap<String, Object>();
		String groupIdString = adminService.getCurrent().getGroupId();
		if(groupIdString==null){
			groupIdString="";
		}
		ordersTotal.setGroupId(groupIdString);
		Page<OrdersTotal> page = ordersTotalService.findForGrouPage(ordersTotal, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(ordersTotalService.findGroupOrderTotalSumPepole(ordersTotal));
		}
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * Agent是否可以查看确认单(该确认但是否是经过op修改之后的)
	 * @return
	 */
	@RequestMapping(value = "/isReview", method = RequestMethod.POST)
	public @ResponseBody Map<String,String> isReview(String id){
		Order order = orderService.findById(id);
		Tour tour  = tourService.findById(order.getTourId());
		String ok = "";
		if(tour!=null){
			if(tour.getIsChanged()==1){
				ok = "ok";
			}
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("ok", ok);
		return map;
	}
	
	/**
	 * Item
	 * Group查看订单列表
	 */
	@RequestMapping(value = "/itemGroupList", method = RequestMethod.GET)
	public String itemGroupList(ModelMap model) {
		model.addAttribute("menuId", "308");
		return "/admin/order/itemGroupList";
	}
	/**
	 * Item
	 * Group查看订单列表
	 */
	@RequestMapping(value = "/agencyGroupList", method = RequestMethod.GET)
	public String agencyGroupList(ModelMap model) {
		model.addAttribute("menuId", "325");
		return "/admin/order/agencyGroupList";
	}
	
	/**
	 * 生成PDF
	 */
	@RequestMapping(value="/exportVoucherforOpconfirm",method = RequestMethod.GET)
	public String exportVoucherforOpconfirm(Model model,String id) {
		String destPath = orderToPdfService.createBPdfforOpConfirm(id);
		Order order = orderService.findById(id);
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(id);
		Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
		String at = "";
		if(arriveTime!=null){
			at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
		}
		lineName=tourInfoForOrder.getLineName()+"("+at+")";
		model.addAttribute("destPath", destPath);
		model.addAttribute("lineName", lineName);
		model.addAttribute("orderId", id);
		model.addAttribute("order", order);
		return "/admin/orders/exportVoucher";
	}

	/**
	 * Item
	 * Group查看订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/itemGroupList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemGroupList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		String groupIdString = adminService.getCurrent().getGroupId();
		if(groupIdString==null){
			groupIdString="";
		}
		order.setGroupId(groupIdString);
		Page<Order> page = orderService.findForGroupPage(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(orderService.findGroupOrderSumPepole(order));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * Group
	 * ietm list 打印
	 */
	@RequestMapping(value = "/findGroupOrderListPrint", method = RequestMethod.GET)
	public String findGroupOrderListPrint(ModelMap model,Order order) {
		String groupIdString = adminService.getCurrent().getGroupId();
		if(groupIdString==null){
			groupIdString="";
		}
		order.setGroupId(groupIdString);
		List<Order> ordersList= orderService.findGroupOrderListPrint(order);
		Order ord=orderService.findGroupSumPepoleAndPayOrCost(order);
		Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
		model.addAttribute("ordersTime", order);
		model.addAttribute("order", ord);
		model.addAttribute("deptName", dept.getDeptName());
		model.addAttribute("ordersList", ordersList);
		return "/admin/finance/accountant/agentOrderStaticsListPrint";
	}
	
	/**
	 * Item
	 * region查看订单列表
	 */
	@RequestMapping(value = "/itemRegionList", method = RequestMethod.GET)
	public String itemRegionList(ModelMap model) {
		model.addAttribute("menuId", "309");
		return "/admin/order/itemRegionList";
	}

	/**
	 * Item
	 * region查看订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/itemRegionList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemRegionList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		order.setUserId(adminService.getCurrent().getId());
		order.setState(5);
		Page<Order> page = orderService.findOrderOfRegionList(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(orderService.findRegionOrderSumPepole(order));
		}
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * Item
	 * CEO查看所以订单列表
	 */
	@RequestMapping(value = "/itemCeoOrderList", method = RequestMethod.GET)
	public String itemCeoOrderList(ModelMap model) {
		model.addAttribute("menuId", "311");
		return "/admin/order/itemCeoOrderList";
	}

	/**
	 * Item
	 * CEO查看所以订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/itemCeoOrderList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemCeoOrderList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		//order.setIsSelfOrganize(0);
		order.setState(5);
		Page<TourOrderListVO> page = orderService.findTourOrderListVO(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(orderService.findOrderSumPepole(order));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * Item
	 * Office查看本部门订单列表
	 */
	@RequestMapping(value = "/itemOfficeList", method = RequestMethod.GET)
	public String itemOfficeList(ModelMap model) {
		model.addAttribute("menuId", "310");
		return "/admin/order/itemOfficeList"; 
	}

	/**
	 * Item
	 * Office查看本部门订单列表
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/itemOfficeList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemOfficeList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		order.setDeptId(adminService.getCurrent().getDeptId());
		Page<TourOrderListVO> page = orderService.findTourOrderListVO(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(orderService.findOrderSumPepole(order));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	
	/**
	 * 导出word版voucher
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/exportVoucher", method = RequestMethod.GET)
	protected ModelAndView onSubmit(ModelMap modelMap,HttpServletRequest request,  
            HttpServletResponse response, HttpSession session,String id)  
            throws Exception {
			//String checkDate=request.getParameter("checkDate");
			Order order = orderService.findById(id);
			String orderNumer = order.getOrderNo();
		 	OutputStream os = null;
			String fileName= "voucher-"+orderNumer+".doc";
			response.setContentType("application/msword");  
	       response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(fileName, "UTF-8"));  
	       InputStream inputStream =exportVoucherForWordService.getWordFile(id);
	       os = response.getOutputStream();  
	       byte[] b = new byte[10240];  
	       int length;  
	       while ((length = inputStream.read(b)) > 0) {  
	           os.write(b, 0, length);  
	       }  
	       os.flush();  
	       os.close();  
	       inputStream.close(); 
	        return null;
	        
}
	
	/**
	 * 导出word版Invoice
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/exportInvoice", method = RequestMethod.GET)
	protected ModelAndView exportInvoice(ModelMap modelMap,HttpServletRequest request,  
            HttpServletResponse response, HttpSession session,String id)  
            throws Exception {
			Order order = orderService.findById(id);
			String orderNumer = order.getOrderNo();
		 	OutputStream os = null;
			String fileName= "Invoice-"+orderNumer+".doc";
			response.setContentType("application/msword");  
	       response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(fileName, "UTF-8"));  
	       InputStream inputStream =exportInvoiceForWordService.getWordFile(id);
	       os = response.getOutputStream();  
	       byte[] b = new byte[10240];  
	       int length;  
	       while ((length = inputStream.read(b)) > 0) {  
	           os.write(b, 0, length);  
	       }  
	       os.flush();  
	       os.close();  
	       inputStream.close(); 
	        return null;
	        
}

	/**
	 * brand 选择tourType
	 * 
	 * @return
	 */
	@RequestMapping(value = "/findTourTypeName", method = RequestMethod.POST)
	public @ResponseBody Map<String, String> findTourTypeName(String brand) {
		Map<String, String> tourTypeIdAndNames = new HashMap<String, String>();
		List<TourType> tourTypeList = tourTypeService.findByBrand(brand);
		for (TourType tourType : tourTypeList) {
			tourTypeIdAndNames.put(tourType.getTourTypeId(), tourType.getTypeName());
		}
		return tourTypeIdAndNames;
	}
	//excle导入客人
	@RequestMapping(value = "/importCustomer", method = RequestMethod.POST)
	public String importCustomer(MultipartFile file,String ordersTotalId,
			HttpServletRequest request, String menuId,
			RedirectAttributes redirectAttributes) {
		Map<String,Object> map = new HashMap<String,Object>();
		List<Customer> customerList = new ArrayList<Customer>();
		String fileString= fileService.uploadLocal(FileType.customerForExcle,file);
		String rootPath = servletContext.getRealPath("/") ;
		rootPath="/mnt/tomcat7";
		String downLoadPath = rootPath + fileString;
		File file1 = new File(downLoadPath);
		customerList = orderService.importCustomer(file1);
		//导入成功 
		for(Customer customer:customerList){
			if(customer.getMessage()!=null){
				addFlashMessage(redirectAttributes, new Message(Type.warning, "Import Failed\t"+customer.getMessage(),"Import Failed"));
				 return "redirect:edit.jhtml?ordersTotalId=" +ordersTotalId+"&menuId="+302;
			}else{
			CustomerOrderRel customerOrderRel = new CustomerOrderRel();
			customerOrderRel.setCustomer(customer);
			customerOrderRel.setOrdersTotalId(ordersTotalId);
			customerOrderRel.setRoomNumber(0);
			customerOrderRel.setGuestRoomType(customer.getGuestRoomType());
			ordersTotalService.addCustomer(customerOrderRel);
			}
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		 return "redirect:edit.jhtml?ordersTotalId=" +ordersTotalId+"&menuId="+302;
	}
	/**
	 * 异步查询订单号
	 */
	@RequestMapping(value = "/listSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelect(Order order) {
		List<Order> orderList = orderService.findSelect(order);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderList", orderList);
		return map;
	}
	
    public List<CustomerFlight> addList(List<CustomerFlight> cList){
	 	List<CustomerFlight> list=new ArrayList<CustomerFlight>();
	 	List<CustomerFlight> lista=new ArrayList<CustomerFlight>();
	 	List<CustomerFlight> lists=new ArrayList<CustomerFlight>();
	 	
	 	lists.addAll(cList);
	 	for(int i=0;i<cList.size();i++){
	 		CustomerFlight cf=cList.get(i);
	 		String str="";
	 		int flag=0;
	 		for(int j=lists.size()-1;j>=0;j--){
	 			CustomerFlight cuf=lists.get(j);
	 			
	 			cuf.setFlightNumber(cuf.getFlightNumber()==null ?"":cuf.getFlightNumber());
	 			cf.setFlightNumber(cf.getFlightNumber()==null ?"":cf.getFlightNumber());
	 			cuf.setFlightCode(cuf.getFlightCode()==null ?"":cuf.getFlightCode());
	 			cf.setFlightCode(cf.getFlightCode()==null ?"":cf.getFlightCode());
				if(cf.getArriveDate()!=null&&cuf.getArriveDate()!=null&&cf.getArriveDate().compareTo(cuf.getArriveDate())==0&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()!=null&& cuf.getUserId()!=null&& cf.getUserId().equals(cuf.getUserId())&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			} else if(cf.getArriveDate()!=null&&cuf.getArriveDate()!=null&&cf.getArriveDate().compareTo(cuf.getArriveDate())==0&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()==null&& cuf.getUserId()==null&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}else if(cf.getArriveDate()==null&&cuf.getArriveDate()==null&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()!=null&& cuf.getUserId()!=null&& cf.getUserId().equals(cuf.getUserId())&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}else if(cf.getArriveDate()==null&&cuf.getArriveDate()==null&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()==null&& cuf.getUserId()==null&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}
	 		}
	
	 		if(str.length()>=1){
	 			str=str.substring(0,str.length()-1);
	 		}
	 		
	 		cf.setCustomerNos(str);
	 		if(flag==1){
	 			lista.add(cf);
	 		}
	 	}
	 	
	   	if(lista.size()==1){
	   		CustomerFlight cf=lista.get(0);
	   		cf.setCustomerNos(String.valueOf(cf.getCustomerNo()));
	   		lists.add(cf);
	 	}
 	
	   	list=sortList(lista);
	 	return list;
	 }
    
	public  List<CustomerFlight> sortList(List<CustomerFlight> cfList){
    	List<CustomerFlight> list=new ArrayList<CustomerFlight>();
    	
    	for(CustomerFlight cf:cfList){
    		String strd=cf.getCustomerNos();
    		String[] cusNo=strd.split(",");
    		if(cusNo.length>0){
	    		int[] cusSortNo=sortStr(cusNo);
	    		String cusT=cusStrNo(cusSortNo);
	    		cf.setCustomerNos(cusT);
	    		list.add(cf);
    		}
    	}
    	
    	return list;
    }
	
    public  String cusStrNo(int[] str){
		String strs="";
		int c=1;
		int d=1;
		if(str.length==1){
			strs+=String.valueOf(str[0]);
		}
		for(int i=0;i<str.length-1;i++){
			int a=str[i];
			int b=str[i+1];
			if((b-a)==1){
				if(c==1){
					strs+=String.valueOf(a)+"-";
					c++;
				}
				
			}else if((b-a)==0){
				if(d==1){
					//strs+=String.valueOf(a)+",";
					d++;
				}
			}else{
				strs+=String.valueOf(a)+",";
				c=1;
				d=1;
			}
			if((i+2)==str.length){
				strs+=String.valueOf(b)+",";
			}

		}
		String s=strs.substring((strs.length()-1),strs.length());
		if(s.equals(",")){
			strs=strs.substring(0,strs.length()-1);
		}
		return strs;
    }
    
    public  int[] sortStr(String [] str){
		int[] strs=new int[str.length];
		
		for(int i=0;i<str.length;i++){
			if(!str[i].equals(""))
				strs[i]=Integer.parseInt(str[i]);
		}
		
		Arrays.sort(strs);
		return strs;
    }
    @RequestMapping(value = "/deleteItemFee", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteItemFee(String Id) {
    	Map<String, Object> map=new HashMap<String, Object>();
    	orderFeeItemsService.removeById(Id);
    	map.put("msg", "Successful operation");
		return map;
	}
    
	/**
	 * 同行支付页面跳转
	 * */
    @RequestMapping(value = "/agencyPayList", method = RequestMethod.GET)
	public String agencyPayList(ModelMap model,Order order) {
    	Admin admin=adminService.getCurrent();
		model.addAttribute("menuId", "520");
		model.addAttribute("deptId", admin.getDeptId());
		model.addAttribute("order", order);
		return BaseTemplateURL + "/agencyPayList";
	}
    
    @RequestMapping(value = "/agencyPayList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agencyPayList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(order.getCostState()==null){
			order.setCostState(10);
		}
		Page<TourOrderListVO> page = orderService.findTourOrderListVO(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
    @RequestMapping(value="/venderList",method=RequestMethod.POST)
    public @ResponseBody Map<String, Object> venderList(String brand,String operater){
    	Map<String, Object> map=new HashMap<String, Object>();
    	GroupLine groupline = new GroupLine();
    	groupline.setBrand(brand);
    	groupline.setOperater(operater);
    	String[] ve=null;
    	String vender=groupLineService.venderList(groupline);
		if(vender!=null){
			ve=vender.split(",");
		}
		map.put("venderList", ve);
		return map;
    }
    
    /**
	 * 订单转给同行用户
	 * */
	@RequestMapping(value="/changePUser",method=RequestMethod.POST)
	public @ResponseBody String changePUser(String orderId,double commission){
		Order order=orderService.findById(orderId);
		double rate=1;
		PeerUser peerUser=new PeerUser();
		peerUser.setPeerId(order.getPeerId());
		peerUser.setIsAvailable(0);
		List<PeerUser> list=peerUserService.find(peerUser);
		if(list.size()>0){
			if(list.get(0).getCurrencyTypeId().equals("42DC81C7-3FEE-4B15-9C08-CC575620FD4B")){
				rate=1.4;
			}
			ReceivableInfoOfOrder reOrder=receivableInfoOfOrderService.findByOrderId(orderId);
			OrderReceiveItem orderReceiveItem=new OrderReceiveItem();
			orderReceiveItem.setReceivableInfoOfOrderId(reOrder.getId());
			orderReceiveItem.setType(3);
			List<OrderReceiveItem> orderReceiveItemList = tOrderReceiveItemService.find(orderReceiveItem);
			double otherFee=0;
			if(orderReceiveItemList.size()>0){
				for (OrderReceiveItem orderReceiveItems : orderReceiveItemList) {
					double dis=orderReceiveItems.getItemFee().doubleValue()*orderReceiveItems.getItemFeeNum();
					otherFee+=dis;
				}
			}
			BigDecimal fee= new BigDecimal(reOrder.getTotalCommonTourFee().doubleValue()+reOrder.getTotalFeeOfOthers().doubleValue()-otherFee-commission);
			reOrder.setSumFee(fee);
			receivableInfoOfOrderService.update(reOrder);//保存总值
			/*给order付同行的值*/
			order.setPeerUserId(list.get(0).getPeerUserId());
			order.setPeerUserName(list.get(0).getPeerUserName());
			order.setPeerUserFee(new BigDecimal(commission));
			order.setCusPrice(reOrder.getTotalCommonTourFee());
			order.setReviewState(1);
			order.setCommonTourFee(fee);
			order.setPeerUserRate(new BigDecimal(rate));
			orderService.update(order);
			return"success";
		}else{
			return "fail";
		}
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
    
    
    
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private PeerUserService peerUserService;

	@Autowired
	private CityService cityService;

	@Autowired
	private CountryService countryService;

	@Autowired
	private GroupLineService groupLineService;

	@Autowired
	private LanguageService languageService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private OrdersTotalService ordersTotalService;

	@Autowired
	private PayCostRecordsService payCostRecordsService;

	@Autowired
	private StateService stateService;

	@Autowired
	private TourTypeService tourTypeService;

	@Autowired
	private VenderService venderService;

	@Autowired
	private OrderToPdfService orderToPdfService;

	@Autowired
	private SendMailService sendMailService;
	
	@Autowired
	private CustomerSourceService customerSourceService;

	@Autowired
	private CustomerOrderRelService customerOrderRelService;

	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private InvoiceToPdfService invoiceToPdfService;
	
	@Autowired
	private TourService tourService;
	
	@Autowired
	private TourInfoForOrderService tourInfoForOrderService;
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private OrderRemarkService orderRemarkService;
	
	@Autowired
	private ExportVoucherForWordService exportVoucherForWordService;

	@Autowired
	private ExportInvoiceForWordService exportInvoiceForWordService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private ReceivableInfoOfOrderService receivableInfoOfOrderService;
	
	@Autowired
	private TOrderReceiveItemService tOrderReceiveItemService;
	
	@Autowired
	private OrderFeeItemsService orderFeeItemsService;
	@Autowired
	private BrandService brandService;
	@Resource(name = "nationalityServiceImpl")
	private NationalityService nationalityService;
	@Autowired
	private PrePostHotelService prePostHotelService;
	@Autowired
	private OptionalExcursionService optionalExcursionService;
	@Autowired
	private SupplierPriceService supplierPriceService;
}
