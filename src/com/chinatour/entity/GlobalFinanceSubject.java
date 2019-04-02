package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class GlobalFinanceSubject extends BaseUuidEntity {
	@JsonProperty
	private String 			globalFinanceSubjectId;						//subjectId
	@JsonProperty
	private String 			subjectCode;
	@JsonProperty
	private String 			subjectName;							//subjectName
	@JsonProperty
	private Integer    		codeLen;
	@JsonProperty
	private String 			subjectType;							//subjectType
	@JsonProperty
	private Integer 		directionOfBalance;
	@JsonProperty
	private String 			parentSubjectCode;
	@JsonProperty
	private String 			adjustType;
	@JsonProperty
	private Integer			hasChild;								//是否有明细项目 0:false,1:true
	@JsonProperty
	private Integer 		isUnappropriatedProfit;					//是否为未分配利润科目0:false,1:true
	@JsonProperty
	private Integer			isCurrentYearProfit;					//是否为本年利润科目 0:false,1:true
	@JsonProperty
	private	String			deptId;									//用于查询的条件
}
