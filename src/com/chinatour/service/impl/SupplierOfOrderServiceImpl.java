package com.chinatour.service.impl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.SupplierOfOrder;
import com.chinatour.service.SupplierOfOrderService;
import com.chinatour.persistence.SupplierOfOrderMapper;

/**
 * Service Agent团账单供应商订单
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("supplierOfOrderServiceImpl")
public class SupplierOfOrderServiceImpl extends BaseServiceImpl<SupplierOfOrder, String> implements SupplierOfOrderService {

	@Autowired
	private SupplierOfOrderMapper supplierOfOrderMapper;
	
	@Autowired
	public void setBaseMapper(SupplierOfOrderMapper supplierOfOrderMapper) {
	    	super.setBaseMapper(supplierOfOrderMapper);
	}

	@Override
	public List<SupplierOfOrder> find(SupplierOfOrder supplierOfOrderS) {
		return supplierOfOrderMapper.find(supplierOfOrderS);
	}

}