package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Admin extends BaseUuidEntity {

	/**
	 * 用户名
	 */
	@JsonProperty
	private String username;

	/**
	 * 密码
	 */
	private String password;

	/**
	 * E-mail
	 */
	@JsonProperty
	private String email;

	/**
	 * 姓名
	 */
	@JsonProperty
	private String name;

	/**
	 * 部门
	 */
	@JsonProperty
	private String deptId;

	/**
	 * 是否启用
	 */
	@JsonProperty
	private Boolean isEnabled;

	/**
	 * 角色
	 */
	@JsonProperty
	private Set<AdminRole> adminRoles = new HashSet<AdminRole>();

	/**
	 * 小组 id 用于查询
	 */
	@JsonProperty
	private String groupId;
	
	/**
	 * 地区
	 */
	@JsonProperty
	private List<AdminRegion> adminRegions = new ArrayList<AdminRegion>();
	
	/**
	 * 确认密码
	 */
	private String rePassword;//用于查询     确认密码
	
	@JsonProperty
	private String deptName;	//用户查询部门
	
	@JsonProperty
	private String countryName;	//国家 用于查询
	
	@JsonProperty
	private String Address;
	
	@JsonProperty
	private String Fax;
	
	@JsonProperty
	private String Tel;

}
