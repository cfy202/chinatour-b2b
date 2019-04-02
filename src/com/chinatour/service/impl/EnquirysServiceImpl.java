package com.chinatour.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Enquirys;
import com.chinatour.entity.Order;
import com.chinatour.persistence.EnquirysMapper;
import com.chinatour.persistence.TourTypeOfDeptMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.EnquirysService;

/**
 * Service -询价
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-29 上午9:39:16
 * @revision  3.0
 */

@Service("enquirysServiceImpl")
public class EnquirysServiceImpl extends BaseServiceImpl<Enquirys, String>
		implements EnquirysService {

	@Autowired
	private EnquirysMapper enquirysMapper;
	
	@Autowired
	private TourTypeOfDeptMapper tourTypeOfDeptMapper;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	public void setBaseMapper(EnquirysMapper enquirysMapper) {
		super.setBaseMapper(enquirysMapper);
	}

	@Override
	public Page<Enquirys> findPageByDeptId(Enquirys enquirys, Pageable pageable) {
		List<Enquirys> page =new ArrayList<Enquirys>();
		int pageCount = 1;
		if (pageable == null) {
            pageable = new Pageable();
        }
		String deptId = adminService.getCurrent().getDeptId();
		enquirys.setDeptId(deptId);
		page = enquirysMapper.findByDeptIdPage(enquirys,pageable);
		pageCount = enquirysMapper.findByDeptIdPageCount(enquirys,pageable);
		/*List<String> tourTypeIdList = tourTypeOfDeptMapper.findTourTypeIdByDeptId(deptId);
		if(tourTypeIdList.size() != 0){
			page = enquirysMapper.findByDeptIdPage(enquirys, tourTypeIdList,pageable);
			pageCount = enquirysMapper.findByDeptIdPageCount(enquirys,tourTypeIdList,pageable);
		}*/
        return new Page<Enquirys>(page, pageCount, pageable);
	}
}