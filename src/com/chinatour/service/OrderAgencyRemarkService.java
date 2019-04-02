/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.OrderAgencyRemark;

/**
 * Service  订单修改日志
 * 
 * @copyright   Copyright: 2015 
 * @author Aris
 * @create-time 2015-11-2
 * @revision  3.0
 */
public interface OrderAgencyRemarkService extends BaseService<OrderAgencyRemark, String> {
	/**
	 * 根据订单Id查找记录信息
	 * */
	public List<OrderAgencyRemark> findRemarkByOrderId(String orderId);
}
