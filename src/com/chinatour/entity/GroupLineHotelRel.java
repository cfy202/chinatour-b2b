package com.chinatour.entity;

import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;
@Data
@EqualsAndHashCode(callSuper = false)
public class GroupLineHotelRel extends BaseUuidEntity {
	public GroupLineHotelRel(){}
	public GroupLineHotelRel(String id, String groupLineId, String hotelId, Integer dayNum){
		super();
		this.setId(id);
		this.groupLineId = groupLineId;
		this.hotelId = hotelId;
		this.dayNum = dayNum;
	}
	@JsonProperty
	private String groupLineId;
	
	@JsonProperty
	private String hotelId;
	
	@JsonProperty
	private Hotel hotel;
	
	@JsonProperty
	private Integer dayNum; //酒店对应日程
	
}
