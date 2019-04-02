package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 机票账单
 * @author chinatour
 *
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class SupplierPriceForOrder extends BaseUuidEntity {
	@JsonProperty
	private String supplierPriceForOrderId;
	@JsonProperty
	private String invoiceNo;	//订单号
	@JsonProperty
	private Integer quantity; //数量
	@JsonProperty
	private String airline;		//航空公司
	@JsonProperty
	private String ticketNo;	//航班号
	@JsonProperty
	private BigDecimal charge; //定该机票的实际费用
	@JsonProperty
	private BigDecimal net; //定该机票的实际费用
	@JsonProperty
	private BigDecimal operatorFee; //定该机票的实际费用
	@JsonProperty
	private BigDecimal amount;		//agent应付的费用
	@JsonProperty
	private Integer type;  //机票类型  0 Agent, 2 同行,  1 直客
	@JsonProperty
	private String agentId;  //agent Id
	@JsonProperty
	private String remark;			//录账单时的备注信息（op）
	@JsonProperty
	private String accRemarkOfOp;			// name
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDate;  //出发日期
	@JsonProperty
	private String remarkOfAgent;			//tourId
	@JsonProperty
	private String agency;			//同行id
	@JsonProperty
	private Integer approveStatus;		//账单审核状态  0未完成 1 agent 审核通过   2完成
	@JsonProperty
	private String rateOfCurrencyId;		//汇率
	@JsonProperty
	private String card;		//卡号
	@JsonProperty
	private String userId;		//op
	@JsonProperty
	private String userName;		//op
	@JsonProperty
	private String deptId;		//部门名
	@JsonProperty
	private String uploadUrl;	//上传文件路径
	@JsonProperty
	private String flightPnr;	// 机票定位代码
	@JsonProperty
	private Integer isDel;// 是否删除  1删除 0可用
	@JsonProperty
	private String tempValue01;	//供应商名 /用户名/ 直客名
	@JsonProperty
	private String tempValue02;	//订单id
	@JsonProperty
	private String tempValue03;	//订单编号
	@JsonProperty
	private String tempValue04;	//舱位等级 
	@JsonProperty
	private String tempValue05;	//国内票或 国际票
	@JsonProperty
	private String tempValue06;	//ARC
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date  date; // 机票日期
	@JsonProperty
	private String agentName;  //agnet 姓名 （非储存字段）
	@JsonProperty
	private String deptName;		//部门名（非储存字段）
	@JsonProperty
	private List<AirticketItems> airticketItemsList;//明细列表(非数据字段)
	@JsonProperty
	private String time;//用于统计    时间存储	(非数据库字段)
	@JsonProperty
	private String year;//用于统计    年份的存储	(非数据库字段)
	@JsonProperty
	private String venderName;//同行名	(非数据库字段)
	@JsonProperty
	private String venderId;//供应商id
	@JsonProperty
	private String supplierName;//供应商name
	@JsonProperty
	private String Code;//票号
	@JsonProperty
	private String TicketType;//机票状态
	@JsonProperty
	private String System;
	@JsonProperty
	private String InvoiceNum;//自动生成
	@JsonProperty
	private String invoiceRemark;
	@JsonProperty
	private int BI; //用于统计
	@JsonProperty
	private int BD; //用于统计
	@JsonProperty
	private int EI; //用于统计
	@JsonProperty
	private int ED; //用于统计
	@JsonProperty
	private int PI; //用于统计
	@JsonProperty
	private int PD; //用于统计
	
	@JsonProperty
	private Date arrivalBeginningDate; //抵达日期时间查询
	
	@JsonProperty
	private Date arrivalEndingDate; //抵达日期时间查询
	@JsonProperty
	private String locator;  
}
