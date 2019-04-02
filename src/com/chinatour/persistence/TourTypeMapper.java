package com.chinatour.persistence;


import java.util.List;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.entity.TourType;

/**
 * Dao - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

@Repository
public interface TourTypeMapper extends BaseMapper<TourType, String> {
	
	List<TourType> findByBrand(String brand);

	List<TourType> findByt(@Param("record")TourType tourType);
}