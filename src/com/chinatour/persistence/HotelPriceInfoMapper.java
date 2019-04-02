package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.HotelPriceInfo;

/**
 * Dao--团账单中酒店信息
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午10:07:48
 * @revision  3.0
 */
@Repository
public interface HotelPriceInfoMapper extends
		BaseMapper<HotelPriceInfo, String> {

	List<HotelPriceInfo> findHotelAndCustomer(HotelPriceInfo hotelPriceInfo);

	void batchSave(List<HotelPriceInfo> hotelPriceInfoList);

}