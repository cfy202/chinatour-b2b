package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Created by XuXuebin on 2014-08-29.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class RoleButton extends BaseUuidEntity {

    private String name;

    private String buttonSn;

    private Integer orders;

    private String status;

    private Module module;
}
