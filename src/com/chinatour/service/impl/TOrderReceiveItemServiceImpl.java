/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.service.TOrderReceiveItemService;

/**
 * Service 团订单明细
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:28:19
 * @revision  3.0
 */
@Service("torderReceiveItemServiceImpl")
public class TOrderReceiveItemServiceImpl extends BaseServiceImpl<OrderReceiveItem, String> implements TOrderReceiveItemService{
	@Autowired
	private TOrderReceiveItemMapper torderReceiveItemMapper;
	
	@Autowired
    public void setBaseMapper(TOrderReceiveItemMapper torderReceiveItemMapper) {
        super.setBaseMapper(torderReceiveItemMapper);
    }

	@Override
	public List<OrderReceiveItem> find(OrderReceiveItem orderReceiveItem) {
		return torderReceiveItemMapper.find(orderReceiveItem);
	}

}
