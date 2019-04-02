/**
 * 
 */
package com.chinatour.persistence;


import java.util.List;
import org.springframework.stereotype.Repository;
import com.chinatour.entity.TourTypeOfDept;

/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-9-27 下午5:56:07
 * @revision  3.0
 */
@Repository
public interface TourTypeOfDeptMapper extends BaseMapper<TourTypeOfDept, String>{
	/**
	 * 查找出TourTypeOfDept里同一部门下的信息
	 * @param DeptId
	 * */
	List<TourTypeOfDept> queryTourTypeList(String id);
	
	/**
	 * 
	 * @param deptId
	 * @return
	 */
	List<String> findTourTypeIdByDeptId(String deptId);

	void batchSave(List<TourTypeOfDept> tourTypeOfDeptList);
	
	List<TourTypeOfDept> findTourTypeIdByTourTypeId(String tourTypeId);
	
	List<TourTypeOfDept> findTourTypeOfDeptByDept(String DeptId);
	
	List<TourTypeOfDept> queryByTourType(String typeid);
}
