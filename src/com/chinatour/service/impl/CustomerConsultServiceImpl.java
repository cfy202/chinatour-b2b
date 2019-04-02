package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerConsult;
import com.chinatour.persistence.CustomerConsultMapper;
import com.chinatour.service.CustomerConsultService;
@Service("customerConsultServiceImpl")
public class CustomerConsultServiceImpl extends BaseServiceImpl<CustomerConsult, String> implements CustomerConsultService {
	@Autowired
	private CustomerConsultMapper customerConsultMapper;
	@Autowired
	public void setBaseMapper(CustomerConsultMapper customerConsultMapper){
		super.setBaseMapper(customerConsultMapper);
	}
	@Override
	public List<CustomerConsult> findByCustomerId(String customerId) {
		return customerConsultMapper.findByCustomerId(customerId);
	}
	@Override
	public CustomerConsult findCountCustomerConsult(
			CustomerConsult customerConsult) {
		return customerConsultMapper.findCountCustomerConsult(customerConsult);
	}
	@Override
	public List<CustomerConsult> find(CustomerConsult customerConsult) {
		return customerConsultMapper.find(customerConsult);
	}
	@Override
	public Page<CustomerConsult> findRegionForPage(
			CustomerConsult customerConsult, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<CustomerConsult> page = customerConsultMapper.findRegionForPage(customerConsult, pageable);
        int pageCount = customerConsultMapper.findRegionForPageCount(customerConsult, pageable);
        return new Page<CustomerConsult>(page, pageCount, pageable);
	}
	@Override
	public int findForEndDate(CustomerConsult customerConsult) {
		return customerConsultMapper.findForEndDate(customerConsult);
	}
}
