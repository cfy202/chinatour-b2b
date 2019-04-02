package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.EuropeCustomerFee;
import com.chinatour.persistence.EuropeCustomerFeeMapper;
import com.chinatour.service.EuropeCustomerFeeService;
@Service("europeCustomerFeeServiceImpl")
public class EuropeCustomerFeeServiceImpl extends BaseServiceImpl<EuropeCustomerFee, String> implements EuropeCustomerFeeService {
	@Autowired
	private EuropeCustomerFeeMapper europeCustomerFeeMapper;
	@Autowired
	public void setBaseMapper(EuropeCustomerFeeMapper europeCustomerFeeMapper) {
    	super.setBaseMapper(europeCustomerFeeMapper);
	}
	@Override
	public List<EuropeCustomerFee> findCustomerWithFee(String orderId) {
		return europeCustomerFeeMapper.findCustomerWithFee(orderId);
	}
	@Override
	public List<EuropeCustomerFee> find(EuropeCustomerFee europeCustomerFee) {
		return europeCustomerFeeMapper.find(europeCustomerFee);
	}
}
