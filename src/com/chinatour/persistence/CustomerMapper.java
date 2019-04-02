package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.Customer;

/**
 * Dao   -  客人
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午9:16:27
 * @revision  3.0
 */
@Repository
public interface CustomerMapper extends BaseMapper<Customer, String> {
	
	Customer findByOrderId(String orderId);
	
	List<Customer> findByOrdersTotalId(String ordersTotalId);
	
	List<Customer> findByOrdersId(String ordersId);
	
	void saveCustomers(List<Customer> customerList);
	
	List<Customer> findByCustomerName(Customer customer);
	
	Customer findCustomerTourInfo(Customer customer);
	
	List<Customer> findCustomerForOrder(Customer customer);
	/**
	 * 彻底删除
	 * */
	void deleteId(String customerId);
	
	List<Customer> findCustomerList(Customer customer);
	
	int findCountCustomerList(Customer customer);
	
	List<Customer> findAllCustomerListForPage(@Param("record")Customer customer,@Param("page")Pageable pageable);
	int findAllCustomerListForPageCount(@Param("record")Customer customer,@Param("page")Pageable pageable);
}
