package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
/**
 *  部门针对科目录入报表
 * @author chinatour
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BusinessFlow extends BaseUuidEntity {
	@JsonProperty
	private String 				businessFlowId;						//subjectId
	@JsonProperty
	private String				deptId;
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date              	accountDate ;  //账目月份  201301
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date                createTime ; //账目创建
	@JsonProperty
	private	String				accountSubjectId;					//与全局会计科目的关系
	@JsonProperty
	private BigDecimal              accountsSum   ; //金额
	@JsonProperty
	private Integer             isDel;  //0未删除  1删除
	@JsonProperty
	private Integer 			isAvailable;   //0无效的 ,1 有效的
	@JsonProperty
	private Integer 			ifClose;   //0未扎帐 ,1已扎帐
	@JsonProperty
	private String 				remark; //备注
	@JsonProperty
	private String 			 	subjectCode;   //会计科目编码
	@JsonProperty
	private String 				subjectName;	//科目名称	
	@JsonProperty
	private Integer				hasChild;								//是否有明细项目0:无；1：有
	@JsonProperty
	private String 				parentSubjectCode;  //父及科目Id
	@JsonProperty
	private String 				parentSubjectId;//父及科目编码
	@JsonProperty
	private	String				globalAccountId;					//与全局会计科目的关系
	@JsonProperty
	private String 				subjectType;	//类型  1. Income  2.Cost  3.Sales Income   4.Tour Cost
	@JsonProperty
	private Integer 			level;  //等级  123级
	@JsonProperty
	private Integer             accountDateStr ;  //账目月份  
	@JsonProperty
	private String 				childAccDept;//科目下的记账部门标示
	@JsonProperty
	private AccountSubject accountSubject; //时间查询时传输数据(非储存字段)
}
