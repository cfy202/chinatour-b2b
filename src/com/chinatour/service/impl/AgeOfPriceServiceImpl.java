/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import java.util.List;

import com.chinatour.entity.AgeOfPrice;
import com.chinatour.persistence.AgeOfPriceMapper;
import com.chinatour.service.AgeOfPriceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service -产品不同年龄，不同货币的不同价格
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("ageOfPriceServiceImpl")
public class AgeOfPriceServiceImpl extends BaseServiceImpl<AgeOfPrice,String> implements AgeOfPriceService {

    @Autowired
    private AgeOfPriceMapper ageOfPriceMapper;

    @Autowired
    public void setBaseMapper(AgeOfPriceMapper ageOfPriceMapper) {
        super.setBaseMapper(ageOfPriceMapper);
    }

	@Override
	public List<AgeOfPrice> findByGroupLineId(String id) {
		return ageOfPriceMapper.findByGroupLineId(id);
	}
	
	@Override
	public AgeOfPrice findOnlyOne(AgeOfPrice ageOfprice) {
		return ageOfPriceMapper.findOnlyOne(ageOfprice);
	}

	@Override
	public AgeOfPrice findByDepartureTime(AgeOfPrice ageOfprice) {
		return ageOfPriceMapper.findByDepartureTime(ageOfprice);
	}

	@Override
	public List<AgeOfPrice> findOrderByCurrencyId(AgeOfPrice ageOfPrice) {
		return ageOfPriceMapper.findOrderByCurrencyId(ageOfPrice);
	}

	@Override
	public List<AgeOfPrice> findMaxMin(String groupLineId) {
		return ageOfPriceMapper.findMaxMin(groupLineId);
	}

	@Override
	public List<AgeOfPrice> findByTime(AgeOfPrice ageOfPrice) {
		return ageOfPriceMapper.findByTime(ageOfPrice);
	}

	@Override
	public List<AgeOfPrice> findByPrice(AgeOfPrice ageOfPrice) {
		return ageOfPriceMapper.findByPrice(ageOfPrice);
	}
	
	@Override
	public void deleteAgeOfPrice(AgeOfPrice ageOfPrice) {
		 ageOfPriceMapper.deleteAgeOfPrice(ageOfPrice);
	}
	
	@Override
	public void batchSave(List<AgeOfPrice> ageOfPriceList) {
		 ageOfPriceMapper.batchSave(ageOfPriceList);
	}
	
}