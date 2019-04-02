package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 团账单表
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午9:44:27
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SupplierPrice extends BaseUuidEntity {

	@JsonProperty
	private String supplierPriceId;// id

	@JsonProperty
	private String tourId;// 团id

	@JsonProperty
	private String tourCode;// 团编号

	@JsonProperty
	private String remark;// 备注

	@JsonProperty
	private String checkRemark;// 审核备注

	@JsonProperty
	private String checkUserId;// 审核人

	@JsonProperty
	private Integer accCheck;// 财务审核状态  该团（oP）对应本部门会计审核状态   0未审核 ，1通过，2未通过,3修改审核

	@JsonProperty
	private Date createTime;// 创建时间

	@JsonProperty
	private String accompany;// 全陪人员姓名

	@JsonProperty
	private String tourDept;// 组团部门

	@JsonProperty
	private Integer dayNum;// 天数

	@JsonProperty
	private String nationality;// 国籍

	@JsonProperty
	private Integer allCheck;// 全部审核状态  0未审核 ，1全部通过，2至少有一个未通过

	@JsonProperty
	private Integer completeState;// 账单完成状态	默认0未完成	1完成

	@JsonProperty
	private String subRemark;// 小结单备注

	@JsonProperty
	private Integer totalPeople;// 人数

	@JsonProperty
	private Date checkTime;// 审核时间

	@JsonProperty
	private Integer invoiceState;// 发送部门对账Invoice状态  0 未发 1已发
	
	@JsonProperty
	private String supType;// 供应商类型  地接、保险、酒店、机票等
	
	@JsonProperty
	private String fileUrl;// 上传文件  地接、保险、酒店、机票等
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDateTime; // 抵达时间 		用于查询
	
	@JsonProperty
	private String deptId;// 小结单备注
	
	@JsonProperty
	private BigDecimal supplierCost;// 应付地接费用	用于查询
	
	@JsonProperty
	private BigDecimal supplierPrice;// 应收费用		用于查询
	
	@JsonProperty
	private BigDecimal supplierDifCost;//变更单 应收地接费用		用于查询
	
	@JsonProperty
	private BigDecimal supplierDifPrice;//变更单  应收费用		用于查询
	
	@JsonProperty
	private String userId;//用户id	用于查询
	
	@JsonProperty
	private String deptName;//部门	用于查询
	
	@JsonProperty
	private String supplierName;//用户id	用于查询
	
	@JsonProperty
	private String userName;//用户名	用于查询
	
	@JsonProperty
	private String sprCheck;//审核状态	变更单   会计审核  0未审核  1所有审核通过 2Agent审核未通过  3.会计审核通过  4.会计审核未通过   5变更单已结算	用于查询
	
	@JsonProperty
	private String tax;//结算状态	用于查询
	
	@JsonProperty
	private String lineName;//线路名	用于查询
	
	@JsonProperty
	private String contactor;//会计审核状态  	用于查询
	
	@JsonProperty
	private String userIdOfAgent;// 审核Agent		用于查询
	
	@JsonProperty
	private String checkOfAgent;// Agent审核状态	用于查询
	
	@JsonProperty
	private String type;// 团队类型	用于查询
	
	@JsonProperty
	private String typeName;// 团队名称	用于查询
	
	@JsonProperty
	private BigDecimal supplierUSAPrice;  //用于查询（转化为美元后的值）DeptId
	
	@JsonProperty
	private String toDeptId;   //用于查询（转化为美元后的值）DeptId
	
	@JsonProperty
	private String groupId;// 分组id	用于查询
	
	@JsonProperty
	private List<SupplierPrice> SupplierPriceList;//	用于查询
	
}