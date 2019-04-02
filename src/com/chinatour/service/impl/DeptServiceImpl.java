package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.Dept;
import com.chinatour.entity.RegionDeptRel;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.RegionDeptRelMapper;
import com.chinatour.service.DeptService;

/**
 * Service - 部门
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午14:07:24
 * @revision  3.0
 */

@Service("deptServiceImpl")
public class DeptServiceImpl extends BaseServiceImpl<Dept, String> implements DeptService {

	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private RegionDeptRelMapper regionDeptRelMapper;

	@Autowired
	public void setBaseMapper(DeptMapper deptMapper) {
	    	super.setBaseMapper(deptMapper);
	}
	
	
	@Transactional(readOnly = true)
	public List<Dept> findAll() {
		return deptMapper.findAll();
	}
	
	
	
	@Override
	@Transactional
	public void delete(String id) {
		super.delete(id);
	}

	@Override
	@Transactional(readOnly = true)
	public Dept findById(String id) {
		return super.findById(id);
	}
	
	@Override
	@Transactional
	public int update(Dept entity) {
		return super.update(entity);
	}

    @Override
    @Transactional
    public void save(Dept entity) {
    	super.save(entity);
    }


	@Override
	public List<Dept> listBillDept(String deptId) {
		return null;
	}

	/**
	 * deptId查找区域
	 * */
	@Override
	public List<RegionDeptRel> findRegionByDeptId(String id) {
		return regionDeptRelMapper.findByDeptId(id);
	}


	@Override
	public List<Dept> findCurrencyTypeAll() {
		return deptMapper.findCurrencyTypeAll();
	}


	@Override
	public List<RegionDeptRel> findByRegionId(String regionId) {
		return regionDeptRelMapper.findByRegionId(regionId);
	}


	@Override
	public List<Dept> findDeptByRegionId(String id) {
		return deptMapper.findDeptByRegionId(id);
	}

	
	
}