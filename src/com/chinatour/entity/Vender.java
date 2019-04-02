package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time Sep 15, 2014 11:00:00 AM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Vender extends BaseUuidEntity {
	
	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String venderId;	//Id

	@JsonProperty
	private String code; //编码
	
	@JsonProperty 
	private String name; //名称
	
	@JsonProperty
	private String contactor; //联系人
	
	@JsonProperty
	private String address; //地址
	
	@JsonProperty
	private String zipCode; //邮编
	
	@JsonProperty
	private String tel; //联系电话
	
	@JsonProperty
	private String fax; //传真
	
	@JsonProperty 
	private String email; //邮箱

	@JsonProperty 
	private String billEmail; //邮箱

	@JsonProperty 
	private String b2bEmail; //B2B Confirmation邮箱
	
	@JsonProperty
	private String remarks; //备注
	
	@JsonProperty
	private String countryId; //国家
	
	@JsonProperty
	private String userId; //添加人
	
	@JsonProperty
	private String deptId; //部门
	
	@JsonProperty
	private Integer type; //类型:1-同行；2-供应商   3供应商/同行;
	
	@JsonProperty
	private Integer venderType; //供应商类型：1-Agent添加；2-财务添加
	
	@JsonProperty
	private Integer peerType; //同行类型：1-中文团；2-英文团;3-入境;4-School;5-Business
	
	@JsonProperty
	private Integer isDel; //是否删除  0 ：可用；	1 ：不可用
	
	@JsonProperty
	private Integer status;//是否生效 	0：无效；		1：有效	
	
	/**
	 * 统计使用字段非数据库
	 * */
	@JsonProperty
	private Integer sum;//用于统计    人数存储	(非数据库字段)

	@JsonProperty
	private String time;//用于统计    时间存储	(非数据库字段)
	
	@JsonProperty
	private String year;//用于统计    年份的存储	(非数据库字段)

	@JsonProperty
	private Integer isSelfOrganize; //是否自组  1为自组，0为非自组(非数据库字段)
	
	@JsonProperty
	private Integer orderType; // 订单类型 1.团订单 2.同行团订单 5.非团订单(非数据库字段)
	
	@JsonProperty
	private List<Order> orderList; //订单
	@JsonProperty
	private String groupId;//组Id(非数据库字段)
	@JsonProperty
	private String role;//传递角色(非数据库字段)
	@JsonProperty
	private BigDecimal pay;//(非数据库字段)
	@JsonProperty
	private BigDecimal cost;//(非数据库字段)
	@JsonProperty
	private BigDecimal commonTourFee; // (非数据库字段)
	
	
	@JsonProperty 
	private String registrationNo; //公司编号
	
	@JsonProperty 
	private String businessCode; //公司编码
	
	@JsonProperty 
	private String cityId; //城市id
	
	@JsonProperty 
	private String stateId; //州 id
	
	@JsonProperty 
	private String bankName; //银行名
	
	@JsonProperty 
	private String branchNo; // 分公司
	
	@JsonProperty 
	private String accountName; // 财务名称
	
	@JsonProperty 
	private String accountNumber; //财务帐号
	
	@JsonProperty
	private String countryName; //国家(非数据库字段)
	//非数据库字段，财务系统接口所需字段
	@JsonProperty
	private String firstName;
	@JsonProperty
	private String companyId;
	@JsonProperty
	private String phone;
	@JsonProperty
	private String companyName;
	@JsonProperty
	private String userName; //登录用户
	
}
