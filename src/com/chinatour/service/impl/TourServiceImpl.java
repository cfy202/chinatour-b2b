package com.chinatour.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.FlightWithCustomers;
import com.chinatour.entity.Order;
import com.chinatour.entity.Tour;
import com.chinatour.persistence.CustomerFlightMapper;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.persistence.TourTypeOfDeptMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.TourService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.TourVO;

@Service("tourServiceImpl")
public class TourServiceImpl extends BaseServiceImpl<Tour, String> implements TourService {

	@Autowired
	private AdminService adminService;

	@Autowired
	private TourMapper tourMapper;

	@Autowired
	private OrderMapper orderMapper;

	@Autowired
	private CustomerOrderRelMapper customerOrderRelMapper;

	@Autowired
	private CustomerMapper customerMapper;
	
	@Autowired
	private TourTypeOfDeptMapper tourTypeOfDeptMapper;
	
	@Autowired
	private CustomerFlightMapper customerFlightMapper;

	@Autowired
	public void setTourMapper(TourMapper tourMapper) {
		this.setBaseMapper(tourMapper);
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.chinatour.service.TourService#findOrderPage(com.chinatour.entity.Order, com.chinatour.Pageable)
	 */
	@Override
	@Transactional(readOnly = true)
	public Page<Order> findOrderPage(Order order,Pageable pageable){
		List<Order> orderList = new ArrayList<Order>();
		int pageCount = 1;
		String deptId = adminService.getCurrent().getDeptId();
		order.setDeptId(deptId);
		//List<String> tourTypeIdList = tourTypeOfDeptMapper.findTourTypeIdByDeptId(deptId);
		if (pageable == null) {
			pageable = new Pageable();
		}
		orderList = orderMapper.findForTourPage(order,pageable);
		pageCount = orderMapper.findForTourPageCount(order,pageable);
		/*if(tourTypeIdList.size() != 0){
			orderList = orderMapper.findForTourPage(order, tourTypeIdList,pageable);
			pageCount = orderMapper.findForTourPageCount(order,tourTypeIdList,pageable);
		}*/
		return new Page<Order>(orderList, pageCount, pageable);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.chinatour.service.TourService#addTour(com.chinatour.entity.Tour,
	 * java.lang.String[])
	 */
	@Override
	@Transactional
	public String addTour(Tour tour, String[] orderIdArray) {
		tour.setTourId(UUIDGenerator.getUUID());
		tour.setUserId(adminService.getCurrent().getId());
		tour.setUserName(adminService.getCurrent().getUsername());
		tour.setDeptId(adminService.getCurrent().getDeptId());
		tour.setModifyDate(new Date());
		//tourMapper.save(tour);

		Order order = new Order();
		order.setTourId(tour.getTourId());
		order.setTourCode(tour.getTourCode());
		order.setState(2);
		
		int customerTourNo = 0;//团人数
		int totalPeople = 0;//非团人数
		for (String orderId : orderIdArray) {
			order.setId(orderId);
			orderMapper.update(order);
			for(CustomerOrderRel customerOrderRel : customerOrderRelMapper.findByOrderId(orderId)){
				customerOrderRel.setCustomerTourNo(++customerTourNo);
				customerOrderRelMapper.update(customerOrderRel);
			}
			//如果是非团直接取订单总人数
			if(tour.getTourType()==2){
				Order ord=orderMapper.findById(orderId);
				totalPeople+=ord.getTotalPeople();
			}
			
		}
		if(tour.getTourType()==2){
			tour.setTotalPeople(totalPeople);
		}else{
			tour.setTotalPeople(customerTourNo);
		}
		tourMapper.save(tour);
		return tour.getTourId();
	}

	/* (non-Javadoc)
	 * @see com.chinatour.service.TourService#addOrders(java.lang.String, java.lang.String[])
	 */
	@Override
	@Transactional
	public void addOrders(String tourId, String[] orderIdArray) {
		Order order = new Order();
		Tour tour = tourMapper.findById(tourId);
		int maxCustomerNo = customerOrderRelMapper.findMaxCustomerTourNo(tourId);
		int addPeopleNumber = 0;
		int totalPeople = 0;//非团人数
		
		order.setTourId(tourId);
		order.setTourCode(tour.getTourCode());
		order.setState(2);
		for (String orderId : orderIdArray) {
			order.setId(orderId);
			orderMapper.update(order);
			for(CustomerOrderRel customerOrderRel : customerOrderRelMapper.findByOrderId(orderId)){
				customerOrderRel.setCustomerTourNo(++maxCustomerNo);
				customerOrderRelMapper.update(customerOrderRel);
				//添加未取消的客人人数
				if((customerOrderRel.getIsDel()==0)||(customerOrderRel.getIsDel()==3)){
					addPeopleNumber++;
				}
				
			}
			//如果是非团直接取订单总人数
			if(tour.getTourType()==2){
				Order ord=orderMapper.findById(orderId);
				totalPeople+=ord.getTotalPeople();
			}
		}
		if(tour.getTourType()==2){
			tourMapper.changeTotalPeople(totalPeople, tour.getTourId());
		}else{
			tourMapper.changeTotalPeople(addPeopleNumber, tour.getTourId());
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinatour.service.TourService#findTourVOByOrderId(java.lang.String)
	 */
	@Override
	@Transactional(readOnly = true)
	public List<TourVO> findTourVOByOrderId(String orderId,Pageable pageable) {
		Order order = new Order();
		order.setId(orderId);
		return findTourVOByOrderIdOrTourId(order,pageable);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.chinatour.service.TourService#findTourVOByTourId(java.lang.String)
	 */
	@Override
	@Transactional
	public List<TourVO> findTourVOByTourId(String tourId,Pageable pageable) {
		Order order = new Order();
		order.setTourId(tourId);
		return findTourVOByOrderIdOrTourId(order,pageable);
	}
	


	/* (non-Javadoc)
	 * @see com.chinatour.service.TourService#findByTourName(java.lang.String)
	 */
	@Override
	public Tour findByTourCode(String tourCode) {
		return tourMapper.findByTourCode(tourCode);
	}
	
	
	@Override
	@Transactional
	public int update(Tour tour){
		for(Order order : orderMapper.findByTourId(tour.getTourId())){
			order.setTourCode(tour.getTourCode());
			orderMapper.update(order);
		}
		return tourMapper.update(tour);
	}
	

	/* (non-Javadoc)
	 * @see com.chinatour.service.TourService#removeOrdersFromTour(java.lang.String[])
	 */
	@Override
	@Transactional
	public void removeOrdersFromTour(String[] orderIdArray,String tourId) {
		Order order = new Order();
		CustomerOrderRel customerOrderRel = new CustomerOrderRel();
		order.setTourId("");
		order.setTourCode("");
		order.setState(0);
		int customerNum = 0;//客人人数
		for (String orderId : orderIdArray) {
			customerOrderRel.setOrderId(orderId);
			customerOrderRel.setCustomerTourNo(0);
			order.setId(orderId);
			orderMapper.update(order);
			//修改客人团编号
			customerOrderRelMapper.updateByOrderId(customerOrderRel);
			//查出未取消的客人人数 
			customerOrderRel.setIsDel(0);
			customerNum +=customerOrderRelMapper.findCountIsDelByOrderId(customerOrderRel);
		}
		//修改团人数
		Tour tour=tourMapper.findById(tourId);
		if(tour.getTotalPeople()>0){
			tourMapper.changeTotalPeople(-customerNum, tourId);
		}else{
			tourMapper.changeTotalPeople(0, tourId);
		}
	}
	
	/**
	 * 根据包含条件的order查询出TourVO
	 * 
	 * @param order_
	 * @return
	 */
	private List<TourVO> findTourVOByOrderIdOrTourId(Order order_,Pageable pageable) {

		List<TourVO> tourVOList = new ArrayList<TourVO>();
		TourVO tourVO;
		Tour tour = null;
		Customer customer;
		List<CustomerOrderRel> customerOrderRelList;
		if(order_.getId() == null){
			tour = tourMapper.findById(order_.getTourId());
		}
		List<Order> orderList = orderMapper.findForPage(order_, pageable);
		for (Order order : orderList) {
			customerOrderRelList = customerOrderRelMapper.findByOrderId(order.getId());
			for (CustomerOrderRel customerOrderRel : customerOrderRelList) {
				tourVO = new TourVO();
				tourVO.setOrderNo(order.getOrderNo());
				tourVO.setTourCode(order.getTourCode());
				tourVO.setState(order.getState());
				tourVO.setAgent(adminService.findById(order.getUserId()).getUsername());
				if (order_.getId() == null) {
					tourVO.setCustomerOrderNo(customerOrderRel.getCustomerTourNo());
					tourVO.setTotalPeople(tour.getTotalPeople());
				} else {
					tourVO.setCustomerOrderNo(customerOrderRel.getCustomerOrderNo());
					tourVO.setTotalPeople(order.getTotalPeople());
				}
				tourVO.setIsDel(customerOrderRel.getIsDel());
				customer = customerMapper.findById(customerOrderRel.getCustomerId());
				tourVO.setId(customer.getCustomerId());
				tourVO.setLastName(customer.getLastName());
				tourVO.setFirstName(customer.getFirstName());
				tourVOList.add(tourVO);
			}
		}
		return tourVOList;
	}

	/**
	 * 小组 分页
	 * 本小组 所有表单
	 * @param order
	 * @param pageable
	 * @return
	 */
	@Override
	public Page<Tour> findForGrouPage(Tour tour, Pageable pageable) {
		if (pageable == null) {
		    pageable = new Pageable();
		}
		List<Tour> page = tourMapper.findForGroupPage(tour, pageable);
		int pageCount = tourMapper.findForGroupPageCount(tour, pageable);
		return new Page<Tour>(page, pageCount, pageable);
	}

	/**
	 *查询团账单完成状态
	 * @param tourId
	 * @return
	 */
	@Override
	public Tour findAllCheckByTourId(String tourId) {
		return tourMapper.findAllCheckByTourId(tourId);
	}
	
	
	/**
	 * region 分页
	 * 本地区 所有agent团订单
	 * @param order
	 * @param pageable
	 * @return
	 */
	@Override
	public Page<Tour> findTourOfRegionPage(Tour tour, Pageable pageable) {
		if (pageable == null) {
		    pageable = new Pageable();
		}
		List<Tour> page = tourMapper.findTourOfRegionPage(tour, pageable);
		int pageCount = tourMapper.findTourOfRegionPageCount(tour, pageable);
		return new Page<Tour>(page, pageCount, pageable);
	}
	
	/**
	 * office 分页
	 * 本地区 所有agent团订单
	 * @param order
	 * @param pageable
	 * @return
	 */
	@Override
	public Page<Tour> findTourOfOrderPage(Tour tour, Pageable pageable) {
		if (pageable == null) {
		    pageable = new Pageable();
		}
		List<Tour> page = tourMapper.findTourOfOrderPage(tour, pageable);
		int pageCount = tourMapper.findTourOfOrderPageCount(tour, pageable);
		return new Page<Tour>(page, pageCount, pageable);
	}
	/**
	 * group 分页
	 * 本地区 所有agent团订单
	 * @param order
	 * @param pageable
	 * @return
	 */
	@Override
	public Page<Tour> findTourOfGroupPage(Tour tour, Pageable pageable) {
		if (pageable == null) {
		    pageable = new Pageable();
		}
		List<Tour> page = tourMapper.findTourOfGroupPage(tour, pageable);
		int pageCount = tourMapper.findTourOfGroupPageCount(tour, pageable);
		return new Page<Tour>(page, pageCount, pageable);
	}

	@Override
	public Page<Tour> findTourOfUserForPage(Tour tour, Pageable pageable) {
		if (pageable == null) {
		    pageable = new Pageable();
		}
		List<Tour> page = tourMapper.findTourOfUserForPage(tour, pageable);
		int pageCount = tourMapper.findTourOfUserForPageCount(tour, pageable);
		return new Page<Tour>(page, pageCount, pageable);
	}
	//op团下航班分页
	@Override
	public Page<CustomerFlight> findFlightForOpForPage(CustomerFlight customerFlight, Pageable pageable) {
		if (pageable == null) {
		    pageable = new Pageable();
		}
		List<CustomerFlight> page = customerFlightMapper.findFlightForOpForPage(customerFlight, pageable);
		int pageCount = customerFlightMapper.findFlightForOpForPageCount(customerFlight, pageable);
		return new Page<CustomerFlight>(page, pageCount, pageable);
	}

	@Override
	public Tour findTourOfOrderSumPepole(Tour tour) {
		return tourMapper.findTourOfOrderSumPepole(tour);
	}

	@Override
	public Tour findTourOfGroupSumPepole(Tour tour) {
		return tourMapper.findTourOfGroupSumPepole(tour);
	}

	@Override
	public Tour findTourOfRegionSumPepole(Tour tour) {
		return tourMapper.findTourOfRegionSumPepole(tour);
	}


	@Override
	public List<Tour> findList(Tour tour) {
		return tourMapper.findList(tour);
	}

	@Override
	public List<Tour> findListForSingle(Tour tour) {
		return tourMapper.findListForSingle(tour);
	}

	@Override
	public List<Tour> findListForTour(Tour tour) {
		
		return tourMapper.findListForTour(tour);
	}

	@Override
	public void changeTotalPeople(int i, String tourCode) {
		 tourMapper.changeTotalPeople(i,tourCode);
	}

	@Override
	public Tour findTourOfUserSumPepole(Tour tour) {
		return tourMapper.findTourOfUserSumPepole(tour);
	}

	@Override
	public List<FlightWithCustomers> getCustomerFlightList(CustomerFlight customerFlightTemp) {
		List<CustomerFlight> customerFlightList = customerFlightMapper.queryFlightForOp(customerFlightTemp);
		List<FlightWithCustomers> flightWithCustomersList = getFlightWithCustomer(customerFlightList);
		return flightWithCustomersList;
	}
	
	private List<FlightWithCustomers> getFlightWithCustomer(List<CustomerFlight> customerFlightList){
		List<FlightWithCustomers> cftList = new ArrayList<FlightWithCustomers>();
		Customer customer = null;
		for(int i=0;i<customerFlightList.size()-1;i++){
			CustomerFlight cuf = customerFlightList.get(i);
			FlightWithCustomers fwc = new FlightWithCustomers();
			fwc.setCustomerFlight(cuf);
			customer = new Customer();
			customer.setFirstName(cuf.getFirstName());
			customer.setMiddleName(cuf.getMiddleName());
			customer.setLastName(cuf.getLastName());
			List<Customer> customerList = fwc.getCustomerList();
			if(customerList==null){
			 customerList = new ArrayList<Customer>();
			}
			customerList.add(customer);
			for(int j=i+1;j<customerFlightList.size();j++){
				CustomerFlight cf = customerFlightList.get(j);
				if(cf.getArriveDate()!=null&&cuf.getArriveDate()!=null&&cf.getArriveDate().compareTo(cuf.getArriveDate())==0&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber())&& cf.getOutOrEnter()==cuf.getOutOrEnter()&&cf.getRemark().equals(cuf.getRemark())){
					customer = new Customer();
					customer.setFirstName(cf.getFirstName());
					customer.setMiddleName(cf.getMiddleName());
					customer.setLastName(cf.getLastName());
					customerList.add(customer);
					customerFlightList.remove(cf);
					j--;
				}
			}
			fwc.setCustomerList(customerList);
			fwc.setCustomerSize(customerList.size());
			customerFlightList.remove(cuf);
			cftList.add(fwc);
			i--;
		}
		return cftList;
	}
}
