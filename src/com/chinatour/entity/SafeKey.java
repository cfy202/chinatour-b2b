package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SafeKey implements Serializable {

    /**
     * 密钥
     */
    private String value;

    /**
     * 到期时间
     */
    private Date expire;
}
