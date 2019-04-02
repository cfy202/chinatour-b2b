/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.persistence;


import com.chinatour.entity.Area;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Dao - 地区
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Repository
public interface AreaMapper extends BaseMapper<Area, Long> {

    /**
     * 查找顶级地区
     *
     * @param count 数量
     * @return 顶级地区
     */
    List<Area> findRoots(Integer count);

}