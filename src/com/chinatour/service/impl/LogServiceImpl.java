/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import com.chinatour.entity.Log;
import com.chinatour.persistence.LogMapper;
import com.chinatour.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Service - 日志
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("logServiceImpl")
public class LogServiceImpl extends BaseServiceImpl<Log, Long> implements LogService {

    @Autowired
    private LogMapper logMapper;

    @Autowired
    public void setBaseMapper(LogMapper logMapper) {
        super.setBaseMapper(logMapper);
    }

    public void clear() {
        logMapper.removeAll();
    }

}