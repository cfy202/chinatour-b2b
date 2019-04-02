/**
 * 
 */
package com.chinatour.service;

import com.chinatour.entity.TourInfoForOrder;

/**
 * Service  团信息
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:54:32
 * @revision  3.0
 */
public interface TourInfoForOrderService extends BaseService<TourInfoForOrder, String> {

	TourInfoForOrder findByOrderId(String id);
}
