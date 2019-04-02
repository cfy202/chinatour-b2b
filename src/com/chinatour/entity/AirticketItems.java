package com.chinatour.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;
@Data
@EqualsAndHashCode(callSuper = false)
public class AirticketItems extends BaseUuidEntity {
	@JsonProperty
    private String itemsId; //id
	@JsonProperty
    private String ticketNo;//机票号
	@JsonProperty
    private BigDecimal net;//定该机票的实际费用
	@JsonProperty
    private BigDecimal tax;//定该机票的税收费用
	@JsonProperty
    private BigDecimal total;//定该机票的实际费用+定该机票的税收费用
	@JsonProperty
    private BigDecimal selling;//应付agent费用
	@JsonProperty
	private BigDecimal charge; //定该机票的实际费用
	@JsonProperty
    private String supplierpricefororderId;//机票账单表
	@JsonProperty
    private String orderId;//订单号 查询
	@JsonProperty
    private String orderNo;//订单号 查询
	@JsonProperty
    private String userId;//用户id 查询
	@JsonProperty
    private String userName;//用户名 查询
}