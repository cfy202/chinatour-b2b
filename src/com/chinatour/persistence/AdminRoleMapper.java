package com.chinatour.persistence;

import java.util.List;

import com.chinatour.entity.AdminRole;
import org.springframework.stereotype.Repository;

/**
 * Created by XuXuebin on 2014-08-30.
 */
@Repository
public interface AdminRoleMapper extends BaseMapper<AdminRole, String> {

	void batchSave(List<AdminRole> adminRoleList);

}
