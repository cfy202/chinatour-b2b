package com.chinatour.persistence;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.TourInfoForOrder;

/**
 * Dao  团信息
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:50:21
 * @revision  3.0
 */
@Repository
public interface TourInfoForOrderMapper extends BaseMapper<TourInfoForOrder, String> {
	
	/**
	 * 根据订单ID查询TourInfoForOrder
	 * 
	 * @param orderId
	 * @return
	 */
	public TourInfoForOrder findByOrderId(String orderId);
	
	/**
	 * 非团订单修改时更新tourInfoForOrder
	 * 
	 * @param tourInfoForOrder
	 */
	void updateDepartureDateAndDayNum(TourInfoForOrder tourInfoForOrder);
}
