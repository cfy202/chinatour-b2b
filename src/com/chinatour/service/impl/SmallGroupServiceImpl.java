package com.chinatour.service.impl;

import java.util.List;

import com.chinatour.entity.SmallGroup;
import com.chinatour.persistence.SmallGroupMapper;
import com.chinatour.service.SmallGroupService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



/**
 * Service  小组
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-16 上午11:57:54
 * @revision  3.0
 */
@Service("smallGroupServiceImpl")
public class SmallGroupServiceImpl extends BaseServiceImpl<SmallGroup, String> implements SmallGroupService {

    @Autowired
    private SmallGroupMapper groupMapper;

    @Autowired
    public void setBaseMapper(SmallGroupMapper groupMapper) {
        super.setBaseMapper(groupMapper);
    }

	@Override
	public List<SmallGroup> findByDeptId(String deptId) {
		return groupMapper.findByDeptId(deptId);
	}
}