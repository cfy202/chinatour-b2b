/**
 * 
 */
package com.chinatour.entity;

import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-9-27 下午5:04:31
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TourTypeOfDept {
	
	@JsonProperty
	private String tourTypeOfDeptId;//ID
	
	@JsonProperty
	private String deptId;//部门Id
	
	@JsonProperty
	private String tourTypeId;//团队类型Id
	
	@JsonProperty
	private String code;//团队类型编码
	
	@JsonProperty
	private String deptName;//部门名称
	
	@JsonProperty
	private String tourTypeName;//团队类型名称
	
	@JsonProperty
	private Date startTime;//开始时间
	
	@JsonProperty
	private Date endTime;//结束时间
	
	@JsonProperty
	private Date orderTime;//订单创建时间
	
	@JsonProperty
	private String typeName;//借用字段（用于从tourTypeoddept中取出typename）
	
	@JsonProperty
	private String brand;//借用字段
}
