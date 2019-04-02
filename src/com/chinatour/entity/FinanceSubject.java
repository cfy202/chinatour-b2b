package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class FinanceSubject extends BaseUuidEntity {
	@JsonProperty
	private String 				financeSubjectId;						//subjectId
	@JsonProperty
	private String 				subjectCode;
	@JsonProperty
	private String 				subjectName;							//subjectName
	@JsonProperty
	private Integer    			codeLen;
	@JsonProperty
	private String 				subjectType;							//subjectType（OUTLAY:费用-损益类，COST:成本类，ASSET:资产类，INCOME:收入-损益类，LIABILITY:负债类，OWNEREQUITY:所有者权益类）
	@JsonProperty
	private Integer 			directionOfBalance;						//1.借方；2，贷方
	@JsonProperty
	private String 				parentSubjectCode;
	@JsonProperty
	private String 				adjustType;
	@JsonProperty
	private String				deptId;
	@JsonProperty
	private Integer				hasChild;								//是否有明细项目0:false,1:true
	@JsonProperty
	private Integer 			isUnappropriatedProfit;					//是否为未分配利润科目0:false,1:true
	@JsonProperty
	private Integer				isCurrentYearProfit;					//是否为本年利润科目 0:false,1:true
	@JsonProperty
	private	String				globalFinanceSubjectId;					//与全局会计科目的关系
	@JsonProperty
	private Boolean				ifAdjustAllowed;						//是否在AccData表中存在过初始化或者记账，不对应数据库中的字段
	@JsonProperty
	private String				reportItemId;							//报表项目ID
	@JsonProperty
	private String				reportType;								//报表类型 资产负债表、损益表...
	@JsonProperty
	private String				reportSubjectType;						//报表项目对应的会计科目大类
	@JsonProperty
	private String				subSubjectType;							//报表项目二级项目类型 流动资产、流动负债、等
	@JsonProperty
	private Boolean				isCash;									//是否属于货币资本类型，如是，则需要选择记账时的资本用途
	@JsonProperty
	private String				direction;								//记账方向
	@JsonProperty
	private Double				occurValue;								//用于在自动记账时保存发生额
	@JsonProperty
	private String				colName;								//用于保存发生自动 记账的列名，key值
	@JsonProperty
	private String				cashFlowItemId;							//用于保存每次查询后的SubjectItemRel中的资金用途ID
	@JsonProperty
	private String				itemName;								//cashFlowItemId对应的itemName
	@JsonProperty
	private String				adjustId;								//对应AutoCertCfgItem中的Digital值为0的主键ID
	@JsonProperty
	private	BigDecimal			originBalance;							//期初值
	@JsonProperty
	private	BigDecimal			occurSum;								//本期累计发生额
	@JsonProperty
	private	BigDecimal			remainingSum;							//余额
	@JsonProperty
	private	String				ledgerMonth;							//账期
	
	private String 				globalFinanceSubject;                   //用于处理页面数据
	
}
