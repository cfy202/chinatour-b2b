/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.OrderAgencyRemark;
import com.chinatour.entity.OrderRemark;
import com.chinatour.persistence.CustomerMapper;
import com.chinatour.persistence.OrderAgencyRemarkMapper;
import com.chinatour.persistence.OrderRemarkMapper;
import com.chinatour.service.OrderAgencyRemarkService;
import com.chinatour.service.OrderRemarkService;

/**
 * Service  同行订单修改日志
 * 
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-11-2
 * @revision  3.0
 */
@Service("orderAgencyRemarkServiceImpl")
public class OrderAgencyRemarkServiceImpl extends BaseServiceImpl<OrderAgencyRemark, String> implements OrderAgencyRemarkService{
	@Autowired
	private OrderAgencyRemarkMapper orderAgencyRemarkMapper;
	
	@Autowired
    public void setBaseMapper(OrderAgencyRemarkMapper orderAgencyRemarkMapper) {
        super.setBaseMapper(orderAgencyRemarkMapper);
    }

	@Override
	public List<OrderAgencyRemark> findRemarkByOrderId(String orderId) {
		return orderAgencyRemarkMapper.queryByOrderId(orderId);
	}
}	
