/**
 * 
 */
package com.chinatour.entity;

import java.math.BigDecimal;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-11 下午4:56:21
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class InvoiceAndCreditItems extends BaseUuidEntity{
	
	@JsonProperty
	private	String		itemsId;//ID
	@JsonProperty
	private	String		description; //描述
	@JsonProperty      
	private	String		remarks; //摘要
	@JsonProperty          
	private	BigDecimal	amount; //金额
	@JsonProperty           
	private	BigDecimal	dollarAmount;//美元金额 
	@JsonProperty     
	private	String		invoiceAndCreditId;//对账表ID
	@JsonProperty
	private	Integer		businessNo; //业务编码   
	@JsonProperty    
	private	String		billToDeptId; //发送部门
	@JsonProperty    
	private	String		deptId;//本部门
	@JsonProperty
	private	int		ifBeginningValue;			//是否为期初值
	@JsonProperty
	private	Integer		sortNo;			//作为录入时排序
	@JsonProperty
	private	int		ifVerified;//审核状态        1、待审核    2、审核通过    3、审核不通过
	@JsonProperty
	private	String		verifyRemarks;//审核摘要
	@JsonProperty
	private BigDecimal    	afteramount;//转换后的(非数据字段)

}
