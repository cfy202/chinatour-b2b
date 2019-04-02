package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.SupplierPriceInfo;

/**
 * Service 团账单机票
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-23 下午3:53:26
 * @revision 3.0
 */
public interface SupplierPriceInfoService extends
		BaseService<SupplierPriceInfo, String> {

	List<SupplierPriceInfo> findSupplierAndCustomer(SupplierPriceInfo supplierPriceInfo);

}
