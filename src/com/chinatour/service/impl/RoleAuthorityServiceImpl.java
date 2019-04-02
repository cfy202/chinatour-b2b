package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.RoleAuthority;
import com.chinatour.persistence.RoleAuthorityMapper;
import com.chinatour.service.RoleAuthorityService;

/**
 * Service - 权限
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-30 下午5:10:13
 * @revision  3.0
 */
@Service("roleAuthorityServiceImpl")
public class RoleAuthorityServiceImpl extends BaseServiceImpl<RoleAuthority, String>
		implements RoleAuthorityService {

	@Autowired
	private RoleAuthorityMapper roleAuthorityMapper;

	@Autowired
	public void setBaseMapper(RoleAuthorityMapper roleAuthorityMapper) {
		super.setBaseMapper(roleAuthorityMapper);
	}
}
