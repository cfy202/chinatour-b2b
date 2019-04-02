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
public class ShareSpace extends BaseUuidEntity {
	
	/**
	 *  
	 */
	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String shareSpaceId;	//Id
	
	@JsonProperty
	private String shareName; //文件名称
	
	@JsonProperty
	private String shareUrl; //文件路径
	
	@JsonProperty
	private String userId; //上次用户
	
	@JsonProperty
	private String shareTypeId; //所属文件类型
	
	@JsonProperty
	private Integer isDel; //是否删除  0 未删除；1 删除
	
	@JsonProperty
	private String serverIp; //服务器IP
	
}
