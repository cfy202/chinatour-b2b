package com.chinatour.service;

import java.io.File;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;
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
 * @create-time 2014-9-4 上午10:32:53
 * @revision 3.0
 */
public interface OrderService extends BaseService<Order, String> {


	/**
	 * 添加产品
	 * 
	 * @param productVO
	 */
	public void saveProduct(ProductVO  productVO);
	/**
	 * 添加产品
	 * 
	 * @param productVO
	 */
	public void saveProductNew(ProductVO  productVO);
	
	/**
	 * 根据子订单ID加载产品
	 * 
	 * @param ordersId
	 * @return
	 */
	public ProductVO loadProduct(String ordersId);
	
	/**
	 * 更新团订单产品
	 * 
	 * @param productVO
	 * @param deleteItemIds
	 */
	public void updateProduct(ProductVO productVO,String[] deleteItemIds);
	/**
	 * 更新团订单产品
	 * 
	 * @param productVO
	 * @param deleteItemIds
	 */
	public void updateProductNew(ProductVO productVO,String[] deleteItemIds);
	
	/**
	 * 根据订单ID取消订单
	 * @param orderId
	 */
	public String cancelOrder(String orderId);
	
	/**
	 * 根据订单ID恢复订单
	 * @param orderId
	 */
	public String recoverOrder(String orderId);
	
	/**
	 * 根据订单ID加载收入支出
	 * @param orderId
	 * @return
	 */
	public PayCostEditVO findPayCostByOrderId(String orderId);
	
	/**
	 * 更新收入支出
	 * @param tourOrderPayCostVO
	 */
	public void updatePayCost(PayCostEditVO payCostEditVO);
	
	/**
	 * 查找到团订单list列表
	 * 若用户已分组,查出组下的团订单
	 * 若未分组,查出该用户下的团订单
	 * 
	 * @param order
	 * @param pageable
	 * @return
	 */
	public Page<TourOrderListVO> findTourOrderListVO(Order order, Pageable pageable);
	
	/**
	 * 本小组订单分页
	 * @param order
	 * @param pageable
	 * @return
	 */
	Page<Order> findForGrouPage(Order order, Pageable pageable);
	

	/**
	 * 查询订单
	 * @return
	 */
	public List<Order> find(Order order);
	
	/**
	 * 查询订单的agent
	 * @returns
	 */
	public List<Order> findUserOfOrder(Order order);
	

	/**
	 * 根据订单ID查找客人
	 * 
	 * @param id
	 * @return
	 */
	public Page<Customer> findCustomerPagesByOrderId(Pageable pageable,String orderId);
	
	/**
	 * 取消客人
	 * 
	 * @param customerId
	 * @param orderId
	 */
	public String cancelCustomer(String customerOrderRelId);
	
	/**
	 * 恢复客人
	 * @param customerId
	 * @param orderId
	 */
	public String recoverCustomer(String customerOrderRelId);
	
	/**
	 * 查找团下订单的收入支出
	 * @param order
	 * @return
	 */
	public List<Order> findOrderOfPayOrCost(Order order);
	
	/**
	 * 查询订单的总利润
	 * @param order
	 * @return
	 */
	public Order findOrderProfit(Order order);
	
	/**
	 * 分页 	查询订单结算状态
	 * @param order
	 * @param pageable
	 * @return
	 */
	public Page<Order> findOrderOfTourTaxPage(Order order, Pageable pageable);
	
	@Transactional
	public void billOrdersProfitCredit(OrdersTotal ordersTotal,List<Order> orderList,SettlementTotalVO settlementTotalVO);
	
	//变更单结算发送5%操作团利润，本部门不发送
	@Transactional
	public void billOrdersChangeProfitCredit(String[] orderIds,String toRateOfCurrencyId);
	
	
	/**
	 * 分页 	region查看订单
	 * @param order
	 * @param pageable
	 * @return
	 */
	public Page<Order> findOrderOfRegionList(Order order, Pageable pageable);
	
	/**
	 * 查看所以客人
	 * @param tourId
	 * @return
	 */
	public List<Order> findCustomerForTourId(String tourId);
	
	/**
	 * 查询一个团下的订单
	 * 
	 */
	public List<Order> findByTourId(String tourId);
	
	/**
	 * 查询一个订单的客人
	 * @param orderId
	 * @return
	 */
	public Order findCustomerForOrderId(String orderId);
	/**
	 * 根据总订单Id查找子订单
	 * @param orderTotalId
	 * @return
	 */
	public List<Order> findChildOrderList(String orderTotalId);
	
	/**
	 * 保存非团订单
	 * 
	 * @param singleOrdersVO
	 */
	public void saveSingleProduct(SingleOrdersVO singleOrdersVO);
	
	/**
	 * 根据订单ID加载出非团订单
	 * 
	 * @param ordersId
	 * @return
	 */
	public SingleOrdersVO loadSingleProduct(String ordersId);
	
	/**
	 * 修改非团订单
	 * 
	 * @param singleOrdersVO
	 */
	public void updateSingleProduct(SingleOrdersVO singleOrdersVO);
	/**
	 * 查询一个总单下的子订单
	 */
	public List<Order> findByOrdersTotalId(String ordersTotalId);

	public Page<Order> findForGroupPage(Order order, Pageable pageable);
	/**
	 * 
	 *查询订单人数
	 * */
	public TourOrderListVO findOrderSumPepole(Order order);
	
	/**
	 * 
	 *查询订单人数
	 * */
	public Order findRegionOrderSumPepole(Order order);
	
	/**
	 * 
	 *查询订单人数
	 * */
	public Order findGroupOrderSumPepole(Order order);
	
	/**
	 * 查出团下客人信息并根据团客人编号排序
	 * @param tourId
	 * @return
	 */
	public List<Order> findCustomerListByTourId(Order order);

	public void changeTotalPeopleByOrderId(int change,String orderId);
	
	public void confirmCancelOrder(Order order);
	
	public void confirmRecoverOrder(Order order);
	
	public void confirmCancelCustomer(CustomerOrderRel customerOrderRel);
	
	public void confirmRecoverCustomer(CustomerOrderRel customerOrderRel);
	
	public void confirmCancelTourCustomer(CustomerOrderRel customerOrderRel);
	
	public void confirmRecoverTourCustomer(CustomerOrderRel customerOrderRel);
	
	/**
	 * 根据客人ID查看相应的订单
	 * */
	public List<Order> getOrderByCusId(String customerId);
	
	
	/**
	 * 导入客人信息
	 */
	
	public List<Customer> importCustomer(File file);

	public Page<Order> findOrdersTaxPage(Order order, Pageable pageable);

	public Order findSumPepoleAndPayOrCost(Order order);

	public List<Order> findOrderTaxPrint(Order order);

	public Page<Order> findOrderTaxGroupPage(Order order, Pageable pageable);

	public Order findGroupSumPepoleAndPayOrCost(Order order);

	public List<Order> findGroupOrderTaxPrint(Order order);

	public List<Order> findTourOrderListVOPrint(Order order);

	public Order findAgentSumPayOrCost(Order order);

	public List<Order> findGroupOrderListPrint(Order order);

	public Order findForTourPageTotalPepole(Order order);
	/**
	 * 同行用户中查看佣金等其他费用
	 * */
	public List<Order> statementList(Order order);
	/**
	 * 同行用户佣金总和
	 * */
	public Order statementCount(Order order);
	
	/**
	 * 同行支付
	 */
	
	//Page<Order> queryOrderForVenderPage( Order order,Pageable pageable);
	
	//同行订单导出
	List<TourOrderListVO> findTourOrderListVOForExport(Order order);
	
	/**
	 * PeerUser删除客人，删除客人信息及客人订单关系
	 * 
	 * @param customerId
	 * @param orderId
	 */
	public String delCustomer(String customerOrderRelId);

	public List<Order> findSelect(Order order);
	
	public int findCount(Order order);
	
	/*按照RefNo查找Order*/
	public List<Order> findByRefNo(String RefNo);
	
	public List<Order> findByOrdersTotal(String ordersTotalNo);
}
