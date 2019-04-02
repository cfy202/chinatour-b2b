package com.chinatour.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PrePostHotel;
import com.chinatour.entity.Tour;
import com.chinatour.persistence.CustomerFlightMapper;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.PrePostHotelMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.NoticeService;
import com.chinatour.service.OrdersTotalService;
import com.chinatour.util.UUIDGenerator;

/**
 * Service 总订单信息
 * 
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time 2014-12-19 下午16:15:53
 * @revision 3.0
 */
@Service("ordersTotalServiceImpl")
public class OrdersTotalServiceImpl extends BaseServiceImpl<OrdersTotal,String> implements OrdersTotalService{
	
	private static final String TWIN_BED = Constant.GUEST_ROOM_TYPES[0];
	private static final String KING_BED = Constant.GUEST_ROOM_TYPES[1];
	private static final String SINGLE = Constant.GUEST_ROOM_TYPES[2];
	private static final String EXTRA_BED = Constant.GUEST_ROOM_TYPES[3];
	private static final String SHARING_EXISTING_BED = Constant.GUEST_ROOM_TYPES[5];
	private static final String ROOM_MATCHING = Constant.GUEST_ROOM_TYPES[6];
    
	@Autowired 
	private AdminService adminService;
	
	@Autowired
	private OrdersTotalMapper ordersTotalMapper;
	
	@Autowired
	private CustomerOrderRelMapper customerOrderRelMapper;
	
	@Autowired
	private CustomerMapper customerMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private TourMapper tourMapper;
	
	@Resource(name = "noticeServiceImpl")
	private NoticeService noticeService;
	
	@Autowired
	private CustomerFlightMapper customerFlightMapper;
	
	@Autowired
	private PrePostHotelMapper prePostHotelMapper;

	@Autowired
	public void setBaseMapper(OrdersTotalMapper ordersTotalMapper) {
		super.setBaseMapper(ordersTotalMapper);
	}
	
	/**
	 * 保存总订单,并返回
	 * 
	 * @param ordersTotal
	 * @param customer
	 * @param customerArray
	 * @return
	 */
	@Override
	@Transactional
	public synchronized OrdersTotal saveTotalOrder(OrdersTotal ordersTotal) {
		Admin admin = adminService.getCurrent();
		ordersTotal.setOrdersTotalId(UUIDGenerator.getUUID());
		ordersTotal.setUserId(admin.getId());
		ordersTotal.setDeptId(admin.getDeptId());
		ordersTotal.setAgent(admin.getUsername());
		ordersTotal.setServer(Constant.SERVER);
		ordersTotalMapper.save(ordersTotal);
		ordersTotal.setOrderNumber(ordersTotalMapper.findById(ordersTotal.getOrdersTotalId()).getOrderNumber());
		ordersTotal.setBookingDate(new Date());
		return ordersTotal;
	}
	
	/**
	 * 更新总订单
	 */
	public void updateOrdersTotal(OrdersTotal ordersTotal){
		if(ordersTotal.getWr().equalsIgnoreCase("retail")){
			ordersTotal.setCompanyId("");
			ordersTotal.setCompany("");
			orderMapper.updateTourOrdersByOrdersTotalId("",ordersTotal.getContactName(),1,ordersTotal.getOrdersTotalId());
			orderMapper.updateSingleOrdersByOrdersTotalId("",ordersTotal.getContactName(),ordersTotal.getOrdersTotalId());
		}else{
			orderMapper.updateTourOrdersByOrdersTotalId(ordersTotal.getCompanyId(),ordersTotal.getContactName(),2,ordersTotal.getOrdersTotalId());
			orderMapper.updateSingleOrdersByOrdersTotalId(ordersTotal.getCompanyId(),ordersTotal.getContactName(),ordersTotal.getOrdersTotalId());
		}
		ordersTotalMapper.update(ordersTotal);
	}
	
	/**
	 * 根据总订单ID查找出总订单和所属客人
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public Map<String,Object> findTotalOrder(String ordersTotalId) {
		Map<String,Object> result = new HashMap<String,Object>();
		OrdersTotal ordersTotal = ordersTotalMapper.findById(ordersTotalId);
		List<CustomerOrderRel> customerOrderRelList = customerOrderRelMapper.findWithCustomerByOrdersTotalId(ordersTotalId);
		result.put("customerOrderRelList", customerOrderRelList);
		result.put("ordersTotal", ordersTotal);
		return result;
	}
	
	/**
	 * 
	 */
	@Override
	@Transactional
	public boolean checkCustomerName(Customer customer) {
		List<Customer> cusList = customerMapper.findByCustomerName(customer);
		if(cusList.size() != 0){
			return true; 
		}
		return false;
	}
	
	/**
	 * 给总订单添加客人
	 * 
	 * @param customer
	 * @param ordersTotalId
	 */
	@Override 
	@Transactional
	public Map<String, Object> addCustomer(CustomerOrderRel customerOrderRel) {
		Map<String, Object> map = new HashMap<String, Object>();
		int maxCustomerOrderNo = customerOrderRelMapper.findMaxCustomerOrderNoByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		int maxCustomerRoomNumber = customerOrderRelMapper.findMaxRoomNumberByOrdersTotalId(customerOrderRel.getOrdersTotalId()); 
		List<Order> orders = orderMapper.findByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		//状态为0，2，3，7的订单数量
		int existOrdersNumber = orderMapper.countExistOrdersInOrdersTotal(customerOrderRel.getOrdersTotalId());
		
		//如果订单已全部被取消，不能添加客人,返回 noOrder
		if(orders.size() != 0 && existOrdersNumber == 0){
			map.put("Msg", "noOrder");
			//return "noOrder";
		}
		
		/*
		 * 保存客人
		 */
		Admin admin=adminService.getCurrent();
		customerOrderRel.getCustomer().setCustomerId(UUIDGenerator.getUUID());
		customerOrderRel.getCustomer().setModifyDate(new Date());
		customerMapper.save(customerOrderRel.getCustomer());
		map.put("customerId", customerOrderRel.getCustomer().getCustomerId());
		customerOrderRel.setCustomerId(customerOrderRel.getCustomer().getCustomerId());
		customerOrderRel.setContactFlag(0);
		customerOrderRel.setCustomerOrderNo(maxCustomerOrderNo + 1);
		
		
		/* 如果是新加房，添加房号  */
		if(customerOrderRel.getRoomNumber()!=null){//同行用户添加客人时没有房型，房型在后面添加所以为Null,系统内部添加客人要选房型，执行此段代码
			if(customerOrderRel.getRoomNumber() == 0){
				if(!(SHARING_EXISTING_BED.equals(customerOrderRel.getGuestRoomType()) || SINGLE.equals(customerOrderRel.getGuestRoomType()) || ROOM_MATCHING.equals(customerOrderRel.getGuestRoomType()))){
					customerOrderRel.setRoomNumber(maxCustomerRoomNumber + 1);
				}
			/* 如果需要组房  */	
			}else if(KING_BED.equals(customerOrderRel.getGuestRoomType()) || TWIN_BED.equals(customerOrderRel.getGuestRoomType()) || EXTRA_BED.equals(customerOrderRel.getGuestRoomType())){
				int roomIsFull = 1;
				if(EXTRA_BED.equals(customerOrderRel.getGuestRoomType())){
					roomIsFull = 2;
				}else{
					String extraBedCustomerId = customerOrderRelMapper.getExtraBedCustomerWithRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(), customerOrderRel.getRoomNumber());
					if(extraBedCustomerId != null && !"".equals(extraBedCustomerId)){
						roomIsFull = 2;
					}
				}
				customerOrderRel.setRoomIsFull(roomIsFull);
				customerOrderRelMapper.setRoomIsFullByRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(), customerOrderRel.getRoomNumber(), roomIsFull);
			}
		}
		
		/*
		 * 如果总订单中没有产品
		 */
		if(orders.size() == 0){
			customerOrderRel.setId(UUIDGenerator.getUUID());
			customerOrderRelMapper.save(customerOrderRel);
		}else{
			for(Order order : orders){ 
				if(order.getTourId().length() != 0){
					Tour tour = tourMapper.findById(order.getTourId());
					//Customer cus = customerMapper.findById(customerOrderRel.getCustomerId());
					//查出该订单下最大团客人编号 
					int maxCustomerTourNo = customerOrderRelMapper.findMaxCustomerTourNo(tour.getTourId());
					//团中客人编号
					int number=maxCustomerTourNo+1;
					//判断是否组团 是发送站内信提示订单添加客人
					String title = Constant.SYSNOTICE + Constant.ORDERS + order.getOrderNo() + Constant.IN_STRING + Constant.ADD_STRING + number + Constant.CUSTOMERCODE;
					//发送站内信
					noticeService.sendMail(title, adminService.getCurrent().getId(), tour.getUserId());
					//该订单的团人数加一人
					tourMapper.changeTotalPeople(1,tour.getTourId());
					//查出该订单下最大团客人编号 
					customerOrderRel.setCustomerTourNo(maxCustomerTourNo + 1);
				}else{
					customerOrderRel.setCustomerTourNo(0);
				}
				switch(order.getState()){
					case 0: 
					case 2: 
					case 3: 
					case 4: customerOrderRel.setIsDel(0); break;
					case 5: 
					case 6: 
					case 7: customerOrderRel.setIsDel(1);
				}
				customerOrderRel.setId(UUIDGenerator.getUUID());
			    customerOrderRel.setOrderId(order.getId());
				customerOrderRelMapper.save(customerOrderRel);
				List<CustomerFlight> customerFlightList = new ArrayList<CustomerFlight>();
				CustomerFlight customerFlight = null;
				for(int index = 1; index <= 2; index++){
					customerFlight = new CustomerFlight();
					customerFlight.setId(UUIDGenerator.getUUID());
					customerFlight.setCustomerOrderRelId(customerOrderRel.getId());
					customerFlight.setOutOrEnter(index);
					if(index == 1){
						customerFlight.setIfPickUp(2);
					}else{
						customerFlight.setIfSendUp(2);
					}
					customerFlightList.add(customerFlight);
				}
				if(customerFlightList.size() > 0){
					customerFlightMapper.saveCustomerFlights(customerFlightList);
				}
				
				//订单添加人数
				orderMapper.changeTotalPeopleByOrderId(1, order.getId());
			}	
		}
		map.put("customerOrderRelId", customerOrderRel.getId());
		return map;
	}
	
	
	/**
	 * 给总订单添加客人
	 * 
	 * @param customer
	 * @param ordersTotalId
	 */
	@Override 
	@Transactional
	public String addCustomerForSelect(CustomerOrderRel customerOrderRel) {
		int maxCustomerOrderNo = customerOrderRelMapper.findMaxCustomerOrderNoByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		int maxCustomerRoomNumber = customerOrderRelMapper.findMaxRoomNumberByOrdersTotalId(customerOrderRel.getOrdersTotalId()); 
		List<Order> orders = orderMapper.findByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		int existOrdersNumber = orderMapper.countExistOrdersInOrdersTotal(customerOrderRel.getOrdersTotalId());
		
		if(orders.size() != 0 && existOrdersNumber == 0){
			return "noOrder";
		}
		
		customerOrderRel.setCustomerOrderNo(maxCustomerOrderNo + 1);
		customerOrderRel.setRoomNumber(maxCustomerRoomNumber + 1);
		
		/*
		 * 如果总订单中没有产品
		 */
		if(orders.size() == 0){
			customerOrderRel.setId(UUIDGenerator.getUUID());
			customerOrderRelMapper.save(customerOrderRel);
		}else{
			for(Order order : orders){
				if(order.getTourId().length() != 0){
					Tour tour = tourMapper.findById(order.getTourId());
					//Customer cus = customerMapper.findById(customerOrderRel.getCustomerId());
					//查出该订单下最大团客人编号 
					int maxCustomerTourNo = customerOrderRelMapper.findMaxCustomerTourNo(tour.getTourId());
					//判断是否组团 是发送站内信提示订单添加客人
					String title = Constant.SYSNOTICE + Constant.ORDERS + order.getOrderNo() + Constant.IN_STRING + Constant.ADD_STRING + maxCustomerTourNo + Constant.CUSTOMERCODE;
					//发送站内信
					noticeService.sendMail(title, adminService.getCurrent().getId(), tour.getUserId());
					//该订单的团人数加一人
					/*(tour.setTotalPeople(tour.getTotalPeople() + 1);
					tourMapper.update(tour);*/
					tourMapper.changeTotalPeople(1,tour.getTourId());
					//查出该订单下最大团客人编号 
					//int maxCustomerTourNo = customerOrderRelMapper.findMaxCustomerTourNo(tour.getTourId());
					customerOrderRel.setCustomerTourNo(maxCustomerTourNo + 1);
				}else{
					customerOrderRel.setCustomerTourNo(0);
				}
				switch(order.getState()){
					case 0: 
					case 2: 
					case 3: 
					case 4: customerOrderRel.setIsDel(0); break;
					case 5: 
					case 6: 
					case 7: customerOrderRel.setIsDel(1);
				}
				customerOrderRel.setId(UUIDGenerator.getUUID());
			    customerOrderRel.setOrderId(order.getId());
				customerOrderRelMapper.save(customerOrderRel);
				//订单添加人数
				orderMapper.changeTotalPeopleByOrderId(1, order.getId());
			}	
		}
		return customerOrderRel.getId();
	}
	
	/**
	 * 根据总订单和房型查找出客人
	 */
	@Override
	@Transactional(readOnly = true)
	public List<CustomerOrderRel> getRoommates(String ordersTotalId, String guestRoomType) {
		if(EXTRA_BED.equals(guestRoomType)){
			return customerOrderRelMapper.getRoommatesWithExtraBed(ordersTotalId);
		}else{
			return customerOrderRelMapper.getRoommates(ordersTotalId, guestRoomType);
		}
	}
	
	/**
	 * 根据总订单和房型，或房号查找出客人
	 */
	public List<CustomerOrderRel> getRoommatesWithRoomNumber(String ordersTotalId,String guestRoomType,int roomNumber){
		if(EXTRA_BED.equals(guestRoomType)){
			return customerOrderRelMapper.getExtraBedRoommatesWithRoomNumber(ordersTotalId,roomNumber);
		}else{
			return customerOrderRelMapper.getRoommatesWithRoomNumber(ordersTotalId, guestRoomType,roomNumber);
		}
	}
	
	/**
	 * 修改客人信息
	 */
	@Override
	@Transactional
	public void updateCustomer(CustomerOrderRel customerOrderRel){
		
		CustomerOrderRel originalCustomerOrderRel = customerOrderRelMapper.findById(customerOrderRel.getId());
		int maxCustomerRoomNumber = customerOrderRelMapper.findMaxRoomNumberByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		String customerId = originalCustomerOrderRel.getCustomerId();
		customerOrderRel.getCustomer().setCustomerId(customerId);
		
		//修改客人名发站内信 王存
		List<Order> orders = orderMapper.findByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		Customer customer=customerMapper.findById(customerId);
		Customer customerNew= customerOrderRel.getCustomer();
		if(customerNew.getMiddleName()==null){
			customerNew.setMiddleName("");
		}
		boolean temp=false;//判断是否修改过客人
		if (!customer.getFirstName().equals(customerNew.getFirstName())
				|| !customer.getLastName().equals(customerNew.getLastName())
				|| !customer.getMiddleName().equals(customerNew.getMiddleName())) {
		   temp=true;
		}
		if(temp&&orders.size()!=0){
			for(Order order : orders){
				if(order.getTourId().length() != 0){
					//判断是否修改客人名 是发送站内信提示订单修改客人
					String title = Constant.SYSNOTICE + Constant.ORDERS + order.getOrderNo()+"/"+order.getTourCode()
							+ adminService.getCurrent().getName()+"  修改客人名："+customer.getLastName()+"/"+customer.getFirstName()+"/"+customer.getMiddleName()
							+"为："+customerNew.getLastName()+"/"+customerNew.getFirstName()+"/"+customerNew.getMiddleName();
					//发送站内信
					Tour tour=tourMapper.findById(order.getTourId());
					noticeService.sendMail(title, adminService.getCurrent().getId(), tour.getUserId());
				}
			}
		}
		
		customerMapper.update(customerOrderRel.getCustomer());
		customerOrderRelMapper.updateTicketTypeByCusIdAndOrdersTotalId(customerOrderRel.getTicketType(), customerId, customerOrderRel.getOrdersTotalId());
		//更改voucherStr
		CustomerOrderRel crel=new CustomerOrderRel();
		crel.setId(customerOrderRel.getId());
		if(customerOrderRel.getVoucherStr()!=null){
			crel.setVoucherStr(customerOrderRel.getVoucherStr());
		}else{
			crel.setVoucherStr("none");
		}
		customerOrderRelMapper.update(crel);
		
		
		/* 如果客人的房型或房间号发生更改，更新内容 */
		if(!(originalCustomerOrderRel.getGuestRoomType().equals(customerOrderRel.getGuestRoomType()) && originalCustomerOrderRel.getRoomNumber() == customerOrderRel.getRoomNumber())){
			/* 把以前的房间换一个状态  */
			if(originalCustomerOrderRel.getRoomIsFull() >= 1){
				if(EXTRA_BED.equals(originalCustomerOrderRel.getGuestRoomType())){
					customerOrderRelMapper.setRoomIsFullByRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(),originalCustomerOrderRel.getRoomNumber(), 1);
				}else if(TWIN_BED.equals(originalCustomerOrderRel.getGuestRoomType()) || KING_BED.equals(originalCustomerOrderRel.getGuestRoomType())){
					customerOrderRelMapper.setRoomIsFullByRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(),originalCustomerOrderRel.getRoomNumber(), 0);
				}
			}
			
		    /* 如果是新加房，设置房型和房号    */
			if(customerOrderRel.getRoomNumber() == 0){
				int roomNumber = 0;
				if(!(SHARING_EXISTING_BED.equals(customerOrderRel.getGuestRoomType()) || SINGLE.equals(customerOrderRel.getGuestRoomType()) || ROOM_MATCHING.equals(customerOrderRel.getGuestRoomType()))){
					roomNumber = maxCustomerRoomNumber + 1;
				}
				customerOrderRelMapper.updateRoomTypeAndRoomNumberByCustomerIdAndOrdersTotalId(customerOrderRel.getGuestRoomType(), roomNumber, customerId, customerOrderRel.getOrdersTotalId());
				customerOrderRelMapper.setRoomIsFullByRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(), roomNumber, 0);
			/* 如果房间是已存在房间，更改房型和房间号，根据情况设置该房间已满或未满  */	
			}else{
				customerOrderRelMapper.updateRoomTypeAndRoomNumberByCustomerIdAndOrdersTotalId(customerOrderRel.getGuestRoomType(),customerOrderRel.getRoomNumber(), customerId, customerOrderRel.getOrdersTotalId());
				if(TWIN_BED.equals(customerOrderRel.getGuestRoomType()) || KING_BED.equals(customerOrderRel.getGuestRoomType())){
					String extraBedCustomerId = customerOrderRelMapper.getExtraBedCustomerWithRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(), customerOrderRel.getRoomNumber());
					if(extraBedCustomerId != null && !customerId.equals(extraBedCustomerId)){
						customerOrderRelMapper.setRoomIsFullByRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(), customerOrderRel.getRoomNumber(), 2);
					}else{
						customerOrderRelMapper.setRoomIsFullByRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(), customerOrderRel.getRoomNumber(), 1);
					}
				}else if(EXTRA_BED.equals(customerOrderRel.getGuestRoomType())){
					customerOrderRelMapper.setRoomIsFullByRoomNumberAndOrdersTotalId(customerOrderRel.getOrdersTotalId(), customerOrderRel.getRoomNumber(), 2);
				}
			}
		}
	}
	/**
	 * 同行用户修改客人
	 * */
	@Override
	@Transactional
	public void updateCustomerByPeerUser(CustomerOrderRel customerOrderRel){
		CustomerOrderRel originalCustomerOrderRel = customerOrderRelMapper.findById(customerOrderRel.getId());
		int maxCustomerRoomNumber = customerOrderRelMapper.findMaxRoomNumberByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		String customerId = originalCustomerOrderRel.getCustomerId();
		customerOrderRel.getCustomer().setCustomerId(customerId);
		
		List<Order> orders = orderMapper.findByOrdersTotalId(customerOrderRel.getOrdersTotalId());
		Customer customer=customerMapper.findById(customerId);
		Customer customerNew= customerOrderRel.getCustomer();
		if(customerNew.getMiddleName()==null){
			customerNew.setMiddleName("");
		}
		customerMapper.update(customerOrderRel.getCustomer());
		customerOrderRelMapper.updateTicketTypeByCusIdAndOrdersTotalId(customerOrderRel.getTicketType(), customerId, customerOrderRel.getOrdersTotalId());
	}
	/**
	 * 根据总订单ID查出所有客人(添加产品时添加航班时选择)
	 * 
	 * @param ordersTotalId
	 * @return
	 */ 
	@Override
	@Transactional(readOnly = true)
	public List<Customer> findCustomersByOrdersTotalId(String ordersTotalId){
		return customerMapper.findByOrdersTotalId(ordersTotalId);
	}
	
	/**
	 * 根据子订单ID查出所有客人(编辑产品时添加航班时选择)
	 * 
	 * @param orderId
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public List<Customer> findCustomersByOrderId(String orderId){
		return customerMapper.findByOrdersId(orderId);
	}
	
	/**
	 * 根据小组查询出总订单列表
	 * 
	 * @param ordersTotal
	 * @param pageable
	 * @return
	 */
	public Page<OrdersTotal> findForGrouPage(OrdersTotal ordersTotal, Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<OrdersTotal> ordersTotalList = ordersTotalMapper.findForGroupPage(ordersTotal, pageable);
		int pageCount = ordersTotalMapper.findForGroupPageCount(ordersTotal, pageable);
		return new Page<OrdersTotal>(ordersTotalList, pageCount, pageable);
	}

	@Override
	public Page<OrdersTotal> findOrderTotalTaxPage(OrdersTotal ordersTotal,
			Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<OrdersTotal> ordersTotalList = ordersTotalMapper.findOrderTotalTaxPage(ordersTotal, pageable);
		int pageCount = ordersTotalMapper.findOrderTotalTaxPageCount(ordersTotal, pageable);
		return new Page<OrdersTotal>(ordersTotalList, pageCount, pageable);
	}

	@Override
	public Page<OrdersTotal> findOrderOfRegionList(OrdersTotal ordersTotal,
			Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<OrdersTotal> ordersTotalList = ordersTotalMapper.findOrderOfRegionPage(ordersTotal, pageable);
		int pageCount = ordersTotalMapper.findOrderOfRegionPageCount(ordersTotal, pageable);
		return new Page<OrdersTotal>(ordersTotalList, pageCount, pageable);
	}

	@Override
	public OrdersTotal findOrderTotalSumPepole(OrdersTotal ordersTotal) {
		return ordersTotalMapper.findOrderTotalSumPepole(ordersTotal);
	}

	@Override
	public OrdersTotal findGroupOrderTotalSumPepole(OrdersTotal ordersTotal) {
		return ordersTotalMapper.findGroupOrderTotalSumPepole(ordersTotal);
	}

	@Override
	public OrdersTotal findRegionOrderTotalSumPepole(OrdersTotal ordersTotal) {
		return ordersTotalMapper.findRegionOrderTotalSumPepole(ordersTotal);
	}

	@Override
	public Page<OrdersTotal> findOrderTotalTaxGroupPage(
			OrdersTotal ordersTotal, Pageable pageable) {
		if (pageable == null) {
			pageable = new Pageable();
		}
		List<OrdersTotal> ordersTotalList = ordersTotalMapper.findOrderTotalTaxGroupPage(ordersTotal, pageable);
		int pageCount = ordersTotalMapper.findOrderTotalTaxGroupPageCount(ordersTotal, pageable);
		return new Page<OrdersTotal>(ordersTotalList, pageCount, pageable);
	}

	@Override
	public OrdersTotal findSumPepoleAndPayOrCost(OrdersTotal ordersTotal) {
		return ordersTotalMapper.findSumPepoleAndPayOrCost(ordersTotal);
	}

	@Override
	public List<OrdersTotal> findOrderTotalTaxPrint(OrdersTotal ordersTotal) {
		return ordersTotalMapper.findOrderTotalTaxPrint(ordersTotal);
	}

	@Override
	public OrdersTotal findGroupSumPepoleAndPayOrCost(OrdersTotal ordersTotal) {
		return ordersTotalMapper.findGroupSumPepoleAndPayOrCost(ordersTotal);
	}

	@Override
	public List<OrdersTotal> findGroupOrderTotalTaxPrint(OrdersTotal ordersTotal) {
		return ordersTotalMapper.findGroupOrderTotalTaxPrint(ordersTotal);
	}

	@Override
	public void delTotalInfo(String peerUserId) {
		OrdersTotal ordersTotal=new OrdersTotal();
		ordersTotal.setPeerUserId(peerUserId);
		List<OrdersTotal> otList=ordersTotalMapper.find(ordersTotal);
		if(otList.size()>0){
			//针对生成关系表的总订单进行删除
			CustomerOrderRel rel=new CustomerOrderRel();
			rel.setOrdersTotalId(peerUserId);
			rel.setIsDel(50);
			//查找废弃总单的废弃客人
			List<CustomerOrderRel> relList=customerOrderRelMapper.findRelByPeerUserId(rel);
			if(relList.size()>0){
				CustomerOrderRel rels=new CustomerOrderRel();
				rels.setIsDel(5);
				//删除多余客人
				for(int i=0;i<relList.size();i++){
					rels.setCustomerId(relList.get(i).getCustomerId());
					List<CustomerOrderRel> relLists=customerOrderRelMapper.findRelByPeerUserId(rels);
					customerOrderRelMapper.deleteId(relList.get(i).getId());
					if(relLists.size()==0){
						customerMapper.deleteId(relList.get(i).getCustomerId());
					}
				}
				
			}
			//查找没有子单的总单
			List<OrdersTotal> ordersTotalList= ordersTotalMapper.findNoOrderId(peerUserId);
			if(ordersTotalList.size()>0){
				for(int a=0;a<ordersTotalList.size();a++){
					//删除废弃的提前入住和续住
					PrePostHotel pp=new PrePostHotel();
					pp.setOrderId(ordersTotalList.get(a).getOrdersTotalId());
					List<PrePostHotel> prePostList=prePostHotelMapper.findByOrderId(pp);
					if(prePostList.size()>0){
						for(PrePostHotel prePostHotel:prePostList){
							prePostHotelMapper.removeById(prePostHotel.getPrePostHotelId());
						}
					}
					ordersTotalMapper.deleteByOrdersTotalId(ordersTotalList.get(a).getOrdersTotalId());
				}
			}
		}
	}
}
