/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour;

import java.util.Date;

/**
 * 文件信息
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class FileInfo {

    /**
     * 文件地址
     */
    public enum FileType {

        /**
         * 询价文件
         */
    	enquiryPath,

        /**
         * 贡献空间
         */
        sharePath,

        /**
         * 站内信
         */
        appendixPath,

        /**
         * 团报价
         */
        tourQuotePath,
        
        /**
         * 客人信息excle
         */
        customerForExcle,
        /**
         * Product   Images
         * */
        productImagePath,
        /**
         * 同行用户的LOGO地址
         * */
        peerUserLogoPath,
        /**
         * News
         * */
        imagePath
    }

    /**
     * 排序类型
     */
    public enum OrderType {

        /**
         * 名称
         */
        name,

        /**
         * 大小
         */
        size,

        /**
         * 类型
         */
        type
    }

    /**
     * 名称
     */
    private String name;

    /**
     * URL
     */
    private String url;

    /**
     * 是否为目录
     */
    private Boolean isDirectory;

    /**
     * 大小
     */
    private Long size;

    /**
     * 最后修改日期
     */
    private Date lastModified;

    /**
     * 获取名称
     *
     * @return 名称
     */
    public String getName() {
        return name;
    }

    /**
     * 设置名称
     *
     * @param name 名称
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取URL
     *
     * @return URL
     */
    public String getUrl() {
        return url;
    }

    /**
     * 设置URL
     *
     * @param url URL
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * 获取是否为目录
     *
     * @return 是否为目录
     */
    public Boolean getIsDirectory() {
        return isDirectory;
    }

    /**
     * 设置是否为目录
     *
     * @param isDirectory 是否为目录
     */
    public void setIsDirectory(Boolean isDirectory) {
        this.isDirectory = isDirectory;
    }

    /**
     * 获取大小
     *
     * @return 大小
     */
    public Long getSize() {
        return size;
    }

    /**
     * 设置大小
     *
     * @param size 大小
     */
    public void setSize(Long size) {
        this.size = size;
    }

    /**
     * 获取最后修改日期
     *
     * @return 最后修改日期
     */
    public Date getLastModified() {
        return lastModified;
    }

    /**
     * 设置最后修改日期
     *
     * @param lastModified 最后修改日期
     */
    public void setLastModified(Date lastModified) {
        this.lastModified = lastModified;
    }

}