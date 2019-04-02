package com.chinatour.service.impl;

import com.chinatour.entity.Module;
import com.chinatour.persistence.ModuleMapper;
import com.chinatour.service.ModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by XuXuebin on 2014-08-29.
 */
@Service("moduleServiceImpl")
public class ModuleServiceImpl extends BaseServiceImpl<Module, String> implements ModuleService {

    @Autowired
    public void setBaseMapper(ModuleMapper moduleMapper) {
        super.setBaseMapper(moduleMapper);
    }


}
