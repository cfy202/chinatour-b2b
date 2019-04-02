package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.apache.commons.lang3.builder.CompareToBuilder;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public abstract class OrderEntity extends BaseEntity implements Comparable<OrderEntity> {
    /**
     * "排序"属性名称
     */
    public static final String ORDER_PROPERTY_NAME = "order";

    /**
     * 排序
     */
    @JsonProperty
    private Integer order;

    /**
     * 实现compareTo方法
     *
     * @param orderEntity 排序对象
     * @return 比较结果
     */
    public int compareTo(OrderEntity orderEntity) {
        return new CompareToBuilder().append(getOrder(), orderEntity.getOrder()).append(getId(), orderEntity.getId()).toComparison();
    }
}
