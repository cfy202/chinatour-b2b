/**
 * 
 */
package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.ReceivableInfoOfOrderMapper;
import com.chinatour.service.ReceivableInfoOfOrderService;

/**
 * Service  订单收费（总）
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:22:41
 * @revision  3.0
 */
@Service("receivableInfoOfOrderServiceImpl")
public class ReceivableInfoOfOrderServiceImpl extends BaseServiceImpl<ReceivableInfoOfOrder, String> implements ReceivableInfoOfOrderService{
	@Autowired
	private ReceivableInfoOfOrderMapper receivableInfoOfOrderMapper;
	
	@Autowired
    public void setBaseMapper(ReceivableInfoOfOrderMapper receivableInfoOfOrderMapper) {
        super.setBaseMapper(receivableInfoOfOrderMapper);
    }
	
	@Override
	public ReceivableInfoOfOrder findByOrderId(String orderId) {
		
		return receivableInfoOfOrderMapper.findByOrderId(orderId);
	}
}
