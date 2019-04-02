package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.State;


/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 28, 2014 3:28:51 PM
 * @revision  3.0
 */

@Repository
public interface StateMapper extends BaseMapper<State, String> {
	
	List<State> findByCountryId(String countryId);

}
