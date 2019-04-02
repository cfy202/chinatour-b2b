/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import com.chinatour.CommonAttributes;
import com.chinatour.LogConfig;
import com.chinatour.service.LogConfigService;
import org.dom4j.Document;
import org.dom4j.io.SAXReader;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Service - 日志配置
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("logConfigServiceImpl")
public class LogConfigServiceImpl implements LogConfigService {

    @SuppressWarnings("unchecked")
    @Cacheable("logConfig")
    public List<LogConfig> getAll() {
        try {
            File shopxxXmlFile = new ClassPathResource(CommonAttributes.SETTINGS_XML_PATH).getFile();
            Document document = new SAXReader().read(shopxxXmlFile);
            List<org.dom4j.Element> elements = document.selectNodes("/settings/logConfig");
            List<LogConfig> logConfigs = new ArrayList<LogConfig>();
            for (org.dom4j.Element element : elements) {
                String operation = element.attributeValue("operation");
                String urlPattern = element.attributeValue("urlPattern");
                LogConfig logConfig = new LogConfig();
                logConfig.setOperation(operation);
                logConfig.setUrlPattern(urlPattern);
                logConfigs.add(logConfig);
            }
            return logConfigs;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}