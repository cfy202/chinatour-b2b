package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Agent团账单供应商表
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午9:41:11
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SupplierOfAgent extends BaseUuidEntity {

	@JsonProperty
	private String supplierOfAgentId;// id

	@JsonProperty
	private BigDecimal sum;// 账单总额

	@JsonProperty
	private String supPriceInfoRelId;// 账单供应商

	@JsonProperty
	private String userId;// Agent
	
	@JsonProperty
	private String tourId;// 用于查询	 团id
	
	@JsonProperty
	private BigDecimal UsaSum; //美国费用	用于查询
	
	@JsonProperty
	private BigDecimal total; //总费用	用于查询
	
	@JsonProperty
	private String deptId;		//用于查询
}