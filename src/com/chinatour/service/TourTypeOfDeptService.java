/**
 * 
 */
package com.chinatour.service;

import java.util.List;
import com.chinatour.entity.TourTypeOfDept;

/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-9-27 下午5:16:21
 * @revision  3.0
 */

public interface TourTypeOfDeptService extends BaseService<TourTypeOfDept, String> {
	/**
	 * 查找出TourTypeOfDept里同一部门下的信息
	 * @param DeptId
	 */
	List<TourTypeOfDept> queryTourTypeList(String id);

	void batchSave(List<TourTypeOfDept> tourTypeOfDeptList);
	
	List<TourTypeOfDept> findTourTypeOfDeptByDept(String DeptId);
	
	List<TourTypeOfDept> queryByTourType(String id);
}
