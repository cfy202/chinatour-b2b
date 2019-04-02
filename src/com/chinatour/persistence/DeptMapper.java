package com.chinatour.persistence;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Dept;

/**
 * Dao - 部门
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午14:07:24
 * @revision  3.0
 */

@Repository
public interface DeptMapper extends BaseMapper<Dept, String> {
	/**
	 * 对账部门信息
	 * */
	List<Dept> listBillDept(String deptId);

	Dept findCountryNameById(String deptId);
	Dept findCountryNameByIdForLogin(String deptId);

	List<Dept> findCurrencyTypeAll();
	List<Dept> findDeptByRegionId(String id);
}