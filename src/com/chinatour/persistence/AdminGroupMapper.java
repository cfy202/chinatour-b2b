package com.chinatour.persistence;

import com.chinatour.entity.AdminGroup;
import org.springframework.stereotype.Repository;

/**
 * Dao		用户小组关系
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-16 上午11:26:12
 * @revision  3.0
 */
@Repository
public interface AdminGroupMapper extends BaseMapper<AdminGroup, String> {
    /**
     * 查询小组
     *
     * @param adminId
     * @return
     */
    AdminGroup findByAdminId (String adminId);
}
