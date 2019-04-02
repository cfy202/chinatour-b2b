package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by XuXuebin on 2014/8/12.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Tag extends BaseEntity {

    /**
     * 类型
     */
    public enum Type {

        /**
         * 文章标签
         */
        article,

        /**
         * 商品标签
         */
        product
    }

    ;

    /**
     * 名称
     */
    private String name;

    /**
     * 类型
     */
    private Type type;

    /**
     * 图标
     */
    private String icon;

    /**
     * 备注
     */
    private String memo;

    /**
     * 文章
     */
    private Set<Article> articles = new HashSet<Article>();

}
