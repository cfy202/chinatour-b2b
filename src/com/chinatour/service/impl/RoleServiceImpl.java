/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import com.chinatour.entity.Role;
import com.chinatour.persistence.RoleMapper;
import com.chinatour.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service - 角色
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("roleServiceImpl")
public class RoleServiceImpl extends BaseServiceImpl<Role, String> implements RoleService {

    @Autowired
    public void setBaseMapper(RoleMapper roleMapper) {
        super.setBaseMapper(roleMapper);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void save(Role role) {
        super.save(role);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public int update(Role role) {
        return super.update(role);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(String id) {
        super.delete(id);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(String... ids) {
        super.delete(ids);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(Role role) {
        super.delete(role);
    }

}