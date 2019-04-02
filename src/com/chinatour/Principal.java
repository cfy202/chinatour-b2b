/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour;

import java.io.Serializable;

/**
 * 身份信息
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class Principal implements Serializable {

    private static final long serialVersionUID = 5798882004228239559L;

    /**
     * ID
     */
    private String id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 用户图像
     */
    private String userImage;
    /**
     * 用户类型（同行用户：PeerUser,  后台用户：Admin）
     * */
    private String type;
    
   

	/**
     * @param id       ID
     * @param username 用户名
     */
    public Principal(String id, String username,String userImage,String type) {
        this.id = id;
        this.username = username;
        this.userImage=userImage;
        this.type=type;
    }
    
    /**
     * @param id       ID
     * @param username 用户名
     */
    public Principal(String id, String username) {
        this.id = id;
        this.username = username;
    }


    /**
     * 获取ID
     *
     * @return ID
     */
    public String getId() {
        return id;
    }

    /**
     * 设置ID
     *
     * @param id ID
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * 获取用户名
     *
     * @return 用户名
     */
    public String getUsername() {
        return username;
    }

    /**
     * 设置用户名
     *
     * @param username 用户名
     */
    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return username;
    }

	public String getUserImage() {
		return userImage;
	}

	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}