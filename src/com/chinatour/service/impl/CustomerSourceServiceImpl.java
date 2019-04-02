package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.CustomerSource;
import com.chinatour.persistence.CustomerSourceMapper;
import com.chinatour.service.CustomerSourceService;

/**
 * @author Jared
 *
 */
@Service("customerSourceServiceImpl")
public class CustomerSourceServiceImpl extends BaseServiceImpl<CustomerSource, String> implements CustomerSourceService {
	
	@Autowired
	private CustomerSourceMapper customerSourceMapper;
	
	@Autowired
	public void setCustomerSourceMapper(CustomerSourceMapper customerSourceMapper){
		super.setBaseMapper(customerSourceMapper);
	}

	/* (non-Javadoc)
	 * @see com.chinatour.service.CustomerSourceService#find(com.chinatour.entity.CustomerSource)
	 */
	@Override
	public List<CustomerSource> find(CustomerSource customerSource) {
		return customerSourceMapper.find(customerSource);
	}

	@Override
	public List<CustomerSource> findSource() {
		return customerSourceMapper.findSource();
	}
}
