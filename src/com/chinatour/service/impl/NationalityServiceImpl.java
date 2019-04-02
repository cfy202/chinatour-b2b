package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.chinatour.entity.Nationality;
import com.chinatour.persistence.NationalityMapper;
import com.chinatour.service.NationalityService;

/**
 * @copyright   Copyright: 2014 
 * @author Cery
 * @create-time Aug 29, 2014 4:50:44 PM
 * @revision  3.0
 */
@Service("nationalityServiceImpl")
public class NationalityServiceImpl extends BaseServiceImpl<Nationality, String> implements NationalityService{
   
	/**
	 * NationalityMapper注入
	 * @param NationalityMapper
	 */
	@Autowired
	public void setNationalityMapper(NationalityMapper NationalityMapper){
		this.setBaseMapper(NationalityMapper);
	}
}
