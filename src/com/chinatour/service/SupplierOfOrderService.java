package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.SupplierOfOrder;


/**
 * Service Agent团账单供应商订单
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-23 下午3:53:26
 * @revision 3.0
 */
public interface SupplierOfOrderService extends
		BaseService<SupplierOfOrder, String> {

	List<SupplierOfOrder> find(SupplierOfOrder supplierOfOrderS);

}
