package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.AdminGroup;
import com.chinatour.persistence.AdminGroupMapper;
import com.chinatour.service.AdminGroupService;

/**
 * Service - 用户小组关系
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-16 下午12:01:18
 * @revision 3.0
 */
@Service("adminGroupServiceImpl")
public class AdminGroupServiceImpl extends BaseServiceImpl<AdminGroup, String>
		implements AdminGroupService {
	@Autowired
	private AdminGroupMapper adminGroupMapper;

	@Autowired
	public void setBaseMapper(AdminGroupMapper adminGroupMapper) {
		super.setBaseMapper(adminGroupMapper);
	}
}
