package com.chinatour.service.impl;

import com.chinatour.entity.RoleButton;
import com.chinatour.persistence.RoleButtonMapper;
import com.chinatour.service.RoleButtonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by XuXuebin on 2014-08-29.
 */
@Service("roleButtonServiceImpl")
public class RoleButtonServiceImpl extends BaseServiceImpl<RoleButton, String> implements RoleButtonService {

    @Autowired
    public void setBaseMapper(RoleButtonMapper roleButtonMapper) {
        super.setBaseMapper(roleButtonMapper);
    }
}
