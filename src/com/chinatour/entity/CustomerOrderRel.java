package com.chinatour.entity;

import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 3, 2014 2:46:16 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode
public class CustomerOrderRel extends BaseUuidEntity {
	
	@JsonProperty
	private String customerId; //客人ID
	
	@JsonProperty
	private String orderId; //子订单ID
	
	@JsonProperty 
	private String ordersTotalId; //总订单ID
	
	@JsonProperty
	private String sameComeIn; //(疑问字段)
	
	@JsonProperty
	private Integer contactFlag; // 客人在总订单下的状态  0 正常，1 已删除   （客人与总订单的关系）
	
	@JsonProperty
	private Integer customerOrderNo; //总订单中客人序号   （客人与总订单的关系）
	
	@JsonProperty
	private String guestRoomType; //房型     （客人与总订单的关系）
	
	@JsonProperty
	private Integer roomNumber; //房号      （客人与总订单的关系）
	
	@JsonProperty
	private Integer roomIsFull; //(针对双人间)客人的选房是否满员  0.未满员，1.满员，2.已有加床    （客人与总订单的关系）
	
	@JsonProperty
	private String ticketType; // GIT Ticket 团队机票; FIT Ticket 散客机票    （客人与总订单的关系）
	
	@JsonProperty
	private String voucherStr;//Voucher信息
	
	@JsonProperty
	private Integer customerTourNo; //团中客人序号(如果组团)   （客人与子订单的关系）
	
	@JsonProperty
	private Integer isDel; //是否已被删除  0 未删除,1 已删除, 3,恢复中 , 5 删除中 cancelling (客人与子订单的关系)
	
	
	
	
	@JsonProperty
	private String userName; //用于查询  用户名称 （非储存字段） 
	
	@JsonProperty
	private Customer customer; //订单传输数据 （非储存字段）
	 
	private List<CustomerFlight> customerFlightList; //对应的出入境航班信息 （非储存字段）
	
	private Order order;  //orderId对应的订单（非存储字段）
	
	@JsonProperty
	private String carName;//拼车时的车的名称
	@JsonProperty
	private String carId;//拼车时的车辆id
}
