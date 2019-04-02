
package com.chinatour.persistence;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.SmallGroup;

/**
 * Dao - 小组
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-16 上午11:26:51
 * @revision  3.0
 */
@Repository
public interface SmallGroupMapper extends BaseMapper<SmallGroup, String> {
	List<SmallGroup> findByDeptId(String deptId);
}