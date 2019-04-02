package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.AdminRegion;
import com.chinatour.persistence.AdminRegionMapper;
import com.chinatour.service.AdminRegionService;

/**
 * Service - 用户地区关系
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-16 下午12:01:18
 * @revision 3.0
 */
@Service("adminRegionServiceImpl")
public class AdminRegionServiceImpl extends BaseServiceImpl<AdminRegion, String>
		implements AdminRegionService {
	@Autowired
	private AdminRegionMapper adminRegionMapper;

	@Autowired
	public void setBaseMapper(AdminRegionMapper adminRegionMapper) {
		super.setBaseMapper(adminRegionMapper);
	}

	@Override
	public void batchSave(List<AdminRegion> adminRegionList) {
		adminRegionMapper.batchSave(adminRegionList);
		
	}

	@Override
	public AdminRegion findByAdminId(String adminId) {
		return adminRegionMapper.findByAdminId(adminId);
	}
}
