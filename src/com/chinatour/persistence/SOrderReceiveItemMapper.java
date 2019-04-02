/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.OrderReceiveItem;

/**
 * Dao  团，非团订单明细
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:46:57
 * @revision  3.0
 */
@Repository
public interface SOrderReceiveItemMapper extends BaseMapper<OrderReceiveItem,String> {
	
	/**
	 * 根据receibleInfoOfOrderId查出OrderReceiveItem
	 * @param receivableInfoOfOrderId
	 * @return
	 */
	List<OrderReceiveItem> findByReceivableInfoOfOrderId(String receivableInfoOfOrderId);
	
	/**
	 * 
	 * @param receivableInfoOfOrderId
	 */
	void removeByReceivableInfoOfOrderId(String receivableInfoOfOrderId);

}
