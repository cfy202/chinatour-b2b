package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
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
public interface TOrderReceiveItemMapper extends BaseMapper<OrderReceiveItem,String> {
	
	/**
	 * 根据ReceivableInfoOfOrderId查找
	 * 
	 * @param receivableInfoOfOrderId
	 * @return
	 */
	List<OrderReceiveItem> findByReceivableInfoOfOrderId(String receivableInfoOfOrderId);
	/**
	 * 查询明细，关联自选项产品
	 * @param receivableInfoOfOrderId
	 * @return
	 */
	List<OrderReceiveItem> findByReceivableInfoOfOptional(String tourId);
	
	List<OrderReceiveItem> findCustomerOptional(String customerOrderRelId);
	
	/**
	 * 根据ReceivableInfoOfOrderId和type查找num的最大值
	 * 
	 * @param receivableInfoOfOrderId
	 * @param type
	 * @return
	 */
	Integer findMaxNumByReceivableInfoOfOrderIdAndType(@Param("receivableInfoOfOrderId")String receivableInfoOfOrderId, @Param("type")Integer type);
	

}
