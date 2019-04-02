package com.chinatour.persistence;

import java.util.List;

import com.chinatour.entity.AdminRegion;

import org.springframework.stereotype.Repository;

/**
 *  Dao		用户地区关系
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-11-24 下午5:29:49
 * @revision  3.0
 */
@Repository
public interface AdminRegionMapper extends BaseMapper<AdminRegion, String> {

	void batchSave(List<AdminRegion> adminRegionList);
	AdminRegion findByAdminId(String adminId);

}
