/**
 * 
 */
package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.persistence.SOrderReceiveItemMapper;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.service.SOrderReceiveItemService;

/**
 * Service  非团订单明细
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:25:09
 * @revision  3.0
 */
@Service("sorderReceiveItemServiceImpl")
public class SOrderReceiveItemServiceImpl extends BaseServiceImpl<OrderReceiveItem, String> implements SOrderReceiveItemService{
	@Autowired
	private SOrderReceiveItemMapper sOrderReceiveItemMapper;
	
	@Autowired
    public void setBaseMapper(SOrderReceiveItemMapper sOrderReceiveItemMapper) {
        super.setBaseMapper(sOrderReceiveItemMapper);
    }
}
