package com.chinatour.service;

/**
 * Created by XuXuebin on 2014/7/9.
 */

import com.chinatour.entity.Admin;

import java.util.List;

/**
 * Service - 管理员
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public interface AdminService extends BaseService<Admin, String> {

    /**
     * 判断用户名是否存在
     *
     * @param username 用户名(忽略大小写)
     * @return 用户名是否存在
     */
    boolean usernameExists(String username);

    /**
     * 根据用户名查找管理员
     *
     * @param username 用户名(忽略大小写)
     * @return 管理员，若不存在则返回null
     */
    Admin findByUsername(String username);

    /**
     * 根据ID查找权限
     *
     * @param id ID
     * @return 权限, 若不存在则返回null
     */
    List<String> findAuthorities(String id);

    /**
     * 判断管理员是否登录
     *
     * @return 管理员是否登录
     */
    boolean isAuthenticated();

    /**
     * 获取当前登录管理员
     *
     * @return 当前登录管理员, 若不存在则返回null
     */
    Admin getCurrent();

    /**
     * 获取当前登录用户名
     *
     * @return 当前登录用户名, 若不存在则返回null
     */
    String getCurrentUsername();

    /**
     * 获取用户信息
     *
     * @param id
     * @return
     */
    Admin findByIdAndRole(String id);
    
    /**
     * 获取用户集合
     *
     * @param id
     * @return
     */
    List<Admin> find(Admin admin);

	List<Admin> findAllOfDeptName();
}