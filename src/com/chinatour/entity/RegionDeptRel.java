package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 
 * @author Andy
 *
 * @date
 */
@Data
@EqualsAndHashCode
public class RegionDeptRel extends BaseUuidEntity{
	
	public RegionDeptRel(){}
	
	public RegionDeptRel(String id, String regionId, String deptId){
		super();
		this.setId(id);
		this.regionId = regionId;
		this.deptId = deptId;
	}
	@JsonProperty
	private String regionId; //区域ID
	
	@JsonProperty
	private String deptId; //部门ID
	
	@JsonProperty
	private Dept dept; //部门
	
	@JsonProperty
	private Region region; //区域
}
