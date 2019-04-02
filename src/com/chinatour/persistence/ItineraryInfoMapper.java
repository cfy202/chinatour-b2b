package com.chinatour.persistence;


import org.springframework.stereotype.Repository;

import com.chinatour.entity.ItineraryInfo;

/**
 * Dao - 订单确认单
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014/8/26 上午10:47:24
 * @revision  3.0
 */

@Repository
public interface ItineraryInfoMapper extends BaseMapper<ItineraryInfo, String> {
	ItineraryInfo findByTourId(String tourId);
	ItineraryInfo findByTourIdWhithDel(String tourId);
	ItineraryInfo findByTourWithIsDel(String tourId);

}