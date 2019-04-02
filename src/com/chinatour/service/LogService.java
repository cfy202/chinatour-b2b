/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service;


import com.chinatour.entity.Log;

/**
 * Service - 日志
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public interface LogService extends BaseService<Log, Long> {

    /**
     * 清空日志
     */
    void clear();

}