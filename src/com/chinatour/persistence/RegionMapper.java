package com.chinatour.persistence;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Region;

/**
 * 
 * @author Andy
 *
 * @date
 */
@Repository
public interface RegionMapper extends BaseMapper<Region, String> {
	
	Region findDeptByRegionId(String id);
}
