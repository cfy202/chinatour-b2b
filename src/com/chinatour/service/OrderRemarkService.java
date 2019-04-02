/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.OrderRemark;

/**
 * Service  订单修改日志
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:42:13
 * @revision  3.0
 */
public interface OrderRemarkService extends BaseService<OrderRemark, String> {
	/**
	 * 根据订单Id查找记录信息
	 * */
	public List<OrderRemark> findRemarkByOrderId(String orderId);
}
