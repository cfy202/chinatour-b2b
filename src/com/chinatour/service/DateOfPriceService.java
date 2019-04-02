/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service;

import com.chinatour.entity.DateOfPrice;

import java.util.List;

/**
 * Service - 产品不同时间段的不同价格
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public interface DateOfPriceService extends BaseService<DateOfPrice, String> {
	/**
	 * 查找产品下的价格记录
	 * */
	List<DateOfPrice> findByGroupLineId(String id);
}