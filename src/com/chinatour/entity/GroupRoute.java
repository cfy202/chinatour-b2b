package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class GroupRoute extends BaseUuidEntity{
	public GroupRoute(){}
	
	public GroupRoute(String id,int dayNum, String routeName, String routeDescribeForEn,String routeDescribeForUs) {
		super();
		this.setId(id);
		this.dayNum = dayNum;
		this.routeName = routeName;
		this.routeDescribeForEn = routeDescribeForEn;
		this.routeDescribeForUs = routeDescribeForUs;
	}
	
	@JsonProperty
	private int dayNum;			//线路是第几天
	@JsonProperty
	private String routeName;	//线路名称
	@JsonProperty
	private String routeDescribeForEn;	//中文线路描述
	@JsonProperty
	private String routeDescribeForUs;	//英文线路描述
	@JsonProperty
	private String groupLineId; //行程id
	@JsonProperty
	private String hotel;//追随的酒店信息
	
}
