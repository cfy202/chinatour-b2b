package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.OptionalExcurition;
import com.chinatour.persistence.OptionalExcursionMapper;
import com.chinatour.service.OptionalExcursionService;

@Service("optionalExcursionServiceImpl")
public class OptionalExcursionServiceImpl extends BaseServiceImpl<OptionalExcurition, String> implements OptionalExcursionService {
	@Autowired
	private OptionalExcursionMapper optionalExcursionMapper;
	@Autowired
	public void setOptionalExcursionMapper(OptionalExcursionMapper optionalExcursionMapper){
		this.setBaseMapper(optionalExcursionMapper);
	}

}
