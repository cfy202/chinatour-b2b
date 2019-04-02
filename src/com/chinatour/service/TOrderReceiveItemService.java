/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.OrderReceiveItem;

/**
 * Service 团订单明细
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:52:26
 * @revision  3.0
 */
public interface TOrderReceiveItemService extends BaseService<OrderReceiveItem, String> {

	List<OrderReceiveItem> find(OrderReceiveItem orderReceiveItem);

}
