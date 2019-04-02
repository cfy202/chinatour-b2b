package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Log extends BaseUuidEntity {

    /**
     * "日志内容"属性名称
     */
    public static final String LOG_CONTENT_ATTRIBUTE_NAME = Log.class.getName() + ".CONTENT";

    /**
     * 操作
     */
    private String operation;

    /**
     * 操作员
     */
    private String operator;

    /**
     * 内容
     */
    private String content;

    /**
     * 请求参数
     */
    private String parameter;

    /**
     * IP
     */
    private String ip;
    
    /**
     * 订单id
     */
    private String orderId;
    
    /**
     *订单号 
     */
    private String orderNo;
    
 
}
