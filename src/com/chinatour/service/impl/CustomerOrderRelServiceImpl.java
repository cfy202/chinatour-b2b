package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.Car;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.service.CustomerOrderRelService;

/**
 * Service  客人订单关系
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:13:58
 * @revision  3.0
 */
@Service("customerOrderRelServiceImpl")
public class CustomerOrderRelServiceImpl extends BaseServiceImpl<CustomerOrderRel, String> implements CustomerOrderRelService{
	
	@Autowired
	 private CustomerOrderRelMapper customerOrderRelMapper;
	 
	 @Autowired
	 public void setBaseMapper(CustomerOrderRelMapper customerOrderRelMapper) {
	        super.setBaseMapper(customerOrderRelMapper);
	 }

	@Override
	public List<CustomerOrderRel> findByOrderId(String id) {
		return customerOrderRelMapper.findByOrderId(id);
	}
	
	//根据OrderId查询出List（包含Customer），要求不被删除的
	@Override
	public List<CustomerOrderRel> findNotDelCustomerByOrderId(String orderId){
		return customerOrderRelMapper.findNotDelCustomerByOrderId(orderId);
	}
	
	@Override
	@Transactional(readOnly=true)
	public CustomerOrderRel findWithCustomerById(String id){
		return customerOrderRelMapper.findWithCustomerById(id);
	}

	@Override
	public List<CustomerOrderRel> findCustomerByOrderId(String id) {
		return customerOrderRelMapper.findCustomerByOrderId(id);
	}

	@Override
	public List<CustomerOrderRel> find(CustomerOrderRel customerOrderRel) {
		return customerOrderRelMapper.find(customerOrderRel);
	}

	@Override
	public int findMaxCustomerOrderNo(String id) {
		return customerOrderRelMapper.findMaxCustomerOrderNo(id);
	}

	@Override
	public void updateByOrderId(CustomerOrderRel customerOrderRel) {
		customerOrderRelMapper.updateByOrderId(customerOrderRel);
	}

	@Override
	public int findMaxCustomerOrderNoByOrdersTotalId(String ordersTotalId) {
		return customerOrderRelMapper.findMaxCustomerOrderNoByOrdersTotalId(ordersTotalId);
	}

	@Override
	public int findCountCustomerByOrderId(CustomerOrderRel customerOrderRel) {
		return customerOrderRelMapper.findCountCustomerByOrderId(customerOrderRel);
	}

	@Override
	public int countExistCustomersInOrdersTotal(String ordersTotalId) {
		return customerOrderRelMapper.countExistCustomersInOrdersTotal(ordersTotalId);
	}

	@Override
	public List<com.chinatour.entity.CustomerOrderRel> CustomerOrderRel(
			String orderTotalId) {
		return customerOrderRelMapper.findCustomerTotalForInvoice(orderTotalId);
	}

	@Override
	public void deleteId(String customerOrderRelId) {
		customerOrderRelMapper.deleteId(customerOrderRelId);
	}

	@Override
	public List<CustomerOrderRel> getNoRoom(String ordersTotalId) {
		return customerOrderRelMapper.getNoRoom(ordersTotalId);
	}

	@Override
	public List<CustomerOrderRel> findRoomCustomer(String orderTotalId) {
		return customerOrderRelMapper.findRoomCustomer(orderTotalId);
	}

	@Override
	public List<CustomerOrderRel> getKingRoom(String ordersTotalId) {
		return customerOrderRelMapper.getKingRoom(ordersTotalId);
	}

	@Override
	public void saveCarInfo(Car car,String[] customerOrderRelIds) {
		customerOrderRelMapper.saveCarInfo(car,customerOrderRelIds);
	}
}
