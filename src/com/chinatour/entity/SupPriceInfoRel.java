package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 账单供应商表
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:02:05
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SupPriceInfoRel extends BaseUuidEntity {

	@JsonProperty
	private String supPriceInfoRelId;// id

	@JsonProperty
	private String tourId;// 团id

	@JsonProperty
	private String supplierName;// 供应商名称

	@JsonProperty
	private BigDecimal supplierPrice;// 应收费用

	@JsonProperty
	private BigDecimal supplierCost;// 应付地接费用

	@JsonProperty
	private Integer supplierState;// 状态：0 新录入、 1不可修改。

	@JsonProperty
	private String remark;// 备注

	@JsonProperty
	private Integer type;// 类型：地接、保险、酒店、机票等

	@JsonProperty
	private String numbering;// 单号

	@JsonProperty
	private Date createTime;// 创建时间

	@JsonProperty
	private String supId;// 供应商：地接社supplier表、酒店hotel表
	
	@JsonProperty
	private List<SupplierOfAgent> supplierOfAgentList;// 用于查询  	团账单agent
	
	@JsonProperty
	private BigDecimal sum;// 总费用		用于查询

	@JsonProperty
	private String userId;// 用户id		用于查询
	
	@JsonProperty
	private String supplierOfOrderId;// Agent团账单供应商订单id		用于查询

	@JsonProperty
	private String orderId;// 订单		用于查询

	@JsonProperty
	private String supplierOfAgentId;// Agent账单供应商		用于查询
	
	@JsonProperty 
	private BigDecimal rateUp; //部门间汇率 分子			用于查询
	
	@JsonProperty
	private BigDecimal rateDown; //部门间汇率 分母		用于查询
}