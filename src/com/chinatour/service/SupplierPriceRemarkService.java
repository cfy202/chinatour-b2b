package com.chinatour.service;


import java.util.List;

import com.chinatour.entity.SupplierPriceRemark;

/**
 * Service - 账单变更单
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-11-1 上午11:59:37
 * @revision  3.0
 */
public interface SupplierPriceRemarkService extends BaseService<SupplierPriceRemark, String> {

	List<SupplierPriceRemark> find(SupplierPriceRemark supplierPriceRemark);

	void saveList(List<SupplierPriceRemark> supplierPriceRemarkList);

	List<SupplierPriceRemark> findSupplierPriceRemark(
			SupplierPriceRemark supplierPriceRemark);

	List<SupplierPriceRemark> findAgentTax(
			SupplierPriceRemark supplierPriceRemark);

	SupplierPriceRemark findRateById(String supplierPriceRemarkId);
	
	//查找一个订单下的所有可以结算的变更单
	List<SupplierPriceRemark> findSupplierPriceRemarkByOrderId(String orderId);
	
}