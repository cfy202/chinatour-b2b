package com.chinatour.entity;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

@Data
@EqualsAndHashCode(callSuper = false)
public class StatisticalProfit extends BaseUuidEntity {
	@JsonProperty
	private String deptId;
	@JsonProperty
	private String deptName;
	@JsonProperty
	private TabRecord jan = new TabRecord();
	@JsonProperty
	private TabRecord feb = new TabRecord();
	@JsonProperty
	private TabRecord mar = new TabRecord();
	@JsonProperty
	private TabRecord apr = new TabRecord();
	@JsonProperty
	private TabRecord may = new TabRecord();
	@JsonProperty
	private TabRecord jun = new TabRecord();
	@JsonProperty
	private TabRecord jul = new TabRecord();
	@JsonProperty
	private TabRecord aug = new TabRecord();
	@JsonProperty
	private TabRecord sep = new TabRecord();
	@JsonProperty
	private TabRecord oct = new TabRecord();
	@JsonProperty
	private TabRecord nov = new TabRecord();
	@JsonProperty
	private TabRecord dec = new TabRecord();
	@JsonProperty
	private TabRecord total = new TabRecord(); 
	@JsonProperty
	private String time;
	@JsonProperty
	private String childAccDept;//针对科目下的部门存放部门Id
	@JsonProperty
	private String childAccDeptName;//针对科目下的部门存放部门Id
	@JsonProperty
	private BigDecimal totalSalesIncome = new BigDecimal(0.00);  //一年的收入总和
	@JsonProperty
	private BigDecimal totalTourCost = new BigDecimal(0.00);	//一年的支出总和
	@JsonProperty
	private BigDecimal totalIncome = new BigDecimal(0.00);  //一年的收入总和
	@JsonProperty
	private BigDecimal totalCost = new BigDecimal(0.00);	//一年的支出总和
	@JsonProperty
	private BigDecimal totalProfit = new BigDecimal(0.00);	//一年的利润总额
	@JsonProperty
	private List<String> deptIds = new ArrayList<String>(); //用于ceo及region的deptId存储
	
}
