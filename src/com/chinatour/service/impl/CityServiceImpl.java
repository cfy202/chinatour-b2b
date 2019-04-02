package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.City;
import com.chinatour.persistence.CityMapper;
import com.chinatour.service.CityService;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 29, 2014 4:50:44 PM
 * @revision  3.0
 */
@Service("cityServiceImpl")
public class CityServiceImpl extends BaseServiceImpl<City, String> implements CityService{
   
	/**
	 * CityMapper注入
	 * @param cityMapper
	 */
	@Autowired
	public void setCityMapper(CityMapper cityMapper){
		this.setBaseMapper(cityMapper);
	}
}
