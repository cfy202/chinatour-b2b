package com.chinatour.service;

import com.chinatour.entity.Region;
import com.chinatour.entity.RegionDeptRel;

/**
 * 
 * @author Andy
 *
 * @date
 */

public interface RegionService extends BaseService<Region, String>{
	
	/**
	 * 查询包含部门信息的区域
	 * @return
	 */
	public Region findRegionForDept(String id);
	
	/**
	 * 保存包含部门信息的区域
	 * @param region
	 */
	public void saveRegionWithDept(Region region);
	
	
	/**
	 * 更新包含部门信息的区域
	 * @param region
	 */
	public void updateRegionWithDept(Region region);
	
	/**
	 * 删除包含部门信息的区域
	 * @param region
	 */
	public void deleteRegionWithDept(String id);
}
