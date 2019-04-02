package com.chinatour.service.impl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.service.FlightPriceInfoService;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.FlightPriceInfoMapper;
/**
 * Service 团账单 机票
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("flightPriceInfoServiceImpl")
public class FlightPriceInfoServiceImpl extends BaseServiceImpl<FlightPriceInfo, String> implements FlightPriceInfoService {

	@Autowired
	private FlightPriceInfoMapper flightPriceInfoMapper;
	
	@Autowired
	private CustomerOrderRelMapper customerOrderRelMapper;
	
	@Autowired
	public void setBaseMapper(FlightPriceInfoMapper flightPriceInfoMapper) {
	    	super.setBaseMapper(flightPriceInfoMapper);
	}

	@Override
	public List<FlightPriceInfo> findByTourId(String tourId) {
		return flightPriceInfoMapper.findByTourId(tourId);
	}

	@Override
	public List<FlightPriceInfo> findFlightAndCustomer(
			FlightPriceInfo flightPriceInfo) {
		return flightPriceInfoMapper.findFlightAndCustomer(flightPriceInfo);
	}

}