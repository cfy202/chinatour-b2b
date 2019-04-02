package com.chinatour.entity;

/**
 *  部门选择科目
 */
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

@Data
@EqualsAndHashCode(callSuper = false)

public class AccountSubject {
	@JsonProperty
	private String 				accountSubjectId;						//subjectId
	@JsonProperty
	private String 			 	subjectCode;   //会计科目编码
	@JsonProperty
	private String 				subjectName;	//科目名称	
	/*@JsonProperty
	private String 				entId;   //去掉
*/	@JsonProperty
	private String				deptId;
	@JsonProperty
	/*private String				entName; //去掉
	@JsonProperty*/
	private Integer				hasChild;								//是否有明细项目0：没有；1：已有
	@JsonProperty
	private Date                createTime ;
	@JsonProperty
	private String 				parentSubjectCode;  //父及科目Id
	@JsonProperty
	private String 				parentSubjectId;//父及科目编码
	@JsonProperty
	private	String				globalAccountId;					//与全局会计科目的关系
	@JsonProperty
	private Integer 				subjectType;	//类型  1. Income  2.Cost 3.Sales Income   4.Tour Cost
	@JsonProperty
	private Integer 			level;  //等级  123级
	@JsonProperty
	private String              childAccDept;//记账部门的标示号     (1.Sales-OutBound   2.Ticketing   3.InBound     4.Marketing   5.Wholesale)------------->新系统改为groupId
	@JsonProperty
	private String              childAccDeptName;//固定的记账部门名称---------》用来保存groupName
	@JsonProperty
	private List<AccountSubject> childAccountSubjectList; //用来保存该科目的子科目
	@JsonProperty
	private List<BusinessFlow> businessFlowList;
	@JsonProperty
	private BigDecimal totalYearly; //(非储存字段)
	@JsonProperty
	private String percentYearly; //(非储存字段)
	@JsonProperty
	String accountDateStr;
	@JsonProperty
	private Integer 			isDel;  //0 有效  1删除
	
}
