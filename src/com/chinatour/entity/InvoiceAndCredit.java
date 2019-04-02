/**
 * 
 */
package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**
 * 对账
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-8 下午8:37:45
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class InvoiceAndCredit extends BaseUuidEntity {
	@JsonProperty
	private	String		invoiceAndCreditId;					//ID
	@JsonProperty
	private	Integer		businessNo;							//Invoice 或者CreditMemo 的业务流水号 5位数
	@JsonProperty
	private	String		billToDeptId;						//Invoice 或者CreditMemo关联的对方部门ID，如果不是公司内部各部门会计对账，则些字段 为null
	@JsonProperty
	private	String		deptId;								//当前INvoice 所属的部门 ；
	@JsonProperty
	private String		rateOfCurrencyId;					//汇率Id
	@JsonProperty
	private	BigDecimal	enterCurrency;						//本次Invoice 或者CreditMemo输入的金额
	@JsonProperty
	private	BigDecimal	dollar;								//enterCurrency与汇率计算后得到的美元金额
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private	Date		month;								//业务发生的月份（记账月份），统一以YYYYMMDD
	@JsonProperty
	private	String		recordType;							//记录的类型：INVOICE\CREDIT
	@JsonProperty
	private	String		confirmStatus;						//确认的状态 NEW:手动录入未审核状态,NEWAUTO:账单发送未审核状态,CONFIRM:手动录入确认,CONFIRMAUTO:系统自动审核,CONFIRMSEND:账单审核确认,REJECT (初始状态、自动发送、确认、拒绝）
	@JsonProperty
	private	String		confirmRemarks;						//确认时输入的备注摘要信息
	@JsonProperty
	private	Date		createDate;							//记录创建的时间
	@JsonProperty
	private	String		tourCode;							//团号，可先项，将来可以在此用AutoComplete选择团号
	@JsonProperty
	private	String		billToReceiver;						//接收INVOICE或者CREDIT的对象名称 如果是本分公司内部的，则BillToDept和BillToReceiver分别写本分公司的部门Id 和员工名字
	@JsonProperty
	private	String		remarks;							//记录创建者输入的备注摘要说明
	@JsonProperty
	private	String		emailTo;							//邮件提醒对方的邮件地址
	@JsonProperty
	private	int			ifBeginningValue;					//是否为初值确认账单    1、不是期初      2、期初设置
	@JsonProperty
	private	String		prefix;								//业务编号BusinessNo的前缀
	@JsonProperty
	private	String		billFromDept;						//用于保存发出账单方的分公司名称，即deptName
	@JsonProperty
	private String		tourId;								//团Id
	@JsonProperty
	private String		userName;							//一般保存Agent名字
	@JsonProperty
	private RateOfCurrency rateOfCurrency;				//部门间的汇率表
	@JsonProperty
	private	BigDecimal	exchangeRate;						//与美元的汇率
	@JsonProperty
	private	String	deptName;						//显示对账部门的名称(非数据字段)
	@JsonProperty
	private List<InvoiceAndCreditItems> listInvoiceAndCreditItems;//明细列表(非数据字段)
	@JsonProperty
	private Date beginningDate; //时间查询时传输数据(非储存字段)
	@JsonProperty
	private Date endingDate; //时间查询时传输数据(非储存字段)
	@JsonProperty
	private Integer confirmStatusForFlag;//非存储字段
//	@JsonProperty
//	@JsonSerialize(using = JsonDateSerializer.class)
//	private	String		monthDate;								//记账月份，统一以YYYYMM(非数据字段，用来显示)
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDateTime;                           //团抵达时间
	@JsonProperty
	private Date beginningDateForArr; //时间查询时传输数据抵达日期(非储存字段)
	@JsonProperty
	private Date endingDateForArr; //时间查询时传输数据抵达日期(非储存字段)
	@JsonProperty
	private Integer isSuccess; // 数据是否进入财务系统
	@JsonProperty
	private Date approveDate; //审核时间
	@JsonProperty
	private BigDecimal	exAmount;  //部门间转换金额 非存储字段
	@JsonProperty
	private String	exRate;  //部门间转换汇率 非存储字段
	@JsonProperty
	private Integer isAuto;  //是否系统发送的往来账 1 是，0不是
}
