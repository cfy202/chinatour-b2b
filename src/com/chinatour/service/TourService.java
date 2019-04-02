package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.FlightWithCustomers;
import com.chinatour.entity.Order;
import com.chinatour.entity.Tour;
import com.chinatour.vo.TourVO;

public interface TourService extends BaseService<Tour, String> {
	
	/**
	 * 如果当前用户有小组,根据小组查出所有订单
	 * 如果当前用户没有小组,根据当前用户查处所有订单
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	public Page<Order> findOrderPage(Order order,Pageable pageable);
	
	/**
	 * 根据传进去的tour和若干orderId进行组团 返回tourId
	 * 
	 * @param tour
	 * @param orderIdArray
	 * @return
	 */
	public String addTour(Tour tour, String[] orderIdArray);
	
    
	/**
	 * 向现已存在的团里添加新的订单
	 * 
	 * @param orderIdArray
	 */
	public void addOrders(String tourId, String[] orderIdArray);

	/**
	 * 根据orderId查出所关联的客人
	 * 
	 * @param orderId
	 * @return
	 */
	public List<TourVO> findTourVOByOrderId(String orderId,Pageable pageable);

	/**
	 * 根据tourId查出所关联的客人
	 * 
	 * @param tourId
	 * @return
	 */
	public List<TourVO> findTourVOByTourId(String tourId,Pageable pageable);

	/**
	 * 根据团号查找团
	 * 
	 * @param tourCode
	 * @return
	 */
	public Tour findByTourCode(String tourCode);
	
	/**
	 * 在团中取消订单
	 * 
	 * @param orderIdArray
	 * @param tourId
	 */
	public void removeOrdersFromTour(String[] orderIdArray,String tourCode);
	
	/**
	 * 本小组订单分页
	 * @param order
	 * @param pageable
	 * @return
	 */
	Page<Tour> findForGrouPage(Tour tour, Pageable pageable);
	
	/**
	 *查询团账单完成状态
	 * @param tourId
	 * @return
	 */
	public Tour findAllCheckByTourId(String tourId);
	
	/**
	 * region 订单分页
	 * @param tour
	 * @param pageable
	 * @return
	 */
	public Page<Tour> findTourOfRegionPage(Tour tour, Pageable pageable);
	
	/**
	 * office 订单分页
	 * @param tour
	 * @param pageable
	 * @return
	 */
	public Page<Tour> findTourOfOrderPage(Tour tour, Pageable pageable);
	
	/**
	 * group 订单分页
	 * @param tour
	 * @param pageable
	 * @return
	 */
	public Page<Tour> findTourOfGroupPage(Tour tour, Pageable pageable);
	
	/**
	 *  团订单分页
	 * @param tour
	 * @param pageable
	 * @return
	 */
	public Page<Tour> findTourOfUserForPage(Tour tour, Pageable pageable);
	/**
	 * op团下航班分页
	 * @param tour
	 * @param pageable
	 * @return
	 */
	public Page<CustomerFlight> findFlightForOpForPage(CustomerFlight customerFlight, Pageable pageable);
	/**
	 * 查询 agent 订单下 总人数
	 * @param tour
	 * @return
	 */
	public Tour findTourOfOrderSumPepole(Tour tour);
	/**
	 * 查询 Group 订单下 总人数
	 * @param tour
	 * @return
	 */
	public Tour findTourOfGroupSumPepole(Tour tour);
	
	/**
	 * 查询 Region 订单下 总人数
	 * @param tour
	 * @return
	 */
	public Tour findTourOfRegionSumPepole(Tour tour);
	
	/**
	 * 通过传入的tour来查找所有tour(非自组)
	 */
	public List<Tour> findList(Tour tour);
	
	/**
	 * 通过传入的tour来查找所有tour（自组）
	 */
	public List<Tour> findListForSingle(Tour tour);
	
	List<Tour> findListForTour(Tour tour);

	public void changeTotalPeople(int i, String tourCode);

	public Tour findTourOfUserSumPepole(Tour tour);
	
	public List<FlightWithCustomers> getCustomerFlightList(CustomerFlight customerFlight);
}
