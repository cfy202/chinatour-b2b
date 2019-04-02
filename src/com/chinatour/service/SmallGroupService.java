package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.SmallGroup;

/**
 * Service - 小组
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-16 上午11:54:52
 * @revision  3.0
 */
public interface SmallGroupService extends BaseService<SmallGroup, String> {
	List<SmallGroup> findByDeptId(String deptId);
}