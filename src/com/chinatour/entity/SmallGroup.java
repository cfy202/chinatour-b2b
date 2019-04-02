package com.chinatour.entity;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 小组
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-16 上午11:14:02
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SmallGroup extends BaseUuidEntity {

	private static final long serialVersionUID = 7065110973203482161L;

	@JsonProperty
	private String groupId; // Id

	@JsonProperty
	private String name; // 名称

	@JsonProperty
	private String remark; // 备注
	
	@JsonProperty
	private String deptId; // 部门id

	@JsonProperty
	private String deptName; // 部门名称
	
	@JsonProperty
	private List<AdminGroup> adminGroup; // 用户小组关系
}
