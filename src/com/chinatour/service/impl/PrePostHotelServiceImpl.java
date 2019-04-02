/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import com.chinatour.entity.Area;
import com.chinatour.entity.PrePostHotel;
import com.chinatour.persistence.AreaMapper;
import com.chinatour.persistence.PrePostHotelMapper;
import com.chinatour.service.AreaService;
import com.chinatour.service.PrePostHotelService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author Aries
 * @create-time Aug 17, 2015 3:34:33 PM
 * @revision  3.0
 */
@Service("prePostHotelServiceImpl")
public class PrePostHotelServiceImpl extends BaseServiceImpl<PrePostHotel, String> implements PrePostHotelService {

    @Autowired
    private PrePostHotelMapper prePostHotelMapper;

    @Autowired
    public void setBaseMapper(PrePostHotelMapper prePostHotelMapper) {
        super.setBaseMapper(prePostHotelMapper);
    }

	@Override
	public List<PrePostHotel> findByOrderId(PrePostHotel prePostHotel) {
		return prePostHotelMapper.findByOrderId(prePostHotel);
	}

   
}