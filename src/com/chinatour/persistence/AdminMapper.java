package com.chinatour.persistence;

/**
 * Created by XuXuebin on 2014/7/9.
 */

import java.util.List;

import com.chinatour.entity.Admin;
import org.springframework.stereotype.Repository;

/**
 * Dao - 管理员
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Repository
public interface AdminMapper extends BaseMapper<Admin, String> {

    /**
     * 判断用户名是否存在
     *
     * @param username 用户名(忽略大小写)
     * @return 用户名是否存在
     */
    int usernameExists(String username);

    /**
     * 根据用户名查找管理员
     *
     * @param username 用户名(忽略大小写)
     * @return 管理员，若不存在则返回null
     */
    Admin findByUsername(String username);

    /**
     * 查询带角色信息的实体-简化
     *
     * @param id
     * @return
     */
    Admin findByIdForRole(String id);

    /**
     * 查询带角色信息的实体-所有
     *
     * @param id
     * @return
     */
    Admin findByIdAndRole(String id);

	List<Admin> findAllOfDeptName();
}