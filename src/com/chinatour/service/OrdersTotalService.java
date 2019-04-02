package com.chinatour.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.OrdersTotal;

/**
 * Service 总订单信息
 * 
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time 2014-12-19 下午16:15:53
 * @revision 3.0
 */
public interface OrdersTotalService extends BaseService<OrdersTotal,String> {
	
	/**
	 * 保存总订单,并返回
	 * 
	 * @param ordersTotal
	 * @param customer
	 * @param customerArray
	 * @return
	 */
	public OrdersTotal saveTotalOrder(OrdersTotal ordersTotal);
	
	/**
	 * 更新总订单
	 * 
	 * @param ordersTotal
	 */
	public void updateOrdersTotal(OrdersTotal ordersTotal);
	
	/**
	 * 根据总订单ID查找出总订单和所属客人信息
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	public Map<String,Object> findTotalOrder(String ordersTotalId);
	
	/**
	 * 检查客人的名称是否重复
	 * 
	 * @param customerOrderRel
	 * @return
	 */
	public boolean checkCustomerName(Customer customer);
	
	/**
	 * 给总订单添加客人,返回OrdersTotalId
	 * 
	 * @param customer
	 * @param ordersTotalId
	 */
	public Map<String, Object> addCustomer(CustomerOrderRel customerOrderRel);
	
	/**
	 * 将选择出的客人添加到订单中
	 * @param customerOrderRel
	 * @return
	 */
	public String addCustomerForSelect(CustomerOrderRel customerOrderRel);
	
	/**
	 * 根据总订单ID和房型查出客人
	 * 
	 * @param ordersTotalId
	 * @param guestRoomType
	 * @return
	 */
	public List<CustomerOrderRel> getRoommates(String ordersTotalId,String guestRoomType);
	
	/**
	 * 根据总订单ID，房型，房号查出客人
	 * 
	 * @param ordersTotalId
	 * @param guestRoomType
	 * @param roomNumber
	 * @return
	 */
	public List<CustomerOrderRel> getRoommatesWithRoomNumber(String ordersTotalId,String guestRoomType,int roomNumber);
	
	
	/**
	 * 修改客人信息
	 * 
	 * @param customerOrderRel
	 * @return
	 */
	public void updateCustomer(CustomerOrderRel customerOrderRel);
	
	/**
	 * 修改客人信息(同行用户)
	 * 
	 * @param customerOrderRel
	 * @return
	 */
	public void updateCustomerByPeerUser(CustomerOrderRel customerOrderRel);
	

	/**
	 * 根据总订单ID查出所有客人(添加产品时添加航班时选择)
	 * 
	 * @param ordersTotalId
	 * @return
	 */
	public List<Customer> findCustomersByOrdersTotalId(String ordersTotalId);
	
	/**
	 * 根据子订单ID查出所有客人(编辑产品时添加航班时选择)
	 * 
	 * @param orderId
	 * @return
	 */
	public List<Customer> findCustomersByOrderId(String orderId);
	
	/**
	 * 根据小组查询出总订单列表
	 * 
	 * @param ordersTotal
	 * @param pageable
	 * @return
	 */
	public Page<OrdersTotal> findForGrouPage(OrdersTotal ordersTotal, Pageable pageable);
	
	/**
	 * 查询总订单结算状态
	 * @param ordersTotal
	 * @param pageable
	 * @return
	 */
	public Page<OrdersTotal> findOrderTotalTaxPage(OrdersTotal ordersTotal,
			Pageable pageable);

	/**
	 * 总订单ceo 查看
	 * @param ordersTotal
	 * @param pageable
	 * @return
	 */
	public Page<OrdersTotal> findOrderOfRegionList(OrdersTotal ordersTotal,
			Pageable pageable);
	
	/**
	 * 查看总人数和总应收团款
	 * @param ordersTotal
	 * @return
	 */
	public OrdersTotal findOrderTotalSumPepole(OrdersTotal ordersTotal);
	
	/**
	 * Group
	 * 查看总人数和总应收团款
	 * @param ordersTotal
	 * @return
	 */
	public OrdersTotal findGroupOrderTotalSumPepole(OrdersTotal ordersTotal);
	
	/**
	 * region
	 * 查看总人数和总应收团款
	 * @param ordersTotal
	 * @return
	 */
	public OrdersTotal findRegionOrderTotalSumPepole(OrdersTotal ordersTotal);

	public Page<OrdersTotal> findOrderTotalTaxGroupPage(
			OrdersTotal ordersTotal, Pageable pageable);

	public OrdersTotal findSumPepoleAndPayOrCost(OrdersTotal ordersTotal);
	
	/**
	 * 财务结算list 页面打印 
	 * @param ordersTotal
	 * @return
	 */
	public List<OrdersTotal> findOrderTotalTaxPrint(OrdersTotal ordersTotal);

	public OrdersTotal findGroupSumPepoleAndPayOrCost(OrdersTotal ordersTotal);

	public List<OrdersTotal> findGroupOrderTotalTaxPrint(OrdersTotal ordersTotal);
	/**
	 * 删除没有子订单的总订单的所有相关信息（彻底删除）主要用于同行用户下的订单
	 * */
	void delTotalInfo(String peerUserId);
}
