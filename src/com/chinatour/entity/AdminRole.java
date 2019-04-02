package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * Created by XuXuebin on 2014-08-30.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AdminRole implements Serializable {
    /**
     * 用户编号
     */
    private String admins;

    /**
     * 权限编号
     */
    private String roles;

    private Admin admin;

    private Role role;
}
