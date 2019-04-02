package com.chinatour.persistence;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.Enquirys;

/**
 * Dao - 询价
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-29 上午9:35:37
 * @revision  3.0
 */

@Repository
public interface EnquirysMapper extends BaseMapper<Enquirys, String> {

	List<Enquirys> findByDeptIdPage(@Param("record")Enquirys enquirys, @Param("page")Pageable pageable);

	int findByDeptIdPageCount(@Param("record")Enquirys enquirys, @Param("page")Pageable pageable);

}