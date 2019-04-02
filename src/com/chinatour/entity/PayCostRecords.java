package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 3, 2014 3:33:30 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode
public class PayCostRecords extends BaseUuidEntity {
	
	@JsonProperty
	private String orderId; //订单ID
	
	@JsonProperty
	private String code; //单号
	
	@JsonProperty
	private BigDecimal sum; //收款、支付金额
	
	@JsonProperty
	private String way; //收款或者支付方式
	
	@JsonProperty
	private String item; //款项
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date time; //收款、支付时间
	
	@JsonProperty
	private String remark; //摘要
	
	@JsonProperty
	private Integer status; //财务审核状态  0,未审核；1，通过；2，不通过；3，已入账；4，系统审核
	
	@JsonProperty
	private String confirmRemark; //审核摘要
	
	@JsonProperty
	private String billNo; //缴费单号
	
	@JsonProperty
	private String venderId; //成本供应商
	
	@JsonProperty
	private Integer type; //成本类型：手动生成：0  ；  账单自动生成：（ 1.地接  2.酒店 3.机票  4.保险  5其他）变更单生成：9  欧洲部变更单或机票部变更单 6
	
	@JsonProperty
	private Integer payOrCost; //类型：1：收入、 2：支出
	
	@JsonProperty
	private String checkUserId;//审核人id
	
	@JsonProperty
	private Order orderList;	//用于查询 	order对象
	
	@JsonProperty
	private String scheduleOfArriveTime;	//用于查询 	抵达日期
	
	@JsonProperty
	private String venderString; //用于查询 	成本供应商
	
	@JsonProperty
	private String deptIdString; //用于查询 		部门id
	
	@JsonProperty
	private String tourCode; //用于查询 	 团号
	
	@JsonProperty
	private String orderNo; //用于查询 	 订单号（拓展）
	
	@JsonProperty
	private String groupId; //用于查询 	 团号
	
	@JsonProperty
	private String userName; //用于查询 	 团号
	
	@JsonProperty
	private BigDecimal payTotalSum; // 总收入 	用于查询  
	
	@JsonProperty
	private BigDecimal costTotalSum; // 总支出 	用于查询
	
	@JsonProperty
	private Integer isSuccess; // 数据是否进入财务系统
	
	@JsonProperty
	private Date approveDate; //审核时间
	
	@JsonProperty
	private Date beginningTime;//非数据库存储字段，用于传输time
	
	@JsonProperty
	private Date endingTime;//非数据库存储字段，用于传输time
}
