/**
 * 
 */
package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**
 * 部门往来账记录
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-22 下午4:39:46
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AccountRecord extends BaseUuidEntity{
	
	@JsonProperty
	private	String		accountRecordId;   						//Invoice或者CreidtMemo转为正式的账目记录ID
	@JsonProperty
	private	String		invoiceAndCreditId;						//记录所属的Invoice或者CreditMemo ID对账
	@JsonProperty 
	private	Integer		businessNo;							    //业务编号
	@JsonProperty    
	private	String		billToDeptId;      						//发送部门
	@JsonProperty
	private	String		deptId;            						//本部门
	@JsonProperty
	private	String		tourCode;      							//团号
	@JsonProperty
	private	BigDecimal	receivableCurrency;  					//应收金额 本位币
	@JsonProperty
	private	BigDecimal	receivedAmount;  						//应收金额
	@JsonProperty
	private	BigDecimal	receivableAmount;  						//应收金额美元
	@JsonProperty
	private String      billToReceiver;							//接收部门
	@JsonProperty
	private	Date		createDate;        						//日期
	@JsonProperty
	private	String		month;             						//记账月份
	@JsonProperty
	private	Integer		ifBeginningValue;  						//是否期初  1、没有设置  2、设置期初
	@JsonProperty
	private	String		remarks;								//摘要
	@JsonProperty
	private String		year;									//查询年份（非数据库）
	@JsonProperty
	private	BigDecimal	balanceDue;								//（非数据库字段）
	@JsonProperty
	private	Boolean		isData;					//是否为数据，月和年汇总时为False（非数据库字段）
	@JsonProperty
	private	String		label;					//当数据为月、年数据时，显示用的标签（非数据库字段）
	@JsonProperty
	private String 		startMonth; 			//用于打印月份查询（非数据库字段）
	@JsonProperty
	private String		endMonth;				//用于打印月份查询（非数据库字段）
	
	@JsonProperty
	private String		businessName;				//前缀
}
