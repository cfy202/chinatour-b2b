package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Role extends BaseUuidEntity {
    /**
     * 名称
     */
	@JsonProperty
    private String name;

    /**
     *权限是否可用
     *权限可用为0 不可用为1
     */
	@JsonProperty
    private Boolean isSystem;

    /**
     * 描述
     */
	@JsonProperty
    private String description;

    /**
     * 权限
     */
    private List<String> authorities = new ArrayList<String>();

    /**
     * 管理员
     */
    private Set<Admin> admins = new HashSet<Admin>();
}
