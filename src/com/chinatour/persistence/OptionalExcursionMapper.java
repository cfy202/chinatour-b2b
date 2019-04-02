package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.OptionalExcurition;

@Repository
public interface OptionalExcursionMapper extends BaseMapper<OptionalExcurition, String>{
	
	List<OptionalExcurition> findByCode(String code);
}
