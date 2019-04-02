package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.FlightPriceInfo;

/**
 * Dao团账单中机票信息
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:06:21
 * @revision 3.0
 */
@Repository
public interface FlightPriceInfoMapper extends
		BaseMapper<FlightPriceInfo, String> {

	List<FlightPriceInfo> findByTourId(String tourId);

	List<FlightPriceInfo> findFlightAndCustomer(FlightPriceInfo flightPriceInfo);

	void batchSave(List<FlightPriceInfo> flightPriceInfoList);

}