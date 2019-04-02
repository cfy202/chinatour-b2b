/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.DateOfPrice;
import com.chinatour.persistence.DateOfPriceMapper;
import com.chinatour.service.DateOfPriceService;

/**
 * Service -产品不同年龄，不同货币的不同价格
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("dateOfPriceServiceImpl")
public class DateOfPriceServiceImpl extends BaseServiceImpl<DateOfPrice,String> implements DateOfPriceService {

    @Autowired
    private DateOfPriceMapper dateOfPriceMapper;

    @Autowired
    public void setBaseMapper(DateOfPriceMapper dateOfPriceMapper) {
        super.setBaseMapper(dateOfPriceMapper);
    }

	@Override
	public List<DateOfPrice> findByGroupLineId(String id) {
		return dateOfPriceMapper.findByGroupLineId(id);
	}

}