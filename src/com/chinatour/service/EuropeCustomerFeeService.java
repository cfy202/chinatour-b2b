package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.EuropeCustomerFee;

public interface EuropeCustomerFeeService extends BaseService<EuropeCustomerFee, String> {
	List<EuropeCustomerFee> findCustomerWithFee(String orderId);
	List<EuropeCustomerFee> find(EuropeCustomerFee europeCustomerFee);
}
