package com.chinatour.service.impl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.HotelPriceInfo;
import com.chinatour.persistence.HotelPriceInfoMapper;
import com.chinatour.service.HotelPriceInfoService;
/**
 * Service 团账单 酒店
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("hotelPriceInfoServiceImpl")
public class HotelPriceInfoServiceImpl extends BaseServiceImpl<HotelPriceInfo, String> implements HotelPriceInfoService {

	@Autowired
	private HotelPriceInfoMapper hotelPriceInfoMapper;
	
	@Autowired
	public void setBaseMapper(HotelPriceInfoMapper hotelPriceInfoMapper) {
	    	super.setBaseMapper(hotelPriceInfoMapper);
	}

	@Override
	public List<HotelPriceInfo> findHotelAndCustomer(
			HotelPriceInfo hotelPriceInfo) {
		return hotelPriceInfoMapper.findHotelAndCustomer(hotelPriceInfo);
	}

}