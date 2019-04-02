package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * 月报表  全部会计科目
 * @author chinatour
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class GlobalAccount {
	@JsonProperty
	private String 			globalAccountId;						//subjectId
	@JsonProperty
	private String 			subjectCode;   //会计科目编码
	@JsonProperty
	private String 			subjectName;	//科目名称						
	@JsonProperty
	private String 			subjectType;	//类型  1. Income  2.Cost  3.Sales Income   4.Tour Cost
	@JsonProperty
	private Integer 		directionOfBalance;  //暂时没用
	@JsonProperty
	private Integer			hasChild;								//是否有明细项目1:有；0：无
	@JsonProperty
	private Integer 		level;  //等级  123级
	@JsonProperty
	private String          pid;                                     //父类globalAccountId
	@JsonProperty
	private String 				entId;
	@JsonProperty
	private String				deptId;
}
