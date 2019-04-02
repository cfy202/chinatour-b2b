package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerConsult;

public interface CustomerConsultService extends BaseService<CustomerConsult, String> {
	List<CustomerConsult> findByCustomerId(String customerId);
	/**
	 * 查询咨询记录总数
	 * @param customerConsult
	 * @return
	 */
	CustomerConsult findCountCustomerConsult(CustomerConsult customerConsult);
	
	List<CustomerConsult> find(CustomerConsult customerConsult);
	
	public Page<CustomerConsult> findRegionForPage(CustomerConsult customerConsult, Pageable pageable);
	
	/**
	 * 获取到当天的电话记录
	 * @return
	 */
	int findForEndDate(CustomerConsult customerConsult);
	
}
