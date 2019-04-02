/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.RateOfCurrency;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-18 下午2:26:01
 * @revision  3.0
 */

public interface RateOfCurrencyService extends BaseService<RateOfCurrency, String>{
	
	RateOfCurrency getRate(RateOfCurrency rateOfCurrency);

	List<RateOfCurrency> find(RateOfCurrency rateOfCurrency);
}
