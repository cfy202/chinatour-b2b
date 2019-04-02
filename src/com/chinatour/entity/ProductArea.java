package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

import lombok.EqualsAndHashCode;

/**
 * 产品所属区域（目的地区域）
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProductArea extends BaseUuidEntity {
	
	
	@JsonProperty
	private String areaName;//区域名字
}
