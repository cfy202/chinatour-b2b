package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.ShareSpace;
import com.chinatour.entity.ShareType;


/**
 * Service - 共享空间
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

public interface ShareSpaceService extends BaseService<ShareType, String> {
	
	List<ShareSpace> find(ShareSpace shareSpace);

	void save(ShareSpace shareSpace);

	ShareSpace findById(String id, String temp);
	
}