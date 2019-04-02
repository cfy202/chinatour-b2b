package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Country;
import com.chinatour.persistence.CountryMapper;
import com.chinatour.service.CountryService;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 28, 2014 3:41:04 PM
 * @revision  3.0
 */
@Service("countryServiceImpl")
public class CountryServiceImpl extends BaseServiceImpl<Country, String> implements CountryService {
   
	/**
	 * CountryMapper注入
	 * @param countryMapper
	 */
	@Autowired
	public void setCountryMapper(CountryMapper countryMapper){
		super.setBaseMapper(countryMapper);
	}
}
