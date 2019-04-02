package com.chinatour.entity;

import java.util.Date;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RoomSharing extends BaseUuidEntity {
	
	@JsonProperty
	private String roomSharingId;//id

	@JsonProperty
	private String productCode;//产品号
	
	@JsonProperty
	private String productName;//产品名
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arrivalDate;//抵达时间
	
	@JsonProperty
	private String tourType;//团类型
	
	@JsonProperty
	private Integer sex;//性别    1 女 F；2 男 M
	
	@JsonProperty
	private String roomType;//房间类型
	
	@JsonProperty
	private String userId;//用户名
	
	@JsonProperty
	private String userName;//用户名
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date createDate;//创建时间
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date modifyDate;//修改时间
	
	@JsonProperty
	private Integer status;//状态  0 pending 1 close
	
	@JsonProperty
	private Integer totalPeople;//人数
	
	@JsonProperty
	private Integer roomOrTour;//拼房或拼团   1 room 2 tour
	
	@JsonProperty
	private String remark;//备注
	
	@JsonProperty
	private String description;//描述

}