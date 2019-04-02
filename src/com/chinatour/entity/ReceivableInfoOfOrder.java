package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 3, 2014 1:53:52 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode
public class ReceivableInfoOfOrder extends BaseUuidEntity {
	
	@JsonProperty
	private BigDecimal totalCommonTourFee; //常规团费总额
	
	@JsonProperty
	private BigDecimal totalFeeOfOthers; //《非团无》《团==其他费用总额》
	
	@JsonProperty
	private BigDecimal sumFee; //《非团==共计应收团款》《团==共计应收团款》
	
	@JsonProperty
	private String orderId; //订单ID
	
	@JsonProperty
	private String orderNo; //订单号
	
	@JsonProperty
	private BigDecimal peerUserCost; //同行订单同行佣金
	
	@JsonProperty
	private Integer totalPeople; //总人数
	
	/*****非数据库字段*****/
	@JsonProperty
	private List<OrderReceiveItem> orderReceiveItemList;//费用详情集合
	
	@JsonProperty
	private TourInfoForOrder tourInfoForOrder;//订单信息
}
