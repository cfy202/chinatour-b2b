package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.OrderFeeItems;

/**
 * @author Aries
 * @create-time 2016-3-17
 * @revision  3.0
 */
public interface OrderFeeItemsService extends BaseService<OrderFeeItems, String> {
	/**
	 * 根据orderId删除数据
	 * */
	public void delByOrderId(String orderId);
	/**
	 * 根据orderId查找数据
	 * */
	public List<OrderFeeItems> findByOrderId(String orderId);
	
	public void removeById(String Id);

}
