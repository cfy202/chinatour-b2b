package com.chinatour.service.impl;

import java.util.List;

import com.chinatour.entity.ItineraryInfo;
import com.chinatour.persistence.AdminMapper;
import com.chinatour.persistence.ItineraryInfoMapper;
import com.chinatour.service.ItineraryInfoService;
import com.chinatour.service.LogService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service - 订单确认单
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午12:47:24
 * @revision  3.0
 */

@Service("itineraryServiceImpl")
public class ItineraryInfoServiceImpl extends BaseServiceImpl<ItineraryInfo, String> implements ItineraryInfoService {

    @Autowired
    private ItineraryInfoMapper itineraryInfoMapper;

    @Autowired
    public void setBaseMapper(ItineraryInfoMapper itineraryInfoMapper) {
    	super.setBaseMapper(itineraryInfoMapper);
    }


    @Transactional(readOnly = true)
    public List<ItineraryInfo> findAll() {
    	return itineraryInfoMapper.findAll();
    }
    
    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void save(ItineraryInfo entity) {
    	super.save(entity);
    }

	@Override
	@Transactional
	public void delete(String id) {
		super.delete(id);
	}
	
	@Override
	@Transactional(readOnly = true)
	public ItineraryInfo findById(String id) {
		return super.findById(id);
	}

    @Override
    @Transactional
    public int update(ItineraryInfo entity) {
    	return super.update(entity);
    }


	@Override
	public ItineraryInfo findByTourId(String tourId) {
		return itineraryInfoMapper.findByTourId(tourId);
	}


	@Override
	public ItineraryInfo findByTourIdWhithDel(String tourId) {
		return itineraryInfoMapper.findByTourIdWhithDel(tourId);
	}


	@Override
	public ItineraryInfo findByTourWithIsDel(String tourId) {
		return itineraryInfoMapper.findByTourWithIsDel(tourId);
	}
    
}