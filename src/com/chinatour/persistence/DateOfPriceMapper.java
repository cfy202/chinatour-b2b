/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.persistence;


import java.util.List;

import com.chinatour.entity.DateOfPrice;
import org.springframework.stereotype.Repository;

/**
 * Dao -产品不同时间段不同价格
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Repository
public interface DateOfPriceMapper extends BaseMapper<DateOfPrice,String> {
	
	List<DateOfPrice> findByGroupLineId(String id);

}