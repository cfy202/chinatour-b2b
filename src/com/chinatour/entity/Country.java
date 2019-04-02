package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 28, 2014 3:36:35 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Country extends BaseUuidEntity {
	
	public Country() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Country(String id, String countryName) {
		super();
		this.setId(id); 
		this.countryName = countryName;
	}
	
	@JsonProperty
	private String countryName; //国家名称
	@JsonProperty
	private int sort; // 排序

}
