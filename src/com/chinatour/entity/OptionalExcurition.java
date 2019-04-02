package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.SerializedName;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * 此类为自选项
 * @author whoisme
 *
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class OptionalExcurition  extends BaseUuidEntity{

    @JsonProperty
    private String name;    //自选项名称
    
    @JsonProperty
    private BigDecimal price;    //价格
    
    @JsonProperty 
    private String remark;    //备注
    
    @JsonProperty
    @SerializedName("code")
    private String type;    //自选项类型
    
	@JsonProperty
	private String role;//用于统计
	
	@JsonProperty
	private Integer sum;//用于统计 
	
	@JsonProperty
	private String time;//用于统计  格式YYYY-MM

	@JsonProperty
	private String deptId;//用于统计 
	
	@JsonProperty
	private String userId;//非数据库字段
	
	@JsonProperty
	private String departureDate;	//出发日期 (同时在统计中用来存放年份，统计借用字段  格式：YYYY)(借用字段，在同行系统头部使用接收字段)（B2B必有）
	
	@JsonProperty
	private String tripDesc;  //线路描述(统计中的借用字段：Retail 1 or WholeSale 2)
	
	@JsonProperty
	private String contactor;  //联系人 	用于查询(统计借用字段，在统计中传递Role)
	
	@JsonProperty
	private String groupId;//组Id(非数据库字段)
	
	@JsonProperty
	private BigDecimal pay;//(非数据库字段)
	
	@JsonProperty
	private BigDecimal cost;//(非数据库字段)

	@JsonProperty
	private BigDecimal commonTourFee; // (非数据库字段)
}







