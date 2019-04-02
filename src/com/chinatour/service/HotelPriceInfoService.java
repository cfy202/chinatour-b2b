package com.chinatour.service;


import java.util.List;

import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.entity.HotelPriceInfo;

/**
 * Service 团账单 酒店
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-27 上午10:37:39
 * @revision  3.0
 */
public interface HotelPriceInfoService extends
		BaseService<HotelPriceInfo, String> {

	List<HotelPriceInfo> findHotelAndCustomer(HotelPriceInfo hotelPriceInfo);
}
