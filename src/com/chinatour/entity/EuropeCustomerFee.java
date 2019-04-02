package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class EuropeCustomerFee extends BaseUuidEntity {
	@JsonProperty
	private String europeCustomerFeeId;
	@JsonProperty
	private String orderId;
	@JsonProperty
	private String europeTourPriceId;
	@JsonProperty
	private BigDecimal enterCurrency;
	@JsonProperty
	private BigDecimal amount;
	@JsonProperty
	private BigDecimal dollar;
	@JsonProperty
	private String remark;
	@JsonProperty
	private Integer state;
	@JsonProperty
	private String LastName;
	@JsonProperty
	private String middleName;
	@JsonProperty
	private String firstName;
	@JsonProperty
	private Integer CustomerOrderNo;
	@JsonProperty
	private String CustomerOrderRelId;
	@JsonProperty
	private RateOfCurrency rateOfCurrency;
	@JsonProperty
	private String rateOfCurrencyId;
}
