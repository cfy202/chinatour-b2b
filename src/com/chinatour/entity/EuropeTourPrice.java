package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

@Data
@EqualsAndHashCode(callSuper = false)
public class EuropeTourPrice extends BaseUuidEntity {
	@JsonProperty
	private String europeTourPriceId;   
	@JsonProperty
	private String orderId;
	@JsonProperty
	private String orderNo;
	@JsonProperty
	private BigDecimal receivableAmount;     
	@JsonProperty
	private BigDecimal actualCostForTour;      
	@JsonProperty
	private String tourId; 
	@JsonProperty
	private String tourCode;
	@JsonProperty
	private String remark;
	@JsonProperty
	private String rateOfCurrencyId;
	@JsonProperty
	private String approveRemarkOPAcc;
	@JsonProperty
	private String deptIdForTour;
	@JsonProperty
	private String deptIdForOrder;
	@JsonProperty
	private String userIdForTour;
	@JsonProperty
	private String lineName;
	@JsonProperty
	private String userIdForOrder;
	@JsonProperty
	private String approveRemarkAgent;
	@JsonProperty
	private Integer completeState;  //账单状态：0-未录账单，1-账单已录，3-op财务已审核，2-agent已审核，4-agent财务结算
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date createTime;
	@JsonProperty
	private Integer isComplete;//是否已完成录入非数据库字段
	@JsonProperty
	private Integer payOrCost;  //判断为收入还是支出   0-收入；1-支出;3-变更单
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDateTime;
	@JsonProperty
	private BigDecimal currencyOfSelf;   //非数据库字段,对方部门金额
	@JsonProperty
	private Integer state;   //团结算状态
	@JsonProperty
	private Integer isInput;   //账单是否录入
	@JsonProperty
	private String venderId;    //供应商id
	@JsonProperty
	private String venderName;  //供应商名称
	@JsonProperty
	private String agentInfo;  //非数据库字段    deptName-agentName
	@JsonProperty
	private String invoiceNo;
	@JsonProperty
	private String userName;      //查询op
	@JsonProperty
	private String deptName;      //查询agent 部门
	@JsonProperty
	private String groupId;       //Team  Id
}
