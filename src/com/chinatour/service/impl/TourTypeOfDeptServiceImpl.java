/**
 * 
 */
package com.chinatour.service.impl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.TourTypeOfDept;
import com.chinatour.persistence.TourTypeOfDeptMapper;
import com.chinatour.service.TourTypeOfDeptService;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-9-27 下午5:42:46
 * @revision  3.0
 */
@Service("tourTypeOfDeptServiceImpl")
public class TourTypeOfDeptServiceImpl extends BaseServiceImpl<TourTypeOfDept, String> implements TourTypeOfDeptService {
	    
		/**
		 * TourTypeOfDeptMapper注入
		 * @param TourTypeOfDeptMapper
		 */
		@Autowired
		TourTypeOfDeptMapper tourTypeOfDeptMapper;
		
		@Autowired
		public void setBaseMapper(TourTypeOfDeptMapper tourTypeOfDeptMapper) {
		    	super.setBaseMapper(tourTypeOfDeptMapper);
		}
		
		/**
		  * 查找出TourTypeOfDept里同一部门下的信息
		  * @param DeptId
		 */
		@Override
		public List<TourTypeOfDept> queryTourTypeList(String id) {
			return tourTypeOfDeptMapper.queryTourTypeList(id);
		}
		/**删除在ids里面的信息*/
		 @Override
		 @Transactional
		 @CacheEvict(value = "authorization", allEntries = true)
		 public void delete(String... ids) {
		     super.delete(ids);
		 }

		@Override
		public void batchSave(List<TourTypeOfDept> tourTypeOfDeptList) {
			tourTypeOfDeptMapper.batchSave(tourTypeOfDeptList);
		}

		@Override
		public List<TourTypeOfDept> findTourTypeOfDeptByDept(String DeptId) {
			return tourTypeOfDeptMapper.findTourTypeOfDeptByDept(DeptId);
		}

		@Override
		public List<TourTypeOfDept> queryByTourType(String id) {
			return tourTypeOfDeptMapper.queryByTourType(id);
		}
		
}
