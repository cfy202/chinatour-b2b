package com.chinatour.entity;

import lombok.Data;

import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Discount extends BaseUuidEntity {
    /**
     * 树路径分隔符
     */
    private static final String TREE_PATH_SEPARATOR = ",";

    /**
     * 折扣价
     */
    private BigDecimal discountPrice;

    /**
     * 订单ID
     */
    private String orderId;


}
