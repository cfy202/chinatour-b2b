package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class InvoiceMail {
	@JsonProperty
	private String destPath;   //附件文件的路径
	
	@JsonProperty
	private String addressTo;   //收件人地址（可为多位）
	
	@JsonProperty
	private String orderNo;   //确认单号
	
	@JsonProperty
	private String subject;   //邮件主题
	
	@JsonProperty
	private String orderId;   //子订单id
	
	@JsonProperty
	private String lineName;   //线路名称
	
	@JsonProperty
	private String ordersTotalId;   //总订单id
	
	@JsonProperty
	private int iOrV;      //判断是invoice or voucher   f/c 1:invoice   2.voucher
	
	@JsonProperty
	private String logo;      //logo
	
	@JsonProperty
	private String menuId; 
	
	@JsonProperty
	private String tourCode;
	
	@JsonProperty
	private String itInfo;
	
	
}
