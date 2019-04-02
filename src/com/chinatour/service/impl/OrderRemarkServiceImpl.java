/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.OrderRemark;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.OrderRemarkMapper;
import com.chinatour.service.OrderRemarkService;

/**
 * Service  订单修改日志
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:18:09
 * @revision  3.0
 */
@Service("orderRemarServiceImpl")
public class OrderRemarkServiceImpl extends BaseServiceImpl<OrderRemark, String> implements OrderRemarkService{
	@Autowired
	private OrderRemarkMapper orderRemarkMapper;
	
	@Autowired
    public void setBaseMapper(OrderRemarkMapper orderRemarkMapper) {
        super.setBaseMapper(orderRemarkMapper);
    }

	@Override
	public List<OrderRemark> findRemarkByOrderId(String orderId) {
		return orderRemarkMapper.queryByOrderId(orderId);
	}
}	
