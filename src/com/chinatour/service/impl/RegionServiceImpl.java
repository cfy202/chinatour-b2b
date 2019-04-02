package com.chinatour.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.Region;
import com.chinatour.entity.RegionDeptRel;
import com.chinatour.persistence.RegionDeptRelMapper;
import com.chinatour.persistence.RegionMapper;
import com.chinatour.service.RegionService;
import com.chinatour.util.UUIDGenerator;

@Service("regionServiceImpl")
public class RegionServiceImpl extends BaseServiceImpl<Region, String> implements RegionService {

	@Autowired
	private RegionMapper regionMapper;
	
	@Autowired
	private RegionDeptRelMapper regionDeptRelMapper;
	
	/**
	 * RegionMapper注入
	 * @param RegionMapper
	 */
	@Autowired
	public void setRegionMapper(RegionMapper regionMapper){
		super.setBaseMapper(regionMapper);
	}

	@Override
	public Region findRegionForDept(String id) {
		return regionMapper.findDeptByRegionId(id);
	}

	@Override
	@SuppressWarnings("unchecked")
	@Transactional
	public void saveRegionWithDept(Region region) {
		Region regionWithoutDept = new Region();
		regionWithoutDept.setId(region.getId());
		regionWithoutDept.setRegionName(region.getRegionName());
		regionMapper.save(regionWithoutDept);
		List<String> deptIds = region.getDeptId();
		List<RegionDeptRel> regionDeptRels = new ArrayList<RegionDeptRel>();
		for(int i=0;i<deptIds.size();i++){
			RegionDeptRel regionDeptRel = new RegionDeptRel();
			regionDeptRel.setId(UUIDGenerator.getUUID());
			regionDeptRel.setRegionId(regionWithoutDept.getId());
			regionDeptRel.setDeptId(deptIds.get(i));
			regionDeptRels.add(regionDeptRel);
		}
		regionDeptRelMapper.addTrainRecordBatch(regionDeptRels);
	}

	@Override
	@SuppressWarnings("unchecked")
	@Transactional
	public void updateRegionWithDept(Region region) {
		Region regionWithoutDept = new Region();
		regionWithoutDept.setId(region.getId());
		regionWithoutDept.setRegionName(region.getRegionName());
		regionMapper.update(regionWithoutDept);
		List<RegionDeptRel> oldRegionDeptRels = regionDeptRelMapper.findByRegionId(region.getId());
		String[] oldRegionDeptRelId = new String[oldRegionDeptRels.size()];
		for(int i=0;i<oldRegionDeptRels.size();i++){
			oldRegionDeptRelId[i] = oldRegionDeptRels.get(i).getId();
		}
		//批量删除
		regionDeptRelMapper.removeByIds(oldRegionDeptRelId);
		List<String> deptIds = region.getDeptId();
		List<RegionDeptRel> regionDeptRels = new ArrayList<RegionDeptRel>();
		for(String deptId:deptIds){
			RegionDeptRel regionDeptRel = new RegionDeptRel();
			regionDeptRel.setId(UUIDGenerator.getUUID());
			regionDeptRel.setDeptId(deptId);
			regionDeptRel.setRegionId(region.getId());
			regionDeptRels.add(regionDeptRel);
		}
		//批量插入
		regionDeptRelMapper.addTrainRecordBatch(regionDeptRels);
	}
	
	
	@Override
	@SuppressWarnings("unchecked")
	@Transactional
	public void deleteRegionWithDept(String  id) {
		Region region = regionMapper.findById(id);
		List<RegionDeptRel> oldRegionDeptRels = regionDeptRelMapper.findByRegionId(region.getId());
		List<String> oldRegionDeptRelIds = new ArrayList<String>();
		for(RegionDeptRel regionDeptRel:oldRegionDeptRels){
			oldRegionDeptRelIds.add(regionDeptRel.getId());
		}
		String[] oldRegionDeptRelId = new String[oldRegionDeptRelIds.size()];
		for(int i=0;i<oldRegionDeptRelIds.size();i++){
			oldRegionDeptRelId[i] = oldRegionDeptRelIds.get(i);
		}
		regionDeptRelMapper.removeByIds(oldRegionDeptRelId);
		regionMapper.removeById(id);
	}

}
