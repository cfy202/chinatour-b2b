package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.Order;
import com.chinatour.entity.Zipcode;
import com.chinatour.vo.TourOrderListVO;

/**
 * Service  客人信息
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:35:02
 * @revision  3.0
 */
public interface CustomerService extends BaseService<Customer, String>{

	List<Customer> find(Customer customer);

	Customer findCustomerTourInfo(Customer customer);
	
	List<Customer> findCustomerForOrder(Customer customer);
	/**彻底删除客人*/
	void deleteId(String customerId);
	
	List<Customer> findCustomerList(Customer customer);
	
	int findCountCustomerList(Customer customer);
	
	public Page<Customer> findAllCustomerListForPage(Customer customer, Pageable pageable);
	List<Zipcode> findSelect(Zipcode zipcode);
}
