package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.GroupRoute;

@Repository
public interface GroupRouteMapper extends BaseMapper<GroupRoute, String> {
	/**
	 * 根据线路查出所有的行程
	 * 
	 * @param groupLineId
	 * @return
	 */
	List<GroupRoute> findGroupRouteByGroupLineId(String groupLineId);
	
	/**
	 * 
	 * @param groupLineId
	 */
	void deleteByGroupLineId(String groupLineId);
	
}
