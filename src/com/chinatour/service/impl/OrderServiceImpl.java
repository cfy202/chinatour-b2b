package com.chinatour.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.AccountRecord;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.InvoiceAndCreditItems;
import com.chinatour.entity.Language;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderAgencyRemark;
import com.chinatour.entity.OrderFeeItems;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.OrderRemark;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.PeerUser;
import com.chinatour.entity.PrePostHotel;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.TourType;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.AccountRecordMapper;
import com.chinatour.persistence.CurrencyTypeMapper;
import com.chinatour.persistence.CustomerFlightMapper;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.DiscountMapper;
import com.chinatour.persistence.GroupLineMapper;
import com.chinatour.persistence.InvoiceAndCreditItemsMapper;
import com.chinatour.persistence.InvoiceAndCreditMapper;
import com.chinatour.persistence.LanguageMapper;
import com.chinatour.persistence.OrderAgencyRemarkMapper;
import com.chinatour.persistence.OrderFeeItemsMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.OrderRemarkMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.PayCostRecordsMapper;
import com.chinatour.persistence.PrePostHotelMapper;
import com.chinatour.persistence.RateOfCurrencyMapper;
import com.chinatour.persistence.ReceivableInfoOfOrderMapper;
import com.chinatour.persistence.SOrderReceiveItemMapper;
import com.chinatour.persistence.SupplierCheckMapper;
import com.chinatour.persistence.SupplierPriceInfoMapper;
import com.chinatour.persistence.SupplierPriceMapper;
import com.chinatour.persistence.SupplierPriceRemarkMapper;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.persistence.TourInfoForOrderMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.persistence.TourTypeMapper;
import com.chinatour.persistence.VenderMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.NoticeService;
import com.chinatour.service.OrderService;
import com.chinatour.service.PeerUserService;
import com.chinatour.service.VenderService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.PayCostEditVO;
import com.chinatour.vo.ProductVO;
import com.chinatour.vo.SettlementTotalVO;
import com.chinatour.vo.SingleOrdersVO;
import com.chinatour.vo.TourOrderListVO;

/**
 * Service 订单信息
 * 
 * @copyright Copyright: 2014
 * @author Pis
 * @create-time 2014-9-4 上午11:00:28
 * @revision 3.0
 */
@Service("orderServiceImpl")
public class OrderServiceImpl extends BaseServiceImpl<Order, String> implements OrderService {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private PeerUserService peerUserService;
	
	@Autowired
	private VenderService venderService;

	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private CustomerMapper customerMapper;

	@Autowired
	private CustomerOrderRelMapper customerOrderRelMapper;

	@Autowired
	private TourInfoForOrderMapper tourInfoForOrderMapper;

	@Autowired
	private ReceivableInfoOfOrderMapper receivableInfoOfOrderMapper;

	@Autowired
	private SOrderReceiveItemMapper sOrderReceiveItemMapper;

	@Autowired
	private TOrderReceiveItemMapper tOrderReceiveItemMapper;

	@Autowired
	private PayCostRecordsMapper payCostRecordsMapper;

	@Autowired
	private CustomerFlightMapper customerFlightMapper;

	@Autowired
	private OrdersTotalMapper ordersTotalMapper;
	
	@Autowired
	private LanguageMapper languageMapper;
	
	@Autowired
	private TourMapper tourMapper;
	
	@Autowired
	private TourTypeMapper tourTypeMapper;
	
	@Autowired
	private VenderMapper venderMapper;
	
	@Autowired
	private DeptMapper deptMapper;
	
	@Autowired
	private InvoiceAndCreditMapper invoiceAndCreditMapper;
	
	@Autowired
	private CurrencyTypeMapper currencyTypeMapper;
	
	@Autowired
	private RateOfCurrencyMapper rateOfCurrencyMapper;
	
	@Autowired
	private AccountRecordMapper accountRecordMapper;
	
	@Autowired
	private InvoiceAndCreditItemsMapper invoiceAndCreditItemsMapper;
	
	@Autowired
	private SupplierPriceRemarkMapper supplierPriceRemarkMapper;
	
	@Autowired
	private SupplierCheckMapper supplierCheckMapper;
	
	@Autowired
	private SupplierPriceMapper supplierPriceMapper;
	
	@Autowired
	private SupplierPriceInfoMapper supplierPriceInfoMapper;

	@Autowired
	private GroupLineMapper groupLineMapper;

	@Resource(name = "noticeServiceImpl")
	private NoticeService noticeService;
	
	@Autowired
	private OrderRemarkMapper orderRemarkMapper;
	
	@Autowired
	private DiscountMapper discountMapper;
	
	@Autowired
	private PrePostHotelMapper prePostHotelMapper;
	
	@Autowired
	private OrderAgencyRemarkMapper orderAgencyRemarkMapper;
	
	@Autowired
	private OrderFeeItemsMapper orderFeeItemsMapper;
	
	@Autowired
	public void setBaseMapper(OrderMapper orderMapper) {
		super.setBaseMapper(orderMapper);
	}

	/**
	 * 添加产品
	 * 
	 * @param productVO
	 */
	@Override
	@Transactional
	public void saveProduct(ProductVO productVO){
		OrdersTotal ordersTotal = ordersTotalMapper.findById(productVO.getOrdersTotalId());
		int tourTypeType = tourTypeMapper.findById(productVO.getOrder().getTourTypeId()).getType();
		TourInfoForOrder tourInfoForOrder = productVO.getTourInfoForOrder();
		ReceivableInfoOfOrder receivableInfoOfOrder = productVO.getReceivableInfoOfOrder();
		List<OrderReceiveItem> orderReceiveItemList = new ArrayList<OrderReceiveItem>();
		List<CustomerFlight> customerFlightList = new ArrayList<CustomerFlight>();
		Map<String,List<CustomerFlight>> customerIdAndCustomerFlight = new HashMap<String,List<CustomerFlight>>();
		for(CustomerOrderRel customerOrderRel : productVO.getCustomerFlights()){
			customerIdAndCustomerFlight.put(customerOrderRel.getCustomerId(),customerOrderRel.getCustomerFlightList());
		}
		
		/* 根据总订单ID查找出同产品的一组CustomerOrderRel */
		List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findBySameProductOrdersTotalId(productVO.getOrdersTotalId());
		
		/*
		 * 保存一条子订单
		 */
		Order order = productVO.getOrder();
		order.setId(UUIDGenerator.getUUID());
		order.setOrdersTotalId(ordersTotal.getOrdersTotalId());
		order.setTotalPeople(ordersTotal.getTotalPeople());
		order.setCommonTourFee(productVO.getReceivableInfoOfOrder().getSumFee());//保存共计应收团款
		order.setPeerId(ordersTotal.getCompanyId());
		order.setContact(ordersTotal.getContactName());
		
		//如果总订单是retail类型，子订单类型为1 团类型，否则为2 同行类型
		if(ordersTotal.getWr().equalsIgnoreCase("retail")){
			order.setOrderType(1);
		}else{
			order.setOrderType(2);
		}
		
		if(tourInfoForOrder.getGroupLineId() == null || "".equals(tourInfoForOrder.getGroupLineId())){
		//单订
			
		}else if(tourTypeType == 0){
		//品牌自录入团
			order.setOrderTourType(Order.BRAND_SELF);
			order.setIsSelfOrganize(0);
		}else if(tourTypeType == 1){
		//品牌系统录入团
			order.setOrderTourType(Order.BRAND_SYS);
			order.setIsSelfOrganize(0);
		}else if(tourTypeType == 3){
		//入境系统录入团
			order.setOrderTourType(Order.INBOUND_SYS);
			order.setIsSelfOrganize(1);		
		}else{
		//入境自录入团
			order.setOrderTourType(Order.INBOUND_SELF);
			order.setIsSelfOrganize(1);		
		}
		//有线路 非团订单
		if(productVO.getIsSelfOrganize()==2){
			order.setIsSelfOrganize(2);
		}
		
		order.setModifyDate(new Date());
		
		Admin admin=adminService.getCurrent();
		if(admin!=null){
			order.setUserId(adminService.getCurrent().getId());
			order.setUserName(adminService.getCurrent().getUsername());
			order.setDeptId(adminService.getCurrent().getDeptId());
		}else{
			PeerUser p=peerUserService.getCurrent();
			Vender vender=venderService.findById(p.getPeerId());
			admin=adminService.findById(vender.getUserId());
			order.setUserId(admin.getId());
			order.setUserName(admin.getUsername());
			order.setPeerUserName(p.getPeerUserName());
			order.setDeptId(admin.getDeptId());
		}
		
		order.setOrderNo(ordersTotal.getOrderNumber());
		orderMapper.save(order);
		
		/*
		 * 保存订单信息
		 */
	    tourInfoForOrder.setId(UUIDGenerator.getUUID());
	    tourInfoForOrder.setOrderId(order.getId());
	    if(order.getBrand().equals("中国美")){
	    	tourInfoForOrder.setScheduleOfArriveTime(tourInfoForOrder.getDepartureDate());
	    }
		tourInfoForOrderMapper.save(tourInfoForOrder);
		
		/*
		 * 保存费用信息
		 */
		receivableInfoOfOrder.setId(UUIDGenerator.getUUID());
		receivableInfoOfOrder.setTotalPeople(ordersTotal.getTotalPeople());
		receivableInfoOfOrder.setOrderId(order.getId());
		receivableInfoOfOrderMapper.save(receivableInfoOfOrder);
		orderReceiveItemList.add(productVO.getAdultItem());
		orderReceiveItemList.add(productVO.getChildrenItem());
		addToTotalList(orderReceiveItemList,productVO.getOtherFeeList());
		addToTotalList(orderReceiveItemList,productVO.getDiscountList());
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			if(orderReceiveItem!=null){
				orderReceiveItem.setId(UUIDGenerator.getUUID());
				orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				tOrderReceiveItemMapper.save(orderReceiveItem);
			}
		}
		
		/*
		 * 将产品添加至总订单
		 */
		if(customerOrderRelList.get(0).getOrderId().length() == 0){
			/* 如果是给总订单第一次添加产品 ,直接更新orderId字段   */
			String[] customerOrderRelIds = new String[customerOrderRelList.size()];
			for(int i=0; i<customerOrderRelList.size(); i++){
				CustomerOrderRel customerOrderRel = customerOrderRelList.get(i);
				this.setCustomerFlightList(customerFlightList, customerIdAndCustomerFlight.get(customerOrderRel. getCustomerId()), customerOrderRelIds[i] = customerOrderRel.getId());
			}
			customerOrderRelMapper.setOrderIdByIds(order.getId(), customerOrderRelIds);
		}else{
			// order的state为0，2，3，7
			int existOrderNumber = orderMapper.countExistOrdersInOrdersTotal(productVO.getOrdersTotalId());
			//如果订单已全部取消时,新增订单则恢复总订单客人人数，更改总订单客人状态
			if(existOrderNumber == 1){
				int totalPeople = customerOrderRelMapper.countCustomersInOrdersTotal(productVO.getOrdersTotalId());
				ordersTotalMapper.setTotalPeopleByOrdersTotalId(totalPeople, productVO.getOrdersTotalId());
				orderMapper.setTotalPeopleByOrderId(totalPeople, order.getId());
				//将已存在的订单中客人的总订单状态置为正常
				customerOrderRelMapper.setContactFlagByCusIdAndOrToId(0, null, productVO.getOrdersTotalId());
			}
			
			/* 如果是给总订单再次添加产品 ,设入一组ID和OrderId保存  */
			for(CustomerOrderRel customerOrderRel : customerOrderRelList){
				customerOrderRel.setId(UUIDGenerator.getUUID());
				customerOrderRel.setCustomerTourNo(0);  //取消原子订单中客人团编号
				customerOrderRel.setOrderId(order.getId());
				//如果订单已全部取消时，设置客人总订单子订单皆为正常
				if(existOrderNumber == 1){
					customerOrderRel.setIsDel(0); 
					customerOrderRel.setContactFlag(0);
				}else{
					customerOrderRel.setIsDel(customerOrderRel.getContactFlag()); //客人在本订单中状态与客人总订单状态保持一致
				}
				this.setCustomerFlightList(customerFlightList, customerIdAndCustomerFlight.get(customerOrderRel.getCustomerId()), customerOrderRel.getId());
			}
			customerOrderRelMapper.saveCustomerOrderRels(customerOrderRelList);
		}
		if(customerFlightList.size() > 0){
			customerFlightMapper.saveCustomerFlights(customerFlightList);
		}
		//同行用户添加折扣信息为空就不存在，不为空添加信息
		if(productVO.getDiscount()!=null){
			productVO.getDiscount().setOrderId(order.getId());
			discountMapper.save(productVO.getDiscount());
		}
		//同行用户中使用更改
		PrePostHotel prePostHotel=new PrePostHotel();
		prePostHotel.setOrderId(productVO.getOrdersTotalId());
		List<PrePostHotel> prePostList=prePostHotelMapper.findByOrderId(prePostHotel);
		if(prePostList.size()>0){
			for(PrePostHotel prePost:prePostList){
				prePost.setOrderId(order.getId());
				prePostHotelMapper.update(prePost);
			}
		}
		//产生辅助表
		if(productVO.getFeeItems()!=null){
			String[] fee=productVO.getFeeItems().split(",");
			for(int a=0;a<fee.length;a++){
				String[] items=fee[a].split(":");
				OrderFeeItems ofi=new OrderFeeItems();
				ofi.setId(UUIDGenerator.getUUID());
				ofi.setFeeTitle(items[0]);
				ofi.setNum(Integer.parseInt(items[1]));
				ofi.setPrice(new BigDecimal(items[2]));
				ofi.setPax(Integer.parseInt(items[3]));
				ofi.setOrderId(order.getId());
				orderFeeItemsMapper.save(ofi);
			}
		}
	}
	
	/**
	 * 添加产品
	 * 
	 * @param productVO
	 */
	@Override
	@Transactional
	public void saveProductNew(ProductVO productVO){
		OrdersTotal ordersTotal = ordersTotalMapper.findById(productVO.getOrdersTotalId());
		int tourTypeType=10;
		if(productVO.getOrder().getTourTypeId()!=null){
			tourTypeType= tourTypeMapper.findById(productVO.getOrder().getTourTypeId()).getType();
		}
		TourInfoForOrder tourInfoForOrder = productVO.getTourInfoForOrder();
		ReceivableInfoOfOrder receivableInfoOfOrder = productVO.getReceivableInfoOfOrder();
		List<OrderReceiveItem> orderReceiveItemList = new ArrayList<OrderReceiveItem>();
		List<CustomerFlight> customerFlightList = new ArrayList<CustomerFlight>();
		Map<String,List<CustomerFlight>> customerIdAndCustomerFlight = new HashMap<String,List<CustomerFlight>>();
		for(CustomerOrderRel customerOrderRel : productVO.getCustomerFlights()){
			customerIdAndCustomerFlight.put(customerOrderRel.getCustomerId(),customerOrderRel.getCustomerFlightList());
		}
		
		/* 根据总订单ID查找出同产品的一组CustomerOrderRel */
		List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findBySameProductOrdersTotalId(productVO.getOrdersTotalId());
		
		/*
		 * 保存一条子订单
		 */
		Order order = productVO.getOrder();
		order.setId(UUIDGenerator.getUUID());
		order.setOrdersTotalId(ordersTotal.getOrdersTotalId());
		order.setTotalPeople(ordersTotal.getTotalPeople());
		order.setCommonTourFee(productVO.getReceivableInfoOfOrder().getSumFee());//保存共计应收团款
		order.setPeerId(ordersTotal.getCompanyId());
		order.setContact(ordersTotal.getContactName());
		
		//如果总订单是retail类型，子订单类型为1 团类型，否则为2 同行类型,OrderType有值并且为5,则为非团类型的订单
		if(ordersTotal.getWr().equalsIgnoreCase("retail")){
			order.setOrderType(1);
		}else{
			order.setOrderType(2);
		}
		
		if(tourInfoForOrder.getGroupLineId() == null || "".equals(tourInfoForOrder.getGroupLineId())){
		//单订
			
		}else if(tourTypeType == 0){
		//品牌自录入团
			order.setOrderTourType(Order.BRAND_SELF);
			order.setIsSelfOrganize(0);
		}else if(tourTypeType == 1){
		//品牌系统录入团
			order.setOrderTourType(Order.BRAND_SYS);
			order.setIsSelfOrganize(0);
		}else if(tourTypeType == 3){
		//入境系统录入团
			order.setOrderTourType(Order.INBOUND_SYS);
			order.setIsSelfOrganize(1);		
		}else if(tourTypeType == 10){
		//非团订单
			order.setOrderType(5);
			order.setIsSelfOrganize(1);		
		}else{
		//入境自录入团
			order.setOrderTourType(Order.INBOUND_SELF);
			order.setIsSelfOrganize(1);		
		}
		//有线路 非团订单
		if(productVO.getIsSelfOrganize()==1){
			order.setIsSelfOrganize(1);
		}
		
		order.setModifyDate(new Date());
		
		Admin admin=adminService.getCurrent();
		if(admin!=null){
			order.setUserId(adminService.getCurrent().getId());
			order.setUserName(adminService.getCurrent().getUsername());
			order.setDeptId(adminService.getCurrent().getDeptId());
		}else{
			PeerUser p=peerUserService.getCurrent();
			Vender vender=venderService.findById(p.getPeerId());
			admin=adminService.findById(vender.getUserId());
			order.setUserId(admin.getId());
			order.setUserName(admin.getUsername());
			order.setPeerUserName(p.getPeerUserName());
			order.setDeptId(admin.getDeptId());
		}
		
		order.setOrderNo(ordersTotal.getOrderNumber());
		orderMapper.save(order);
		
		/*
		 * 保存订单信息
		 */
	    tourInfoForOrder.setId(UUIDGenerator.getUUID());
	    tourInfoForOrder.setOrderId(order.getId());
		tourInfoForOrderMapper.save(tourInfoForOrder);
		
		/*
		 * 保存费用信息
		 */
		receivableInfoOfOrder.setId(UUIDGenerator.getUUID());
		receivableInfoOfOrder.setTotalPeople(ordersTotal.getTotalPeople());
		receivableInfoOfOrder.setOrderId(order.getId());
		receivableInfoOfOrderMapper.save(receivableInfoOfOrder);
		orderReceiveItemList.add(productVO.getAdultItem());
		orderReceiveItemList.add(productVO.getChildrenItem());
		addToTotalList(orderReceiveItemList,productVO.getOtherFeeList());
		addToTotalList(orderReceiveItemList,productVO.getDiscountList());
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			if(orderReceiveItem!=null){
				orderReceiveItem.setId(UUIDGenerator.getUUID());
				orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				tOrderReceiveItemMapper.save(orderReceiveItem);
			}
		}
		
		/*
		 * 将产品添加至总订单
		 */
		if(customerOrderRelList.get(0).getOrderId().length() == 0){
			/* 如果是给总订单第一次添加产品 ,直接更新orderId字段   */
			String[] customerOrderRelIds = new String[customerOrderRelList.size()];
			for(int i=0; i<customerOrderRelList.size(); i++){
				CustomerOrderRel customerOrderRel = customerOrderRelList.get(i);
				this.setCustomerFlightList(customerFlightList, customerIdAndCustomerFlight.get(customerOrderRel. getCustomerId()), customerOrderRelIds[i] = customerOrderRel.getId());
			}
			customerOrderRelMapper.setOrderIdByIds(order.getId(), customerOrderRelIds);
		}else{
			// order的state为0，2，3，7
			int existOrderNumber = orderMapper.countExistOrdersInOrdersTotal(productVO.getOrdersTotalId());
			//如果订单已全部取消时,新增订单则恢复总订单客人人数，更改总订单客人状态
			if(existOrderNumber == 1){
				int totalPeople = customerOrderRelMapper.countCustomersInOrdersTotal(productVO.getOrdersTotalId());
				ordersTotalMapper.setTotalPeopleByOrdersTotalId(totalPeople, productVO.getOrdersTotalId());
				orderMapper.setTotalPeopleByOrderId(totalPeople, order.getId());
				//将已存在的订单中客人的总订单状态置为正常
				customerOrderRelMapper.setContactFlagByCusIdAndOrToId(0, null, productVO.getOrdersTotalId());
			}
			
			/* 如果是给总订单再次添加产品 ,设入一组ID和OrderId保存  */
			for(CustomerOrderRel customerOrderRel : customerOrderRelList){
				customerOrderRel.setId(UUIDGenerator.getUUID());
				customerOrderRel.setCustomerTourNo(0);  //取消原子订单中客人团编号
				customerOrderRel.setOrderId(order.getId());
				//如果订单已全部取消时，设置客人总订单子订单皆为正常
				if(existOrderNumber == 1){
					customerOrderRel.setIsDel(0); 
					customerOrderRel.setContactFlag(0);
				}else{
					customerOrderRel.setIsDel(customerOrderRel.getContactFlag()); //客人在本订单中状态与客人总订单状态保持一致
				}
				this.setCustomerFlightList(customerFlightList, customerIdAndCustomerFlight.get(customerOrderRel.getCustomerId()), customerOrderRel.getId());
			}
			customerOrderRelMapper.saveCustomerOrderRels(customerOrderRelList);
		}
		if(customerFlightList.size() > 0){
			customerFlightMapper.saveCustomerFlights(customerFlightList);
		}
		//同行用户添加折扣信息为空就不存在，不为空添加信息
		if(productVO.getDiscount()!=null){
			productVO.getDiscount().setOrderId(order.getId());
			discountMapper.save(productVO.getDiscount());
		}
		//同行用户中使用更改
		PrePostHotel prePostHotel=new PrePostHotel();
		prePostHotel.setOrderId(productVO.getOrdersTotalId());
		List<PrePostHotel> prePostList=prePostHotelMapper.findByOrderId(prePostHotel);
		if(prePostList.size()>0){
			for(PrePostHotel prePost:prePostList){
				prePost.setOrderId(order.getId());
				prePostHotelMapper.update(prePost);
			}
		}
		//产生辅助表
		if(productVO.getFeeItems()!=null){
			String[] fee=productVO.getFeeItems().split(",");
			for(int a=0;a<fee.length;a++){
				String[] items=fee[a].split(":");
				OrderFeeItems ofi=new OrderFeeItems();
				ofi.setId(UUIDGenerator.getUUID());
				ofi.setFeeTitle(items[0]);
				ofi.setNum(Integer.parseInt(items[1]));
				ofi.setPrice(new BigDecimal(items[2]));
				ofi.setPax(Integer.parseInt(items[3]));
				ofi.setOrderId(order.getId());
				orderFeeItemsMapper.save(ofi);
			}
		}
	}
	
	/**
	 * 根据子订单ID加载产品
	 */
	@Transactional
	@Override
	public ProductVO loadProduct(String ordersId){
		ProductVO product = new ProductVO();
		product.setOrdersTotalId(ordersId);
		List<OrderReceiveItem> otherFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> discountList = new ArrayList<OrderReceiveItem>();
		Order order = orderMapper.findById(ordersId);
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderMapper.findByOrderId(ordersId);
		List<CustomerOrderRel> customerOrderRels = customerOrderRelMapper.findWithCustomerFlightByOrderIdAndOrdersTotalId(order.getOrdersTotalId(), ordersId);
		ReceivableInfoOfOrder receivableInfoOfOrder = receivableInfoOfOrderMapper.findByOrderId(ordersId);
		List<OrderReceiveItem> orderReceiveItemList = tOrderReceiveItemMapper.findByReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
		
		product.setOrder(order);
		
		product.setTourInfoForOrder(tourInfoForOrder);
		product.setCustomerFlights(customerOrderRels);
		
		product.setReceivableInfoOfOrder(receivableInfoOfOrder);
		for(OrderReceiveItem ort : orderReceiveItemList){
			if(ort.getNum() == 101){
				product.setAdultItem(ort);
			}else if(ort.getNum() == 102){
				product.setChildrenItem(ort);
			}else if(ort.getNum() >= 300){
				discountList.add(ort);
			}else{
				otherFeeList.add(ort);
			}
		}
		product.setOtherFeeList(otherFeeList);
		product.setDiscountList(discountList);
		product.setGroupLine(groupLineMapper.findById(tourInfoForOrder.getGroupLineId()));
		product.setDiscount(discountMapper.findByOrderId(ordersId));
		return product;
	}
	
	/**
	 * 更新团订单产品
	 */
	@Transactional
	@Override
	public void updateProduct(ProductVO productVO,String[] deleteItemIds){
		if(deleteItemIds != null && deleteItemIds.length != 0){
			tOrderReceiveItemMapper.removeByIds(deleteItemIds);
		}
		Order order = new Order();
		TourInfoForOrder tourInfoForOrder  = productVO.getTourInfoForOrder();
		ReceivableInfoOfOrder receivableInfoOfOrder = productVO.getReceivableInfoOfOrder();
		OrderRemark orderRemark = productVO.getOrderRemark();
		OrderAgencyRemark orderAgencyRemark=productVO.getOrderAgencyRemark();//同行订单修改信息
		List<OrderReceiveItem> orderReceiveItemList = new ArrayList<OrderReceiveItem>();
		TourType originalTourType = tourTypeMapper.findById(orderMapper.findById(productVO.getOrdersTotalId()).getTourTypeId());
		TourType changedTourType = tourTypeMapper.findById(productVO.getOrder().getTourTypeId());
		if(productVO.getNewState() == null){
			productVO.setNewState(0);
		}
		Order o = new Order();
		o=orderMapper.findById(productVO.getOrdersTotalId());
		if(productVO.getNewState()==1){
			Tour tour=new Tour();
			tour=tourMapper.findById(o.getTourId());
			if(tour==null){
				
			}else{
				tour.setNewState(1);//团通知OP
				tourMapper.update(tour);
				order.setNoticeState(1);//订单通知OP
			}
		}else{
			order.setNoticeState(2);//不通知
		}
		
		/*
		 * 更新子订单信息
		 */
		order.setId(productVO.getOrdersTotalId());
		order.setCommonTourFee(productVO.getReceivableInfoOfOrder().getSumFee());//保存共计应收团款
		order.setTourTypeId(productVO.getOrder().getTourTypeId());
		order.setModifyDate(new Date());
		order.setPlanticket(productVO.getOrder().getPlanticket());//agent国内机票
		order.setOtherInfo(productVO.getOrder().getOtherInfo());//备注信息
		order.setRate(productVO.getOrder().getRate());
		order.setPeerUserFee(productVO.getOrder().getPeerUserFee());
		if(o.getReviewState()==5&&orderAgencyRemark.getUpdateRemark()!=null){//如果之前通过审核，再次审核状态
			order.setReviewState(6);
		}else{
			order.setReviewState(productVO.getOrder().getReviewState());
		}
		if(productVO.getWarnState() == null){
			productVO.setWarnState(0);
		}
		if(productVO.getWarnState()==2){
			order.setWarnState(2);//通知财务
		}
		/*if(order.getReviewState()==2){
			order.setWarnState(2);//通知财务
		}*/
		if(productVO.getTourInfoForOrder().getGroupLineId() != null){
			switch(changedTourType.getType()){
				case 0: order.setOrderTourType(Order.BRAND_SELF); break;
				case 1: order.setOrderTourType(Order.BRAND_SYS); break;
				case 3: order.setOrderTourType(Order.INBOUND_SYS); break;
				case 4: order.setOrderTourType(Order.INBOUND_SELF);
			}
		}
		BigDecimal sumFee = orderMapper.findById(productVO.getOrdersTotalId()).getCommonTourFee();
		if(sumFee.compareTo(order.getCommonTourFee())!=0){
			order.setIsEdit(1);
			order.setIfUpdateSuc(0);
		}
		orderMapper.update(order);
		
		if(productVO.getTourInfoForOrder().getGroupLineId() != null){
		//原本订单不是单订订单
			if(originalTourType.getTourTypeId().equals(productVO.getOrder().getTourTypeId())){
			/* 团队类型没有发生改变时  */	
				if(originalTourType.getType() == 0 || originalTourType.getType() == 4){
				/* 原本是自录入团，更新产品信息  */
					productVO.getGroupLine().setDepartureDate(dateFormat(productVO.getTourInfoForOrder().getDepartureDate()));
					groupLineMapper.updateIndependentGroupLine(productVO.getGroupLine());
					tourInfoForOrder.setScheduleLineCode(productVO.getGroupLine().getTourCode());
					tourInfoForOrder.setLineName(productVO.getGroupLine().getTourName());
				}else{
				/* 原本是系统录入团，更改产品 */
					GroupLine groupLine = groupLineMapper.findById(productVO.getTourInfoForOrder().getGroupLineId());
					tourInfoForOrder.setScheduleLineCode(groupLine.getTourCode());
					tourInfoForOrder.setLineName(groupLine.getTourName());
				}
			}else if(changedTourType.getType() == 0 || changedTourType.getType() == 4){
			/* 转为自录入团 */
				productVO.getGroupLine().setId(UUIDGenerator.getUUID());
				productVO.getGroupLine().setBrand(productVO.getOrder().getBrand());
				productVO.getGroupLine().setTourTypeId(productVO.getOrder().getTourTypeId());
				productVO.getGroupLine().setDepartureDate(dateFormat(productVO.getTourInfoForOrder().getDepartureDate()));
				groupLineMapper.save(productVO.getGroupLine());
				tourInfoForOrder.setGroupLineId(productVO.getGroupLine().getId());
				tourInfoForOrder.setScheduleLineCode(productVO.getGroupLine().getTourCode());
				tourInfoForOrder.setLineName(productVO.getGroupLine().getTourName());
			}else{
			/* 转为系统录入团 */	
				GroupLine groupLine = groupLineMapper.findById(productVO.getTourInfoForOrder().getGroupLineId());
				tourInfoForOrder.setScheduleLineCode(groupLine.getTourCode());
				tourInfoForOrder.setLineName(groupLine.getTourName());
			}
		}
																
		/*
		 * 更新订单信息
		 */
		tourInfoForOrderMapper.update(tourInfoForOrder);
		
		/*
		 * 更新航班信息
		 */
		if(productVO!=null&&productVO.getCustomerFlights()!=null){
			for(CustomerOrderRel customerOrderRel : productVO.getCustomerFlights()){
				customerOrderRelMapper.update(customerOrderRel);
				for(CustomerFlight customerFlight : customerOrderRel.getCustomerFlightList()){
					if(customerFlight.getId() == null || customerFlight.getId().equals("")){
						customerFlight.setId(UUIDGenerator.getUUID());
						customerFlight.setCustomerOrderRelId(customerOrderRel.getId());
						customerFlightMapper.save(customerFlight);
					}
					customerFlightMapper.updateCustomerFlight(customerFlight);
				}
			}
		}
		
		/*
		 * 保存费用信息
		 */
		receivableInfoOfOrderMapper.update(receivableInfoOfOrder);
		
		orderReceiveItemList.add(productVO.getAdultItem());
		orderReceiveItemList.add(productVO.getChildrenItem());
		addToTotalList(orderReceiveItemList,productVO.getOtherFeeList());
		addToTotalList(orderReceiveItemList,productVO.getDiscountList());
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			if(orderReceiveItem.getId() == null || orderReceiveItem.getId().length() == 0){
				orderReceiveItem.setId(UUIDGenerator.getUUID());
				orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				tOrderReceiveItemMapper.save(orderReceiveItem);
			}else{
				tOrderReceiveItemMapper.update(orderReceiveItem);
			}
		}
		if(productVO.getWarnState() != null){
			orderRemark.setOrderRemarksId(UUIDGenerator.getUUID());
			orderRemark.setModifyDate(new Date());
			orderRemark.setOrderId(order.getId());
			orderRemark.setUserId(adminService.getCurrent().getId());
			orderRemark.setUserName(adminService.getCurrent().getUsername());
			orderRemarkMapper.save(orderRemark);
		}
		if(orderAgencyRemark.getUpdateRemark()!=null){
			orderAgencyRemark.setOrderAgencyRemarksId(UUIDGenerator.getUUID());
			orderAgencyRemark.setModifyDate(new Date());
			orderAgencyRemark.setOrderId(order.getId());
			orderAgencyRemark.setUserId(adminService.getCurrent().getId());
			orderAgencyRemark.setUserName(adminService.getCurrent().getUsername());
			orderAgencyRemarkMapper.save(orderAgencyRemark);
		}
		if(productVO.getOrderFeeItems()!=null){
			List<OrderFeeItems> orderFeeItemsList=productVO.getOrderFeeItems();
			for(OrderFeeItems orderFeeItems:orderFeeItemsList){
				if(orderFeeItems.getFeeTitle()!=null && orderFeeItems.getId()!=null){
				orderFeeItemsMapper.update(orderFeeItems);
				}else if(orderFeeItems.getFeeTitle()!=null && orderFeeItems.getId()==null){
					orderFeeItems.setId(UUIDGenerator.getUUID());
					orderFeeItems.setOrderId(order.getId());
					orderFeeItemsMapper.save(orderFeeItems);
				}else{
				}
			}
		}
	}

	
	/**
	 * 更新团订单产品
	 */
	@Transactional
	@Override
	public void updateProductNew(ProductVO productVO,String[] deleteItemIds){
		if(deleteItemIds != null && deleteItemIds.length != 0){
			tOrderReceiveItemMapper.removeByIds(deleteItemIds);
		}
		Order order = new Order();
		TourInfoForOrder tourInfoForOrder  = productVO.getTourInfoForOrder();
		ReceivableInfoOfOrder receivableInfoOfOrder = productVO.getReceivableInfoOfOrder();
		OrderRemark orderRemark = productVO.getOrderRemark();
		OrderAgencyRemark orderAgencyRemark=productVO.getOrderAgencyRemark();//同行订单修改信息
		List<OrderReceiveItem> orderReceiveItemList = new ArrayList<OrderReceiveItem>();
		TourType changedTourType =new TourType();
		TourType originalTourType = tourTypeMapper.findById(orderMapper.findById(productVO.getOrdersTotalId()).getTourTypeId());
		if(productVO.getOrder().getTourTypeId()!=null){
			changedTourType = tourTypeMapper.findById(productVO.getOrder().getTourTypeId());
		}
		if(productVO.getNewState() == null){
			productVO.setNewState(0);
		}
		Order o = new Order();
		o=orderMapper.findById(productVO.getOrdersTotalId());
		if(productVO.getNewState()==1){
			Tour tour=new Tour();
			tour=tourMapper.findById(o.getTourId());
			if(tour==null){
				
			}else{
				tour.setNewState(1);//团通知OP
				tourMapper.update(tour);
				order.setNoticeState(1);//订单通知OP
			}
		}else{
			order.setNoticeState(2);//不通知
		}
		
		/*
		 * 更新子订单信息
		 */
		order.setId(productVO.getOrdersTotalId());
		order.setCommonTourFee(productVO.getReceivableInfoOfOrder().getSumFee());//保存共计应收团款
		order.setTourTypeId(productVO.getOrder().getTourTypeId());
		order.setModifyDate(new Date());
		order.setPlanticket(productVO.getOrder().getPlanticket());//agent国内机票
		order.setOtherInfo(productVO.getOrder().getOtherInfo());//备注信息
		order.setRate(productVO.getOrder().getRate());
		order.setPeerUserFee(productVO.getOrder().getPeerUserFee());
		if(o.getReviewState()==5&&orderAgencyRemark.getUpdateRemark()!=null){//如果之前通过审核，再次审核状态
			order.setReviewState(6);
		}else{
			order.setReviewState(productVO.getOrder().getReviewState());
		}
		if(productVO.getWarnState() == null){
			productVO.setWarnState(0);
		}
		if(productVO.getWarnState()==2){
			order.setWarnState(2);//通知财务
		}
		/*if(order.getReviewState()==2){
			order.setWarnState(2);//通知财务
		}*/
		if(productVO.getTourInfoForOrder().getGroupLineId() != null){
			if(changedTourType!=null&&changedTourType.getType()!=null){
				switch(changedTourType.getType()){
					case 0: order.setOrderTourType(Order.BRAND_SELF); break;
					case 1: order.setOrderTourType(Order.BRAND_SYS); break;
					case 3: order.setOrderTourType(Order.INBOUND_SYS); break;
					case 4: order.setOrderTourType(Order.INBOUND_SELF);
				}
			}
		}
		order.setIsEdit(1);
		orderMapper.update(order);
		
		if(productVO.getTourInfoForOrder().getGroupLineId() != null){
		//原本订单不是单订订单
			if(productVO.getOrder().getTourTypeId()!=null){
				if(originalTourType.getTourTypeId().equals(productVO.getOrder().getTourTypeId())){
				/* 团队类型没有发生改变时  */	
					if(originalTourType.getType() == 0 || originalTourType.getType() == 4){
					/* 原本是自录入团，更新产品信息  */
						productVO.getGroupLine().setDepartureDate(dateFormat(productVO.getTourInfoForOrder().getDepartureDate()));
						groupLineMapper.updateIndependentGroupLine(productVO.getGroupLine());
						tourInfoForOrder.setScheduleLineCode(productVO.getGroupLine().getTourCode());
						tourInfoForOrder.setLineName(productVO.getGroupLine().getTourName());
					}else{
					/* 原本是系统录入团，更改产品 */
						GroupLine groupLine = groupLineMapper.findById(productVO.getTourInfoForOrder().getGroupLineId());
						tourInfoForOrder.setScheduleLineCode(groupLine.getTourCode());
						tourInfoForOrder.setLineName(groupLine.getTourName());
					}
				}else if(changedTourType.getType() == 0 || changedTourType.getType() == 4){
				/* 转为自录入团 */
					productVO.getGroupLine().setId(UUIDGenerator.getUUID());
					productVO.getGroupLine().setBrand(productVO.getOrder().getBrand());
					productVO.getGroupLine().setTourTypeId(productVO.getOrder().getTourTypeId());
					productVO.getGroupLine().setDepartureDate(dateFormat(productVO.getTourInfoForOrder().getDepartureDate()));
					groupLineMapper.save(productVO.getGroupLine());
					tourInfoForOrder.setGroupLineId(productVO.getGroupLine().getId());
					tourInfoForOrder.setScheduleLineCode(productVO.getGroupLine().getTourCode());
					tourInfoForOrder.setLineName(productVO.getGroupLine().getTourName());
				}else{
				/* 转为系统录入团 */	
					GroupLine groupLine = groupLineMapper.findById(productVO.getTourInfoForOrder().getGroupLineId());
					tourInfoForOrder.setScheduleLineCode(groupLine.getTourCode());
					tourInfoForOrder.setLineName(groupLine.getTourName());
				}
			}
		}
																
		/*
		 * 更新订单信息
		 */
		tourInfoForOrderMapper.update(tourInfoForOrder);
		
		/*
		 * 更新航班信息
		 */
		if(productVO!=null&&productVO.getCustomerFlights()!=null){
			for(CustomerOrderRel customerOrderRel : productVO.getCustomerFlights()){
				customerOrderRelMapper.update(customerOrderRel);
				for(CustomerFlight customerFlight : customerOrderRel.getCustomerFlightList()){
					if(customerFlight.getId() == null || customerFlight.getId().equals("")){
						customerFlight.setId(UUIDGenerator.getUUID());
						customerFlight.setCustomerOrderRelId(customerOrderRel.getId());
						customerFlightMapper.save(customerFlight);
					}
					customerFlightMapper.updateCustomerFlight(customerFlight);
				}
			}
		}
		
		/*
		 * 保存费用信息
		 */
		receivableInfoOfOrderMapper.update(receivableInfoOfOrder);
		
		orderReceiveItemList.add(productVO.getAdultItem());
		orderReceiveItemList.add(productVO.getChildrenItem());
		addToTotalList(orderReceiveItemList,productVO.getOtherFeeList());
		addToTotalList(orderReceiveItemList,productVO.getDiscountList());
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			if(orderReceiveItem.getId() == null || orderReceiveItem.getId().length() == 0){
				orderReceiveItem.setId(UUIDGenerator.getUUID());
				orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				tOrderReceiveItemMapper.save(orderReceiveItem);
			}else{
				tOrderReceiveItemMapper.update(orderReceiveItem);
			}
		}
		if(productVO.getWarnState() != null){
			orderRemark.setOrderRemarksId(UUIDGenerator.getUUID());
			orderRemark.setModifyDate(new Date());
			orderRemark.setOrderId(order.getId());
			orderRemark.setUserId(adminService.getCurrent().getId());
			orderRemark.setUserName(adminService.getCurrent().getUsername());
			orderRemarkMapper.save(orderRemark);
		}
		if(orderAgencyRemark.getUpdateRemark()!=null){
			orderAgencyRemark.setOrderAgencyRemarksId(UUIDGenerator.getUUID());
			orderAgencyRemark.setModifyDate(new Date());
			orderAgencyRemark.setOrderId(order.getId());
			orderAgencyRemark.setUserId(adminService.getCurrent().getId());
			orderAgencyRemark.setUserName(adminService.getCurrent().getUsername());
			orderAgencyRemarkMapper.save(orderAgencyRemark);
		}
		if(productVO.getOrderFeeItems()!=null){
			List<OrderFeeItems> orderFeeItemsList=productVO.getOrderFeeItems();
			for(OrderFeeItems orderFeeItems:orderFeeItemsList){
				if(orderFeeItems.getFeeTitle()!=null && orderFeeItems.getId()!=null){
				orderFeeItemsMapper.update(orderFeeItems);
				}else if(orderFeeItems.getFeeTitle()!=null && orderFeeItems.getId()==null){
					orderFeeItems.setId(UUIDGenerator.getUUID());
					orderFeeItems.setOrderId(order.getId());
					orderFeeItemsMapper.save(orderFeeItems);
				}else{
				}
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinatour.service.OrderService#findTourOrderListVO(com.chinatour.
	 * entity.Order, com.chinatour.Pageable)
	 */
	@Override
	@Transactional(readOnly = true)
	public Page<TourOrderListVO> findTourOrderListVO(Order or, Pageable pageable) {
		List<TourOrderListVO> tourOrderListVOList = new ArrayList<TourOrderListVO>();
	//	String groupIdString = adminService.getCurrent().getGroupId();

		if (pageable == null) {
			pageable = new Pageable();
		}

		//if (groupIdString == null || groupIdString.length() == 0) {
			//or.setUserId(adminService.getCurrent().getId());
			//List<Order>	orderList = orderMapper.findForPage(or, pageable);
			int pageCount = orderMapper.findForPageCount(or);
		/*} else {
			or.setGroupId(groupIdString);
			orderList = orderMapper.findForGroupPage(or, pageable);
			pageCount = orderMapper.findForGroupPageCount(or, pageable);
		}*/
		
		tourOrderListVOList = orderMapper.findTourOrderListVOForPage(or, pageable);
		return new Page<TourOrderListVO>(tourOrderListVOList, pageCount, pageable);
	}	
	/**
	 * 保存非团订单
	 */
	@Override
	@Transactional
	public void saveSingleProduct(SingleOrdersVO singleOrdersVO){
		
		OrdersTotal ordersTotal = ordersTotalMapper.findById(singleOrdersVO.getOrdersTotalId());
		Order order = singleOrdersVO.getOrder();
		TourInfoForOrder tourInfoForOrder = singleOrdersVO.getTourInfoForOrder();
		ReceivableInfoOfOrder receivableInfoOfOrder = singleOrdersVO.getReceivableInfoOfOrder();
		List<OrderReceiveItem> orderReceiveItemList = new ArrayList<OrderReceiveItem>();
		
		/* 根据总订单ID查找出同产品的一组CustomerOrderRel */
		List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findBySameProductOrdersTotalId(singleOrdersVO.getOrdersTotalId());
		
		/*
		 * 保存一条子订单
		 */
		if(order == null){
			order = new Order();
		}
		order.setId(UUIDGenerator.getUUID());
		order.setOrdersTotalId(ordersTotal.getOrdersTotalId());
		order.setTotalPeople(ordersTotal.getTotalPeople());
		order.setCommonTourFee(singleOrdersVO.getReceivableInfoOfOrder().getSumFee());//保存共计应收团款
		order.setPeerId(ordersTotal.getCompanyId());
		order.setContact(ordersTotal.getContactName());
		order.setIsSelfOrganize(2);
		order.setOrderType(5);
		order.setModifyDate(new Date());
		order.setUserId(adminService.getCurrent().getId());
		order.setUserName(adminService.getCurrent().getUsername());
		order.setDeptId(adminService.getCurrent().getDeptId());
		order.setOrderNo(ordersTotal.getOrderNumber());
		orderMapper.save(order);
		
		/*
		 * 保存订单信息
		 */
		if(tourInfoForOrder == null){
			tourInfoForOrder = new TourInfoForOrder();
		}
	    tourInfoForOrder.setId(UUIDGenerator.getUUID());
	    tourInfoForOrder.setOrderId(order.getId());
		tourInfoForOrderMapper.save(tourInfoForOrder);
		
		/*
		 * 保存费用信息
		 */
		receivableInfoOfOrder.setId(UUIDGenerator.getUUID());
		receivableInfoOfOrder.setTotalPeople(ordersTotal.getTotalPeople());
		receivableInfoOfOrder.setOrderId(order.getId());
		receivableInfoOfOrderMapper.save(receivableInfoOfOrder);
		
		addToTotalList(orderReceiveItemList,singleOrdersVO.getVisaFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getFlightTicketFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getHotelFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getTicketFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getInsuranceFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getOtherFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getBusTourFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getCruiseFeeList());
		
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			orderReceiveItem.setId(UUIDGenerator.getUUID());
			orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
			sOrderReceiveItemMapper.save(orderReceiveItem);
		}
		
		/*
		 * 将产品添加至总订单
		 */
		if(customerOrderRelList.get(0).getOrderId().length() == 0){
			/* 如果是给总订单第一次添加产品 ,直接更新orderId字段   */
			String[] customerOrderRelIds = new String[customerOrderRelList.size()];
			for(int i=0; i<customerOrderRelList.size(); i++){
				customerOrderRelIds[i] = customerOrderRelList.get(i).getId();
			}
			customerOrderRelMapper.setOrderIdByIds(order.getId(), customerOrderRelIds);
		}else{
			// order的state为0，2，3，7
			int existOrderNumber = orderMapper.countExistOrdersInOrdersTotal(singleOrdersVO.getOrdersTotalId());
			//如果订单已全部取消时,新增订单则恢复总订单客人人数，更改总订单客人状态
			if(existOrderNumber == 1){
				int totalPeople = customerOrderRelMapper.countCustomersInOrdersTotal(singleOrdersVO.getOrdersTotalId());
				ordersTotalMapper.setTotalPeopleByOrdersTotalId(totalPeople, singleOrdersVO.getOrdersTotalId());
				orderMapper.setTotalPeopleByOrderId(totalPeople, order.getId());
				//将已存在的订单中客人的总订单状态置为正常
				customerOrderRelMapper.setContactFlagByCusIdAndOrToId(0, null, singleOrdersVO.getOrdersTotalId());
			}
			
			/* 如果是给总订单再次添加产品 ,设入一组ID和OrderId保存  */
			for(CustomerOrderRel customerOrderRel : customerOrderRelList){
				customerOrderRel.setId(UUIDGenerator.getUUID());
				customerOrderRel.setCustomerTourNo(0);  //取消原子订单中客人团编号
				customerOrderRel.setOrderId(order.getId());
				//如果订单已全部取消时，设置客人总订单子订单皆为正常
				if(existOrderNumber == 1){
					customerOrderRel.setIsDel(0); 
					customerOrderRel.setContactFlag(0);
				}else{
					customerOrderRel.setIsDel(customerOrderRel.getContactFlag()); //客人在本订单中状态与客人总订单状态保持一致
				}
			}
			customerOrderRelMapper.saveCustomerOrderRels(customerOrderRelList);
		}
	}			
	
	/**
	 * 加载非团订单
	 * 
	 * @return
	 */
	@Transactional(readOnly = true)
	public SingleOrdersVO loadSingleProduct(String ordersId){
		SingleOrdersVO singleOrdersVO = new SingleOrdersVO();
		Order order = orderMapper.findById(ordersId);
		singleOrdersVO.setOrder(order);
		singleOrdersVO.setOrdersTotalId(ordersTotalMapper.findById(order.getOrdersTotalId()).getOrderNumber());
		singleOrdersVO.setTourInfoForOrder(tourInfoForOrderMapper.findByOrderId(ordersId));
		singleOrdersVO.setReceivableInfoOfOrder(receivableInfoOfOrderMapper.findByOrderId(ordersId));
		
		List<OrderReceiveItem> orderReceiveItemList = sOrderReceiveItemMapper.findByReceivableInfoOfOrderId(singleOrdersVO.getReceivableInfoOfOrder().getId());
		
		List<OrderReceiveItem> visaFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> flightTicketFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> hotelFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> ticketFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> insuranceFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> otherFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> busTourFeeList = new ArrayList<OrderReceiveItem>();
		List<OrderReceiveItem> cruiseFeeList = new ArrayList<OrderReceiveItem>();
		List<PayCostRecords> payRecords = new ArrayList<PayCostRecords>();
		List<PayCostRecords> costRecords = new ArrayList<PayCostRecords>();
		
		Set<String> nonGroupTypeSet = new HashSet<String>();
		
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			if(orderReceiveItem.getNum() >= 100 && orderReceiveItem.getNum() < 200){
				visaFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("1");
			}else if(orderReceiveItem.getNum() >= 200 && orderReceiveItem.getNum() < 300){
				flightTicketFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("2");
			}else if(orderReceiveItem.getNum() >= 300 && orderReceiveItem.getNum() < 400){
				hotelFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("3");
			}else if(orderReceiveItem.getNum() >= 400 && orderReceiveItem.getNum() < 500){
				ticketFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("4");
			}else if(orderReceiveItem.getNum() >= 500 && orderReceiveItem.getNum() < 600){
				insuranceFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("5");
			}else if(orderReceiveItem.getNum() >= 600 && orderReceiveItem.getNum() < 700){
				busTourFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("6");
			}else if(orderReceiveItem.getNum() >= 700 && orderReceiveItem.getNum() < 800){
				cruiseFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("7");	
			}else{
				otherFeeList.add(orderReceiveItem);
				nonGroupTypeSet.add("8");	
			}
		}
		List<PayCostRecords> payCostRecordsList = payCostRecordsMapper.findByOrderId(ordersId);
		for(PayCostRecords payCostRecords : payCostRecordsList){
			if(payCostRecords.getPayOrCost() == 1){
				payRecords.add(payCostRecords);
			}else{
				costRecords.add(payCostRecords);
			}
		}
		
		singleOrdersVO.setVisaFeeList(visaFeeList);
		singleOrdersVO.setFlightTicketFeeList(flightTicketFeeList);
		singleOrdersVO.setHotelFeeList(hotelFeeList);
		singleOrdersVO.setTicketFeeList(ticketFeeList);
		singleOrdersVO.setInsuranceFeeList(insuranceFeeList);
		singleOrdersVO.setOtherFeeList(otherFeeList);
		singleOrdersVO.setBusTourFeeList(busTourFeeList);
		singleOrdersVO.setCruiseFeeList(cruiseFeeList);
		singleOrdersVO.setPayRecordsList(payRecords);
		singleOrdersVO.setCostRecordsList(costRecords);
		singleOrdersVO.setNonGroupTypeSet(nonGroupTypeSet);
		return singleOrdersVO;
	}
	
	/**
	 * 修改非团订单
	 */
	@Override
	@Transactional
	public void updateSingleProduct(SingleOrdersVO singleOrdersVO){
		singleOrdersVO.getOrder().setCommonTourFee(singleOrdersVO.getReceivableInfoOfOrder().getSumFee());//保存共计应收团款
		Order order = singleOrdersVO.getOrder();
		order.setIsEdit(1);
		orderMapper.updateFlightPnrAndArriveDate(order);
		tourInfoForOrderMapper.updateDepartureDateAndDayNum(singleOrdersVO.getTourInfoForOrder());
		
		receivableInfoOfOrderMapper.update(singleOrdersVO.getReceivableInfoOfOrder());
		sOrderReceiveItemMapper.removeByReceivableInfoOfOrderId(singleOrdersVO.getReceivableInfoOfOrder().getId());
		List<OrderReceiveItem> orderReceiveItemList = new ArrayList<OrderReceiveItem>();
		
		addToTotalList(orderReceiveItemList,singleOrdersVO.getVisaFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getFlightTicketFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getHotelFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getTicketFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getInsuranceFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getOtherFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getBusTourFeeList());
		addToTotalList(orderReceiveItemList,singleOrdersVO.getCruiseFeeList());
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			orderReceiveItem.setId(UUIDGenerator.getUUID());
			orderReceiveItem.setReceivableInfoOfOrderId(singleOrdersVO.getReceivableInfoOfOrder().getId());
			sOrderReceiveItemMapper.save(orderReceiveItem);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinatour.service.OrderService#findForGrouPage(com.chinatour.entity
	 * .Order, com.chinatour.Pageable)
	 */
	@Override
	@Transactional(readOnly = true)
	public Page<Order> findForGrouPage(Order order, Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<Order> orderList = orderMapper.findForGroupPage(order, pageable);
		int pageCount = orderMapper.findForGroupPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}

	/*
	 * (non-Javadoc)
	 * @see com.chinatour.service.OrderService#findPayCostByOrderId(java.lang.String)
	 */
	@Override
	@Transactional(readOnly = true)
	public PayCostEditVO findPayCostByOrderId(String orderId) {
		PayCostEditVO payCostEditVO = new PayCostEditVO();
		BigDecimal sumPay = new BigDecimal(0.0);
		BigDecimal sumCost = new BigDecimal(0.0);
		List<PayCostRecords> payRecordsList = new ArrayList<PayCostRecords>();
		List<PayCostRecords> costRecordsList = new ArrayList<PayCostRecords>();
		for(PayCostRecords payCostRecords : payCostRecordsMapper.findByOrderId(orderId)){
			if(payCostRecords.getPayOrCost() == 1){
				payRecordsList.add(payCostRecords);
				sumPay = sumPay.add(payCostRecords.getSum());
			} else {
				costRecordsList.add(payCostRecords);
				sumCost = sumCost.add(payCostRecords.getSum());
			}
		}
		payCostEditVO.setOrderId(orderId);
		payCostEditVO.setSumPay(sumPay);
		payCostEditVO.setSumCost(sumCost);
		payCostEditVO.setPayRecordsList(payRecordsList);
		payCostEditVO.setCostRecordsList(costRecordsList);
		return payCostEditVO;
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.chinatour.service.OrderService#updateTourOrderPayCost(com.chinatour.vo.TourOrderPayCostVO)
	 */
	@Override
	@Transactional
	public void updatePayCost(PayCostEditVO payCostEditVO) {
		List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
		if(payCostEditVO.getPayRecordsList()!=null){
			payCostRecordsList.addAll(payCostEditVO.getPayRecordsList());
		}
		if(payCostEditVO.getCostRecordsList()!=null){
			payCostRecordsList.addAll(payCostEditVO.getCostRecordsList());
		}
		for (PayCostRecords payCostRecords : payCostRecordsList) {
			if(payCostRecords.getId() == null || payCostRecords.getId().length() == 0){
				payCostRecords.setId(UUIDGenerator.getUUID());
				payCostRecords.setOrderId(payCostEditVO.getOrderId());
				payCostRecordsMapper.save(payCostRecords);
			}
			payCostRecordsMapper.update(payCostRecords);
		}
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.chinatour.service.OrderService#findCustomerByOrderId(java.lang.String)
	 */
	@Override
	@Transactional
	public Page<Customer> findCustomerPagesByOrderId(Pageable pageable,String orderId) {
		List<Customer> customerList = new ArrayList<Customer>();
		CustomerOrderRel cusOrderRel = new CustomerOrderRel();
		Customer customer = null;
		cusOrderRel.setOrderId(orderId);
        if (pageable == null) {
            pageable = new Pageable();
        }
        
		int total = customerOrderRelMapper.findForPageCount(cusOrderRel);
		for (CustomerOrderRel customerOrderRel : customerOrderRelMapper.findForPage(cusOrderRel, pageable)) {
			customer = customerMapper.findById(customerOrderRel.getCustomerId());
			customer.setLanguage(languageMapper.findById(customer.getLanguageId()));
			customer.setCustomerTourNo(customerOrderRel.getCustomerTourNo());
			customer.setIsDel(customerOrderRel.getIsDel());
			customerList.add(customer);
		}
		return new Page<Customer>(customerList,total,pageable);
	}
	
	/*
	 * 取消子订单功能(agent的操作)
	 */
	@Transactional
	@Override
	public String cancelOrder(String orderId) {
		Order order = orderMapper.findById(orderId);
		if(!"".equals(order.getTourId())){
			orderMapper.changeTotalPeopleOfStateByOrderId(orderId,0, 4); 
			CustomerOrderRel customerOrderRel=new CustomerOrderRel();
			customerOrderRel.setOrderId(order.getId());
			customerOrderRel.setIsDel(0);//不计算已经删除的客人
			int people =customerOrderRelMapper.findCountIsDelByOrderId(customerOrderRel);
			tourMapper.changeTotalPeople(-people,order.getTourId());//修改团人数
			this.setCancelingCustomer(order);//设置客人取消中
			/* 发送站内信  */
			String title = Constant.SYSNOTICE + Constant.CANCELOF_ORDER + order.getOrderNo() +'/'+order.getTourCode();
			noticeService.sendMail(title, adminService.getCurrent().getId(), tourMapper.findById(order.getTourId()).getUserId());
		}else{
			confirmCancelOrder(order);
		}
		//如果是取消最后一个子订单，返回all 
		if("all".equals(order.getGuestRoomType())){
			return "all";
		}
		return "";
	}

	/*
	 * 已组团订单
	 * 订单取消中 设置客人取消中
	 */
	public void setCancelingCustomer(Order order){
		List<CustomerOrderRel> customerOrderRelList =customerOrderRelMapper.findByOrderId(order.getId());
		for(int i=0;i<customerOrderRelList.size();i++){
			CustomerOrderRel customerOrderRel=customerOrderRelList.get(i);
			//将该客人置为取消中
			customerOrderRelMapper.changeCustomerState(customerOrderRel.getId(), 5); 
		}
		
	}
	
	/* 
	 * 确认取消子订单
	 */
	@Override
	public void confirmCancelOrder(Order order) {
		if(!"".equals(order.getTourId())){
			orderMapper.changeStateByOrderId(order.getId(), 5); 
		}else{
			orderMapper.changeStateByOrderId(order.getId(), 6); 
		}
		//将子订单下的所有客人置为取消,并将子订单人数置为0
		customerOrderRelMapper.cancelAllCustomerByOrderId(order.getId()); 
		
		/* 如果总订单下订单全部取消,则把总订单人数置为0，把所有的客人的总订单状态都置为 1 */
		int existOrderNumber = orderMapper.countExistOrdersInOrdersTotal(order.getOrdersTotalId());
		if(existOrderNumber == 0){
			ordersTotalMapper.setTotalPeopleByOrdersTotalId(0, order.getOrdersTotalId());
			customerOrderRelMapper.setContactFlagByCusIdAndOrToId(1, null, order.getOrdersTotalId());
			order.setGuestRoomType("all");
		}
	}

	/*
	 * 恢复订单功能(agent的操作)
	 */
	@Transactional
	@Override
	public String recoverOrder(String orderId) {
		Order order = orderMapper.findById(orderId);
		if(!"".equals(order.getTourId())){
			this.setRecoveringCustomer(order);
			int totalPeople=customerOrderRelMapper.countExistCustomersInOrdersTotal(order.getOrdersTotalId());
			orderMapper.changeTotalPeopleOfStateByOrderId(order.getId(), totalPeople,7);
			int tPeople = customerOrderRelMapper.countExistCustomersInOrdersTotal(order.getOrdersTotalId());
			OrdersTotal ordersTotal=new OrdersTotal();
			ordersTotal.setTotalPeople(tPeople);
			ordersTotal.setOrdersTotalId(order.getOrdersTotalId());
			ordersTotalMapper.update(ordersTotal);
			/*CustomerOrderRel customerOrderRel=new CustomerOrderRel();
			customerOrderRel.setOrderId(order.getId());
			customerOrderRel.setIsDel(0);//不计算已经恢复的客人
			int people =customerOrderRelMapper.findCountCustomerByOrderId(customerOrderRel);*/
			tourMapper.changeTotalPeople(totalPeople,order.getTourId());//修改团人数
			/* 发送站内信  */
			String title = Constant.SYSNOTICE + Constant.RECOVER_STRING + Constant.ORDERS + order.getOrderNo()+'/'+order.getTourCode();
			noticeService.sendMail(title, adminService.getCurrent().getId(), tourMapper.findById(order.getTourId()).getUserId());
		}else{
			confirmRecoverOrder(order);
		}
		//如果是所有子订单都已取消的情况，返回all 
		if("all".equals(order.getGuestRoomType())){
			return "all";
		}
		return "";
	}

	/*
	 * 
	 * 订单恢复中 设置客人恢复中
	 */
	public void setRecoveringCustomer(Order order){
		//修改客人在总账单下的状态为可用
		customerOrderRelMapper.setContactFlagByCusIdAndOrToId(0, null, order.getOrdersTotalId());
		List<CustomerOrderRel> customerOrderRelList =customerOrderRelMapper.findByOrderId(order.getId());
		for(int i=0;i<customerOrderRelList.size();i++){
			CustomerOrderRel customerOrderRel=customerOrderRelList.get(i);
			//将该客人置为恢复中
			customerOrderRelMapper.changeCustomerState(customerOrderRel.getId(), 3); 
		}
		
	}
	
	/* 
	 * 确认恢复订单
	 */
	@Override
	public void confirmRecoverOrder(Order order) {
		/* 如果总订单下所有订单取消，则把总订单人数置为正常，把所有的客人的总订单状态都置为 0 */
		int existOrderNumber = orderMapper.countExistOrdersInOrdersTotal(order.getOrdersTotalId());
		if(existOrderNumber == 0){
			int totalPeople = customerOrderRelMapper.countCustomersInOrdersTotal(order.getOrdersTotalId());
			ordersTotalMapper.setTotalPeopleByOrdersTotalId(totalPeople, order.getOrdersTotalId());
			customerOrderRelMapper.setContactFlagByCusIdAndOrToId(0, null, order.getOrdersTotalId());
			order.setGuestRoomType("all");
		}
		/* 恢复订单状态 */
		if(!"".equals(order.getTourId())){
			orderMapper.changeStateByOrderId(order.getId(), 2); //如果组团将订单状态置为2
		}else{
			orderMapper.changeStateByOrderId(order.getId(), 0); //如果未组团将订单状态置为0 
		}
		OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
		//将子订单下的所有客人置为客人总订单状态,并将子订单人数置为总订单人数
		customerOrderRelMapper.recoverAllCustomerByOrderId(order.getId(), ordersTotal.getTotalPeople());
	}	
	
	/*
	 * 取消客人的功能(agent的操作)
	 */
	@Override
	@Transactional
	public String cancelCustomer(String customerOrderRelId) {
		/* 总订单人数减1，总订单客人状态置为删除  */
		CustomerOrderRel customerOrderRel = customerOrderRelMapper.findById(customerOrderRelId);
		ordersTotalMapper.changeTotalPeople(-1, customerOrderRel.getOrdersTotalId());
		customerOrderRelMapper.setContactFlagByCusIdAndOrToId(1, customerOrderRel.getCustomerId(), customerOrderRel.getOrdersTotalId());
		int totalPeople = customerOrderRelMapper.countExistCustomersInOrdersTotal(customerOrderRel.getOrdersTotalId());
		
		String result = ""; 
		if("".equals(customerOrderRel.getOrderId())){
		//如果总订单没有子订单，直接删除客人
			customerOrderRelMapper.changeCustomerState(customerOrderRelId, 1);
		}else{
			String title;
			Order order;
			//总订单中未删除的所有子订单人数减1
			orderMapper.changeTotalPeopleInExistOrders(-1, customerOrderRel.getOrdersTotalId());
			//找出该客人在总订单下对应的未删除的子订单
			List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findExistOrdersByCustomerIdAndOrdersTotalId(customerOrderRel.getCustomerId(), customerOrderRel.getOrdersTotalId());
			//遍历每一条子订单
			for(CustomerOrderRel cor : customerOrderRelList){
				order = cor.getOrder();
				if(!"".equals(order.getTourId())){
					/* 如果子订单已组团，将订单下的该客人置为取消中 */
					customerOrderRelMapper.changeCustomerState(cor.getId(), 5);
					CustomerOrderRel cuor=new CustomerOrderRel();
					cuor.setOrderId(order.getId());
					cuor.setIsDel(0);//不计算已经删除的客人
					int people =customerOrderRelMapper.findCountIsDelByOrderId(cuor);
					/*订单下 客人删除 订单申请删除*/
					if(people == 0){ 
						orderMapper.changeStateByOrderId(order.getId(), 4);
					}
					tourMapper.changeTotalPeople(-1,order.getTourId());
					//发送站内信
					title =  Constant.SYSNOTICE + Constant.CANCELOF_ORDER + order.getOrderNo()+'/'+order.getTourCode() + Constant.IN_STRING + cor.getCustomerTourNo() + Constant.CUSTOMERCODE;
					noticeService.sendMail(title, adminService.getCurrent().getId(), tourMapper.findById(order.getTourId()).getUserId());
				}else{
					/* 如果子订单没有组团，将子订单下的该客人置为已取消   */	
					customerOrderRelMapper.changeCustomerState(cor.getId(), 1);
					if(totalPeople == 0){ 
						orderMapper.changeStateByOrderId(order.getId(), 6);
						result = "all";
					}
				}
			}
		}
		return result;
	}
	/**
	 * PeerUser 删除客人，删除掉这个客人和关系表数据
	 * */
	public String delCustomer(String customerOrderRelId) {
		/* 总订单人数减1，总订单客人状态置为删除  */
		PeerUser peerUser=peerUserService.getCurrent();
		String result = ""; 
		CustomerOrderRel customerOrderRel = customerOrderRelMapper.findById(customerOrderRelId);
		if(customerOrderRel.getOrderId()!=null){
			if(customerOrderRel.getGuestRoomType().equals("King Bed")||customerOrderRel.getGuestRoomType().equals("Twin Bed")){
				//重置相关房型
				CustomerOrderRel crel=new CustomerOrderRel();
				crel.setOrdersTotalId(customerOrderRel.getOrdersTotalId());
				crel.setRoomNumber(customerOrderRel.getRoomNumber());
				List<CustomerOrderRel> crelList=customerOrderRelMapper.find(crel);
				for(int i=0;i<crelList.size();i++){
					CustomerOrderRel r=crelList.get(i);
					if(r.getCustomerId()==customerOrderRel.getCustomerId()){
						CustomerFlight customerFlight=new CustomerFlight();
						customerFlight.setCustomerOrderRelId(r.getId());
						List<CustomerFlight> fl=customerFlightMapper.find(customerFlight);
						for(int a=0;a<fl.size();a++){
							customerFlightMapper.removeById(fl.get(a).getId());//删除航班
						}
						customerOrderRelMapper.deleteId(r.getId());//删除关系表
					}else{
						//只清空同住人房型，不删除关系及航班
						CustomerOrderRel rl=new CustomerOrderRel();
						rl.setId(r.getId());
						rl.setOrdersTotalId(r.getOrdersTotalId());
						rl.setCustomerId(r.getCustomerId());
						rl.setContactFlag(0);
						rl.setCustomerOrderNo(r.getCustomerOrderNo());
						customerOrderRelMapper.save(rl);
					}
					
				}
			}else{
				//个人的不涉及其他人的房型，直接删除航班及关系表
				CustomerFlight customerFlight=new CustomerFlight();
				customerFlight.setCustomerOrderRelId(customerOrderRel.getId());
				List<CustomerFlight> fl=customerFlightMapper.find(customerFlight);
				for(int a=0;a<fl.size();a++){
					customerFlightMapper.removeById(fl.get(a).getId());//删除航班
				}
				customerOrderRelMapper.deleteId(customerOrderRel.getId());//删除关系表
			}
		}else{
			//下单时候的删除及新添加客人的删除，不涉及航班
			int totalPeople = customerOrderRelMapper.countExistCustomersInOrdersTotal(customerOrderRel.getOrdersTotalId());
			customerOrderRel.setIsDel(5);
			customerOrderRel.setOrdersTotalId(peerUser.getPeerUserId());
			customerOrderRel.setCustomerId(customerOrderRel.getCustomerId());
			List<CustomerOrderRel> relLists=customerOrderRelMapper.findRelByPeerUserId(customerOrderRel);
			customerOrderRelMapper.deleteId(customerOrderRelId);//删除客人和订单的关系
			if(relLists.size()==0){
				customerMapper.deleteId(customerOrderRel.getCustomerId());//删除客人
			}
		}
			result = "all";
		return result;
	}
	
	/*
	 * 确认客人取消
	 */
	@Override
	public void confirmCancelCustomer(CustomerOrderRel customerOrderRel){
		//将该客人置为已取消
		customerOrderRelMapper.changeCustomerState(customerOrderRel.getId(), 1); 
		int totalPeople = customerOrderRelMapper.countExistCustomersInOrdersTotal(customerOrderRel.getOrdersTotalId());
		if(totalPeople == 0){
			//如果客人取消完，取消订单	
			orderMapper.changeStateByOrderId(customerOrderRel.getOrderId(), 5); 
		}
	}
	
	/*
	 * 团下客人取消
	 */
	@Override
	public void confirmCancelTourCustomer(CustomerOrderRel customerOrderRel){
		//将该客人置为已取消
		customerOrderRelMapper.changeCustomerState(customerOrderRel.getId(), 1); 
		//查询客人是否取消完
		int totalPeople = customerOrderRelMapper.counTourCustomersByOrderId(customerOrderRel.getOrderId());
		if(totalPeople == 0){
			//如果客人取消完，取消订单	
			orderMapper.changeStateByOrderId(customerOrderRel.getOrderId(), 5); 
		}
	}
	
	/*
	 * 恢复客人功能(agent的操作)
	 */
	@Override
	@Transactional
	public String recoverCustomer(String customerOrderRelId){
		/* 总订单人数加1，客人的总订单状态置为0  */
		CustomerOrderRel customerOrderRel = customerOrderRelMapper.findById(customerOrderRelId);
		int totalPeople = customerOrderRelMapper.countExistCustomersInOrdersTotal(customerOrderRel.getOrdersTotalId());
		ordersTotalMapper.changeTotalPeople(1, customerOrderRel.getOrdersTotalId());
		customerOrderRelMapper.setContactFlagByCusIdAndOrToId(0, customerOrderRel.getCustomerId(), customerOrderRel.getOrdersTotalId());
		String result = ""; 
		String title;
		Order order;
		
		if("".equals(customerOrderRel.getOrderId())){
		//如果总订单没有子订单，直接恢复客人状态
			customerOrderRelMapper.changeCustomerState(customerOrderRelId, 0);
		}else{
			//遍历子订单
			List<CustomerOrderRel> customerOrderRelList;
			if(totalPeople == 0){
				//总订单下所有订单人数加1
				orderMapper.changeTotalPeopleByOrdersTotalId(1, customerOrderRel.getOrdersTotalId());
				//找出该客人在总订单下对应的所有子订单
				customerOrderRelList = customerOrderRelMapper.findAllOrdersByCustomerIdAndOrdersTotalId(customerOrderRel.getCustomerId(), customerOrderRel.getOrdersTotalId());
			}else{
				//总订单中未删除的所有子订单人数加1
				orderMapper.changeTotalPeopleInExistOrders(1, customerOrderRel.getOrdersTotalId());
				//找出该客人在总订单下对应的未删除的子订单
				customerOrderRelList = customerOrderRelMapper.findExistOrdersByCustomerIdAndOrdersTotalId(customerOrderRel.getCustomerId(), customerOrderRel.getOrdersTotalId());
			}
			for(CustomerOrderRel cor : customerOrderRelList){
				order = cor.getOrder();
				if(!"".equals(order.getTourId())){
					if(order.getState()!=4){//4 申请取消
						/* 如果子订单已组团，并且该客人不是取消中，则将订单下的该客人置为恢复中  */
						customerOrderRelMapper.changeCustomerState(cor.getId(), 3);
						/*如果订单取消，设置订单取消中*/
						if(order.getState()==5){
							orderMapper.changeStateByOrderId(order.getId(), 7);
						}
						//修改团人数
						tourMapper.changeTotalPeople(1,order.getTourId());
						//发送站内信
						title =  Constant.SYSNOTICE + Constant.RECOVER_STRING + order.getOrderNo()+'/'+order.getTourCode() + Constant.IN_STRING + cor.getCustomerTourNo() + Constant.CUSTOMERCODE;
						noticeService.sendMail(title, adminService.getCurrent().getId(), tourMapper.findById(order.getTourId()).getUserId());
					}
				}else{
					customerOrderRelMapper.changeCustomerState(cor.getId(), 0);
					if(totalPeople == 0){
						orderMapper.changeStateByOrderId(order.getId(), 0);
						result = "all";
					}
				}
			}
		}
		return result;
	}
	
	/*
	 * 确认恢复客人
	 */
	@Override
	public void confirmRecoverCustomer(CustomerOrderRel customerOrderRel){
		//将该客人置为正常
		customerOrderRelMapper.changeCustomerState(customerOrderRel.getId(), 0); 
		Order order = orderMapper.findById(customerOrderRel.getOrderId());
		//如果订单已取消，恢复订单
		if(order.getState() > 3 && order.getState() < 7){
			orderMapper.changeStateByOrderId(customerOrderRel.getOrderId(), 2); 
		}
	}
	
	/*
	 * 已组团订单
	 * 团下恢复客人
	 */
	@Override
	public void confirmRecoverTourCustomer(CustomerOrderRel customerOrderRel){
		//将该客人置为正常
		customerOrderRelMapper.changeCustomerState(customerOrderRel.getId(), 0); 
		Order order = orderMapper.findById(customerOrderRel.getOrderId());
		//如果订单已取消，恢复订单
		if(order.getState() > 3 && order.getState() <= 7){
			orderMapper.changeStateByOrderId(customerOrderRel.getOrderId(), 2); 
		}
	}
	
	@Override
	public List<Order> find(Order order) {
		return orderMapper.find(order);
	}

	@Override
	public List<Order> findUserOfOrder(Order order) {
		return orderMapper.findUserOfOrder(order);
	}
	
	/*
	 * 给matrix里添加add
	 */
	private void addItem(List matrix,List add){
		if(add != null){
			matrix.addAll(add);
		}
	}

	@Override
	public List<Order> findOrderOfPayOrCost(Order order) {
		return orderMapper.findOrderOfPayOrCost(order);
	}

	@Override
	public Order findOrderProfit(Order order) {
		return orderMapper.findOrderProfit(order);
	}

	@Override
	public Page<Order> findOrderOfTourTaxPage(Order order, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<Order> page = orderMapper.findOrderOfTourTaxPage(order, pageable);
        int pageCount = orderMapper.findOrderOfTourTaxPageCount(order, pageable);
        return new Page<Order>(page, pageCount, pageable);
	}


	@Override
	@Transactional
	public void billOrdersProfitCredit(OrdersTotal ordersTotal,List<Order> orderList,SettlementTotalVO settlementTotalVO) {
			if(orderList!=null&&orderList.size()!=0){
				Admin agent = adminService.getCurrent();   //获取当前操作用户的部门
				Dept deptForAgent = deptMapper.findById(agent.getDeptId());
				for(Order order:orderList){
					Tour tour = tourMapper.findById(order.getTourId());
					Dept deptForOp = deptMapper.findById(adminService.findById(tour.getUserId()).getDeptId());
				    	int bg=order.getPriceExpression().compareTo(new BigDecimal(0.00));
				    	boolean blean= compareDate(tour.getArriveDateTime());//抵达日期2016-01-01 后 不发 5%
					if(deptForAgent.getDeptId()!=deptForOp.getDeptId()&&(bg!=0)&&order.getState()!=5&&order.getState()!=6&&blean){
						String rateOfCurrencyId = settlementTotalVO.getSupplierCheck().getToRateOfCurrencyId(); //agent--->op
						RateOfCurrency rateOfCurrency = rateOfCurrencyMapper.findById(rateOfCurrencyId); 
						//获取两部门之间的汇率
						/*RateOfCurrency rateOfCurrency = new RateOfCurrency();
						rateOfCurrency.setCurrencyId(deptForAgent.getCurrencyTypeId());
						rateOfCurrency.setToCurrencyId(deptForOp.getCurrencyTypeId());
						rateOfCurrency.setIsAvailable(0);
						rateOfCurrency = rateOfCurrencyMapper.getRate(rateOfCurrency);*/
						
						InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
						invoiceAndCreditTemp.setDeptId(agent.getDeptId());
						Integer businessNo =invoiceAndCreditMapper.getBusinessNo(deptForAgent.getDeptId());//最大业务编号
						InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
						invoiceAndCredit.setDeptId(agent.getDeptId());
						invoiceAndCredit.setPrefix(deptForAgent.getDeptName());
						invoiceAndCredit.setBusinessNo(businessNo);
						invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
						//invoice月份
						Calendar calendar   =   new   GregorianCalendar(); 
					    calendar.setTime(tour.getArriveDateTime());
					    calendar.add(Calendar.MONTH, +1);
						 //把当前日期向后推迟一个月
					    //calendar.add(Calendar.MONTH, +1); //把结算日期
						invoiceAndCredit.setCreateDate(new Date());
						invoiceAndCredit.setMonth(calendar.getTime());
						invoiceAndCredit.setBillToDeptId(deptForOp.getDeptId());
						invoiceAndCredit.setBillToReceiver(deptForOp.getDeptName());
						invoiceAndCredit.setConfirmStatus(Constant.CONFIRMSTATUS[4]); 
						invoiceAndCredit.setConfirmRemarks(Constant.AUTOCONFIRMREMARKS);
						invoiceAndCredit.setTourCode(tour.getTourCode());
						invoiceAndCredit.setTourId(tour.getTourId());
						invoiceAndCredit.setIfBeginningValue(1);												
						invoiceAndCredit.setRateOfCurrencyId(rateOfCurrency.getId());
						//订单利润的5%(该利润已经过汇率转换)
						//BigDecimal enterCurrency = order.getProfit().multiply(Constant.OP_PROFIT).setScale(2, BigDecimal.ROUND_HALF_UP);
						BigDecimal enterCurrency = order.getProfit().multiply(order.getPriceExpression()).setScale(2, BigDecimal.ROUND_HALF_UP);
						//判断利润是正是负
						if(order.getProfit().compareTo(new BigDecimal(0))==1){
							invoiceAndCredit.setRecordType(Constant.CREDIT);
							invoiceAndCredit.setEnterCurrency(enterCurrency);
						}else {
							invoiceAndCredit.setRecordType(Constant.INVOICE);
							invoiceAndCredit.setEnterCurrency(new BigDecimal(0).subtract(enterCurrency));
						}
						
						//String remarks = order.getOrderNo()+Constant.ORDERPROFIT+order.getProfit().setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"*"+Constant.OP_PROFIT.setScale(2, BigDecimal.ROUND_HALF_UP); //(子单号订单利润：总利润*0.05)
						String remarks = order.getOrderNo()+Constant.ORDERPROFIT+order.getProfit().setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"*"+order.getPriceExpression(); //(子单号订单利润：总利润*0.05)
						invoiceAndCredit.setDollar(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));
						List<InvoiceAndCreditItems>  listInvoiceAndCreditItems = new ArrayList<InvoiceAndCreditItems>();
						InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
						invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
						invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
						invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
						invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
						invoiceAndCreditItems.setIfVerified(2); //已审核
						invoiceAndCreditItems.setAmount(invoiceAndCredit.getEnterCurrency());
						invoiceAndCreditItems.setDollarAmount(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));								
						invoiceAndCreditItems.setRemarks(remarks);
						invoiceAndCreditItems.setDescription(order.getUserName());
						listInvoiceAndCreditItems.add(invoiceAndCreditItems);
						invoiceAndCreditItemsMapper.save(invoiceAndCreditItems);
						
						invoiceAndCredit.setListInvoiceAndCreditItems(listInvoiceAndCreditItems);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
						invoiceAndCredit.setRemarks(remarks);
						invoiceAndCreditMapper.save(invoiceAndCredit);
						
						//保存对账信息
						AccountRecord account1=new AccountRecord();			//本部门账
						AccountRecord account2=new AccountRecord();			//对方部门账
						//本部门 部门 记录
						account1.setAccountRecordId(UUIDGenerator.getUUID());
						account1.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						account1.setBusinessNo(invoiceAndCredit.getBusinessNo());
						account1.setDeptId(invoiceAndCredit.getDeptId());
						account1.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
						account1.setBillToReceiver(invoiceAndCredit.getPrefix());
						account1.setCreateDate(invoiceAndCredit.getCreateDate());
						String month=simpleDateFormat.format(invoiceAndCredit.getMonth());
						account1.setMonth(month);
						account1.setRemarks(invoiceAndCredit.getRemarks());
						account1.setTourCode(invoiceAndCredit.getTourCode());
						account1.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
						//对方部门 记录
						account2.setAccountRecordId(UUIDGenerator.getUUID());
						account2.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						account2.setBusinessNo(invoiceAndCredit.getBusinessNo());
						account2.setDeptId(invoiceAndCredit.getBillToDeptId());
						account2.setBillToReceiver(invoiceAndCredit.getPrefix());
						account2.setCreateDate(invoiceAndCredit.getCreateDate());
						account2.setMonth(month);    //日期格式转化
						account2.setRemarks(invoiceAndCredit.getRemarks());
						account2.setTourCode(invoiceAndCredit.getTourCode());
						account2.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
						account2.setBillToDeptId(invoiceAndCredit.getDeptId());
						
						BigDecimal exDollar = invoiceAndCredit.getEnterCurrency()
								.multiply(rateOfCurrency.getRateUp())
								.divide(rateOfCurrency.getRateDown(), 2,BigDecimal.ROUND_HALF_UP);
						if(invoiceAndCredit.getRecordType()==Constant.INVOICE){
							account2.setReceivableCurrency(new BigDecimal(0).subtract(exDollar));
							account2.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
							account2.setReceivedAmount(new BigDecimal(0).subtract(invoiceAndCredit.getEnterCurrency()));
							
							account1.setReceivableCurrency(invoiceAndCredit.getEnterCurrency());
							account1.setReceivableAmount(invoiceAndCredit.getDollar());		//应收
							account1.setReceivedAmount(exDollar);
							}
						if(invoiceAndCredit.getRecordType()==Constant.CREDIT){
							account2.setReceivableCurrency(exDollar);
							account2.setReceivableAmount(invoiceAndCredit.getDollar());		//应收
							account2.setReceivedAmount(invoiceAndCredit.getEnterCurrency());
							
							account1.setReceivableCurrency(new BigDecimal(0).subtract(invoiceAndCredit.getEnterCurrency()));
							account1.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
							account1.setReceivedAmount(new BigDecimal(0).subtract(exDollar));
						}
						accountRecordMapper.save(account1);
						accountRecordMapper.save(account2);
						
					}
					order.setCheckTime(new Date());
					order.setTax(4);
					orderMapper.update(order);
				}
			}
	}
					/*String tourId = order.getTourId();
					Tour tour = tourMapper.findById(tourId);
					Admin op = adminService.findById(tour.getUserId());
					Dept toDept = deptMapper.findById(op.getDeptId()); 
					
					//获取汇率
					RateOfCurrency rateOfCurrency = new RateOfCurrency();
					rateOfCurrency.setCurrencyId(deptMapper.findById(agent.getDeptId()).getCurrencyTypeId());
					rateOfCurrency.setToCurrencyId(deptMapper.findById(op.getDeptId()).getCurrencyTypeId());
					rateOfCurrency.setIsAvailable(0);
					rateOfCurrency = rateOfCurrencyMapper.getRate(rateOfCurrency);
					
				   if(dept.getDeptId()!=toDept.getDeptId()){
						InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
						invoiceAndCreditTemp.setDeptId(agent.getDeptId());
						Integer businessNo =invoiceAndCreditMapper.getBusinessNo(dept.getDeptId());//最大业务编号
						InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
						invoiceAndCredit.setDeptId(agent.getDeptId());
						invoiceAndCredit.setPrefix(dept.getDeptName());
						invoiceAndCredit.setBusinessNo(businessNo);
						invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
						//invoice月份
						Calendar calendar   =   Calendar.getInstance();
					    calendar.set(Calendar.MONTH,calendar.get(Calendar.MONTH)+1);  //把当前日期向后推迟一个月
					    //calendar.add(Calendar.MONTH, +1); //把结算日期
						invoiceAndCredit.setCreateDate(new Date());
						invoiceAndCredit.setMonth(calendar.getTime());
						invoiceAndCredit.setBillToDeptId(toDept.getDeptId());
						invoiceAndCredit.setBillToReceiver(toDept.getDeptName());
						invoiceAndCredit.setConfirmStatus(Constant.CONFIRMSTATUS[4]); 
						invoiceAndCredit.setConfirmRemarks(Constant.AUTOCONFIRMREMARKS);
						invoiceAndCredit.setTourCode(tour.getTourCode());
						invoiceAndCredit.setTourId(tour.getTourId());
						invoiceAndCredit.setIfBeginningValue(1);												
						invoiceAndCredit.setRateOfCurrencyId(rateOfCurrency.getId());
						invoiceAndCredit.setRecordType(Constant.CREDIT);
						invoiceAndCredit.setEnterCurrency(enterCurrency);
						invoiceAndCredit.setDollar(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));
						invoiceAndCredit.setListInvoiceAndCreditItems(listInvoiceAndCreditItems);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
						invoiceAndCredit.setRemarks(ordersTotal.getOrderNumber()+"-"+order.getOrderNo()+order.getTourCode()+Constant.ORDERPROFIT+order.getProfit().setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"*"+Constant.OP_PROFIT.setScale(2, BigDecimal.ROUND_HALF_UP));
						invoiceAndCreditMapper.save(invoiceAndCredit);
						
						BigDecimal enterCurrency = new BigDecimal(0);
						List<InvoiceAndCreditItems>  listInvoiceAndCreditItems = new ArrayList<InvoiceAndCreditItems>();
						for(Order orders : orderList){
								InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
								invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
								invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
								invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
								invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
								invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
								invoiceAndCreditItems.setIfVerified(2); //已审核
								//已转为agent部门的币种，不用在转化
								invoiceAndCreditItems.setAmount(orders.getProfit().multiply(Constant.OP_PROFIT).setScale(2, BigDecimal.ROUND_HALF_UP));
								enterCurrency = enterCurrency.add(invoiceAndCreditItems.getAmount());
								invoiceAndCreditItems.setDollarAmount(orders.getProfit().multiply(Constant.OP_PROFIT).divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));								
								invoiceAndCreditItems.setRemarks(orders.getProfit().setScale(2, BigDecimal.ROUND_HALF_UP)+Constant.ORDERPROFIT);
								invoiceAndCreditItems.setDescription(agent.getName());
								listInvoiceAndCreditItems.add(invoiceAndCreditItems);
						}
						invoiceAndCredit.setEnterCurrency(enterCurrency);
						invoiceAndCredit.setDollar(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));
						invoiceAndCredit.setListInvoiceAndCreditItems(listInvoiceAndCreditItems);
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
						invoiceAndCredit.setRemarks(ordersTotal.getOrderNumber()+"-"+order.getOrderNo()+order.getTourCode()+Constant.ORDERPROFIT+order.getProfit().setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"*"+Constant.OP_PROFIT.setScale(2, BigDecimal.ROUND_HALF_UP));
						invoiceAndCreditMapper.save(invoiceAndCredit);
						for(InvoiceAndCreditItems invoiceItem:invoiceAndCredit.getListInvoiceAndCreditItems()){
							invoiceAndCreditItemsMapper.save(invoiceItem);
						}
						
						AccountRecord account1=new AccountRecord();			//本部门账
						AccountRecord account2=new AccountRecord();			//对方部门账
						//本部门 部门 记录
						account1.setAccountRecordId(UUIDGenerator.getUUID());
						account1.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						account1.setBusinessNo(invoiceAndCredit.getBusinessNo());
						account1.setDeptId(invoiceAndCredit.getDeptId());
						account1.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
						account1.setBillToReceiver(invoiceAndCredit.getPrefix());
						account1.setCreateDate(invoiceAndCredit.getCreateDate());
						String month=simpleDateFormat.format(invoiceAndCredit.getMonth());
						account1.setMonth(month);
						account1.setRemarks(invoiceAndCredit.getRemarks());
						account1.setTourCode(invoiceAndCredit.getTourCode());
						account1.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
						//对方部门 记录
						account2.setAccountRecordId(UUIDGenerator.getUUID());
						account2.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						account2.setBusinessNo(invoiceAndCredit.getBusinessNo());
						account2.setDeptId(invoiceAndCredit.getBillToDeptId());
						account2.setBillToReceiver(invoiceAndCredit.getPrefix());
						account2.setCreateDate(invoiceAndCredit.getCreateDate());
						account2.setMonth(month);    //日期格式转化
						account2.setRemarks(invoiceAndCredit.getRemarks());
						account2.setTourCode(invoiceAndCredit.getTourCode());
						account2.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
						account2.setBillToDeptId(invoiceAndCredit.getDeptId());
						
						BigDecimal exDollar = invoiceAndCredit.getEnterCurrency()
								.multiply(rateOfCurrency.getRateUp())
								.divide(rateOfCurrency.getRateDown(), 2,BigDecimal.ROUND_HALF_UP);
						if(invoiceAndCredit.getRecordType()==Constant.CREDIT){
							account2.setReceivableCurrency(invoiceAndCredit.getEnterCurrency());//应收本货币
							account2.setReceivableAmount(invoiceAndCredit.getDollar());		//应收美元
							account1.setReceivableCurrency(new BigDecimal(0).subtract(exDollar));
							account1.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
							}
						if(invoiceAndCredit.getRecordType()==Constant.INVOICE){
							account1.setReceivableCurrency(invoiceAndCredit.getEnterCurrency());//应收本货币
							account1.setReceivableAmount(invoiceAndCredit.getDollar());		//应收美元
							account2.setReceivableCurrency(new BigDecimal(0).subtract(exDollar));
							account2.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
						}
						accountRecordMapper.save(account1);
						accountRecordMapper.save(account2);
					}
				}*/
	
		//变更单发送5%操作团利润，本部门不发送
		@Transactional
		@Override
		public void billOrdersChangeProfitCredit(String[] orderIds,String toRateOfCurrencyId){
			Admin agent = adminService.getCurrent();
			Dept deptForAgent = deptMapper.findById(agent.getDeptId());
			RateOfCurrency rateOfCurrency = rateOfCurrencyMapper.findById(toRateOfCurrencyId);
			List<String> orderIdList = new ArrayList<String>();
			for(String orderId:orderIds){
				if(!orderIdList.contains(orderId)){
					orderIdList.add(orderId);
				}
			}
			for(String orderId:orderIdList){
				//找出该订单下的所有可以结算的变更单
				List<SupplierPriceRemark> supplierPriceRemarks = supplierPriceRemarkMapper.findSupplierPriceRemarkByOrderId(orderId);
				//计算未结算变更单的金额
				BigDecimal totalDifference = new BigDecimal(0);
				
				for(SupplierPriceRemark supplierPriceRemark:supplierPriceRemarks){
					totalDifference = totalDifference.add(supplierPriceRemark.getDifferenceSum());
					supplierPriceRemark.setSprCheck(5);
					supplierPriceRemarkMapper.update(supplierPriceRemark);
				}
				
				Order order = orderMapper.findById(orderId);
				TourType tourType=new TourType();
				if(order!=null&&order.getTourTypeId()!=null){
					 tourType=tourTypeMapper.findById(order.getTourTypeId());
				}
				
				//	OrdersTotal ordersTotal = ordersTotalMapper.findById(order.getOrdersTotalId());
					Tour tour = tourMapper.findById(order.getTourId());
					Dept deptForOp = deptMapper.findById(adminService.findById(tour.getUserId()).getDeptId());
					//获取汇率
					/*RateOfCurrency rateOfCurrency = new RateOfCurrency();
					rateOfCurrency.setCurrencyId(deptForAgent.getCurrencyTypeId());
					rateOfCurrency.setToCurrencyId(deptForOp.getCurrencyTypeId());
					rateOfCurrency.setIsAvailable(0);
					rateOfCurrency = rateOfCurrencyMapper.getRate(rateOfCurrency);*/
					 int bg=tourType.getPriceExpression().compareTo(new BigDecimal(0.00));
					 boolean blean= compareDate(tour.getArriveDateTime());//抵达日期2016-01-01 后 不发 5%
					if(deptForAgent.getDeptId()!=deptForOp.getDeptId()&&(bg!=0)&&order.getState()!=5&&order.getState()!=6&&blean){
						InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
						invoiceAndCreditTemp.setDeptId(agent.getDeptId());
						Integer businessNo =invoiceAndCreditMapper.getBusinessNo(agent.getDeptId());
						
						InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
						invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
						invoiceAndCredit.setDeptId(agent.getDeptId());
						invoiceAndCredit.setPrefix(deptForAgent.getDeptName());
						invoiceAndCredit.setBusinessNo(businessNo);
						invoiceAndCredit.setCreateDate(new Date());
						SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
						Date monthForDate = supplierPriceRemarks.get(supplierPriceRemarks.size()-1).getInsertTime();
						invoiceAndCredit.setMonth(monthForDate);//不对
						invoiceAndCredit.setIfBeginningValue(1);
						invoiceAndCredit.setBillToDeptId(deptForOp.getDeptId());
						invoiceAndCredit.setBillToReceiver(deptForOp.getDeptName());
						invoiceAndCredit.setConfirmStatus(Constant.CONFIRMSTATUS[4]);
						invoiceAndCredit.setConfirmRemarks(Constant.AUTOCONFIRMREMARKS);
						invoiceAndCredit.setTourCode(tour.getTourCode());
						invoiceAndCredit.setTourId(tour.getTourId());
						invoiceAndCredit.setRateOfCurrencyId(rateOfCurrency.getId());
						BigDecimal currency = totalDifference.multiply(rateOfCurrency.getRateDown());
						currency = currency.divide(rateOfCurrency.getRateUp(),2,BigDecimal.ROUND_HALF_UP);
						if(totalDifference.compareTo(new BigDecimal(0))==-1){
							invoiceAndCredit.setRecordType(Constant.CREDIT);
							invoiceAndCredit.setEnterCurrency(new BigDecimal(0).subtract(currency).multiply(tourType.getPriceExpression()).setScale(2, BigDecimal.ROUND_HALF_UP));
						}else {
							invoiceAndCredit.setRecordType(Constant.INVOICE);
							invoiceAndCredit.setEnterCurrency(currency.multiply(tourType.getPriceExpression()).setScale(2, BigDecimal.ROUND_HALF_UP));//本invoice或credit的输入金额（本位币）
						}
						
						/*if(order.getProfit().compareTo(new BigDecimal(0))==1){
							invoiceAndCredit.setRecordType(Constant.CREDIT);
							invoiceAndCredit.setEnterCurrency(enterCurrency);
						}else {
							invoiceAndCredit.setRecordType(Constant.INVOICE);
							invoiceAndCredit.setEnterCurrency(new BigDecimal(0).subtract(enterCurrency));
						}*/
						invoiceAndCredit.setDollar(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate(),2));//本invoice或credit的输入金额（美元）
						
						//总单号-子单号-变更利润:biangenglirun*0.05
						String remarks = order.getOrderNo()+Constant.EXCHANGEDPROFITFORMONTH+":"+currency.setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"*"+tourType.getPriceExpression();
						invoiceAndCredit.setRemarks(remarks);
						InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
						invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
						invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
						invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
						invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
						//invoiceAndCreditItems.setIfBeginningValue(1);
						invoiceAndCreditItems.setIfVerified(2);
						invoiceAndCreditItems.setAmount(invoiceAndCredit.getEnterCurrency()); 
						invoiceAndCreditItems.setDollarAmount(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));
						//总单-子单-变更金额*0.05
						invoiceAndCreditItems.setRemarks(remarks);
						invoiceAndCreditItems.setDescription(agent.getUsername());
								
						invoiceAndCreditMapper.save(invoiceAndCredit);
						invoiceAndCreditItemsMapper.save(invoiceAndCreditItems);
						
						AccountRecord account1=new AccountRecord();			//本部门账
						AccountRecord account2=new AccountRecord();			//对方部门账
						//本部门 部门 记录
						account1.setAccountRecordId(UUIDGenerator.getUUID());
						account1.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						account1.setBusinessNo(invoiceAndCredit.getBusinessNo());
						account1.setDeptId(invoiceAndCredit.getDeptId());
						account1.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
						account1.setBillToReceiver(invoiceAndCredit.getPrefix());
						account1.setCreateDate(invoiceAndCredit.getCreateDate());
						String month=simpleDateFormat.format(invoiceAndCredit.getMonth()).substring(0, 7);
						account1.setMonth(month);
						account1.setRemarks(invoiceAndCredit.getRemarks());
						account1.setTourCode(invoiceAndCredit.getTourCode());
						account1.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
						//对方部门 记录
						account2.setAccountRecordId(UUIDGenerator.getUUID());
						account2.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
						account2.setBusinessNo(invoiceAndCredit.getBusinessNo());
						account2.setDeptId(invoiceAndCredit.getBillToDeptId());
						account2.setBillToReceiver(invoiceAndCredit.getPrefix());
						account2.setCreateDate(invoiceAndCredit.getCreateDate());
						account2.setMonth(month);
						account2.setRemarks(invoiceAndCredit.getRemarks());
						account2.setTourCode(invoiceAndCredit.getTourCode());
						account2.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
						account2.setBillToDeptId(invoiceAndCredit.getDeptId());
						
						BigDecimal exDollar = invoiceAndCredit.getEnterCurrency()
								.multiply(rateOfCurrency.getRateUp())
								.divide(rateOfCurrency.getRateDown(), 2,BigDecimal.ROUND_HALF_UP);
						
						if(invoiceAndCredit.getRecordType().equals(Constant.CREDIT)){ //如果为invoice说明该金额为正数
							account2.setReceivableCurrency(exDollar);
							account2.setReceivableAmount(invoiceAndCredit.getDollar());		//应收
							account2.setReceivedAmount(invoiceAndCredit.getEnterCurrency());
							
							account1.setReceivableCurrency(new BigDecimal(0).subtract(invoiceAndCredit.getEnterCurrency()));
							account1.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
							account1.setReceivedAmount(new BigDecimal(0).subtract(exDollar));
						}
						if(invoiceAndCredit.getRecordType().equals(Constant.INVOICE)){//如果为credit说明该金额为负数
							account2.setReceivableCurrency(new BigDecimal(0).subtract(exDollar));
							account2.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
							account2.setReceivedAmount(new BigDecimal(0).subtract(invoiceAndCredit.getEnterCurrency()));
							
							account1.setReceivableCurrency(invoiceAndCredit.getEnterCurrency());
							account1.setReceivableAmount(invoiceAndCredit.getDollar());		//应收
							account1.setReceivedAmount(exDollar);
						}
						accountRecordMapper.save(account1);
						accountRecordMapper.save(account2);
				}
			}
		}
			/*supplierPriceRemark.setSprCheck(5);   //设置为已结算状态
			supplierPriceRemarkMapper.update(supplierPriceRemark);
			Admin agent = adminService.getCurrent();
			Dept dept = deptMapper.findById(agent.getDeptId());
			
			Tour tour = tourMapper.findById(supplierPriceRemark.getTourId());
			Admin op = adminService.findById(tour.getUserId());
			Dept toDept = deptMapper.findById(op.getDeptId());
			//获取汇率
			RateOfCurrency rateOfCurrency = new RateOfCurrency();
			rateOfCurrency.setCurrencyId(deptMapper.findById(agent.getDeptId()).getCurrencyTypeId());
			rateOfCurrency.setToCurrencyId(deptMapper.findById(op.getDeptId()).getCurrencyTypeId());
			rateOfCurrency.setIsAvailable(0);
			rateOfCurrency = rateOfCurrencyMapper.getRate(rateOfCurrency);
		    	if(dept.getDeptId()!=toDept.getDeptId()){
					InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
					invoiceAndCreditTemp.setDeptId(agent.getDeptId());
					Integer businessNo =invoiceAndCreditMapper.getBusinessNo(agent.getDeptId());
					
					InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
					invoiceAndCredit.setDeptId(agent.getDeptId());
					invoiceAndCredit.setPrefix(dept.getDeptName());
					invoiceAndCredit.setBusinessNo(businessNo);
					invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
					invoiceAndCredit.setCreateDate(new Date());
					SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
					invoiceAndCredit.setMonth(supplierPriceRemark.getInsertTime());
					invoiceAndCredit.setIfBeginningValue(1);
					invoiceAndCredit.setBillToDeptId(toDept.getDeptId());
					invoiceAndCredit.setBillToReceiver(toDept.getDeptName());
					invoiceAndCredit.setConfirmStatus(Constant.CONFIRMSTATUS[4]);
					invoiceAndCredit.setConfirmRemarks(Constant.AUTOCONFIRMREMARKS);
					invoiceAndCredit.setTourCode(tour.getTourCode());
					invoiceAndCredit.setTourId(tour.getTourId());
					invoiceAndCredit.setRateOfCurrencyId(rateOfCurrency.getId());
					if(supplierPriceRemark.getDifferenceSum().compareTo(new BigDecimal(0))==1){
						invoiceAndCredit.setRecordType(Constant.CREDIT);
					}else {
						invoiceAndCredit.setRecordType(Constant.INVOICE);
					}
					
					BigDecimal currency = supplierPriceRemark.getDifferenceSum().divide(rateOfCurrency.getRateDown()).multiply(rateOfCurrency.getRateUp());
					invoiceAndCredit.setEnterCurrency(currency.multiply(Constant.OP_PROFIT).setScale(2, BigDecimal.ROUND_HALF_UP));//本invoice或credit的输入金额（本位币）
					invoiceAndCredit.setDollar(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate()));//本invoice或credit的输入金额（美元）
					invoiceAndCredit.setRemarks(simpleDateFormat.format(tour.getArriveDateTime()).substring(0, 7)+Constant.EXCHANGEDPROFITFORMONTH+":"+currency.setScale(2, BigDecimal.ROUND_HALF_UP).toString()+"*"+Constant.OP_PROFIT.setScale(2, BigDecimal.ROUND_HALF_UP));
					
					
					InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
					invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
					invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
					invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
					invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
					invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
					//invoiceAndCreditItems.setIfBeginningValue(1);
					invoiceAndCreditItems.setIfVerified(2);
					invoiceAndCreditItems.setAmount(supplierPriceRemark.getDifferenceSum().multiply(rateOfCurrency.getRateUp()).multiply(Constant.OP_PROFIT).divide(rateOfCurrency.getRateDown(), 2, BigDecimal.ROUND_HALF_UP)); 
					invoiceAndCreditItems.setDollarAmount(supplierPriceRemark.getDifferenceSum().multiply(rateOfCurrency.getRateUp()).multiply(Constant.OP_PROFIT).divide(rateOfCurrency.getRateDown()).divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));
					invoiceAndCreditItems.setRemarks(Constant.EXCHANGEDPROFIT+":"+invoiceAndCreditItems.getAmount().setScale(2, BigDecimal.ROUND_HALF_UP)+"*"+Constant.OP_PROFIT);
					invoiceAndCreditItems.setDescription(agent.getUsername());
							
					invoiceAndCreditMapper.save(invoiceAndCredit);
					invoiceAndCreditItemsMapper.save(invoiceAndCreditItems);
					
					AccountRecord account1=new AccountRecord();			//本部门账
					AccountRecord account2=new AccountRecord();			//对方部门账
					//本部门 部门 记录
					account1.setAccountRecordId(UUIDGenerator.getUUID());
					account1.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
					account1.setBusinessNo(invoiceAndCredit.getBusinessNo());
					account1.setDeptId(invoiceAndCredit.getDeptId());
					account1.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
					account1.setBillToReceiver(invoiceAndCredit.getPrefix());
					account1.setCreateDate(invoiceAndCredit.getCreateDate());
					String month=simpleDateFormat.format(invoiceAndCredit.getMonth()).substring(0, 7);
					account1.setMonth(month);
					account1.setRemarks(invoiceAndCredit.getRemarks());
					account1.setTourCode(invoiceAndCredit.getTourCode());
					account1.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
					//对方部门 记录
					account2.setAccountRecordId(UUIDGenerator.getUUID());
					account2.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
					account2.setBusinessNo(invoiceAndCredit.getBusinessNo());
					account2.setDeptId(invoiceAndCredit.getBillToDeptId());
					account2.setBillToReceiver(invoiceAndCredit.getPrefix());
					account2.setCreateDate(invoiceAndCredit.getCreateDate());
					account2.setMonth(month);
					account2.setRemarks(invoiceAndCredit.getRemarks());
					account2.setTourCode(invoiceAndCredit.getTourCode());
					account2.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
					account2.setBillToDeptId(invoiceAndCredit.getDeptId());
					
					BigDecimal exDollar = invoiceAndCredit.getEnterCurrency()
							.multiply(rateOfCurrency.getRateUp())
							.divide(rateOfCurrency.getRateDown(), 2,BigDecimal.ROUND_HALF_UP);
					
					if(invoiceAndCredit.getRecordType().equals(Constant.CREDIT)){ //如果为invoice说明该金额为正数
						account1.setReceivableCurrency(invoiceAndCredit.getEnterCurrency());
						account1.setReceivableAmount(invoiceAndCredit.getDollar());		//应收
						account2.setReceivableCurrency(new BigDecimal(0).subtract(exDollar));
						account2.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
					}
					if(invoiceAndCredit.getRecordType().equals(Constant.INVOICE)){//如果为credit说明该金额为负数
						account1.setReceivableCurrency(new BigDecimal(0).subtract(invoiceAndCredit.getEnterCurrency()));
						account1.setReceivableAmount(new BigDecimal(0).subtract(invoiceAndCredit.getDollar()));
						account2.setReceivableCurrency(exDollar);
						account2.setReceivableAmount(invoiceAndCredit.getDollar());		//应收
					}
					accountRecordMapper.save(account1);
					accountRecordMapper.save(account2);
			}*/

	@Override
	public Page<Order> findOrderOfRegionList(Order order, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<Order> page = orderMapper.findOrderOfRegionPage(order, pageable);
        int pageCount = orderMapper.findOrderOfRegionPageCount(order, pageable);
        return new Page<Order>(page, pageCount, pageable);
	}
	
	/**
	 * 给customerFlight设置ID和CustomerOrderRelID
	 * 添加入totalContainer List中
	 * 
	 * @param totalContainer
	 * @param customerFlightList
	 * @param customerOrderRelId
	 */
	private void setCustomerFlightList(List<CustomerFlight> totalContainer,List<CustomerFlight> customerFlightList,String customerOrderRelId){
		if(customerFlightList == null){
			CustomerFlight customerFlight = null;
			for(int index = 1; index <= 2; index++){
				customerFlight = new CustomerFlight();
				customerFlight.setId(UUIDGenerator.getUUID());
				customerFlight.setCustomerOrderRelId(customerOrderRelId);
				customerFlight.setOutOrEnter(index);
				if(index == 1){
					customerFlight.setIfPickUp(2);
				}else{
					customerFlight.setIfSendUp(2);
				}
				totalContainer.add(customerFlight);
			}
			return;
		}
		for(CustomerFlight customerFlight : customerFlightList){
			customerFlight.setId(UUIDGenerator.getUUID());
			customerFlight.setCustomerOrderRelId(customerOrderRelId);
			totalContainer.add(customerFlight);
		}
	}
	
	/**
	 * 
	 * @param totalList
	 * @param addList
	 */
	private void addToTotalList(List<OrderReceiveItem> totalList,List<OrderReceiveItem> addList){
		if(totalList != null && addList != null && addList.size() != 0){
			totalList.addAll(addList);
		}
	}
	
	/**
	 * 查看所以客人
	 */
	@Override
	public List<Order> findCustomerForTourId(String tourId) {
		return orderMapper.findCustomerForTourId(tourId);
	}

	@Override
	public List<Order> findByTourId(String tourId) {
		return orderMapper.findByTourId(tourId);
	}

	@Override
	public Order findCustomerForOrderId(String orderId) {
		return orderMapper.findCustomerForOrderId(orderId);
	}
	
	/**
	 * 根据总订单Id查找子订单
	 * @param orderTotalId
	 * @return
	 */
	@Override
	public List<Order> findChildOrderList(String ordersTotalId) {
		return orderMapper.findChildOrderList(ordersTotalId);
	}
	
	/**
	 * 查询一个总单下的子订单
	 */
	@Override
	public List<Order> findByOrdersTotalId(String ordersTotalId) {
		return orderMapper.findByOrdersTotalId(ordersTotalId);
	}

	@Override
	public Page<Order> findForGroupPage(Order order, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<Order> page = orderMapper.findForGroupPageForAgency(order, pageable);
        int pageCount = orderMapper.findForGroupPageCountForAgency(order, pageable);
        return new Page<Order>(page, pageCount, pageable);
	}

	@Override
	public TourOrderListVO findOrderSumPepole(Order order) {
		return orderMapper.findOrderSumPepole(order);
	}

	@Override
	public Order findRegionOrderSumPepole(Order order) {
		return orderMapper.findRegionOrderSumPepole(order);
	}

	@Override
	public Order findGroupOrderSumPepole(Order order) {
		return orderMapper.findGroupOrderSumPepole(order);
	}

	@Override
	public List<Order> findCustomerListByTourId(Order order) {
		return orderMapper.findCustomerListByTourId(order);
	}
	@Override
	public void changeTotalPeopleByOrderId(int change,String orderId) {
		orderMapper.changeTotalPeopleByOrderId(change, orderId);
	}

	@Override
	public List<Order> getOrderByCusId(String customerId) {
		return orderMapper.queryOrderByCusId(customerId);
	}

	@Override
	public List<Customer> importCustomer(File file) {
		List<Customer> customerList = new ArrayList<Customer>();
		try {
			HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(file));
			HSSFSheet sheet = workbook.getSheetAt(0); // 读取第一个工作簿
			HSSFRow row;
			HSSFCell cellLastName = null;
			HSSFCell cellFirstName = null;
			HSSFCell cellGender = null;
			HSSFCell cellBirth = null;
			HSSFCell cellNationality = null;
			HSSFCell cellPassport = null;
			HSSFCell cellExpiryDate = null;
			HSSFCell cellLanguage = null;
			HSSFCell cellRoom = null;
			HSSFCell cellPhone = null;
			HSSFCell cellEmail= null;
			HSSFCell cellAddress = null;
			HSSFRow hssfRow= sheet.getRow(1);
			if(sheet.getLastRowNum()<1||hssfRow.getPhysicalNumberOfCells()!=12){
				  List<Customer> customerForError = new ArrayList<Customer>();
				  Customer customerWithMessage = new Customer();
				  customerWithMessage.setMessage("Malformed");
				  customerForError.add(customerWithMessage);
				  return customerForError;
			}

			for (int j = sheet.getFirstRowNum()+1; j <= sheet.getLastRowNum(); j++) {
				row = sheet.getRow(j);
				cellLastName = row.getCell(0);
				cellFirstName = row.getCell(1);
				cellGender = row.getCell(2);
				cellBirth = row.getCell(3);
				cellNationality = row.getCell(4);
				cellPassport = row.getCell(5);
				cellPassport.setCellType(HSSFCell.CELL_TYPE_STRING);
				cellExpiryDate = row.getCell(6);
				cellLanguage = row.getCell(7);
				cellRoom = row.getCell(8);
				cellPhone = row.getCell(9);
				cellEmail = row.getCell(10);
				cellAddress = row.getCell(11);
				
				Customer customer = new Customer();
				customer.setLastName(cellLastName.getStringCellValue());
				customer.setFirstName(cellFirstName.getStringCellValue());
				if(cellGender.getStringCellValue().equalsIgnoreCase("f")){
					customer.setSex(1);
				}else if(cellGender.getStringCellValue().equalsIgnoreCase("m")){
					customer.setSex(2);
				}else{
					 List<Customer> customerForError = new ArrayList<Customer>();
					  Customer customerWithMessage = new Customer();
					  customerWithMessage.setMessage("Row"+(j+1)+"Column3");
					  customerForError.add(customerWithMessage);
					  return customerForError;
				}
				if(cellBirth.getCellType()!=3){
					if(cellBirth.getCellType()==0&&DateUtil.isCellDateFormatted(cellBirth)){
						  customer.setDateOfBirth(cellBirth.getDateCellValue());
						  
					  }else{
						  List<Customer> customerForError = new ArrayList<Customer>();
						  Customer customerWithMessage = new Customer();
						  customerWithMessage.setMessage("Row"+(j+1)+"Column4");
						  customerForError.add(customerWithMessage);
						  return customerForError;
					  }
				}else{
					customer.setDateOfBirth(cellBirth.getDateCellValue());
				}
				customer.setNationalityOfPassport(cellNationality.getStringCellValue());
				customer.setPassportNo(cellPassport.getStringCellValue());
				
				if(cellExpiryDate.getCellType()!=3){ 
				if(cellExpiryDate.getCellType()==0&&DateUtil.isCellDateFormatted(cellExpiryDate)){
					  customer.setExpireDateOfPassport(cellExpiryDate.getDateCellValue());
				  }else{
					  List<Customer> customerForError = new ArrayList<Customer>();
					  Customer customerWithMessage = new Customer();
					  customerWithMessage.setMessage("Row"+(j+1)+"Column7");
					  customerForError.add(customerWithMessage);
					  return customerForError;
				  }
				}else{
					customer.setExpireDateOfPassport(cellExpiryDate.getDateCellValue());
				}
				//获取输入信息进行数据库匹配
				if(cellLanguage!=null&&cellLanguage.getStringCellValue()!=null){
					Language languageTemp = new Language();
					languageTemp.setLanguage(cellLanguage.getStringCellValue());
					List<Language> languageList = languageMapper.find(languageTemp);
					if(languageList!=null){
						customer.setLanguageId(languageList.get(0).getLanguageId());
					}
					customer.setLanguage(languageList.get(0));
				}
				customer.setGuestRoomType(cellRoom.getStringCellValue());
				customer.setMobile(cellPhone.getStringCellValue());
				customer.setStreetAddress(cellAddress.getStringCellValue());
				customer.setEmail(cellEmail.getStringCellValue());
				customerList.add(customer);
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return customerList; 
		
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
        c1.set(2015,11,31);// 月份 0 开始计算
        c2.setTime(d2);  
      
        int result = c1.compareTo(c2);  
        if (result > 0)  
            return true;  
        else  
            return false;  
    }  
	
	@Override
	public Page<Order> findOrdersTaxPage(Order order, Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<Order> orderList = orderMapper.findOrdersTaxPage(order, pageable);
		int pageCount = orderMapper.findOrdersTaxPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}

	@Override
	public Order findSumPepoleAndPayOrCost(Order order) {
		return orderMapper.findSumPepoleAndPayOrCost(order);
	}

	@Override
	public List<Order> findOrderTaxPrint(Order order) {
		return orderMapper.findOrderTaxPrint(order);
	}

	@Override
	public Page<Order> findOrderTaxGroupPage(Order order, Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<Order> orderList = orderMapper.findOrderTaxGroupPage(order, pageable);
		int pageCount = orderMapper.findOrderTaxGroupPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}

	@Override
	public Order findGroupSumPepoleAndPayOrCost(Order order) {
		return orderMapper.findGroupSumPepoleAndPayOrCost(order);
	}

	@Override
	public List<Order> findGroupOrderTaxPrint(Order order) {
		return orderMapper.findGroupOrderTaxPrint(order);
	}

	@Override
	public List<Order> findTourOrderListVOPrint(Order order) {
		return orderMapper.findTourOrderListVOPrint(order);
	}

	@Override
	public Order findAgentSumPayOrCost(Order order) {
		return orderMapper.findAgentSumPayOrCost(order);
	}

	@Override
	public List<Order> findGroupOrderListPrint(Order order) {
		return orderMapper.findGroupOrderListPrint(order);
	}

	@Override
	public Order findForTourPageTotalPepole(Order order) {
		return orderMapper.findForTourPageTotalPepole(order);
	}
	
	private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	// 日期格式化方法
	private static String dateFormat(Date date){
		if(date != null){
			return dateFormat.format(date);
		}else{
			return "";
		}
	}
	/**
	 * 同行佣金界面List
	 * */
	@Override
	public List<Order> statementList(Order order) {
		return orderMapper.statementList(order);
	}

	@Override
	public Order statementCount(Order order) {
		return orderMapper.statementCount(order);
	}

	/*@Override
	public Page<Order> queryOrderForVenderPage(Order order, Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<Order> orderList = orderMapper.queryOrderForVenderPage(order, pageable);
		int pageCount = orderMapper.queryOrderForVenderPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}*/
	
	@Override
	public List<TourOrderListVO> findTourOrderListVOForExport(Order order) {
		
		return orderMapper.findTourOrderListVOForExport(order);
	}

	@Override
	public List<Order> findSelect(Order order) {
		return orderMapper.findSelect(order);
	}

	@Override
	public int findCount(Order order) {
		return orderMapper.findCount(order);
	}

	@Override
	public List<Order> findByOrdersTotal(String ordersTotalNo) {
		return orderMapper.findByOrdersTotal(ordersTotalNo);
	}

	@Override
	public List<Order> findByRefNo(String RefNo) {
		return orderMapper.findByRefNo(RefNo);
	}
}
