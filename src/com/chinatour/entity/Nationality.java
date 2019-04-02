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
public class Nationality extends BaseUuidEntity {
	@JsonProperty
	private String name;
	
	@JsonProperty
	private String type;
}
