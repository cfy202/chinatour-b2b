package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.TourType;

/**
 * Service - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

public interface TourTypeService extends BaseService<TourType, String> {
	
	List<TourType> findByBrand(String brand);

	List<TourType> findByt(TourType tourType);
	
}