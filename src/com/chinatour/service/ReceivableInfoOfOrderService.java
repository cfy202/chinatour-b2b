/**
 * 
 */
package com.chinatour.service;

import com.chinatour.entity.ReceivableInfoOfOrder;


/**
 * Service  订单收费（总）
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:43:46
 * @revision  3.0
 */
public interface ReceivableInfoOfOrderService extends BaseService<ReceivableInfoOfOrder, String>{
	ReceivableInfoOfOrder findByOrderId(String orderId);
}
