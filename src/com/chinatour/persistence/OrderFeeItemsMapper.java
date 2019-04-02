package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.chinatour.entity.OrderFeeItems;

/**
 * @author Aries
 * @create-time 2016-3-17
 * @revision  3.0
 */
@Repository
public interface OrderFeeItemsMapper extends BaseMapper<OrderFeeItems, String> {
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
