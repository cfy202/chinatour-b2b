package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time Sep 15, 2014 11:00:00 AM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class RateOfCurrency extends BaseUuidEntity {
	
	/**
	 *  
	 */
	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String currencyId;	//本位币

	@JsonProperty
	private String toCurrencyId; //对方货币
	
	@JsonProperty 
	private BigDecimal rateUp; //部门间汇率 分子
	
	@JsonProperty
	private BigDecimal rateDown; //部门间汇率 分母
	
	@JsonProperty
	private BigDecimal usRate; //对美元汇率
	
	@JsonProperty
	private Date updateTime; //更新日期
	
	@JsonProperty
	private int isAvailable; //是否可用  0 可用；1 不可用
	
}
