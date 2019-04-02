/**
 * 
 */
package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-29 上午10:02:28
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Supplier extends BaseUuidEntity{

	/**
	 *  
	 */
	private static final long serialVersionUID = -4761443977863370303L;

	@JsonProperty
	private String supplierId;			//地接Id
	
	@JsonProperty
	private String supplierName;		//地接社名称
	
	@JsonProperty
	private String supplierShortName;	//简称
	
	@JsonProperty
	private String tel;					//电话
	
	@JsonProperty
	private String fax;					//传真
	
	@JsonProperty
	private String contactPerson;		//联系人	
	
	@JsonProperty
	private String mobile;				//手机
	
	@JsonProperty
	private String address;				//地址
	
	@JsonProperty
	private String zipCode;				//邮编
	
	@JsonProperty
	private String email;				//邮箱
	
	@JsonProperty
	private String cityId;				//城市Id
	
	@JsonProperty
	private String province;			//省
	
	@JsonProperty
	private String city;				//城市
	
	@JsonProperty
	private Integer isDel;		 			//是否删除 0:未删除; 1:删除; default 0
	/**
	 * 存放部门ID
	 */
	@JsonProperty
	private String deptId;				//城市
}
