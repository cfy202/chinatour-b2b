package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 权限
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-8 下午4:59:36
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RoleAuthority extends BaseUuidEntity {
    /**
     * 角色
     */
	@JsonProperty
    private String role;

    /**
     * 权限
     */
	@JsonProperty
    private String authorities;

}
