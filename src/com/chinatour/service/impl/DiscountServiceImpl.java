/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;
import com.chinatour.entity.Discount;
import com.chinatour.persistence.DiscountMapper;
import com.chinatour.service.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Service - 折扣价
 * @version 3.0
 */
@Service("discountServiceImpl")
public class DiscountServiceImpl extends BaseServiceImpl<Discount, String> implements DiscountService {

    @Autowired
    private DiscountMapper discountMapper;

    @Autowired
    public void setBaseMapper(DiscountMapper discountMapper) {
        super.setBaseMapper(discountMapper);
    }

	@Override
	public Discount findByOrder(String orderId) {
		return discountMapper.findByOrderId(orderId);
	}


}