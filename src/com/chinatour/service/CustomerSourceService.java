package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.CustomerSource;

/**
 * @author Jared
 *
 */
public interface CustomerSourceService extends BaseService<CustomerSource, String> {
	
	List<CustomerSource> find(CustomerSource customerSource);

	List<CustomerSource> findSource();

}
