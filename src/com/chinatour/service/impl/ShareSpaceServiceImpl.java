package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.ShareSpace;
import com.chinatour.entity.ShareType;
import com.chinatour.persistence.ShareSpaceMapper;
import com.chinatour.persistence.ShareTypeMapper;
import com.chinatour.service.ShareSpaceService;


/**
 * Service - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

@Service("shareSpaceServiceImpl")
public class ShareSpaceServiceImpl extends BaseServiceImpl<ShareType, String> implements ShareSpaceService {

	@Autowired
	private ShareTypeMapper shareTypeMapper;
	
	@Autowired
	private ShareSpaceMapper shareSpaceMapper;

	@Autowired
	public void setBaseMapper(ShareTypeMapper shareTypeMapper) {
	    	super.setBaseMapper(shareTypeMapper);
	}
	
	
	@Transactional(readOnly = true)
	public List<ShareType> findAll() {
		return shareTypeMapper.findAll();
	}
	
	@Transactional(readOnly = true)
	public List<ShareSpace> find(ShareSpace shareSpace) {
		return shareSpaceMapper.find(shareSpace);
	}
	
	@Override
	@Transactional
	public void save(ShareSpace shareSpace) {
		 shareSpaceMapper.save(shareSpace);
	}
	
	@Override
	@Transactional(readOnly = true)
	public ShareSpace findById(String id,String temp) {
		return shareSpaceMapper.findById(id);
	}
	
	@Override
	@Transactional(readOnly = true)
	public ShareType findById(String id) {
		return super.findById(id);
	}

	@Override
	@Transactional
	public int update(ShareType entity) {
		return super.update(entity);
	}

    @Override
    @Transactional
    public void save(ShareType entity) {
    	super.save(entity);
    }

    @Override
    @Transactional
    public void delete(String id) {
    	super.delete(id);
    }
	
}