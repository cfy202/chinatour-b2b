/**
 * 
 */
package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-8-28 下午12:47:24	
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Dept extends BaseUuidEntity {

	/**
	 *  
	 */
	private static final long serialVersionUID = -6440198512652534319L;

	@JsonProperty	
	private String deptId;		//部门Id
	
	@JsonProperty
	private String deptName;	//部门名称
	
	@JsonProperty
	private String tel;			//电话	
	
	@JsonProperty
	private String mobile;		//手机
	
	@JsonProperty
	private String email;		//邮箱
	
	@JsonProperty
	private String address;		//地址
	
	@JsonProperty
	private String fax;			//传真
	
	@JsonProperty
	private String currencyTypeId;//部门本位币种：美元、加币、人民币等	
	
	@JsonProperty
	private String zipCode;		//邮编
	
	@JsonProperty
	private String countryId;	//国家
	
	@JsonProperty
	private String cityId;		//城市
	
	@JsonProperty
	private String explains;     //公司简述
	
	@JsonProperty
	private Integer isDel;		//是否可用   0、可用      1、不可用
	
	@JsonProperty
	private String account;		//部门账户
	
	@JsonProperty
	private String symbol;//货币币种代表符   (用于查询)
	
	@JsonProperty
	private String deptForInvoiceAndCredit;//   (用于查询队长功能时的未审核记录)
}
