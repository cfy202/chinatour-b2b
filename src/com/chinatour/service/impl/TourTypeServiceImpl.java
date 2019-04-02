package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.TourType;
import com.chinatour.persistence.TourTypeMapper;
import com.chinatour.service.TourTypeService;


/**
 * Service - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

@Service("tourTypeServiceImpl")
public class TourTypeServiceImpl extends BaseServiceImpl<TourType, String> implements TourTypeService {

	@Autowired
	private TourTypeMapper tourTypeMapper;

	@Autowired
	public void setBaseMapper(TourTypeMapper tourTypeMapper) {
	    super.setBaseMapper(tourTypeMapper);
	}

	@Override
	@Transactional
	public List<TourType> findByBrand(String brand) {
		return tourTypeMapper.findByBrand(brand);
	}

	@Override
	public List<TourType> findByt(TourType tourType) {
		return tourTypeMapper.findByt(tourType);
	}
}