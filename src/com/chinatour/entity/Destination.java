package com.chinatour.entity;

import lombok.Data;

import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * @copyright   Copyright: 2015 
 * 目的地
 * @author Aries
 * @create-time Jul 3, 2015 11:19:01 AM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Destination extends BaseUuidEntity {
    
	
	public Destination() {
	}

	public Destination(String id, String destination) {
		super();
		this.setId(id);
		this.destination = destination;
	}
	
	@JsonProperty
	private String destination; //目的地
	@JsonProperty
	private String area;//所属区域
	@JsonProperty
	private String year;//年份
}
