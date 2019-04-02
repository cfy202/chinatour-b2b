package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author Jared
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CustomerSource extends BaseUuidEntity{
	
	@JsonProperty
	private String customerSourceId;
	
	@JsonProperty
	private String sourceName;
	
	@JsonProperty
	private String deptId;
}
