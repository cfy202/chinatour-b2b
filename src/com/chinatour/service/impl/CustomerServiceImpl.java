/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.Zipcode;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.ZipcodeMapper;
import com.chinatour.service.CustomerService;

/**
 * Service  客人信息
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:04:27
 * @revision  3.0
 */
@Service("customerServiceImpl")
public class CustomerServiceImpl extends BaseServiceImpl<Customer, String> implements CustomerService{
 	@Autowired
    private CustomerMapper customerMapper;
 	@Autowired
	private ZipcodeMapper zipcodeMapper;
 	
    @Autowired
    public void setBaseMapper(CustomerMapper customerMapper) {
        super.setBaseMapper(customerMapper);
    }

	@Override
	public List<Customer> find(Customer customer) {
		return customerMapper.find(customer);
	}

	@Override
	public Customer findCustomerTourInfo(Customer customer) {
		return customerMapper.findCustomerTourInfo(customer);
	}

	@Override
	public List<Customer> findCustomerForOrder(Customer customer) {
		return customerMapper.findCustomerForOrder(customer);
	}

	@Override
	public void deleteId(String customerId) {
		customerMapper.deleteId(customerId);
	}

	@Override
	public List<Customer> findCustomerList(Customer customer) {
		return customerMapper.findCustomerList(customer);
	}

	@Override
	public int findCountCustomerList(Customer customer) {
		return customerMapper.findCountCustomerList(customer);
	}

	@Override
	public Page<Customer> findAllCustomerListForPage(Customer customer,
			Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<Customer> page = customerMapper.findAllCustomerListForPage(customer,pageable);
        int pageCount = customerMapper.findAllCustomerListForPageCount(customer,pageable);
        return new Page<Customer>(page, pageCount, pageable);
	}

	@Override
	public List<Zipcode> findSelect(Zipcode zipcode) {
		return zipcodeMapper.findSelect(zipcode);
	}
}


