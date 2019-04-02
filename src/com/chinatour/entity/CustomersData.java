package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @ClassName CustomersData
 * @PackageName com.chinatour.entity
 * @Description TODO
 * @author Bowden
 * @Date 2015-11-6 下午3:04:44
 * @Version V1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CustomersData extends BaseUuidEntity{
	
	@JsonProperty
	private String customersId;

	@JsonProperty
	private String accDataId;
	
	@JsonProperty
	private AccData accData;
}
