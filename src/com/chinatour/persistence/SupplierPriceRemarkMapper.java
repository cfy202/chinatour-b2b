package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.SupplierPriceRemark;

/**
 * Dao--账单变更单
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:32:28
 * @revision 3.0
 */
@Repository
public interface SupplierPriceRemarkMapper extends
		BaseMapper<SupplierPriceRemark, String> {

	List<SupplierPriceRemark> findSupplierPriceRemark(
			SupplierPriceRemark supplierPriceRemark);

	List<SupplierPriceRemark> findAgentTax(
			SupplierPriceRemark supplierPriceRemark);

	SupplierPriceRemark findRateById(String supplierPriceRemarkId);
	
	List<SupplierPriceRemark> findSupplierPriceRemarkByOrderId(String orderId);

	List<SupplierPriceRemark> findBill(SupplierPriceRemark supplierPriceRemark);

}