/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.OrderRemark;

/**
 * Dao  订单修改日志
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:43:54
 * @revision  3.0
 */
@Repository
public interface OrderRemarkMapper extends BaseMapper<OrderRemark, String> {
	
	List<OrderRemark> queryByOrderId(String orderId);

}
