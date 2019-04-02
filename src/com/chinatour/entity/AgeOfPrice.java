package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 产品不同年龄，不同货币的不同价格
 * */
@Data
@EqualsAndHashCode(callSuper = false)
public class AgeOfPrice extends OrderEntity {
	
	@JsonProperty
	private String ageOfPriceId;//Id
	@JsonProperty
	private String currencyId;//货币Id（B2B必有）
	@JsonProperty
	private BigDecimal adult;//成人价格
	@JsonProperty
	private BigDecimal bed;//小孩占床价格
	@JsonProperty
	private BigDecimal notBed;//小孩不占床价格
	@JsonProperty
	private BigDecimal children;//2-5岁的小孩的价格(已不使用的價格)
	@JsonProperty
	private BigDecimal baby;//婴儿的价格
	@JsonProperty
	private BigDecimal commission;//成人佣金
	@JsonProperty
	private BigDecimal hotelPrice;//续住酒店价格
	@JsonProperty
	private BigDecimal roomSharing;//男性拼房价格 
	@JsonProperty
	private Integer days;//续住酒店天数(暂时不用)
	@JsonProperty
	private Date departureTime;//时间段（B2B必有）
	@JsonProperty
	private String GroupLineId;//产品Id（B2B必有）
	@JsonProperty
	private Date updateTime;//更改时间
	@JsonProperty
	private Date createTime;//创建时间
	@JsonProperty
	private BigDecimal supplement;//单房差
	@JsonProperty
	private BigDecimal childComm;//小孩佣金
	@JsonProperty
	private Integer isAvailable;//是否可用：0、可用（默认值），1、不可用
	@JsonProperty
	private Integer typeNo;//價格类型     0、默认标间，1、第三人房全套价格高，2、第四人房全套价格（B2B必有）
	/******非数据库字段*****/
	@JsonProperty
	private String currencyChs;//货币币种中文名称
	@JsonProperty
	private String currencyEng;// 货币币种英文名称
	@JsonProperty
	private String symbol;// 货币币种代表符
	@JsonProperty
	private Date maxTime;//最大时间
	@JsonProperty
	private Date minTime;//最小时间
	
	
}
