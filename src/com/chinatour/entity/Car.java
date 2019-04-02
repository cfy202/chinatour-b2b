package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Car extends BaseUuidEntity {
	@JsonProperty
	private String carId;
	@JsonProperty
	private String tourId;
	@JsonProperty
	private String tourCode;
	@JsonProperty
	private String carName;
	@JsonProperty
	private Integer seats;
	@JsonProperty
	private String carRemark;
}
