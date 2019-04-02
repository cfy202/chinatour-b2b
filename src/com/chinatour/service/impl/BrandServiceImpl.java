package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Brand;
import com.chinatour.persistence.BrandMapper;
import com.chinatour.service.BrandService;

/**
 * @copyright   Copyright: 2014 
 * @author Cery
 * @create-time Aug 29, 2014 4:50:44 PM
 * @revision  3.0
 */
@Service("brandServiceImpl")
public class BrandServiceImpl extends BaseServiceImpl<Brand, String> implements BrandService{
   
	/**
	 * BrandMapper注入
	 * @param brandMapper
	 */
	@Autowired
	public void setBrandMapper(BrandMapper brandMapper){
		this.setBaseMapper(brandMapper);
	}
}
