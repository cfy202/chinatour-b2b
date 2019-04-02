package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.entity.Car;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerOrderRel;

/**
 * Dao  客人订单关系
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:40:23
 * @revision  3.0
 */
@Repository
public interface CustomerOrderRelMapper extends BaseMapper<CustomerOrderRel, String>{
	
	/**
	 * 根据子订单ID和总订单ID查出CustomerOrderRel
	 * 
	 * @param ordersTotalId
	 * @param ordersId
	 * @return
	 */
	List<CustomerOrderRel> findByOrderId(String orderId);
	
	/**
	 * 根据子订单ID和总订单ID查出CustomerOrderRel，连同customerFlight一起查出来
	 * @param orderId
	 * @return
	 */
	List<CustomerOrderRel> findWithCustomerFlightByOrderIdAndOrdersTotalId(@Param("ordersTotalId")String ordersTotalId,@Param("orderId")String orderId);
	
	/**
	 * 根据总订单ID查出同产品的一组CustomerOrderRel
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	List<CustomerOrderRel> findBySameProductOrdersTotalId(String ordersTotalId);
	
	/**
	 * 根据总订单ID查出同产品的一组CustomerOrderRel,包含Customer 根据客人编号排序
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	List<CustomerOrderRel> findWithCustomerByOrdersTotalId(String ordersTotalId);
	/**
	 * 根据总订单ID查出同产品的一组CustomerOrderRel,包含Customer 根据房号排序
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	List<CustomerOrderRel> findByOrdersTotalIdRoomNum(String ordersTotalId);
	
	/**
	 * 根据总订单ID和客人ID查出未取消子订单对应的customerOrderRel 
	 * 
	 * @param customerId
	 * @param orderId
	 * @return
	 */
	List<CustomerOrderRel> findExistOrdersByCustomerIdAndOrdersTotalId(@Param("customerId")String customerId,@Param("ordersTotalId")String ordersTotalId);
	
	/**
	 * 根据总订单ID和客人ID查出所有订单对应的customerOrderRel 
	 * 
	 * @param customerId
	 * @param orderId
	 * @return
	 */
	List<CustomerOrderRel> findAllOrdersByCustomerIdAndOrdersTotalId(@Param("customerId")String customerId,@Param("ordersTotalId")String ordersTotalId);
	
	/**
	 * 根据总订单ID查出最大的订单中客人编号
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	int findMaxCustomerOrderNoByOrdersTotalId(String ordersTotalId);
	
	/**
	 * 根据总订单ID查出客人最大的房间号
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	int findMaxRoomNumberByOrdersTotalId(String ordersTotalId);
	
	/**
	 * 根据客人ID和总订单ID更新房型和房号字段
	 */
	void updateRoomTypeAndRoomNumberByCustomerIdAndOrdersTotalId(@Param("roomType")String roomType,@Param("roomNumber")Integer roomNumber,@Param("customerId")String customerId,@Param("ordersTotalId")String ordersTotalId);
	
	/**
	 * 根据总订单ID和房间号设置该房间满员
	 * 
	 * @param ordersTotalId
	 */
	void setRoomIsFullByRoomNumberAndOrdersTotalId(@Param("ordersTotalId")String ordersTotalId,@Param("roomNumber")Integer roomNumber,@Param("roomIsFull")Integer roomIsFull);
	
	/**
	 * 根据总订单Id和房号出该房的加床数量
	 * 
	 * @param ordersTotalId
	 * @param roomNumber
	 * @return
	 */
	String getExtraBedCustomerWithRoomNumberAndOrdersTotalId(@Param("ordersTotalId")String ordersTotalId,@Param("roomNumber")Integer roomNumber);
	
	/**
	 * 根据总订单ID和房间号查询客人数量
	 * 
	 * @param ordersTotalId
	 * @param roomNumber
	 * @return
	 */
	int findCustomerNumberByRoomNumberAndOrdersTotalId(@Param("ordersTotalId")String ordersTotalId,@Param("roomNumber")Integer roomNumber);
	
	/**
	 * 根据总订单ID和房型查出客人
	 * 
	 * @param ordersTotalId
	 * @param guestRoomType
	 * @return
	 */
	public List<CustomerOrderRel> getRoommates(@Param("ordersTotalId")String ordersTotalId,@Param("guestRoomType")String guestRoomType);
	
	/**
	 * 根据总单Id查找未组房客人
	 * */
	public List<CustomerOrderRel> getNoRoom(@Param("ordersTotalId")String ordersTotalId);
	
	/**
	 * 根据总订单ID查出可以添加extra bed的客人
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	public List<CustomerOrderRel> getRoommatesWithExtraBed(String ordersTotalId);
	
	/**
	 * 根据总订单ID和房型,或根据房号查出客人
	 * 
	 * @param ordersTotalId
	 * @param guestRoomType
	 * @return
	 */
	public List<CustomerOrderRel> getRoommatesWithRoomNumber(@Param("ordersTotalId")String ordersTotalId,@Param("guestRoomType")String guestRoomType,@Param("roomNumber")int roomNumber);
	
	/**
	 * 根据总订单ID查出Extra可组的客人以及已组的客人
	 * 
	 * @return
	 */
	public List<CustomerOrderRel> getExtraBedRoommatesWithRoomNumber(@Param("ordersTotalId")String ordersTotalId,@Param("roomNumber")int roomNumber);
	
	/**
	 * 根据总订单ID返回一条CustomerOrderRelId
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	String findOneIdByOrdersTotalId(String ordersTotalId);
	
	/**
	 * 根据ID查询出客人信息
	 * @param id
	 * @return
	 */
	CustomerOrderRel findWithCustomerById(String id);
	
	void saveCustomerOrderRels(@Param("customerOrderRelList")List<CustomerOrderRel> customerOrderRelList);
	
	void setOrderIdByIds(@Param("orderId") String orderId,@Param("ids")String... ids);
	
	int findMaxCustomerTourNo(String tourId);
	
	int findMaxCustomerOrderNo(String orderId);
	
	int updateByOrderId(CustomerOrderRel customerOrderRel);
	
	void recoverByCustomerIdAndOrdersTotalId(@Param("customerId")String customerId,@Param("ordersTotalId")String orderId);

	void changeCustomerState(@Param("customerOrderRelId")String customerOrderRelId,@Param("isDel")Integer isDel);
	
	int updateGuestRoomTypeByCustomerIdAndOrderId(@Param("guestRoomType")String guestRoomType,@Param("customerId")String customerId,@Param("orderId")String orderId);
	
	void updateTicketTypeByCusIdAndOrdersTotalId(@Param("ticketType")String ticketType,@Param("customerId")String customerId,@Param("ordersTotalId")String ordersTotalId); 
	
	List<CustomerOrderRel> findCustomerByOrderId(String id);
	
	void cancelAllCustomerByOrderId(String orderId);
	
	void recoverAllCustomerByOrderId(@Param("orderId")String orderId,@Param("totalPeople")int totalPeople);
	
	int countCustomersInOrdersTotal(String ordersTotalId);
	
	int countExistCustomersInOrdersTotal(String ordersTotalId);
	
	void setContactFlagByCusIdAndOrToId(@Param("contactFlag")int contactFlag,@Param("customerId")String customerId,@Param("ordersTotalId")String ordersTotalId);

	int findCountCustomerByOrderId(CustomerOrderRel customerOrderRel);

	int counTourCustomersByOrderId(String orderId);

	int findCountIsDelByOrderId(CustomerOrderRel customerOrderRel);
	
	//根据OrderId查询出List（包含Customer），要求不被删除的
	List<CustomerOrderRel> findNotDelCustomerByOrderId(String orderId);
	/**
	 * 根据总订单Id查找出 客人个数（不包括和总订单去除关系）contactFlag=0 客人在总订单下有效
	 * */
	int findCountByOrdersTotalId(String ordersTotalId);
	
	//查找总单中未删除的客人
	List<CustomerOrderRel> findCustomerTotalForInvoice(String orderTotalId);
	/**
	 * 彻底删除关系
	 * */
	void deleteId(String customerOrderRelId);
	/**
	 * 查找已组房型的客人(PeerUSer)
	 * */
	List<CustomerOrderRel> findRoomCustomer(String orderTotalId);

	List<CustomerOrderRel> getKingRoom(String orderTotalId);
	/**
	 * 没有子订单的关系表信息
	 * */
	List<CustomerOrderRel> findRelByPeerUserId(CustomerOrderRel customerOrderRel);
	
	/**
	 * 保存拼车信息
	 */
	
	void saveCarInfo(@Param("car")Car car,@Param("customerOrderRelIds")String[] customerOrderRelIds);
	
	List<CustomerOrderRel> findByOrdersTotalIdOrderNo(String ordersTotalId);
}
