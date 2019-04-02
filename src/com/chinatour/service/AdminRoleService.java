package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.AdminRole;

/**
 * Created by XuXuebin on 2014-08-30.
 */
public interface AdminRoleService extends BaseService<AdminRole, String> {

	void batchSave(List<AdminRole> adminRoleList);
}
