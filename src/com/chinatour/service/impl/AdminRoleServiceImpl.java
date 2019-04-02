package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.AdminRole;
import com.chinatour.entity.Language;
import com.chinatour.persistence.AdminRoleMapper;
import com.chinatour.persistence.LanguageMapper;
import com.chinatour.service.AdminRoleService;
import com.chinatour.service.LanguageService;

/**
 * Service - 用户角色
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-9-19 下午1:10:18
 * @revision 3.0
 */
@Service("adminRoleServiceImpl")
public class AdminRoleServiceImpl extends BaseServiceImpl<AdminRole, String>
		implements AdminRoleService {

	@Autowired
	private AdminRoleMapper adminRoleMapper;

	@Autowired
	public void setBaseMapper(AdminRoleMapper adminRoleMapper) {
		super.setBaseMapper(adminRoleMapper);
	}

	@Override
	public void batchSave(List<AdminRole> adminRoleList) {
		adminRoleMapper.batchSave(adminRoleList);
	}
}
