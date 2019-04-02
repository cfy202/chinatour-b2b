package com.chinatour.service;


import java.util.List;

import com.chinatour.entity.Dept;
import com.chinatour.entity.RegionDeptRel;

/**
 * Service - 部门
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午14:07:24
 * @revision  3.0
 */

public interface DeptService extends BaseService<Dept, String> {
	/**
	 * 对账部门信息
	 * */
	List<Dept> listBillDept(String deptId);
	/**
	 * dept查找区域
	 * */
	List<RegionDeptRel> findRegionByDeptId(String id);
	
	List<Dept> findCurrencyTypeAll();
	
	List<RegionDeptRel> findByRegionId(String regionId);
	/**
	 * 根据region
	 * */
	List<Dept> findDeptByRegionId(String id);

}