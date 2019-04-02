/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour;

import com.chinatour.util.SpringUtils;

/**
 * 消息
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class Message {

    /**
     * 类型
     */
    public enum Type {

        /**
         * 成功
         */
        success,

        /**
         * 警告
         */
        warning,

        /**
         * 错误
         */
        danger
    }

    private String title = "操作信息";
    /**
     * 类型
     */
    private Type type;

    /**
     * 内容
     */
    private String content;

    /**
     * 初始化一个新创建的 Message 对象，使其表示一个空消息。
     */
    public Message() {

    }

    /**
     * 初始化一个新创建的 Message 对象
     *
     * @param type    类型
     * @param content 内容
     */
    public Message(Type type, String content) {
        this.type = type;
        this.content = content;
    }

    /**
     * 初始化一个新创建的 Message 对象
     *
     * @param title   标题
     * @param type    类型
     * @param content 内容
     */
    public Message(String title, Type type, String content) {
        this.title = title;
        this.type = type;
        this.content = content;
    }

    /**
     * @param type    类型
     * @param content 内容
     * @param args    参数
     */
    public Message(Type type, String content, Object... args) {
        this.type = type;
        this.content = SpringUtils.getMessage(content, args);
    }

    /**
     * @param title   标题
     * @param type    类型
     * @param content 内容
     * @param args    参数
     */
    public Message(String title, Type type, String content, Object... args) {
        this.title = title;
        this.type = type;
        this.content = SpringUtils.getMessage(content, args);
    }

    /**
     * 返回成功消息
     *
     * @param content 内容
     * @param args    参数
     * @return 成功消息
     */
    public static Message success(String content, Object... args) {
        return new Message(Type.success, content, args);
    }

    /**
     * 返回成功消息
     *
     * @param title   标题
     * @param content 内容
     * @param args    参数
     * @return 成功消息
     */
    public static Message success(String title, String content, Object... args) {
        return new Message(title, Type.success, content, args);
    }

    /**
     * 返回警告消息
     *
     * @param content 内容
     * @param args    参数
     * @return 警告消息
     */
    public static Message warn(String content, Object... args) {
        return new Message(Type.warning, content, args);
    }

    /**
     * 返回警告消息
     *
     * @param title   标题
     * @param content 内容
     * @param args    参数
     * @return 警告消息
     */
    public static Message warn(String title, String content, Object... args) {
        return new Message(title, Type.warning, content, args);
    }

    /**
     * 返回错误消息
     *
     * @param content 内容
     * @param args    参数
     * @return 错误消息
     */
    public static Message error(String content, Object... args) {
        return new Message(Type.danger, content, args);
    }

    /**
     * 返回错误消息
     *
     * @param title   标题
     * @param content 内容
     * @param args    参数
     * @return 错误消息
     */
    public static Message error(String title, String content, Object... args) {
        return new Message(title, Type.danger, content, args);
    }

    /**
     * 获取标题
     *
     * @return 标题
     */
    public String getTitle() {
        return title;
    }

    /**
     * 设置标题
     *
     * @param title 标题
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * 获取类型
     *
     * @return 类型
     */
    public Type getType() {
        return type;
    }

    /**
     * 设置类型
     *
     * @param type 类型
     */
    public void setType(Type type) {
        this.type = type;
    }

    /**
     * 获取内容
     *
     * @return 内容
     */
    public String getContent() {
        return content;
    }

    /**
     * 设置内容
     *
     * @param content 内容
     */
    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return SpringUtils.getMessage(content);
    }

}