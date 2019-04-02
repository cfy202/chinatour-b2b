/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.CustomerFlight;
import com.chinatour.persistence.AdminMapper;
import com.chinatour.persistence.BaseMapper;
import com.chinatour.persistence.CustomerFlightMapper;
import com.chinatour.service.CustomerFlightService;

/**
 * Service  客人航班
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:07:10
 * @revision  3.0
 */
@Service("customerFlightServiceImpl")
public class CustomerFlightServiceImpl extends BaseServiceImpl<CustomerFlight,String> implements CustomerFlightService{
	 @Autowired
	 private CustomerFlightMapper customerFlightMapper;
	
	 @Autowired
	 public void setBaseMapper(CustomerFlightMapper customerFlightMapper) {
	        super.setBaseMapper(customerFlightMapper);
	 }

	@Override
	public List<CustomerFlight> findFlightList(CustomerFlight customerFlight) {
		return customerFlightMapper.findFlightList(customerFlight);
	}

	@Override
	public List<CustomerFlight> find(CustomerFlight customerFlight) {
		return customerFlightMapper.find(customerFlight);
	}

	@Override
	public void removeById(String id) {
		customerFlightMapper.removeById(id);
		
	}

	@Override
	public void deleteById(String id) {
		customerFlightMapper.deleteById(id);
	}
}
