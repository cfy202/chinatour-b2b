package com.chinatour.service.impl;

import com.chinatour.entity.Icons;
import com.chinatour.persistence.IconsMapper;
import com.chinatour.service.IconsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by XuXuebin on 2014-08-29.
 */
@Service("iconsServiceImpl")
public class IconsServiceImpl extends BaseServiceImpl<Icons, String> implements IconsService {

    @Autowired
    public void setBaseMapper(IconsMapper iconsMapper) {
        super.setBaseMapper(iconsMapper);
    }
}
