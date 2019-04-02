package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Agent账单审核表
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午9:39:00
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SupplierCheck extends BaseUuidEntity {

	@JsonProperty
	private String supplierCheckId;// id

	@JsonProperty
	private Integer checkOfAgent;// Agent审核状态 1通过  2.不通过 0未审核

	@JsonProperty
	private String remarkOfAgent;// 审核备注

	@JsonProperty
	private Integer totalPeople;// 人数

	@JsonProperty
	private String userIdOfAgent;// 审核Agent

	@JsonProperty
	private String supplierPriceId;// 团账单

	@JsonProperty
	private String customerNos;// 客人编号

	@JsonProperty
	private String rateOfCurrencyId;// 汇率
	
	@JsonProperty
	private String toRateOfCurrencyId;// 对方部门汇率
	
	@JsonProperty
	private String tourId;// 团id  		用于查询
	
	@JsonProperty
	private String userNameOfAgent;// agent名字 		用于查询
	
	@JsonProperty
	private String tax;// 结算状态		用于查询
	
	@JsonProperty
	private BigDecimal subtotalOfAgent; //账单小计	用于查询
	
	@JsonProperty
	private BigDecimal totalFeeOfAgent; //账单合计	用于查询
	
	@JsonProperty
	private BigDecimal totalRateFeeOfAgent; //账单按订单的汇率合计	用于查询
	
	@JsonProperty
	private BigDecimal totalUSARateFeeOfAgent; //账单按订单的汇率合计	用于查询
	
	@JsonProperty
	private BigDecimal totalFeeOfInsurance; //保险小计	用于查询
	
	@JsonProperty
	private String deptName;// 部门名称		用于查询
	
	@JsonProperty
	private String currencyType;//部门本位币种：美元、加币、人民币等			用于查询
	
	@JsonProperty 
	private BigDecimal rateUp; //部门间汇率 分子			用于查询
	
	@JsonProperty
	private BigDecimal rateDown; //部门间汇率 分母			用于查询
	
	@JsonProperty
	private String deptId;
	
	@JsonProperty
	private BigDecimal exchangeUSARate; //对美元汇率			用于查询
	
}
