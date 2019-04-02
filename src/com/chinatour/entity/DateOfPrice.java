package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 产品不同时间段的不同价格
 * */
@Data
@EqualsAndHashCode(callSuper = false)
public class DateOfPrice extends OrderEntity {
	
	@JsonProperty
	private String dateOfPriceId;//Id
	@JsonProperty
	private String departureTime;//出发时间（存储每天时间用分号隔开）
	@JsonProperty
	private BigDecimal DeparturePrice;//时间段的价格
	@JsonProperty
	private String GroupLineId;//产品Id
	@JsonProperty
	private Date updateTime;//更改时间
	@JsonProperty
	private Integer isAvailable;//是否可用：0、可用（默认值），1、不可用
}
