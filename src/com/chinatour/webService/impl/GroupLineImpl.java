package com.chinatour.webService.impl;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.jws.WebService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Constant;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.Language;
import com.chinatour.entity.OptionalExcurition;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderFinanceInvoice;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.OrderRemark;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.persistence.CustomerFlightMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.GroupLineHotelRelMapper;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.GroupRouteMapper;
import com.chinatour.persistence.OptionalExcursionMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.OrderRemarkMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.PayCostRecordsMapper;
import com.chinatour.persistence.ReceivableInfoOfOrderMapper;
import com.chinatour.persistence.SOrderReceiveItemMapper;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.persistence.TourInfoForOrderMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.CustomerService;
import com.chinatour.service.GroupLineService;
import com.chinatour.service.HotelService;
import com.chinatour.service.ItineraryInfoService;
import com.chinatour.service.LanguageService;
import com.chinatour.service.OrderFinanceInvoiceService;
import com.chinatour.service.OrderService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.ProductFee;
import com.chinatour.vo.SingleOrdersVO;
import com.chinatour.webService.GroupLineInterface;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2015-1-15 下午3:37:08
 * @revision  3.0
 */
@WebService(serviceName="serviceInterface",endpointInterface="com.chinatour.webService.GroupLineInterface")
public class GroupLineImpl implements GroupLineInterface {
	
	@Autowired
	private GroupLineMapper groupLineMapper;
	@Autowired
	private OrdersTotalMapper ordersTotalMapper;
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private TourInfoForOrderMapper tourInfoForOrderMapper;
	@Autowired
	private ReceivableInfoOfOrderMapper receivableInfoOfOrderMapper;
	@Autowired
	private CustomerFlightMapper customerFlightMapper;
	@Autowired
	private CustomerOrderRelMapper customerOrderRelMapper;
	@Autowired
	private GroupLineService groupLineService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private PayCostRecordsMapper payCostRecordsMapper;
	@Autowired
	private ItineraryInfoService itineraryInfoService;
	@Autowired
	private OrderFinanceInvoiceService orderFinanceInvoiceService;
	@Autowired
	private LanguageService languageService;
	@Autowired
	private TOrderReceiveItemMapper tOrderReceiveItemMapper;
	@Autowired
	private OrderRemarkMapper orderRemarkMapper;
	@Autowired
	private GroupRouteMapper groupRouteMapper;
	@Autowired
	private HotelService hotelService;
	@Autowired
	private GroupLineHotelRelMapper groupLineHotelRelMapper;
	@Autowired
	private SOrderReceiveItemMapper sOrderReceiveItemMapper;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OptionalExcursionMapper optionalExcursionMapper;
	
	@Override
	public String getGroupLine() {
		Gson gson = new Gson();
		GroupLine gLine=new GroupLine();
		gLine.setTourTypeId("A112BF2B-1DD1-43E4-8FCD-299FEFD09D8A");//发现中国美中国团
		gLine.setIsSystem(1);
		List<GroupLine> groupLineList = groupLineService.findGroupLine(gLine);
		Type type = new TypeToken<List<GroupLine>>(){}.getType();  //指定集合对象属性  
		String beanListToJson = gson.toJson(groupLineList, type);
		return beanListToJson;
	}
	@Override
	public String saveOrder(String order, String customerList,String tourInfoOfOrder) throws ParseException {
		Gson gson = new Gson();
		//订单信息
		Order orderS = gson.fromJson(order, Order.class);//子订单对象化
		
		JSONObject json =  JSONObject.fromObject(tourInfoOfOrder);
		String tdate = json.getString("arriveTime");
		
		
		/*--------开始赋值预保存----------*/
		/*----------总订单生成--------*/
		OrdersTotal ordersTotal=new OrdersTotal();
		ordersTotal.setOrdersTotalId(UUIDGenerator.getUUID());
		ordersTotal.setUserId(orderS.getUserId());
		Admin admin = adminService.findById(orderS.getUserId());
		ordersTotal.setDeptId(admin.getDeptId());
		ordersTotal.setAgent(admin.getUsername());
		ordersTotal.setTotalPeople(orderS.getTotalPeople());
		ordersTotal.setContactName(orderS.getContactName());
		ordersTotal.setServer(Constant.SERVER);
		ordersTotal.setBookingDate(new Date());
		ordersTotal.setWr("retail");
		ordersTotalMapper.save(ordersTotal);
		ordersTotal.setOrderNumber(ordersTotalMapper.findById(ordersTotal.getOrdersTotalId()).getOrderNumber());
		//子订单订单赋值
		Order orderT = new Order();
		orderT.setId(UUIDGenerator.getUUID());
		orderT.setOrdersTotalId(ordersTotal.getOrdersTotalId());
		//团信息
		TourInfoForOrder tourInfoForOrder = gson.fromJson(tourInfoOfOrder, TourInfoForOrder.class);//TourInfoForOrder对象化
		//团款信息
		ReceivableInfoOfOrder receivableInfoOfOrder = new ReceivableInfoOfOrder();//ReceivableInfoOfOrder对象化
		
		//客人list
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		JSONArray array = JSONArray.fromObject(customerList);//先读取串数组
		Object[] o = array.toArray();//转成对像数组
		for(int a = 0;a<o.length;a++){
			JSONObject obj = JSONObject.fromObject(o[a]);//再使用JsonObject遍历一个个的对像
			String cdate=obj.getString("birthday");
			String cpost=obj.getString("passportDate");
			Customer customerS = (Customer)obj.toBean(obj,Customer.class);//指定转换的类型，但仍需要强制转化
			if(!(cdate.equals(""))){
			customerS.setDateOfBirth(format.parse(cdate));
			}
			if(!(cpost.equals(""))){
			customerS.setExpireDateOfPassport(format.parse(cpost));
			}
			//新客人
			customerS.setCustomerId(UUIDGenerator.getUUID());
			customerS.setCreateDate(new Date());
			customerService.save(customerS);
			//=========客人订单关系表=========
			List<CustomerOrderRel> customerOrderRelList=new ArrayList<CustomerOrderRel>();
			CustomerOrderRel customerOrderRel=new CustomerOrderRel();
			customerOrderRel.setId(UUIDGenerator.getUUID());
			customerOrderRel.setCustomerId(customerS.getCustomerId());
			customerOrderRel.setOrdersTotalId(ordersTotal.getOrdersTotalId());
			customerOrderRel.setOrderId(orderT.getId());
			customerOrderRel.setCustomerOrderNo(a+1);
			customerOrderRel.setGuestRoomType(customerS.getGuestRoomType());
			customerOrderRel.setContactFlag(0);
			customerOrderRel.setCustomerTourNo(0);
			customerOrderRel.setSameComeIn("");
			if(customerS.getRoomNumber()!=null){
				customerOrderRel.setRoomNumber(customerS.getRoomNumber());
			}else{
				customerOrderRel.setRoomNumber(0);
			}
			customerOrderRel.setRoomIsFull(customerS.getRoomIsFull());
			customerOrderRel.setIsDel(0);
			customerOrderRel.setTicketType("");//webservice默认值
			customerOrderRelList.add(customerOrderRel);
			customerOrderRelMapper.saveCustomerOrderRels(customerOrderRelList);
				//=========客人航班==========
				JSONArray arraycf = JSONArray.fromObject(customerS.getCustomerFlightList());
				Object[] oc = arraycf.toArray();//转成对像数组
				List<CustomerFlight> customerFlightList=new ArrayList<CustomerFlight>();
				for (int i = 0; i < oc.length; i++) {
					JSONObject objc = JSONObject.fromObject(oc[i]);//再使用JsonObject遍历一个个的对像
					String arriveDateStr = objc.getString("arriveDateStr");//获取航班日期
					CustomerFlight customerFlight = (CustomerFlight)objc.toBean(objc,CustomerFlight.class);//指定转换的类型，但仍需要强制转化
					customerFlight.setCustomerOrderRelId(customerOrderRel.getId());
					if(!(arriveDateStr.equals(""))){
						customerFlight.setArriveDate(format.parse(arriveDateStr));
					}
					customerFlight.setId(UUIDGenerator.getUUID());
					customerFlightList.add(customerFlight);
				}
				customerFlightMapper.saveCustomerFlights(customerFlightList);
			}
		
		
		/*
		 * 保存一条子订单
		 */
		orderT.setTotalPeople(orderS.getTotalPeople());
		orderT.setContact(ordersTotal.getContactName());
		orderT.setOrderType(1);
		orderT.setIsSelfOrganize(0);
		//如果是Inbound的local tour
		orderT.setBrand("中国美");
		orderT.setTourTypeId("A112BF2B-1DD1-43E4-8FCD-299FEFD09D8A");//发现中国美中国团
		orderT.setModifyDate(new Date());
		orderT.setUserId(admin.getId());
		orderT.setUserName(admin.getUsername());
		orderT.setDeptId(admin.getDeptId());
		orderT.setOrderTourType(Order.BRAND_SYS);
		orderT.setOrderNo(ordersTotal.getOrderNumber());
		orderT.setFlag(1);
		orderMapper.save(orderT);
		
		/*
		 * 保存订单信息
		 */
	    tourInfoForOrder.setId(UUIDGenerator.getUUID());
	    tourInfoForOrder.setOrderId(orderT.getId());
	    if(!(tdate.equals(""))){
	    tourInfoForOrder.setScheduleOfArriveTime(format.parse(tdate));
	    }
		tourInfoForOrderMapper.save(tourInfoForOrder);
		
		/*
		 * 保存费用信息
		 */
		receivableInfoOfOrder.setId(UUIDGenerator.getUUID());
		receivableInfoOfOrder.setTotalPeople(ordersTotal.getTotalPeople());
		receivableInfoOfOrder.setOrderId(orderT.getId());
		receivableInfoOfOrderMapper.save(receivableInfoOfOrder);
		String beanListToJson = gson.toJson(ordersTotal.getOrderNumber());//返回保存后的订单编号
		return beanListToJson;
	}
	@Override
	public String getStatisticsRevenueCost(String userId, String orderFinance) {
		if(userId!=null && !(userId.equals(""))){
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			Gson gson=new Gson();
			OrderFinanceInvoice orderFinanceInvoice=gson.fromJson(orderFinance, OrderFinanceInvoice.class);
			orderFinanceInvoice.setUserId(userId);
			List<OrderFinanceInvoice> listOrderFinanceInvoice=orderFinanceInvoiceService.bookingPCStatistical(orderFinanceInvoice);
			Type type = new TypeToken<List<OrderFinanceInvoice>>(){}.getType();  //指定集合对象属性
			String beanListToJson = gson.toJson(listOrderFinanceInvoice, type);
			return beanListToJson;
		}else{
			return "userID cannot be empty";
		}
	}
	/*@Override
	public String getItineraryinfo() {
		Gson gson=new Gson();
		List<ItineraryInfo>  ListItineraryinfo=new ArrayList<ItineraryInfo>();
		ListItineraryinfo=itineraryInfoService.findAll();
		Type type = new TypeToken<List<ItineraryInfo>>(){}.getType();  //指定集合对象属性  
		String beanListToJson = gson.toJson(ListItineraryinfo, type);
		return beanListToJson;
	}*/
	
	@Override
	public String[] getByOrderNo(String userId, String orderNo) {
		if(userId!=null && !(userId.equals(""))){
			Gson gson=new Gson();
			Customer customer=new Customer();
			List<Customer> customerList=new ArrayList<Customer>();
			
			TourInfoForOrder tourInfoForOrder=new TourInfoForOrder();
			List<TourInfoForOrder> tourInfoForOrderList=new ArrayList<TourInfoForOrder>();
			List<PayCostRecords> payCostRecordsList=new ArrayList<PayCostRecords>();
			PayCostRecords payCostRecords=new PayCostRecords();
			
			//查找出的总订单
			OrdersTotal orderTotal=new OrdersTotal();
			orderTotal.setUserId(userId);
			orderTotal.setOrderNumber(orderNo);
			List<OrdersTotal> orderTotalList=ordersTotalMapper.find(orderTotal);
			
			orderTotal=orderTotalList.get(0);
			//查找出子订单
			Order order=new Order();
			List<Order> orderList = orderMapper.findByOrdersTotalId(orderTotal.getOrdersTotalId());
			if(orderList.size()>0){
				order=orderList.get(0);
				order.setOrderNo(orderTotal.getOrderNumber());
			}
			
			//根据订单查找客人
			CustomerOrderRel customerOrderRel=new CustomerOrderRel();
			customerOrderRel.setOrderId(order.getId());
			customerOrderRel.setOrdersTotalId(order.getOrdersTotalId());
			List<CustomerOrderRel> customerOrderRelList =customerOrderRelMapper.find(customerOrderRel);
			
			ReceivableInfoOfOrder receivableInfoOfOrder=new ReceivableInfoOfOrder();
			List<ReceivableInfoOfOrder> receivableInfoOfOrderList=new ArrayList<ReceivableInfoOfOrder>();
			//查找客人
			for (int i = 0; i < customerOrderRelList.size(); i++) {
				CustomerFlight customerFlight=new CustomerFlight();
				List<CustomerFlight> customerFlightList=new ArrayList<CustomerFlight>();
				customerFlightList=customerFlightMapper.findByCustomerOrderRelId(customerOrderRelList.get(i).getId());
				customer=customerService.findById(customerOrderRelList.get(i).getCustomerId());
				customerList.add(customer);
				customerList.get(i).setCustomerFlightList(customerFlightList);
			}
			
			tourInfoForOrder=tourInfoForOrderMapper.findByOrderId(order.getId());
			/*receivableInfoOfOrder=receivableInfoOfOrderMapper.findByOrderId(order.getId());*/
			payCostRecordsList=payCostRecordsMapper.findByOrderId(order.getId());
			if(payCostRecordsList.size()>0){
				for(int i=0;i<payCostRecordsList.size();i++){
					payCostRecordsList.get(i).setOrderNo(orderTotal.getOrderNumber());
				}
			}
			//将所有查出的信息转换成json
			String orders=gson.toJson(order);
			String customers=gson.toJson(customerList);
			String tourInfoForOrders=gson.toJson(tourInfoForOrder);
			String payCostRecord=gson.toJson(payCostRecordsList);
			String[] orderInfo={orders,customers,tourInfoForOrders,payCostRecord};
			return orderInfo;
		}else{
			String[] orderInfo={"userID cannot be empty"};
			return orderInfo;
		}
	}
	@Override
	public String getLanguage() {
		Gson gson=new Gson();
		List<Language> languageList=languageService.findAll();
		Type type = new TypeToken<List<GroupLine>>(){}.getType();  //指定集合对象属性  
		String beanListToJson = gson.toJson(languageList, type);
		return beanListToJson;
	}
	@Override
	public String updateOrder(String orderNo,String productVO) throws ParseException {
		Gson gson = new Gson();
		//订单信息
		ReceivableInfoOfOrder receivableInfoOfOrder=new ReceivableInfoOfOrder();
		String corder=orderNo+"-1";
		OrdersTotal ot = new OrdersTotal();
		ot.setOrderNumber(orderNo);
		List<OrdersTotal> otlist=ordersTotalMapper.find(ot);
		ot= otlist.get(0);
		Order od = new Order();
		od.setOrderNo(corder);
		List<Order> olist=orderMapper.find(od);
		Order orderT = olist.get(0);
		//更改订单费用
		//保存费用信息
		receivableInfoOfOrder=receivableInfoOfOrderMapper.findByOrderId(orderT.getId());
		receivableInfoOfOrderMapper.removeById(receivableInfoOfOrder.getId());
		ProductFee productFee=gson.fromJson(productVO, ProductFee.class);
		receivableInfoOfOrder=productFee.getReceivableInfoOfOrder();
		receivableInfoOfOrder.setId(UUIDGenerator.getUUID());
		receivableInfoOfOrder.setTotalPeople(orderT.getTotalPeople());
		receivableInfoOfOrder.setOrderId(orderT.getId());
		receivableInfoOfOrderMapper.save(receivableInfoOfOrder);
		ot.setCommonTourFee(receivableInfoOfOrder.getSumFee().doubleValue());
		ordersTotalMapper.update(ot);
		orderT.setCommonTourFee(receivableInfoOfOrder.getSumFee());
		orderMapper.update(orderT);
		/*添加费用明细*/
		List<OrderReceiveItem> orderReceiveItemList=new ArrayList<OrderReceiveItem>(); 
		if(productFee.getAdultItem()!=null){
			orderReceiveItemList.add(productFee.getAdultItem());
		}
		if(productFee.getChildrenItem()!=null){
			orderReceiveItemList.add(productFee.getChildrenItem());
		}
		if(productFee.getOtherFeeList()!=null){
			orderReceiveItemList.addAll(productFee.getOtherFeeList());
		}
		if(productFee.getDiscountList()!=null){
			orderReceiveItemList.addAll(productFee.getDiscountList());
		}
		if(orderReceiveItemList.size()>0){
			for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
				orderReceiveItem.setId(UUIDGenerator.getUUID());
				orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				tOrderReceiveItemMapper.save(orderReceiveItem);
			}
		}
		OrderRemark orderRemark=new OrderRemark();
		orderRemark.setOrderRemarksId(UUIDGenerator.getUUID());
		orderRemark.setOrderId(orderT.getId());
		orderRemark.setCreateDate(new Date());
		orderRemark.setModifyDate(new Date());
		orderRemark.setUpdateRemark("Cost changes");
		orderRemark.setUserId(orderT.getUserId());
		orderRemark.setUserName(orderT.getUserName());
		orderRemarkMapper.save(orderRemark);
		return "SUCCESS";
	}
	@Override
	public String getList() {
		Order order=new Order();
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		String b="2015-06-01";
		int oo=0;
		order.setDeptId("aa20dd70-24d2-11e4-a0d1-00163e002f1d");
		try {
			order.setBeginningDate(format.parse(b));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		GroupLine gLine=new GroupLine();
		gLine.setTourTypeId("A112BF2B-1DD1-43E4-8FCD-299FEFD09D8A");//发现中国美中国团
		gLine.setIsSystem(1);
		List<GroupLine> groupLineLists =new ArrayList<GroupLine>();
		List<GroupLine> groupLineList = groupLineService.findGroupLine(gLine);
		for(int a=0;a<groupLineList.size();a++){
			GroupLine line=new GroupLine();//线路提取信息
			order.setGroupLineId(groupLineList.get(a).getId());
			List<Order> orderLists = new ArrayList<Order>();//获得的订单所有相关信息
			List<Order> orderList = orderMapper.orderListWeb(order);//根据产品查找订单
			if(orderList.size()>0){
				line.setTourCode(groupLineList.get(a).getTourCode());
				line.setTourName(groupLineList.get(a).getTourName());
				
				for(int x=0;x<orderList.size();x++){
					oo +=1;
					Order orders=new Order();
					orders.setOrderNo(orderList.get(x).getOrderNo());
					orders.setTotalPeople(orderList.get(x).getTotalPeople());
					orders.setArriveDate(orderList.get(x).getArriveDate());
					
					CustomerOrderRel customerOrderRel=new CustomerOrderRel();
					customerOrderRel.setOrderId(orderList.get(x).getOrderId());
					customerOrderRel.setOrdersTotalId(orderList.get(x).getOrdersTotalId());
					List<CustomerOrderRel> customerOrderRelList =customerOrderRelMapper.find(customerOrderRel);//客人订单关系信息
					List<Customer> customerList=new ArrayList<Customer>();
					//查找客人
					for (int i = 0; i < customerOrderRelList.size(); i++) {
						List<CustomerFlight> customerFlightList=new ArrayList<CustomerFlight>();
						customerFlightList=customerFlightMapper.findByCustomerOrderRelId(customerOrderRelList.get(i).getId());//航班信息
						Customer customer=customerService.findById(customerOrderRelList.get(i).getCustomerId());//客人信息
						customerList.add(customer);
						customerList.get(i).setCustomerFlightList(customerFlightList);
					}
					orders.setCustomerList(customerList);
					orderLists.add(orders);
				}
				line.setOrderList(orderLists);
				groupLineLists.add(line);
			}
		}
		Gson gson=new Gson();
		Type type = new TypeToken<List<GroupLine>>(){}.getType();  //指定集合对象属性  
		String beanListToJson = gson.toJson(groupLineLists, type);
		return beanListToJson;
	}
	public static Date getNextDay(Date date,GroupLine groupline) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, +groupline.getAddDate());//今天的时间加addDate天
		date = calendar.getTime();
		return date;
	}
	
	@Override
	public String saveOrderWeb(String order, String customerList,String tourInfoOfOrder, String receivableInfoOfOrder) throws ParseException {
		Gson gson = new Gson();
		//订单信息
			Order orderS = gson.fromJson(order, Order.class);//子订单对象化
			String orderId=null;
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			try {
			/*判断是否已经通步*/
			List<Order> Orderlist=orderService.findByRefNo(orderS.getRefNo());
			if(Orderlist!=null&&Orderlist.size()>0){
				OrdersTotal OrTotal=ordersTotalMapper.findById(Orderlist.get(0).getOrdersTotalId());
				String beanListToJson = gson.toJson(OrTotal.getOrderNumber());//返回保存后的订单编号
				return beanListToJson;
			}
			
			/*--------开始赋值预保存----------*/
			/*----------总订单生成--------*/
			OrdersTotal ordersTotal=new OrdersTotal();
			ordersTotal.setOrdersTotalId(UUIDGenerator.getUUID());
			ordersTotal.setUserId(orderS.getUserId());
			Admin admin = adminService.findById(orderS.getUserId());
			ordersTotal.setDeptId(admin.getDeptId());
			ordersTotal.setAgent(admin.getUsername());
			ordersTotal.setTotalPeople(orderS.getTotalPeople());
			ordersTotal.setContactName(orderS.getContactName());
			ordersTotal.setTel(orderS.getTime());
			ordersTotal.setEmail(orderS.getYear());
			ordersTotal.setServer(Constant.SERVER);
			ordersTotal.setBookingDate(new Date());
			ordersTotal.setWr("retail");
			ordersTotalMapper.save(ordersTotal);
			ordersTotal.setOrderNumber(ordersTotalMapper.findById(ordersTotal.getOrdersTotalId()).getOrderNumber());
			//子订单订单赋值
			Order orderT = new Order();
			orderT.setId(UUIDGenerator.getUUID());
			orderT.setOrdersTotalId(ordersTotal.getOrdersTotalId());
			//团信息
			TourInfoForOrder tourInfoForOrder = gson.fromJson(tourInfoOfOrder, TourInfoForOrder.class);//TourInfoForOrder对象化
			GroupLine groupline=groupLineService.findById(tourInfoForOrder.getGroupLineId());
			//以下程序为本次做活动将订单的抵达日期增加一天
			if(tourInfoForOrder.getArriveTime()!=null){
//				if("BAC5993E-8554-4980-877C-32D5C7EEBDEF".equals(tourInfoForOrder.getGroupLineId())){
					getNextDay(format.parse(tourInfoForOrder.getArriveTime()),groupline);
					tourInfoForOrder.setScheduleOfArriveTime(getNextDay(format.parse(tourInfoForOrder.getArriveTime()),groupline));
//				}else{
//					tourInfoForOrder.setScheduleOfArriveTime(format.parse(tourInfoForOrder.getArriveTime()));
//				}
				tourInfoForOrder.setDepartureDate(format.parse(tourInfoForOrder.getArriveTime()));
			}
			
			//团款信息
			ReceivableInfoOfOrder receivableInfoOfOrders = gson.fromJson(receivableInfoOfOrder,ReceivableInfoOfOrder.class);//ReceivableInfoOfOrder对象化
			
			//客人list
			List<Customer> customList =gson.fromJson(customerList,new TypeToken<List<Customer>>() {}.getType());
			for(int a = 0;a<customList.size();a++){
				Customer customerS=customList.get(a);
				if(!(customerS.getBirthday().equals(""))){
				customerS.setDateOfBirth(format.parse(customerS.getBirthday()));
				}
				if(!(customerS.getPassportDate().equals(""))){
				customerS.setExpireDateOfPassport(format.parse(customerS.getPassportDate()));
				}
				//新客人
				customerS.setCustomerId(UUIDGenerator.getUUID());
				customerS.setCreateDate(new Date());
				customerService.save(customerS);
				//=========客人订单关系表=========
				List<CustomerOrderRel> customerOrderRelList=new ArrayList<CustomerOrderRel>();
				CustomerOrderRel customerOrderRel=new CustomerOrderRel();
				customerOrderRel.setId(UUIDGenerator.getUUID());
				customerOrderRel.setCustomerId(customerS.getCustomerId());
				customerOrderRel.setOrdersTotalId(ordersTotal.getOrdersTotalId());
				customerOrderRel.setOrderId(orderT.getId());
				customerOrderRel.setCustomerOrderNo(a+1);
				customerOrderRel.setGuestRoomType(customerS.getGuestRoomType());
				customerOrderRel.setContactFlag(0);
				customerOrderRel.setCustomerTourNo(0);
				customerOrderRel.setSameComeIn("");
				if(customerS.getRoomNumber()!=null){
					customerOrderRel.setRoomNumber(customerS.getRoomNumber());
				}else{
					customerOrderRel.setRoomNumber(0);
				}
				customerOrderRel.setRoomIsFull(customerS.getRoomIsFull());
				customerOrderRel.setIsDel(0);
				customerOrderRel.setTicketType("");//webservice默认值
				customerOrderRel.setVoucherStr("");
				customerOrderRelList.add(customerOrderRel);
				customerOrderRelMapper.save(customerOrderRel);
					//=========客人航班==========
					List<CustomerFlight> oc=customerS.getCustomerFlightList();
					List<CustomerFlight> customerFlightList=new ArrayList<CustomerFlight>();
					for (int i = 0; i < oc.size(); i++) {
						CustomerFlight customerFlight=oc.get(i);
						customerFlight.setCustomerOrderRelId(customerOrderRel.getId());
						if(!(customerFlight.getArriveDateStr().equals(""))){
							customerFlight.setArriveDate(format.parse(customerFlight.getArriveDateStr()));
						}
						customerFlight.setId(UUIDGenerator.getUUID());
						customerFlightList.add(customerFlight);
					}
					customerFlightMapper.saveCustomerFlights(customerFlightList);
				}
			
			
			//保存一条子订单
			orderT.setTotalPeople(orderS.getTotalPeople());
			orderT.setContact(ordersTotal.getContactName());
			orderT.setOrderType(1);
			orderT.setIsSelfOrganize(0);
			//如果是Inbound的local tour
			orderT.setBrand(orderS.getBrand());
			orderT.setModifyDate(new Date());
			orderT.setUserId(admin.getId());
			orderT.setUserName(admin.getUsername());
			orderT.setDeptId(admin.getDeptId());
			orderT.setOrderTourType(Order.BRAND_SYS);
			orderT.setOrderNo(ordersTotal.getOrderNumber());
			orderT.setCommonTourFee(receivableInfoOfOrders.getSumFee());
			orderT.setFlag(1);
			orderT.setTourTypeId(groupline.getTourTypeId());
			orderT.setBrand(groupline.getBrand());
			orderT.setOrderNoIn(orderS.getOrderNoIn());
			orderT.setRefNo(orderS.getRefNo());
			orderMapper.save(orderT);
			
			//保存Income
			if(orderS.getArrivaDate()!=null){
				if(orderS.getSorceId() != 3){
					PayCostRecords payCostRecords=new PayCostRecords();
					payCostRecords.setId(UUIDGenerator.getUUID());
					payCostRecords.setOrderId(orderT.getId());
					payCostRecords.setSum(orderT.getCommonTourFee());
					payCostRecords.setCreateDate(new Date());
					payCostRecords.setTime(format.parse(orderS.getArrivaDate()));
					payCostRecords.setItem("Tour Fee");
					payCostRecords.setCode(orderT.getRefNo());
					if(orderS.getSorceId()==1){
						payCostRecords.setWay("PAYPAL");
						payCostRecords.setRemark(orderS.getUserName());
					}else if(orderS.getSorceId()==2){
						payCostRecords.setRemark("Web Income");
						payCostRecords.setWay("authorize.net");
					}
					payCostRecords.setStatus(0);
					payCostRecords.setType(0);
					payCostRecords.setPayOrCost(1);
					payCostRecordsMapper.save(payCostRecords);
					
					PayCostRecords payCostRecords1=new PayCostRecords();
					payCostRecords1.setId(UUIDGenerator.getUUID());
					payCostRecords1.setOrderId(orderT.getId());
					// 从intertrips导入的信用卡手续费，以后Paypal的手续费计算公式为：手续费= (刷卡钱数*2.9%) + $0.3 , Authorize.net的手续费保持不变。
					if(orderS.getSorceId()==1){//Paypal手续费
						payCostRecords1.setSum(new BigDecimal(orderT.getCommonTourFee().doubleValue()*0.029+0.3).setScale(2,BigDecimal.ROUND_HALF_UP));
						//payCostRecords1.setWay("Credit Card");
						payCostRecords1.setVenderId("1446ED44-6F85-45A1-815D-75B6A6E3E809");
						payCostRecords1.setWay("Check");
					}else{//Authorize.net手续费
						payCostRecords1.setSum(new BigDecimal(orderT.getCommonTourFee().doubleValue()*0.035).setScale(2,BigDecimal.ROUND_HALF_UP));
						payCostRecords1.setVenderId("9E7DAA9A-3A92-42F8-8ED8-EF43F886D53D");
						payCostRecords1.setWay("Check");
					}
					payCostRecords1.setCreateDate(new Date());
					payCostRecords1.setTime(format.parse(orderS.getArrivaDate()));
					payCostRecords1.setItem("Tour Cost");
					payCostRecords1.setCode(orderT.getRefNo());
					payCostRecords1.setRemark("Web Cost");
					payCostRecords1.setStatus(0);
					payCostRecords1.setType(0);
					payCostRecords1.setPayOrCost(2);
					payCostRecordsMapper.save(payCostRecords1);
				}
			}
			
			//保存订单信息
		    tourInfoForOrder.setId(UUIDGenerator.getUUID());
		    tourInfoForOrder.setOrderId(orderT.getId());
			tourInfoForOrderMapper.save(tourInfoForOrder);
			//保存费用信息
			receivableInfoOfOrders.setId(UUIDGenerator.getUUID());
			receivableInfoOfOrders.setTotalPeople(ordersTotal.getTotalPeople());
			receivableInfoOfOrders.setOrderId(orderT.getId());
			receivableInfoOfOrderMapper.save(receivableInfoOfOrders);
			//费用详情添加
			List<OrderReceiveItem> fees=receivableInfoOfOrders.getOrderReceiveItemList();
			for(int i=0;i<fees.size();i++){
				OrderReceiveItem item=fees.get(i);
				item.setId(UUIDGenerator.getUUID());
				item.setReceivableInfoOfOrderId(receivableInfoOfOrders.getId());
				tOrderReceiveItemMapper.save(item);
			}
			//有没有visa
			if(orderS.getTax()==100){
				SingleOrdersVO sv= orderS.getSingleOrdersVO();
				sv.setOrdersTotalId(ordersTotal.getOrdersTotalId());
				OrdersTotal ordersTotals = ordersTotalMapper.findById(ordersTotal.getOrdersTotalId());
				Order orderW = sv.getOrder();
				TourInfoForOrder tourInfoForOrders = sv.getTourInfoForOrder();
				ReceivableInfoOfOrder receivableInfoOfOrderW = sv.getReceivableInfoOfOrder();
				List<OrderReceiveItem> orderReceiveItemList = new ArrayList<OrderReceiveItem>();
				
				/* 根据总订单ID查找出同产品的一组CustomerOrderRel */
				List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findBySameProductOrdersTotalId(ordersTotal.getOrdersTotalId());
				
				/*
				 * 保存一条子订单
				 */
				if(orderW == null){
					orderW = new Order();
				}
				orderW.setId(UUIDGenerator.getUUID());
				orderW.setOrdersTotalId(ordersTotal.getOrdersTotalId());
				orderW.setTotalPeople(ordersTotal.getTotalPeople());
				orderW.setCommonTourFee(sv.getReceivableInfoOfOrder().getSumFee());//保存共计应收团款
				orderW.setPeerId(ordersTotal.getCompanyId());
				orderW.setContact(ordersTotal.getContactName());
				orderW.setReference(orderS.getReference());
				orderW.setIsSelfOrganize(2);
				orderW.setOrderType(5);
				orderW.setModifyDate(new Date());
				orderW.setUserId(admin.getId());
				orderW.setUserName(admin.getUsername());
				orderW.setDeptId(admin.getDeptId());
				orderW.setOrderNo(ordersTotal.getOrderNumber());
				orderW.setOrderNoIn(orderS.getOrderNoIn());
				orderW.setRefNo(orderS.getRefNo());
				orderMapper.save(orderW);
				orderId=orderW.getId();
				
				/*
				 * 保存订单信息
				 */
				if(tourInfoForOrders == null){
					tourInfoForOrders = new TourInfoForOrder();
				}
			    tourInfoForOrders.setId(UUIDGenerator.getUUID());
			    tourInfoForOrders.setOrderId(orderW.getId());
				tourInfoForOrderMapper.save(tourInfoForOrders);
				
				/*
				 * 保存费用信息
				 */
				receivableInfoOfOrderW.setId(UUIDGenerator.getUUID());
				receivableInfoOfOrderW.setTotalPeople(ordersTotal.getTotalPeople());
				receivableInfoOfOrderW.setOrderId(orderW.getId());
				receivableInfoOfOrderMapper.save(receivableInfoOfOrderW);
				
				addToTotalList(orderReceiveItemList,sv.getVisaFeeList());
				
				for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
					orderReceiveItem.setId(UUIDGenerator.getUUID());
					orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrderW.getId());
					sOrderReceiveItemMapper.save(orderReceiveItem);
				}
			}
			String beanListToJson = gson.toJson(ordersTotal.getOrderNumber());//返回保存后的订单编号
			return beanListToJson;
		} catch (Exception e) {
			e.printStackTrace();
			Order ord=orderMapper.findById(orderId);
			if(ord!=null){
				ord.setState(5);
				orderMapper.update(ord);
			}
			String beanListToJson=orderS.getRefNo()+" Save Failed";
			return beanListToJson;
		}
		
	}
	@Override
	public String getGroupLineByCode(String tourCode,String source) {
		Gson gson = new Gson();
		GroupLine gLine=new GroupLine();
		gLine.setTourCode(tourCode);
		gLine.setIsSystem(1);
		Type type = new TypeToken<GroupLine>(){}.getType();  //指定集合对象属性  
		List<GroupLine> groupLineList = groupLineService.findGroupLine(gLine);
		if(groupLineList.size()>0){
			GroupLine groupLine=groupLineList.get(0);
			String beanListToJson = gson.toJson(groupLine, type);
			return beanListToJson;
		}else{
			return "该团不存在";
		}
	}
	@Override
	public String addGroupLine(String groupline) {
		List<Integer> resultList = new ArrayList<Integer>();
		Gson gson = new Gson();
		List<GroupLine> groupLineList  = gson.fromJson(groupline,new TypeToken<List<GroupLine>>(){}.getType());
		for(GroupLine groupLine:groupLineList){
			try{
				List<GroupLine> existGrouplines = groupLineMapper.findByTourCode(groupLine.getTourCode());
				if(existGrouplines != null && existGrouplines.size() > 0){
					GroupLine existGroupLine = existGrouplines.get(0);
					existGroupLine.setLineNo(groupLine.getTourCode());
					existGroupLine.setTourNo(groupLine.getTourCode());
					existGroupLine.setTourName(groupLine.getTourName());
					existGroupLine.setTripDesc(groupLine.getTripDesc());
					existGroupLine.setDepartureDate(groupLine.getDepartureDate());
					existGroupLine.setSpecificItems(groupLine.getSpecificItems());
					existGroupLine.setDestination(groupLine.getDestination());
					existGroupLine.setPlaceStart(groupLine.getPlaceStart());
					existGroupLine.setAttractions(groupLine.getAttractions());
					existGroupLine.setRemark(groupLine.getRemark());
					existGroupLine.setDestinationlist(groupLine.getDestinationlist());
					existGroupLine.setAddDate(groupLine.getAddDate());
					groupLineMapper.update(existGroupLine);
					groupRouteMapper.deleteByGroupLineId(existGroupLine.getId());
					groupLineHotelRelMapper.deleteByGroupLineId(existGroupLine.getId());
					List<GroupRoute> gList=groupLine.getGroupRoute();
					for(int a=0;a<gList.size();a++){
						GroupRoute gr=gList.get(a);
						gr.setId(UUIDGenerator.getUUID());
						gr.setGroupLineId(existGroupLine.getId());
						groupRouteMapper.save(gr);
						if(gr.getHotel()!=null && !"".equals(gr.getHotel())){
							Hotel hotel=new Hotel();
							hotel.setHotelName(gr.getHotel());
							List<Hotel> hList=hotelService.find(hotel);
							if(hList.size()>0){//已存在该酒店
								GroupLineHotelRel rel=new GroupLineHotelRel();
								rel.setId(UUIDGenerator.getUUID());
								rel.setGroupLineId(existGroupLine.getId());
								rel.setDayNum(gr.getDayNum());
								rel.setCreateDate(new Date());
								rel.setHotelId(hList.get(0).getId());
								groupLineHotelRelMapper.save(rel);
							}else{//酒店不存在，先添加酒店信息
								Hotel h=new Hotel();
								h.setId(UUIDGenerator.getUUID());
								h.setHotelName(gr.getHotel());
								h.setCreateDate(new Date());
								hotelService.save(h);
								GroupLineHotelRel rel=new GroupLineHotelRel();
								rel.setId(UUIDGenerator.getUUID());
								rel.setGroupLineId(existGroupLine.getId());
								rel.setDayNum(gr.getDayNum());
								rel.setCreateDate(new Date());
								rel.setHotelId(h.getId());
								groupLineHotelRelMapper.save(rel);
							}
						}
					}
				}else{	
					groupLine.setId(UUIDGenerator.getUUID());
					groupLine.setCreateDate(new Date());
					groupLine.setIsAvailable(0);
					groupLine.setIsSystem(1);
					groupLine.setTourNo(groupLine.getBrand());
					groupLine.setBrand("New Product");
					groupLine.setLineNo(groupLine.getTourCode());
					groupLine.setAddDate(groupLine.getAddDate());
					groupLineService.save(groupLine);
					List<GroupRoute> gList=groupLine.getGroupRoute();
					for(int a=0;a<gList.size();a++){
						GroupRoute gr=gList.get(a);
						gr.setId(UUIDGenerator.getUUID());
						gr.setGroupLineId(groupLine.getId());
						groupRouteMapper.save(gr);
						if(gr.getHotel()!=null && !"".equals(gr.getHotel())){
							Hotel hotel=new Hotel();
							hotel.setHotelName(gr.getHotel());
							List<Hotel> hList=hotelService.find(hotel);
							if(hList.size()>0){//已存在该酒店
								GroupLineHotelRel rel=new GroupLineHotelRel();
								rel.setId(UUIDGenerator.getUUID());
								rel.setGroupLineId(groupLine.getId());
								rel.setDayNum(gr.getDayNum());
								rel.setCreateDate(new Date());
								rel.setHotelId(hList.get(0).getId());
								groupLineHotelRelMapper.save(rel);
							}else{//酒店不存在，先添加酒店信息
								Hotel h=new Hotel();
								h.setId(UUIDGenerator.getUUID());
								h.setHotelName(gr.getHotel());
								h.setCreateDate(new Date());
								hotelService.save(h);
								GroupLineHotelRel rel=new GroupLineHotelRel();
								rel.setId(UUIDGenerator.getUUID());
								rel.setGroupLineId(groupLine.getId());
								rel.setDayNum(gr.getDayNum());
								rel.setCreateDate(new Date());
								rel.setHotelId(h.getId());
								groupLineHotelRelMapper.save(rel);
							}
						}
					}
				}
			}catch(Exception e){
				resultList.add(0);
				continue;
			}
			resultList.add(1);
		}
		return gson.toJson(resultList, new TypeToken<List<Integer>>(){}.getType());
	}
  /**
   * 保存visa数据
   * */
	private void addToTotalList(List<OrderReceiveItem> totalList,List<OrderReceiveItem> addList){
		if(totalList != null && addList != null && addList.size() != 0){
			totalList.addAll(addList);
		}
	}
	@Override
	public String addOptionalExcurition(String OptionalExcurition) {
		List<Integer> resultList = new ArrayList<Integer>();
		Gson gson = new Gson();
		List<OptionalExcurition> OptionalExcuritionList  = gson.fromJson(OptionalExcurition,new TypeToken<List<OptionalExcurition>>(){}.getType());
		for(OptionalExcurition optional:OptionalExcuritionList){
			try{
				List<OptionalExcurition> existoptionals = optionalExcursionMapper.findByCode(optional.getType());
				if(existoptionals != null && existoptionals.size() > 0){
					OptionalExcurition optionalTour = existoptionals.get(0);
					optionalTour.setName(optionalTour.getName());
					optionalExcursionMapper.update(optionalTour);
				}else{	
					optional.setId(UUIDGenerator.getUUID());
					optional.setCreateDate(new Date());
					optional.setModifyDate(new Date());
					optional.setPrice(new BigDecimal(0));
					optionalExcursionMapper.save(optional);
				}
			}catch(Exception e){
				resultList.add(0);
				continue;
			}
			resultList.add(1);
		}
		return gson.toJson(resultList, new TypeToken<List<Integer>>(){}.getType());
	}
}
