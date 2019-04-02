package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.SupplierPriceInfo;

/**
 * Dao --团账单中地接信息
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:28:44
 * @revision 3.0
 */
@Repository
public interface SupplierPriceInfoMapper extends
		BaseMapper<SupplierPriceInfo, String> {

	List<SupplierPriceInfo> findSupplierAndCustomer(
			SupplierPriceInfo supplierPriceInfo);

	void batchSave(List<SupplierPriceInfo> supplierPriceInfoList);

}