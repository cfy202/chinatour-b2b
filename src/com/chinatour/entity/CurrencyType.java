/**
 * 
 */
package com.chinatour.entity;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * @copyright   Copyright: 2014 
 * @author aries
 * @create-time 2014-9-25 下午6:56:20
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class CurrencyType extends BaseUuidEntity{
	
	public CurrencyType(){
		super();
	}
	public CurrencyType(String id,String currencyChs,String currencyEng,String symbol){
		super();
		this.setId(id);
		this.currencyChs=currencyChs;
		this.currencyEng=currencyEng;
		this.symbol=symbol;
	}
	/**
	 * 货币币种中文名称
	 * */
	@JsonProperty
	private String currencyChs;
	/**
	 * 货币币种英文名称
	 * */
	@JsonProperty
	private String currencyEng;
	/**
	 * 货币币种代表符
	 * */
	@JsonProperty
	private String symbol;
	
//	private List<RateOfCurrency> rateOfCurrencyList;

}
