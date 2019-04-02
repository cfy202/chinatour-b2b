package com.chinatour.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Oct 8, 2014 9:00:12 PM
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CustomerOrderVO {
	
	private String customerId; //顾客id编号
	
	private String customerCode; //顾客编码
	
	private String lastName; //姓
	
	private String firstName; //名
	
	private String middleName; //中间名称
	
	private String agent;	//用于查询
	
	private String userId;	//用于查询   
	
	private String orderId;// 订单
	
	private String orderNo;//用于查询  	订单编号
	
	private String state;//用于查询  	订单状态
	
	private String isDel;//删除
	
	private String ticketType;//机票类型
}
