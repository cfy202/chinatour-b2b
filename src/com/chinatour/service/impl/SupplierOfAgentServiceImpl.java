package com.chinatour.service.impl;




import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.SupplierOfAgent;
import com.chinatour.service.SupplierOfAgentService;
import com.chinatour.persistence.SupplierOfAgentMapper;
/**
 * Service 团账单 agent 供应商
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("supplierOfAgentServiceImpl")
public class SupplierOfAgentServiceImpl extends BaseServiceImpl<SupplierOfAgent, String> implements SupplierOfAgentService {

	@Autowired
	private SupplierOfAgentMapper supplierOfAgentMapper;
	
	@Autowired
	public void setBaseMapper(SupplierOfAgentMapper supplierOfAgentMapper) {
	    	super.setBaseMapper(supplierOfAgentMapper);
	}

	@Override
	public List<SupplierOfAgent> find(SupplierOfAgent supplierOfAgent) {
		return supplierOfAgentMapper.find(supplierOfAgent);
	}

	@Override
	public BigDecimal findSumOfAgentAndTourExceptInsurance(
			SupplierOfAgent supplierOfAgentS) {
		return supplierOfAgentMapper.findSumOfAgentAndTourExceptInsurance(supplierOfAgentS);
	}

	@Override
	public SupplierOfAgent findSumUSARateOfAgentAndTour(
			SupplierOfAgent supplierOfAgentS) {
		return supplierOfAgentMapper.findSumUSARateOfAgentAndTour(supplierOfAgentS);
	}

	@Override
	public BigDecimal findInsuranceTotalFeeOfAgentAndTour(
			SupplierOfAgent supplierOfAgentS) {
		return supplierOfAgentMapper.findInsuranceTotalFeeOfAgentAndTour(supplierOfAgentS);
	}

	@Override
	public BigDecimal findSumOfAgentAndTour(SupplierOfAgent supplierOfAgentS) {
		return supplierOfAgentMapper.findSumOfAgentAndTour(supplierOfAgentS);
	}
}