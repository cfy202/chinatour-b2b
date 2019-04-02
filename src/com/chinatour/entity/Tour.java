package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class Tour extends BaseUuidEntity {

	@JsonProperty
	private String tourId; // 团ID

	@JsonProperty
	private String userId; //

	@JsonProperty
	private String deptId; //

	@JsonProperty
	private String type; // 团队类型：独立团，国内特价团 ，非业务团队等  6(机票模拟组团时)

	@JsonProperty
	private String tourCode; // 团号

	@JsonProperty
	private Integer state; // 状态：组团、取消、结算等   3-欧洲团结算

	@JsonProperty
	private String enterpriseName; //

	@JsonProperty
	private String lineName; // 线路名称

	@JsonProperty
	private String lineCode; // 线路编号

	@JsonProperty
	private Integer totalPeople; // 团的总人数

	@JsonProperty
	private String tourQuoteUrl; // 团报价文件 默认 0 未上传文件

	@JsonProperty
	private Integer newState; // 订单修改通知状态  0：不通知    1.通知  2：OP已查看

	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDateTime; // 抵达时间

	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date statisticalArriveTime; // 统计时间

	@JsonProperty
	private Integer isDel; // 是否删除

	@JsonProperty
	private Integer totalNumState; // 紧急加入状态：加入、不加人

	@JsonProperty
	private Integer tourType; // 团订单类型 	1.op组 （团）	2.自组（非团） 
	
	@JsonProperty
	private String groupId; // 1.用于查询 小组下单  2.用于OP group录账单

	@JsonProperty
	private SupplierPrice supplierPrice;// 用于查询  团订单实体
	
	@JsonProperty
	private String userName; // 用户名
	
	@JsonProperty
	private BigDecimal sumFee; // 用于查询   总费用

	@JsonProperty
    private Integer allCheck;  //用于查询		该团（oP）对应本部门所有审核状态   0未审核 ，1全部通过，2至少有一个未通过
	
	@JsonProperty
	private Integer accCheck;// 财务审核状态  该团（oP）对应本部门会计审核状态   0未审核 ，1通过，2未通过,3修改审核
	
	@JsonProperty
	private String code; // 用于查询   团队类型 编号
	
	@JsonProperty
	private Integer completeState;//用于查询  账单完成状态	默认0未完成	1完成
	
	@JsonProperty
	private String typeName; //团队类型名称	 (用于查询 )
	
	@JsonProperty
	private Date beginningDate; //时间查询时传输数据(非储存字段)
	
	@JsonProperty
	private Date endingDate; //时间查询时传输数据(非储存字段)
	
	@JsonProperty
	private Integer isChanged; //op是否修改确认单信息0：未修改；1：已修改
	
	@JsonProperty
	private String sourceName; //团队类型名称	 (用于查询 )
	
	@JsonProperty
	private String tourTypeName; //团队类型 inbound	 (用于查询 )
	
	@JsonProperty
	private String deptName; //部门名（用于查询）
	
	@JsonProperty
	private String supplierPriceId; //账单id（用于查询）
	
	@JsonProperty
	private Integer isDeparture; //是否保证发团 
	
	@JsonProperty
	private String finalRemarks; //添加导游、第一晚酒店信息
	
	@JsonProperty
	private String otherRemarks; //其他信息
	
}
