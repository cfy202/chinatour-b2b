package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.AdminRegion;

/**
 * Service  用户地区关系
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-16 上午11:56:29
 * @revision  3.0
 */
public interface AdminRegionService extends BaseService<AdminRegion, String> {

	void batchSave(List<AdminRegion> adminRegionList);
	//通过用户id查出adminregion
	AdminRegion findByAdminId(String adminId);
}
