package com.chinatour.service.impl;




import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.SupplierPriceInfo;
import com.chinatour.service.SupplierPriceInfoService;
import com.chinatour.persistence.SupplierPriceInfoMapper;
/**
 * Service 团账单 地接
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("supplierPriceInfoServiceImpl")
public class SupplierPriceInfoServiceImpl extends BaseServiceImpl<SupplierPriceInfo, String> implements SupplierPriceInfoService {

	@Autowired
	private SupplierPriceInfoMapper supplierPriceInfoMapper;
	
	@Autowired
	public void setBaseMapper(SupplierPriceInfoMapper supplierPriceInfoMapper) {
	    	super.setBaseMapper(supplierPriceInfoMapper);
	}

	@Override
	public List<SupplierPriceInfo> findSupplierAndCustomer(
			SupplierPriceInfo supplierPriceInfo) {
		return supplierPriceInfoMapper.findSupplierAndCustomer(supplierPriceInfo);
	}

}