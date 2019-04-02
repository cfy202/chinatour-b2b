package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *酒店提前入住和延住
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class PrePostHotel extends OrderEntity {
	
	
	
	@JsonProperty
    private String prePostHotelId;//客人
	@JsonProperty
    private String guest;//客人
	@JsonProperty
    private String roomType;//房型
	@JsonProperty
    private Integer roomNo;//房号
	@JsonProperty
    private Integer nights;//nights数
	@JsonProperty
    private Integer type;//类型  0：提前入住  1：延住
	@JsonProperty
    private String orderId;


}
