package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 账单变更单表
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午9:50:48
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SupplierPriceRemark extends BaseUuidEntity {

	@JsonProperty
	private String supplierPriceRemarkId;// id

	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date eidtTime;// 修改时间

	@JsonProperty
	private String supplierName;// 地接、酒店名称

	@JsonProperty
	private String tourCode;// 团编号

	@JsonProperty
	private BigDecimal preSum;// 原金额

	@JsonProperty
	private BigDecimal nextSum;// 变更后金额

	@JsonProperty
	private BigDecimal differenceSum;// 增减差额

	@JsonProperty
	private String reason;// 变更原因

	@JsonProperty
	private String tourId;// 团id

	@JsonProperty
	private Integer type;// 类型：1 收入、2 支出

	@JsonProperty
	private Integer supfrType;// 类型：1 地接、2 酒店、3 机票、4保险等

	@JsonProperty
	private Integer isDel;// 是否删除 默认0 否

	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date insertTime;// 插入时间

	@JsonProperty
	private Integer sprCheck;// 审核状态:0 未审核 1 全部审核通过	 2  Agent审核未通过	3	会计审核通过 	4 会计审核未通过 5	已结算
	
	@JsonProperty
	private Date accCheckTime;// 审核时间

	@JsonProperty
	private String supplierCheckId;// 变更相关Agent表

	@JsonProperty
	private String supId;// 供应商

	@JsonProperty
	private Integer invoiceState;// 发送部门对账Invoice状态       0:未发    1：已发
	
	@JsonProperty
	private String orderId;// 订单id
	
	@JsonProperty
	private String rateOfCurrencyId;// 汇率   		用于查询
	
	@JsonProperty
	private String userName;// 用户名			用于查询
	
	@JsonProperty
	private String DeptName;// 部门		用于查询
	
	@JsonProperty
	private String userId;// 用户id			用于查询
	
	@JsonProperty
	private BigDecimal usaDifferenceSum;// 增减差额
}