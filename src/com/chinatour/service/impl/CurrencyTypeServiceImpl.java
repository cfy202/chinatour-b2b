package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.CurrencyType;
import com.chinatour.entity.Notice;
import com.chinatour.entity.NoticeContact;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.persistence.CurrencyTypeMapper;
import com.chinatour.persistence.NoticeMapper;
import com.chinatour.persistence.RateOfCurrencyMapper;
import com.chinatour.service.CurrencyTypeService;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 29, 2014 4:50:44 PM
 * @revision  3.0
 */
@Service("currencyTypeServiceImpl")
public class CurrencyTypeServiceImpl extends BaseServiceImpl<CurrencyType, String> implements CurrencyTypeService{
   
	@Autowired
	private RateOfCurrencyMapper rateOfCurrencyMapper;
	
	/**
	 * CurrencyTypeMapper注入
	 * @param currencyTypeMapper
	 */
	@Autowired
	public void setCurrencyTypeMapper(CurrencyTypeMapper currencyTypeMapper){
		this.setBaseMapper(currencyTypeMapper);
	}
	
	/* 
	 * 保存汇率
	 */
	@Override
	@Transactional
	public void save(RateOfCurrency rateOfCurrency) {
		rateOfCurrencyMapper.save(rateOfCurrency);
	}
	
	/* 
	 * 修改汇率
	 */
	@Override
	@Transactional
	public void update(RateOfCurrency oldRate,RateOfCurrency newRate) {
		rateOfCurrencyMapper.update(oldRate);
		rateOfCurrencyMapper.save(newRate);
	}
	
	/* 
	 * 查询汇率
	 */
	@Transactional(readOnly = true)
	public List<RateOfCurrency> findRateOfCurrency(RateOfCurrency rateOfCurrency) {
		return rateOfCurrencyMapper.find(rateOfCurrency);
	}

	/* (non-Javadoc)
	 * 查询汇率
	 */
	@Transactional(readOnly = true)
	public RateOfCurrency findRateById(String id) {
		return rateOfCurrencyMapper.findById(id);
	}
}
