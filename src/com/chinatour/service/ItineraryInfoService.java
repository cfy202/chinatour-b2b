package com.chinatour.service;


import com.chinatour.entity.ItineraryInfo;

/**
 * Service - 订单确认单
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午12:47:24
 * @revision  3.0
 */

public interface ItineraryInfoService extends BaseService<ItineraryInfo, String> {
	ItineraryInfo findByTourId(String tourId);
	
	ItineraryInfo findByTourIdWhithDel(String tourId);
	
	ItineraryInfo findByTourWithIsDel(String tourId);
}