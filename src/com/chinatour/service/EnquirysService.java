package com.chinatour.service;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Enquirys;
import com.chinatour.entity.Vender;


/**
 * Service - 询价
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-29 上午9:36:44
 * @revision  3.0
 */

public interface EnquirysService extends BaseService<Enquirys, String> {

	Page<Enquirys> findPageByDeptId(Enquirys enquirys, Pageable pageable);
	
}