/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.CustomerFlight;

/**
 * Service  客人航班
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:36:54
 * @revision  3.0
 */
public interface CustomerFlightService extends BaseService<CustomerFlight, String>{
	List<CustomerFlight> findFlightList(CustomerFlight customerFlight);
	List<CustomerFlight> find(CustomerFlight customerFlight);
	void removeById(String id);
	/**
	 * 彻底删除航班信息
	 * */
	void deleteById(String id);
}
