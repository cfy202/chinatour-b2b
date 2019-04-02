/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import java.util.List;

import com.chinatour.entity.Appendix;
import com.chinatour.persistence.AppendixMapper;
import com.chinatour.service.AppendixService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Service - 地区
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("appendixServiceImpl")
public class AppendixServiceImpl extends BaseServiceImpl<Appendix, String> implements AppendixService {

    @Autowired
    private AppendixMapper appendixMapper;

    @Autowired
    public void setBaseMapper(AppendixMapper appendixMapper) {
        super.setBaseMapper(appendixMapper);
    }

	@Override
	public List<Appendix> findByNoticeId(String NoticeId) {
		// TODO Auto-generated method stub
		return appendixMapper.findByNoticeId(NoticeId);
	}


}