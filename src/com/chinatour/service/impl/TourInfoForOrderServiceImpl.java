/**
 * 
 */
package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.persistence.TourInfoForOrderMapper;
import com.chinatour.service.TourInfoForOrderService;

/**
 * Service  团信息
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:29:36
 * @revision  3.0
 */
@Service("tourInfoForOrderServiceImpl")
public class TourInfoForOrderServiceImpl extends BaseServiceImpl<TourInfoForOrder, String> implements TourInfoForOrderService{
	@Autowired
	private TourInfoForOrderMapper tourInfoForOrderMapper;
	
	@Autowired
    public void setBaseMapper(TourInfoForOrderMapper tourInfoForOrderMapper) {
        super.setBaseMapper(tourInfoForOrderMapper);
    }

	@Override
	public TourInfoForOrder findByOrderId(String id) {
		return tourInfoForOrderMapper.findByOrderId(id);
	}
	
} 