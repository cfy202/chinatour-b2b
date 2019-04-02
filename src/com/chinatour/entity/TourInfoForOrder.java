package com.chinatour.entity;

import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 3, 2014 2:30:10 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode
public class TourInfoForOrder extends BaseUuidEntity {
     
	@JsonProperty
	private Date scheduleOfArriveTime; //正常抵达日期(团订单)
	
	@JsonProperty
	private String groupLineId; //线路ID
	
	@JsonProperty
	private String tourType; //团类型
	
	@JsonProperty
	private String scheduleLineCode; //线路编号
	
	@JsonProperty
	private String lineName; //新增 线路名称
	
	@JsonProperty
	private String specialRequirements; //客人特殊要求
	
	@JsonProperty
	private String tourInfo; //团队注意事项及备注
	
	@JsonProperty
	private String personalRoute; //自主线路行程
	
	@JsonProperty
	private String orderId; //订单ID
	
	@JsonProperty
	private Date departureDate; //非团中Insurance 团队出发日期,团中订单出发日期
	
	@JsonProperty
	private Date dueDate; //订单收款日期
	 
	@JsonProperty
	private Integer dayNum; //非团中Insurance 天数
	
	@JsonProperty
	private String arriveTime;
	
	@JsonProperty
	private String voucherRemarks;//确认单remarks
	
	@JsonProperty
	private String invoiceRemarks;//Invoice remarks
	
	@JsonProperty
	private String trackingNo;//快递单号
	
}
