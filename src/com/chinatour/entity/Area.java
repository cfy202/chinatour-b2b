package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Area extends OrderEntity {
    /**
     * 树路径分隔符
     */
    private static final String TREE_PATH_SEPARATOR = ",";

    /**
     * 名称
     */
    private String name;

    /**
     * 全称
     */
    private String fullName;

    /**
     * 树路径
     */
    private String treePath;

    /**
     * 上级地区
     */
    private Area parent;

    /**
     * 下级地区
     */
    private Set<Area> children = new HashSet<Area>();

    /**
     * 会员
     */
    private Set<Member> members = new HashSet<Member>();

}
