package com.chinatour.persistence;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.ReceivableInfoOfOrder;

/**
 * Dao  订单收费（总）
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:45:38
 * @revision  3.0
 */
@Repository
public interface ReceivableInfoOfOrderMapper extends BaseMapper<ReceivableInfoOfOrder, String> {
	
	/**
	 * 根据订单ID查询到ReceivableInfoOfOrder
	 * 
	 * @param orderId
	 * @return
	 */
	public ReceivableInfoOfOrder findByOrderId(String orderId);
}
