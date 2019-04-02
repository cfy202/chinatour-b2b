package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.City;
import com.chinatour.entity.Destination;
import com.chinatour.persistence.CityMapper;
import com.chinatour.persistence.DestinationMapper;
import com.chinatour.service.CityService;
import com.chinatour.service.DestinationService;
/**
 * @copyright   Copyright: 2015 
 * 目的地
 * @author Aries
 * @create-time Jul 3, 2015 11:19:01 AM
 * @revision  3.0
 */
@Service("destinationServiceImpl")
public class DestinationServiceImpl extends BaseServiceImpl<Destination, String> implements DestinationService{
   
	@Autowired
	private DestinationMapper destinationMapper;
	/**
	 * DestinationMapper注入
	 * @param destinationMapper
	 */
	@Autowired
	public void setDestinationMapper(DestinationMapper destinationMapper){
		this.setBaseMapper(destinationMapper);
	}

	@Override
	public List<Destination> findByDes(Destination destination) {
		return destinationMapper.findByDes(destination);
	}
}
