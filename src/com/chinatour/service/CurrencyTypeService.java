package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.CurrencyType;
import com.chinatour.entity.RateOfCurrency;


/**
 * @copyright   Copyright: 2014 
 * @author aries
 * @create-time Sup 25, 2014 19:14:20 PM
 * @revision  3.0
 */
public interface CurrencyTypeService extends BaseService<CurrencyType, String> {
	
	/*
	 * 保存汇率
	 */
	void save(RateOfCurrency rateOfCurrency);
	
	/*
	 * 修改汇率
	 */
	void update(RateOfCurrency oldRate,RateOfCurrency newRate);
	
	/*
	 * 查询汇率
	 */
	List<RateOfCurrency> findRateOfCurrency(RateOfCurrency rateOfCurrency);
	
	/*
	 * 查询汇率
	 */
	RateOfCurrency findRateById(String id);

}
