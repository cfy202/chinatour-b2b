package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.CustomerSource;

/**
 * Dao   -  客人
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午9:16:27
 * @revision  3.0
 */
@Repository
public interface CustomerSourceMapper extends BaseMapper<CustomerSource, String> {

	List<CustomerSource> findSource();
	
}
