package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @ClassName VendorsData
 * @PackageName com.chinatour.entity
 * @Description 
 * @author Bowden
 * @Date 2015-11-6 下午2:49:13
 * @Version V1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class VendorsData extends BaseUuidEntity{
	
	@JsonProperty
	private String vendorsId;

	@JsonProperty
	private String accDateId;
	
	@JsonProperty
	private AccData accData;
}
