package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Invoice {
	@JsonProperty
	private Order order;
	
	@JsonProperty
	private Admin agent;
}
