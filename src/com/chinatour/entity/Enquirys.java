package com.chinatour.entity;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Entity 询价
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-9-28 下午3:18:38
 * @revision 3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Enquirys extends BaseUuidEntity {

	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String enquiryId;//询价id

	@JsonProperty
	private String enquiryNo;//询价编号
	
	@JsonProperty
	private Date CreateDate;//创建时间

	@JsonProperty
	private String firstName;//名字

	@JsonProperty
	private String lastName;//名字

	@JsonProperty
	private String contactPhone;//联系人手机

	@JsonProperty
	private String email;//邮箱
	
	@JsonProperty
	private String teamPopulation;//总人数

	@JsonProperty
	private Integer amountOfAdult;//大人人数

	@JsonProperty
	private Integer amountBelow12;//12岁以下人数

	@JsonProperty
	private Integer amountBelow21;//21岁以下，无购物能力人数

	@JsonProperty
	private Date arriveDate;//到达时间

	@JsonProperty
	private String shoppingOption;//是否购物  	1是  	2否

	@JsonProperty
	private String specialRequirment;//特殊要求

	@JsonProperty
	private String commentOfTour;//团队注意事项及备注

	@JsonProperty
	private String privateTravelDetails;//自助线路行程描述

	@JsonProperty
	private String hotelStandard;//酒店标准

	@JsonProperty
	private String remarks;//备注信息

	@JsonProperty
	private String userId;//用户id

	@JsonProperty
	private String deptId;//部门id

	@JsonProperty
	private String humanRaceId;//人种

	@JsonProperty
	private String languageId;//语种id

	@JsonProperty
	private String stateId;//州id

	@JsonProperty
	private String countryId;//国家id

	@JsonProperty
	private String enquiryDocs;//op上传报价文件

	@JsonProperty
	private Integer enState;//是否上传文件   0 否；1是

	@JsonProperty
	private Integer type;//保存草稿 	0 完成；1草稿

	@JsonProperty
	private Integer isAvailable;//是否有效
	
	@JsonProperty
	private String serverIp;//国家id
	
	@JsonProperty
	private Admin admin;//用户
	
	@JsonProperty
	private Dept dept;//部门
	
	@JsonProperty
	private String brand;//产品
	
	@JsonProperty
	private String tourTypeId;//类型
}
