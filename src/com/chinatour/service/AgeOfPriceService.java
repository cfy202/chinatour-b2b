/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service;

import com.chinatour.entity.AgeOfPrice;
import com.chinatour.entity.Area;

import java.util.List;

/**
 * Service - 产品不同年龄，不同货币的不同价格
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public interface AgeOfPriceService extends BaseService<AgeOfPrice, String> {
	/**
	 * 产品下价格记录
	 * */
	List<AgeOfPrice> findByGroupLineId(String id);
	
	public AgeOfPrice findOnlyOne(AgeOfPrice ageOfprice);
	/**
	 * 根据实体类查找一条记录
	 * */
	AgeOfPrice findByDepartureTime(AgeOfPrice ageOfprice);
	/**
	 * 根据当前时间查找最近时间的价格
	 * */
	List<AgeOfPrice> findOrderByCurrencyId(AgeOfPrice ageOfPrice);
	/**
	 * 查找出不同币种，不同价格的最大最小时间 
	 * */
	List<AgeOfPrice> findMaxMin(String groupLineId);

	List<AgeOfPrice> findByTime(AgeOfPrice ageOfPrice);
	/**
	 * 实体类条件查询
	 * */
	List<AgeOfPrice> findByPrice(AgeOfPrice ageOfPrice);
	
	void deleteAgeOfPrice(AgeOfPrice ageOfPrice);
	void batchSave(List<AgeOfPrice> ageOfPriceList);
}