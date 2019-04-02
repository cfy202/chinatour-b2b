package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 29, 2014 2:19:01 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class City extends BaseUuidEntity {
    
	
	public City() {
	}

	public City(String id, String cityName, String cityCode, int cityLevel) {
		super();
		this.setId(id);
		this.cityName = cityName;
		this.cityCode = cityCode;
		this.cityLevel = cityLevel;
	}
	
	@JsonProperty
	private String cityName; //城市名称
	
	@JsonProperty
	private String cityCode; //城市编码
	
	@JsonProperty
	private Integer cityLevel; //城市等级
}
