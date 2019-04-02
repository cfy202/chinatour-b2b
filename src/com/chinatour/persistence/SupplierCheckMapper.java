package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.SupplierCheck;

/**
 * Dao--Agent账单审核
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:10:31
 * @revision 3.0
 */
@Repository
public interface SupplierCheckMapper extends BaseMapper<SupplierCheck, String> {

	List<SupplierCheck> findCheckAndTaxOfOrder(SupplierCheck supplierCheck);

	List<SupplierCheck> findUserInfo(SupplierCheck supplierCheck);

	void batchSave(List<SupplierCheck> supplierCheckListS);
	
	List<SupplierCheck> findBySupplierPriceId(String supplierPriceId);
	
	int findCount(SupplierCheck supplierCheck);
	
	List<SupplierCheck> queryOfDept(SupplierCheck supplierCheck);
	
	List<SupplierCheck> findAgentForDept(SupplierCheck supplierCheck);

}