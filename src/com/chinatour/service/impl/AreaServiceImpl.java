/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import com.chinatour.entity.Area;
import com.chinatour.persistence.AreaMapper;
import com.chinatour.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service - 地区
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("areaServiceImpl")
public class AreaServiceImpl extends BaseServiceImpl<Area, Long> implements AreaService {

    @Autowired
    private AreaMapper areaMapper;

    @Autowired
    public void setBaseMapper(AreaMapper areaMapper) {
        super.setBaseMapper(areaMapper);
    }

    @Transactional(readOnly = true)
    public List<Area> findRoots() {
        return areaMapper.findRoots(null);
    }

    @Transactional(readOnly = true)
    public List<Area> findRoots(Integer count) {
        return areaMapper.findRoots(count);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void save(Area area) {
        super.save(area);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public int update(Area area) {
        return super.update(area);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void delete(Long id) {
        super.delete(id);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void delete(Long... ids) {
        super.delete(ids);
    }

    @Override
    @Transactional
    @CacheEvict(value = "area", allEntries = true)
    public void delete(Area area) {
        super.delete(area);
    }

}