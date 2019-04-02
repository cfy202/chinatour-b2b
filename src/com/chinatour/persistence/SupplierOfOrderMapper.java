package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.SupplierOfOrder;

/**
 * 
 *	Dao--Agent团账单供应商订单
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午10:14:49
 * @revision  3.0
 */
@Repository
public interface SupplierOfOrderMapper extends
		BaseMapper<SupplierOfOrder, String> {

	void batchSave(List<SupplierOfOrder> supplierOfOrderList);

}