package com.chinatour.persistence;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.entity.RateOfCurrency;


/**
 * Dao - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

@Repository
public interface RateOfCurrencyMapper extends BaseMapper<RateOfCurrency, String> {
	/**
	 * 根据条件查找汇率
	 * */
	RateOfCurrency getRate(@Param("record") RateOfCurrency rateOfCurrency);
}