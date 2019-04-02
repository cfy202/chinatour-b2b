package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

@Data
@EqualsAndHashCode(callSuper = false)
public class Resource extends BaseEntity{
	
	
	/**
     * 权限名称
     */
    @JsonProperty
    private String name;

    /**
     * 权限方法
     */
    private String action;
    
    /**
     * 类别：1 一级、2 二级目录
     */
    @JsonProperty
    private int type;

    /**
     * 权限描述
     */
    @JsonProperty
    private String description;

    /**
     * 英文名称
     */
    @JsonProperty
    private String enName;

    /**
     * 状态
     */
    @JsonProperty
    private int State;
    
    /**
	 * 父级目录，针对二级目录
	 */
	private String parentId;

    /**
     * 目录顺序位置
     */
    private int Pos;

}
