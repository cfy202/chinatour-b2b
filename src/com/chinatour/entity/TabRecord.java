package com.chinatour.entity;

import java.math.BigDecimal;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;
@Data
@EqualsAndHashCode(callSuper = false)
public class TabRecord extends BaseUuidEntity {
	@JsonProperty
	private	BigDecimal	salesIncome = new BigDecimal(0.00);
	@JsonProperty
	private	BigDecimal	tourCost = new BigDecimal(0.00);
	@JsonProperty
	private	BigDecimal	income = new BigDecimal(0.00);
	@JsonProperty
	private	BigDecimal	cost = new BigDecimal(0.00);
	@JsonProperty
	private	BigDecimal	profit = new BigDecimal(0.00);
	@JsonProperty
	private BigDecimal time;
}
