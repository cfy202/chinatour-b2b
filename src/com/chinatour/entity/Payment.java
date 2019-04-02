package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Payment extends BaseUuidEntity {
    @JsonProperty
	private String paymentId;
    @JsonProperty
    private String orderId;
    @JsonProperty
    private String orderNo;
    @JsonProperty
    private BigDecimal payment;
    @JsonProperty
    private BigDecimal balance;
    @JsonProperty
    private String payType;
    @JsonProperty
    private String payInfo;
    @JsonProperty
    private BigDecimal amount;
    @JsonProperty
    private String dateStr;  //非数据库存储字段

}