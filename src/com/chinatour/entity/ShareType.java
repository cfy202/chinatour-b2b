package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time Sep 15, 2014 11:00:00 AM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class ShareType extends BaseUuidEntity {
	
	/**
	 *  
	 */
	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String shareTypeId;	//Id

	@JsonProperty
	private String typeName; //团队类型名称
	
	@JsonProperty
	private Integer isDel; //是否删除  0 未删除；1 删除
	
}
