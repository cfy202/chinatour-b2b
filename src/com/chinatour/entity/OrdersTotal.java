package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * 订单总表
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-25 下午3:39:43
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class OrdersTotal extends BaseUuidEntity{
	
	private static final long serialVersionUID = 730735218380015718L;
	
	@JsonProperty
	private String ordersTotalId; //订单总表ID
	
	@JsonProperty
	private String orderNumber; //总订单号
	
	@JsonProperty
	private Integer totalPeople;//总客人数
	
	@JsonProperty
	private String deptId;//部门ID
	
	@JsonProperty
	private String userId;//用户ID
	
	@JsonProperty
	private String wr; // Retail 1 or WholeSale 2
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date bookingDate; // 下单日期
	
	@JsonProperty
	private String agent; // agent名称(冗余字段 admin.name)
	
	@JsonProperty
	private String companyId; // 同行ID
	
	@JsonProperty
	private String company; // 同行名称(冗余字段 vender.name)
	
	@JsonProperty
	private String contactName; // 联系人名称
	
	@JsonProperty
	private String address; // 联系人地址
	
	@JsonProperty
	private String email; // 联系人邮箱
	
	@JsonProperty
	private String tel; //电话
	
	@JsonProperty
	private String postCode; //邮编
	
	@JsonProperty
	private String countryId; //国家ID
	
	@JsonProperty
	private String stateId; //州ID
	
	@JsonProperty
	private String cityId; //城市ID
	
	@JsonProperty
	private String customerSourceId; //客人来源Id
	
	@JsonProperty
	private Integer tax; // 结算状态  0 未结算, 2 已结算 未发0.05Invoice, 3 结算申请, 4 已结算并且发0.05Invoice
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date  checkTime; // 结算时间 		agent申请结算则是 agent结算时间  财务结算 则是财务结算时间 
	
	@JsonProperty
	private Integer isDel; //是否删除掉  0.未删除   1.已删除
	
	private Customer customer; // 用于下订单传输数据(非储存字段)
	
	private String groupId; //小组ID，用于小组查询传输数据(非储存字段)
	
	@JsonProperty
	private String sprCheck; //变更单结算状态(非储存字段)
	
	@JsonProperty
	private String server; //变更单结算状态(非储存字段)
	
	@JsonProperty
	private BigDecimal sumFee; //用来查询总单应收款
	
	@JsonProperty
	private Date settlementDateBeg; //结算时间查询
	
	@JsonProperty
	private Date settlementDateEnd; //结算时间查询
	
	@JsonProperty
	private String TourType;//团队类型(webService)
	
	@JsonProperty
	private String TourCode;  //线路编号(webService)
	
	@JsonProperty
	private double CommonTourFee; //应收款(webService)
	
	@JsonProperty
	private Order order; // 用于查询  子订单(非储存字段)
	
	@JsonProperty
	private BigDecimal payTotalSum; // 总收入 	用于查询  
	
	@JsonProperty
	private BigDecimal costTotalSum; // 总支出 	用于查询
	
	@JsonProperty
	private Date arrivalBeginningDate; //抵达日期时间查询
	
	@JsonProperty
	private Date arrivalEndingDate; //抵达日期时间查询
	
	@JsonProperty
	private String peerUserId;//同行系统下的订单
}


