package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/** 
 * @author 作者 E-mail: Cery
 * @version 创建时间：2016-4-25 上午8:43:29 
 * 类说明 
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Brand {
	
	
	public Brand() {
	}
	public Brand(String brandId, String brandName) {
		super();
		BrandId = brandId;
		BrandName = brandName;
	}
	@JsonProperty
	private String BrandId;
	@JsonProperty
	private String BrandName;

}
