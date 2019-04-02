package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.Car;
import com.chinatour.entity.CustomerOrderRel;

/**
 * Service  客人订单关系
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:38:14
 * @revision  3.0
 */
public interface CustomerOrderRelService extends BaseService<CustomerOrderRel,String>{
	
	public List<CustomerOrderRel> findByOrderId(String id);
	
	public CustomerOrderRel findWithCustomerById(String id);

	public List<CustomerOrderRel> findCustomerByOrderId(String id);

	public List<CustomerOrderRel> find(CustomerOrderRel customerOrderRel);

	public int findMaxCustomerOrderNo(String id);

	public void updateByOrderId(CustomerOrderRel customerOrderRel);

	public int findMaxCustomerOrderNoByOrdersTotalId(String ordersTotalId);

	public int findCountCustomerByOrderId(CustomerOrderRel customerOrderRel);
	
	//根据OrderId查询出List（包含Customer），要求不被删除的
	public List<CustomerOrderRel> findNotDelCustomerByOrderId(String orderId);
	//根据OrdersId查找出有效的客人人数
	public int countExistCustomersInOrdersTotal(String ordersTotalId);
	
	List<CustomerOrderRel> CustomerOrderRel(String orderTotalId);
	
	/**
	 * orderTotalId查找已组房型的客人(PeerUSer)
	 * */
	List<CustomerOrderRel> findRoomCustomer(String orderTotalId);
	/**
	 * 彻底删除关系
	 * */
	void deleteId(String customerOrderRelId);
	/*
	 *ordersTotalId查找未组客人
	 * */
	List<CustomerOrderRel> getNoRoom(String ordersTotalId);
	/**
	 * 获取客人可加人的的房间及客人信息
	 * */
	List<CustomerOrderRel> getKingRoom(String ordersTotalId);
	
	/**
	 * 保存拼车信息
	 * @param carInfo
	 */
	void saveCarInfo(Car car,String[] customerOrderRelIds);
	
}
