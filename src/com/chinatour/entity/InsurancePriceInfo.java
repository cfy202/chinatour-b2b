package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 团账单中保险信息
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午9:37:21
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class InsurancePriceInfo extends BaseUuidEntity {

	@JsonProperty
	private String insurancePriceInfoId;// id

	@JsonProperty
	private Integer customerNo;// 客人序号

	@JsonProperty
	private BigDecimal receivable;// 应收

	@JsonProperty
	private String supplierOfAgentId;// Agent团账单供应商

	@JsonProperty
	private String customerId;// 客人

	@JsonProperty
	private Integer isCalculate;// 是否参与计算

	@JsonProperty
	private String orderId;// 订单id
	
	@JsonProperty
	private String orderNo;// 用于查询 订单编号
	
	@JsonProperty
	private String lastName; //姓 用于查询
	
	@JsonProperty
	private String firstName; //名 用于查询
	
	@JsonProperty
	private String middleName; //中间名称 		用于查询
	
	@JsonProperty
	private String agent;	//用于查询
	
	@JsonProperty
	private String userId;//用于查询  用户id  
	
	@JsonProperty
	private String supPriceInfoRelId;//用于查询  账单供应商id
	
	@JsonProperty
	private String state;//用于查询   订单状态
	
	@JsonProperty
	private String isDel;//用于查询   客人状态
}