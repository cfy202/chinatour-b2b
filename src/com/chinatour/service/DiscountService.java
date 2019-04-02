/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service;

import com.chinatour.entity.Discount;

import java.util.List;

/**
 * Service - 折扣价
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public interface DiscountService extends BaseService<Discount, String> {
	/**
	 * 根据订单Id查找折扣
	 * */
	public Discount findByOrder(String orderId);

}