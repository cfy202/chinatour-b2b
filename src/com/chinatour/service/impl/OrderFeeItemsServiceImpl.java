package com.chinatour.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.OrderFeeItems;
import com.chinatour.persistence.OrderFeeItemsMapper;
import com.chinatour.service.OrderFeeItemsService;

/**
 * @author Aries
 * @create-time 2016-3-17
 * @revision  3.0
 */
@Service("orderFeeItemsServiceImpl")
public class OrderFeeItemsServiceImpl extends BaseServiceImpl<OrderFeeItems, String> implements OrderFeeItemsService{
   
	@Autowired
	private OrderFeeItemsMapper orderFeeItemsMapper;
	@Autowired
	public void setOrderFeeItemsMapper(OrderFeeItemsMapper orderFeeItemsMapper){
		this.setBaseMapper(orderFeeItemsMapper);
	}

	@Override
	public void delByOrderId(String orderId) {
		orderFeeItemsMapper.delByOrderId(orderId);
	}

	@Override
	public List<OrderFeeItems> findByOrderId(String orderId) {
		return orderFeeItemsMapper.findByOrderId(orderId);
	}

	@Override
	public void removeById(String Id) {
		orderFeeItemsMapper.removeById(Id);
	}
	
	
}
