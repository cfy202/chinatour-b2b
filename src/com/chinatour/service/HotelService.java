package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.Hotel;
import com.chinatour.entity.HotelPriceInfo;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 29, 2014 4:49:48 PM
 * @revision  3.0
 */
public interface HotelService extends BaseService<Hotel, String> {

	List<Hotel> find(Hotel hotel);

	List<Hotel> findSelect(Hotel hotel);

}
