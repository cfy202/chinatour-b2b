/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Filter;
import com.chinatour.Order;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.persistence.CityMapper;
import com.chinatour.persistence.RateOfCurrencyMapper;
import com.chinatour.service.RateOfCurrencyService;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-18 下午2:27:17
 * @revision  3.0
 */
@Service("rateOfCurrencyServiceImpl")
public class RateOfCurrencyServiceImpl extends BaseServiceImpl<RateOfCurrency,String> implements RateOfCurrencyService {
	@Autowired
	private RateOfCurrencyMapper rateOfCurrencyMapper;

	@Autowired
	public void setBaseMapper(RateOfCurrencyMapper rateOfCurrencyMapper){
		super.setBaseMapper(rateOfCurrencyMapper);
	}
	
	@Override
	public RateOfCurrency getRate(RateOfCurrency rateOfCurrency) {
		return rateOfCurrencyMapper.getRate(rateOfCurrency);
	}

	@Override
	public List<RateOfCurrency> find(RateOfCurrency rateOfCurrency) {
		return rateOfCurrencyMapper.find(rateOfCurrency);
	}


}
