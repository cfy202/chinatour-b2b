package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * Created by XuXuebin on 2014-08-29.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Module extends BaseUuidEntity {

    private String name;

    private String url;

    private String description;

    private String sn;

    private Icons icons;

    private Integer priority = 99;

    private String parent_id;

    private Module parent;

    private List<Module> children;

    private List<RoleButton> roleButtonList;
}
