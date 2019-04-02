package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.State;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 28, 2014 3:34:33 PM
 * @revision  3.0
 */
public interface StateService extends BaseService<State, String> {
	
	/**
	 * 根据国家ID查询州
	 *  
	 * @param countryId
	 * @return
	 */
	List<State> findByCountryId(String countryId);

}
