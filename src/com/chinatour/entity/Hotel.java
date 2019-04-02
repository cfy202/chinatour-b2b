package com.chinatour.entity;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 29, 2014 2:31:08 PM
 * 
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Hotel extends BaseUuidEntity {
	
	public Hotel() {
	}
	
	public Hotel(String id, String hotelName, String standard,
			String cityId, String cityName, String address, List<GroupLine> groupLine) {
		super();
		this.setId(id); 
		this.hotelName = hotelName;
		this.standard = standard;
		this.cityId = cityId;
		this.cityName = cityName;
		this.groupLine = groupLine;
	}
	
	@JsonProperty
	private String hotelName; //酒店名称
	
	@JsonProperty
	private String standard; //酒店等级
	
	@JsonProperty
	private String cityId; //城市编号
	
	@JsonProperty
	private String cityName; //城市名称
	
	@JsonProperty
	private String address; //酒店地址
	
	@JsonProperty
	private List<GroupLine> groupLine; //线路
	
	@JsonProperty
	private GroupLineHotelRel groupLineHotelRel; //中间表的id
	
	@JsonProperty
	private String groupLineHotelRelId; //中间表的id
	
	@JsonProperty
	private String groupLineId; //中间表的id
	
	@JsonProperty
	private Integer isDel;//	0：可用   1：不可用
	
	@JsonProperty
	private Integer dayNum; //酒店对应日程
	
	@JsonProperty
	private String tel; //酒店对应联系人
	
}
