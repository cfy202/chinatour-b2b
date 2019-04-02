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
public class State extends BaseUuidEntity {
	
	public State() {
		// TODO Auto-generated constructor stub
	}

	public State(String id, String stateName, Country country) {
		super();
		this.setId(id);
		this.stateName = stateName;
		this.country = country;
	}
	
	@JsonProperty
	private String stateName; //州名称
	
	@JsonProperty
	private Country country; //所属国家
}
