package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
/**
 * 
 * @author Administrator
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AccData extends BaseUuidEntity {
	@JsonProperty
	private String dataNo;
	@JsonProperty
	private String displayName;
	@JsonProperty
	private Integer cors;      //判断是customer还是supplier   customer：1；supplier：2     
	@JsonProperty
	private String type;
	@JsonProperty
	private String dorc;
	@JsonProperty
	private String email;
	@JsonProperty
	private String address;
	@JsonProperty
	private String terms;
	@JsonProperty
	private Date startDate;
	@JsonProperty
	private String startDateString;         //非数据库字段，时间字符串格式
	@JsonProperty
	private Date dueDate;
	@JsonProperty
	private String dueDateString;         //非数据库字段，时间字符串格式
	@JsonProperty
	private String invoiceMemo;
	@JsonProperty
	private String statementMemo;
	@JsonProperty
	private String status;     //Open/Partial/Paid/Closed/Overdue/Applied/Unapplied/Closed
	@JsonProperty
	private BigDecimal totalAmount;
	@JsonProperty
	private BigDecimal balance;
	@JsonProperty
	private BigDecimal originalAmount;
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date paymentDate;
	@JsonProperty
	private String payMethodId;
	@JsonProperty
	private String userId;
	@JsonProperty
	private String companyId;
	@JsonProperty
	private String customerId;   //非数据库字段
	@JsonProperty
	private String vendorsId;   //非数据库字段
	@JsonProperty
	private Vender vender;   //非数据库字段
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)    //非数据库字段，开始时间
	private Date beginDate;
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)     //非数据库字段，结束时间
	private Date endDate;
	@JsonProperty
	private String account;
	@JsonProperty
	private String split;
	@JsonProperty
	private String officeSubjectId;
	@JsonProperty
	private String firstName;              //非数据库字段，用于存储客人信息
	@JsonProperty
	private String middleName;             //非数据库字段，用于存储客人信息
	@JsonProperty
	private String lastName;              //非数据库字段，用于存储客人信息
	@JsonProperty
	private Customer customer;              //非数据库字段，用于存储客人信息
	@JsonProperty
	private BigDecimal orgTotalAmount;     //部分支付时，如果没有输入许支付的金额，则默认为累加的和使用该值表示
	@JsonProperty
	private BigDecimal preTotalAmount;    //修改之前的totalAmount
	@JsonProperty
	private BigDecimal preBalance;       //修改之前的balance
	@JsonProperty
	private String accDataId; 
	@JsonProperty
	private BigDecimal payment;
	@JsonProperty
	private CustomersData customersData;
	@JsonProperty
	private VendorsData vendorsData;
	@JsonProperty
	private List<AccDataDetails> accDataDetailsList;
	@JsonProperty
	private String classes;
	@JsonProperty
	private String orderNo;
	@JsonProperty
	private String customerName;
	@JsonProperty
	private String resourceId;          //保存外部接口传来的数据id
}
