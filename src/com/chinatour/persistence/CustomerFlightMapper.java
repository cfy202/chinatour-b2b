/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.Tour;

/**
 * Dao  客人航班
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午11:35:18
 * @revision  3.0
 */
@Repository
public interface CustomerFlightMapper extends BaseMapper<CustomerFlight, String> {
	
	/**
	 * 根据CustomerFlightId查找CustomerFlight
	 * 
	 * @param customerOrderRelId
	 * @return
	 */
	List<CustomerFlight> findByCustomerOrderRelId(String customerOrderRelId);
	
	/**
	 * 批量保存CustomerFlight
	 * 
	 * @param customerFlightList
	 */
	void saveCustomerFlights(@Param("customerFlightList")List<CustomerFlight> customerFlightList);
	
	void updateCustomerFlight(CustomerFlight customerFlight);
	
	List<CustomerFlight> findFlightList(CustomerFlight customerFlight);
	
	List<CustomerFlight> findFlightForOpForPage(@Param("record")CustomerFlight customerFlight,@Param("page") Pageable pageable);

	int findFlightForOpForPageCount(@Param("record")CustomerFlight customerFlight,@Param("page") Pageable pageable);
	
	List<CustomerFlight> queryFlightForOp(CustomerFlight customerFlight);
	/**
	 * 彻底删除数据
	 * */
	void deleteById(String id);
}



