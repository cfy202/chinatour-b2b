package com.chinatour.entity;

import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 3, 2014 3:21:40 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode
public class CustomerFlight extends BaseUuidEntity {
	
	@JsonProperty
	private String flightNumber; //航班号
	
	@JsonProperty
	private String flightCode; //航空公司代码
	
	@JsonProperty
	private String arriveTime; //入境航班:抵达时间; 出境航班:起飞时间
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDate; //入境航班:抵达日期; 出境航班:出境日期
	
	@JsonProperty
	private Integer ifPickUp; //是否接机  1:接机; 2:不接机
	
	@JsonProperty
	private Integer ifSendUp; //是否送机  1:送机; 2:不送机
	
	@JsonProperty
	private Integer outOrEnter; //类型： 1:入境; 2:出境
	
	@JsonProperty
	private String customerOrderRelId; //关系中间表ID
	
	@JsonProperty
	private Integer isDel; //是否删除
	
	@JsonProperty
	private String CustomerNo; //客人编号			 用于查询
	
	@JsonProperty
	private String CustomerNos; //多个客人编号  用逗号隔开          用于查询
	
	@JsonProperty
	private String userId; //用户id         用于查询
	
	@JsonProperty
	private String arriveDateStr;
	
	@JsonProperty
	private String remark;   //航班备注信息
	
	@JsonProperty
	private Customer customer;   //航班备注信息
	
	@JsonProperty
	private String lastName;   //客人名称（用于查询）
	
	@JsonProperty
	private String firstName;   //客人名称（用于查询）
	
	@JsonProperty
	private String middleName;   //客人名称（用于查询）
	
	@JsonProperty
	private String tourCode;   //团号（用于查询）
	
	@JsonProperty
	private String tourId;  //团id（用于查询）
	
	@JsonProperty
	private String deptId;  //部门id（用于查询）
	
	@JsonProperty
	private String customerId;
	
}
