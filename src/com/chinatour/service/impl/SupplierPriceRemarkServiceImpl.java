package com.chinatour.service.impl;



import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.service.SupplierPriceRemarkService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.persistence.SupplierPriceRemarkMapper;
/**
 * Service 账单变更单
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("supplierPriceRemarkServiceImpl")
public class SupplierPriceRemarkServiceImpl extends BaseServiceImpl<SupplierPriceRemark, String> implements SupplierPriceRemarkService {

	@Autowired
	private SupplierPriceRemarkMapper supplierPriceRemarkMapper;

	@Autowired
	public void setBaseMapper(SupplierPriceRemarkMapper supplierPriceRemarkMapper) {
	    	super.setBaseMapper(supplierPriceRemarkMapper);
	}

	@Override
	public List<SupplierPriceRemark> find(
			SupplierPriceRemark supplierPriceRemark) {
		return supplierPriceRemarkMapper.find(supplierPriceRemark);
	}

	@Override
	public void saveList(List<SupplierPriceRemark> supplierPriceRemarkList) {
		for (SupplierPriceRemark s : supplierPriceRemarkList) {
				s.setSupplierPriceRemarkId(UUIDGenerator.getUUID());
				s.setInsertTime(new Date());
			   s.setEidtTime(new Date());
			supplierPriceRemarkMapper.save(s);
		}
	}

	@Override
	public List<SupplierPriceRemark> findSupplierPriceRemark(
			SupplierPriceRemark supplierPriceRemark) {
		return supplierPriceRemarkMapper.findSupplierPriceRemark(supplierPriceRemark);
	}

	@Override
	public List<SupplierPriceRemark> findAgentTax(
			SupplierPriceRemark supplierPriceRemark) {
		return supplierPriceRemarkMapper.findAgentTax(supplierPriceRemark);
	}

	@Override
	public SupplierPriceRemark findRateById(String supplierPriceRemarkId) {
		return supplierPriceRemarkMapper.findRateById(supplierPriceRemarkId);
	}

	@Override
	public List<SupplierPriceRemark> findSupplierPriceRemarkByOrderId(
			String orderId) {
		return supplierPriceRemarkMapper.findSupplierPriceRemarkByOrderId(orderId);
	}
}