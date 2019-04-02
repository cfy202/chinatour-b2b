package com.chinatour.persistence;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Dept;
import com.chinatour.entity.Nationality;

/**
 * 国籍
 * 
 * @copyright   Copyright: 2014 
 * @author Cery
 * @create-time 2014-8-28 下午14:07:24
 * @revision  3.0
 */

@Repository
public interface NationalityMapper extends BaseMapper<Nationality, String> {
	
	
}