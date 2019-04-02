package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Language;
import com.chinatour.persistence.LanguageMapper;
import com.chinatour.service.LanguageService;

/**
 * Service - 语种
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-9-19 下午1:10:18
 * @revision 3.0
 */
@Service("languageServiceImpl")
public class LanguageServiceImpl extends BaseServiceImpl<Language, String>
		implements LanguageService {

	@Autowired
	private LanguageMapper languageMapper;

	@Autowired
	public void setBaseMapper(LanguageMapper languageMapper) {
		super.setBaseMapper(languageMapper);
	}
}
