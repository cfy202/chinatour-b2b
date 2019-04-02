package com.chinatour.entity;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.persistence.BaseMapper;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 
 * @author Andy
 *
 * @date
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Region extends  BaseUuidEntity {
	

	public Region(){
		super();
	}
	
	public Region(String id, String regionName){
		super();
		this.setId(id);
		this.regionName=regionName;
	}
	@JsonProperty
	private String regionName;//区域名字
	
	@JsonProperty
	private List<RegionDeptRel> regionDeptRel;//区域与部门中间表
	
	@JsonProperty
	private List<String> regionDeptRelId;//区域与部门中间表id
	
	@JsonProperty
	private List<String> deptId; // 部门
	
	@JsonProperty
	private List<Dept> dept; // 部门
	
	

}
