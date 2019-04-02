/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;


import org.springframework.stereotype.Repository;
import com.chinatour.entity.OrderAgencyRemark;

/**
 * Dao  同行订单修改日志
 * 
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-11-2
 * @revision  3.0
 */
@Repository
public interface OrderAgencyRemarkMapper extends BaseMapper<OrderAgencyRemark, String> {
	
	List<OrderAgencyRemark> queryByOrderId(String orderId);

}
