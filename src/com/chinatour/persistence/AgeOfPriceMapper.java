/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.persistence;


import java.util.List;

import com.chinatour.entity.AgeOfPrice;
import org.springframework.stereotype.Repository;

/**
 * Dao -产品不同年龄，不同货币的不同价格
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Repository
public interface AgeOfPriceMapper extends BaseMapper<AgeOfPrice,String> {
	List<AgeOfPrice> findByGroupLineId(String id);
	AgeOfPrice findOnlyOne(AgeOfPrice ageOfprice);
	AgeOfPrice findByDepartureTime(AgeOfPrice ageOfprice);
	List<AgeOfPrice> findOrderByCurrencyId(AgeOfPrice ageOfPrice);
	List<AgeOfPrice> findMaxMin(String groupLineId);
	List<AgeOfPrice> findByTime(AgeOfPrice ageOfPrice);
	List<AgeOfPrice> findByPrice(AgeOfPrice ageOfPrice);
	
	//test
	List<AgeOfPrice> findOrderNoCurrencyId(AgeOfPrice ageOfPrice);
	
	/*
	 * 批量保存
	 */
	void batchSave(List<AgeOfPrice> ageOfPriceList);
	void deleteAgeOfPrice(AgeOfPrice ageOfPrice);
	
}