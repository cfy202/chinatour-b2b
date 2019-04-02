package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerConsult;
@Repository
public interface CustomerConsultMapper extends BaseMapper<CustomerConsult, String> {
	/**
	 * 查询客人的所有咨询资料
	 * @param customerId
	 * @return
	 */
	List<CustomerConsult> findByCustomerId(String customerId);
	
	/**
	 * 查询咨询记录总数
	 * @param customerConsult
	 * @return
	 */
	CustomerConsult findCountCustomerConsult(CustomerConsult customerConsult);
	
	/**
	 * 查询区域电话记录
	 * @param customerInfos
	 * @param pageable
	 * @return
	 */
	List<CustomerConsult> findRegionForPage(@Param("record")CustomerConsult customerConsult,@Param("page")Pageable pageable);
	int findRegionForPageCount(@Param("record")CustomerConsult customerConsult,@Param("page")Pageable pageable);
	
	/**
	 * 查询到当天的电话记录
	 * @return
	 */
	int findForEndDate(CustomerConsult customerConsult);
}
