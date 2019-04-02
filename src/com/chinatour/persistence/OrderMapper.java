package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.Order;
import com.chinatour.vo.TourOrderListVO;

/**
 * Dao 订单信息
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:42:22
 * @revision  3.0
 */
@Repository
public interface OrderMapper extends BaseMapper<Order, String> {
	
	List<Order> findByOrdersTotalId(String ordersTotalId);
	
	List<Order> findByTourId(String tourId);
	
	List<Order> findForGroupPage(@Param("record")Order order, @Param("page")Pageable pageable);
	
	int findForGroupPageCount(@Param("record")Order order, @Param("page")Pageable pageable);
	
	List<Order> findForGroupPageForAgency(@Param("record")Order order, @Param("page")Pageable pageable);
	
	int findForGroupPageCountForAgency(@Param("record")Order order, @Param("page")Pageable pageable);

	List<Order> findUserOfOrder(Order order);
	
	/**
	 * 根据子订单ID变动子订单的总人数
	 * 
	 * @param change
	 * @param ordersTotalId
	 */
	void changeTotalPeopleByOrderId(@Param("change")int change,@Param("orderId")String orderId);
	
	/**
	 * 根据总订单ID变动未删除子订单的总人数
	 * 
	 * @param change
	 * @param ordersTotalId
	 */
	void changeTotalPeopleInExistOrders(@Param("change")int change,@Param("ordersTotalId")String ordersTotalId);
	
	/**
	 * 根据总订单ID变动未删除子订单的总人数
	 * 
	 * @param change
	 * @param ordersTotalId
	 */
	void changeTotalPeopleByOrdersTotalId(@Param("change")int change,@Param("ordersTotalId")String ordersTotalId);
	
	/**
	 * 
	 * @param peerId
	 * @param ordersTotalId
	 */
	void updateTourOrdersByOrdersTotalId(@Param("peerId")String peerId,@Param("contact")String contact,@Param("orderType")int orderType,@Param("ordersTotalId")String ordersTotalId);
	
	/**
	 * 
	 * @param peerId
	 * @param ordersTotalId
	 */
	void updateSingleOrdersByOrdersTotalId(@Param("peerId")String peerId,@Param("contact")String contact,@Param("ordersTotalId")String ordersTotalId);
	
	List<Order> findOrderOfPayOrCost(Order order);

	Order findOrderProfit(Order order);

	List<Order> findOrderOfTourTaxPage(@Param("record")Order order, @Param("page")Pageable pageable);

	int findOrderOfTourTaxPageCount(@Param("record")Order order, @Param("page")Pageable pageable);

	List<Order> findOrderOfRegionPage(@Param("record")Order order, @Param("page")Pageable pageable);

	int findOrderOfRegionPageCount(@Param("record")Order order, @Param("page")Pageable pageable);
	
	List<TourOrderListVO> findTourOrderListVOForPage(@Param("record")Order order,@Param("page")Pageable pageable);
	
	/**
	 * 
	 * @param order
	 * @param tourTypeIdList
	 * @param pageable
	 * @return
	 */
	List<Order> findForTourPage(@Param("record") Order order, @Param("tourTypeIdList") List<String> tourTypeIdList, @Param("page") Pageable pageable);
	
	List<Order> findForTourPage(@Param("record") Order order, @Param("page") Pageable pageable);
	
	/**
	 * 
	 * @param order
	 * @param tourTypeIdList
	 * @param pageable
	 * @return
	 */
	int findForTourPageCount(@Param("record") Order order, @Param("page") Pageable pageable);
	int findForTourPageCount(@Param("record") Order order, @Param("tourTypeIdList") List<String> tourTypeIdList, @Param("page") Pageable pageable);

	List<Order> findCustomerForTourId(String tourId);

	Order findCustomerForOrderId(String orderId);
	
	List<Order> findChildOrderList(String orderTotalId);
	
	/**
	 * 修改非团订单时更新Order
	 * 
	 * @param order
	 */
	void updateFlightPnrAndArriveDate(Order order);

	TourOrderListVO findOrderSumPepole(Order order);

	Order findRegionOrderSumPepole(Order order);

	Order findGroupOrderSumPepole(Order order);
	
	List<Order> findByTourIdForArr(String orderTotalId);

	List<Order> findCustomerListByTourId(Order order);
	/**
	 * 根据客人ID查找订单
	 * */
	List<Order> queryOrderByCusId(String customerId);
	
	/* 根据总订单查找存在的订单  */
	int countExistOrdersInOrdersTotal(String ordersTotalId);
	
	/* 根据子订单id设置订单状态 */
	void changeStateByOrderId(@Param("orderId")String orderId,@Param("state")int state);
	
	/* 根据子订单id设置订单状态并且将人设置为0 */
	void changeTotalPeopleOfStateByOrderId(@Param("orderId")String orderId, @Param("change")int change, @Param("state")int state);
	
	void setTotalPeopleByOrderId(@Param("totalPeople")int totalPeople,@Param("orderId")String orderId);

	List<Order> findOrdersTaxPage(@Param("record")Order order, @Param("page")Pageable pageable);

	int findOrdersTaxPageCount(@Param("record")Order order, @Param("page")Pageable pageable);

	Order findSumPepoleAndPayOrCost(Order order);

	List<Order> findOrderTaxPrint(Order order);

	List<Order> findOrderTaxGroupPage(@Param("record")Order order, @Param("page")Pageable pageable);

	int findOrderTaxGroupPageCount(@Param("record")Order order, @Param("page")Pageable pageable);

	Order findGroupSumPepoleAndPayOrCost(Order order);

	List<Order> findGroupOrderTaxPrint(Order order);

	List<Order> findTourOrderListVOPrint(Order order);

	Order findAgentSumPayOrCost(Order order);

	List<Order> findGroupOrderListPrint(Order order);

	Order findForTourPageTotalPepole(Order order);
	
	/**订单详情（统计中使用）*/
	List<Order> orderDetailsPage(@Param("record")Order order, @Param("page")Pageable pageable);
	int orderDetailsPageCount(@Param("record")Order order, @Param("page")Pageable pageable);
	Order detailsCount(@Param("record")Order order);
	
	/**订单详情（统计中使用）Product Brand*/
	List<Order> orderDetailsTPage(@Param("record")Order order, @Param("page")Pageable pageable);
	int orderDetailsTPageCount(@Param("record")Order order, @Param("page")Pageable pageable);
	Order detailsCountT(@Param("record")Order order);
	
	/**订单详情（统计中使用 Booking）*/
	List<Order> orderDetailsBPage(@Param("record")Order order, @Param("page")Pageable pageable);
	int orderDetailsBPageCount(@Param("record")Order order, @Param("page")Pageable pageable);
	Order detailsCountB(@Param("record")Order order);
	
	/**订单详情（统计中使用 Booking）Product Brand*/
	List<Order> orderDetailsBTPage(@Param("record")Order order, @Param("page")Pageable pageable);
	int orderDetailsBTPageCount(@Param("record")Order order, @Param("page")Pageable pageable);
	Order detailsCountBT(@Param("record")Order order);
	/**
	 * 打印统计详情页面
	 * */
	List<Order> detailsPrint(@Param("record") Order order);
	List<Order> detailsTPrint(@Param("record") Order order);
	List<Order> detailsBPrint(@Param("record") Order order);
	List<Order> detailsBTPrint(@Param("record") Order order);
	

	List<Order> orderListWeb(@Param("record")Order order);

	List<Order> findOrderInfo(Order order);

	List<Order> sourceDetailsSPage(@Param("record")Order order, @Param("page")Pageable pageable);

	int sourceDetailsSPageCount(@Param("record")Order order, @Param("page")Pageable pageable);


	Order detailsCountS(@Param("record")Order order);

	List<Order> detailsSPrint(@Param("record") Order order);
	
	List<Order>	statementList(@Param("record") Order order);
	Order statementCount(@Param("record") Order order);
	List<TourOrderListVO> findTourOrderListVOForExport(Order order);

	List<Order> findSelect(Order order);
	
	int findCount(Order order);
	//通过总单号查询子单list
	List<Order> findByOrdersTotal(String ordersTotalId);
	List<Order> findByRefNo(String RefNo);
	/**
	 * 
	 */
	Order detailsCountOptional(@Param("record")Order order);
	/**订单详情（统计中使用 Booking）Product Brand*/
	List<Order> orderDetailsOptional(@Param("record")Order order, @Param("page")Pageable pageable);
	int orderDetailsOptioanlCount(@Param("record")Order order, @Param("page")Pageable pageable);
	List<Order> detailsOptionalPrint(@Param("record") Order order);
	//按抵达日期统计Optional订单数量
	Order detailsCountOptionalForArrival(@Param("record")Order order);
	//按抵达日期查找订单
	List<Order> ArrivalDetailsByOptional(@Param("record")Order order, @Param("page")Pageable pageable);
	int ArrivalDetailsOptioanlCount(@Param("record")Order order, @Param("page")Pageable pageable);
	//打印optional tour抵达日期订单
	List<Order> detailsOptionalPrintForArrival(@Param("record") Order order);
}
