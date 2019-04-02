package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 用户小组关系
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-16 上午11:23:32
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AdminGroup implements Serializable {
    /**
     * 用户编号
     */
    private String adminId;

    /**
     * 小组编号
     */
    private String groupId;
    /**
     * 用户
     */
    private Admin admin;
}
