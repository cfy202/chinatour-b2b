package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Humanrace;
import com.chinatour.persistence.HumanraceMapper;
import com.chinatour.service.HumanraceService;

/**
 * Service - 种族
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-30 下午5:10:13
 * @revision  3.0
 */
@Service("humanraceServiceImpl")
public class HumanraceServiceImpl extends BaseServiceImpl<Humanrace, String>
		implements HumanraceService {

	@Autowired
	private HumanraceMapper humanraceMapper;

	@Autowired
	public void setBaseMapper(HumanraceMapper humanraceMapper) {
		super.setBaseMapper(humanraceMapper);
	}
}
