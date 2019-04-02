package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.RegionDeptRel;


@Repository
public interface RegionDeptRelMapper extends BaseMapper<RegionDeptRel, String> {
	List<RegionDeptRel> findByDeptId(String id);
	
	List<RegionDeptRel> findByRegionId(String id);
	
	void addTrainRecordBatch(List<RegionDeptRel> RegionDeptRels);
}
