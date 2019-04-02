package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.ProductArea;
import com.chinatour.persistence.ProductAreaMapper;
import com.chinatour.service.ProductAreaService;

/**
 * Service - 同行用户
 * @copyright   Copyright: 2015
 * @author Aries
 * @create-time 2015-5-06 上午 11:52:20
 * @revision  3.0
 */

@Service("productAreaServiceImpl")
public class ProductAreaServiceImpl extends BaseServiceImpl<ProductArea, String> implements ProductAreaService {
	@Autowired
	private ProductAreaMapper productAreaMapper;
	
	@Autowired
	public void setBaseMapper(ProductAreaMapper productAreaMapper) {
	    	super.setBaseMapper(productAreaMapper);
	}

}