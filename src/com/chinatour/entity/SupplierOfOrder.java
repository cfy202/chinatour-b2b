package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Agent团账单供应商订单表
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午9:42:50
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SupplierOfOrder extends BaseUuidEntity {

	@JsonProperty
	private String supplierOfOrderId;// id

	@JsonProperty
	private BigDecimal sum;// 金额

	@JsonProperty
	private String orderId;// 订单

	@JsonProperty
	private String supplierOfAgentId;// Agent账单供应商

}