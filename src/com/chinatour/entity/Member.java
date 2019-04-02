package com.chinatour.entity;

import com.chinatour.interceptor.MemberInterceptor;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Member extends BaseEntity {

    /**
     * 性别
     */
    public enum Gender {

        /**
         * 男
         */
        male,

        /**
         * 女
         */
        female
    }

    /**
     * "身份信息"参数名称
     */
    public static final String PRINCIPAL_ATTRIBUTE_NAME = MemberInterceptor.class.getName() + ".PRINCIPAL";

    /**
     * "用户名"Cookie名称
     */
    public static final String USERNAME_COOKIE_NAME = "username";

    /**
     * 会员注册项值属性个数
     */
    public static final int ATTRIBUTE_VALUE_PROPERTY_COUNT = 10;

    /**
     * 会员注册项值属性名称前缀
     */
    public static final String ATTRIBUTE_VALUE_PROPERTY_NAME_PREFIX = "attributeValue";

    /**
     * 最大收藏商品数
     */
    public static final Integer MAX_FAVORITE_COUNT = 10;

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * E-mail
     */
    private String email;

    /**
     * 积分
     */
    private Long point;

    /**
     * 消费金额
     */
    private BigDecimal amount;

    /**
     * 余额
     */
    private BigDecimal balance;

    /**
     * 是否启用
     */
    private Boolean isEnabled;

    /**
     * 是否锁定
     */
    private Boolean isLocked;

    /**
     * 连续登录失败次数
     */
    private Integer loginFailureCount;

    /**
     * 锁定日期
     */
    private Date lockedDate;

    /**
     * 注册IP
     */
    private String registerIp;

    /**
     * 最后登录IP
     */
    private String loginIp;

    /**
     * 最后登录日期
     */
    private Date loginDate;

    /**
     * 姓名
     */
    private String name;

    /**
     * 性别
     */
    private Gender gender;

    /**
     * 出生日期
     */
    private Date birth;

    /**
     * 地址
     */
    private String address;

    /**
     * 邮编
     */
    private String zipCode;

    /**
     * 电话
     */
    private String phone;

    /**
     * 手机
     */
    private String mobile;

    /**
     * 安全密匙
     */
    private SafeKey safeKey;

    /**
     * 地区
     */
    private Area area;


    /**
     * 接收的消息
     */
    private Set<Message> inMessages = new HashSet<Message>();

    /**
     * 发送的消息
     */
    private Set<Message> outMessages = new HashSet<Message>();
}
