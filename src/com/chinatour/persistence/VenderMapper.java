package com.chinatour.persistence;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Vender;

/**
 * Dao - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

@Repository
public interface VenderMapper extends BaseMapper<Vender, String> {
	List<Vender> findSelect(Vender vender);
	List<Vender> findSelectAll(Vender vender);
	//查询vendor包含user
	List<Vender> findVenderUserName(Vender vender);
	List<Vender> findByDept(String DeptId);
	String findMaxCode(Vender vender);
}