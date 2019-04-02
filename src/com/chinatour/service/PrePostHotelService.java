package com.chinatour.service;

import java.util.List;


import com.chinatour.entity.PrePostHotel;

/**
 * @author Aries
 * @create-time Aug 17, 2015 3:34:33 PM
 * @revision  3.0
 */
public interface PrePostHotelService extends BaseService<PrePostHotel, String> {
	
	List<PrePostHotel> findByOrderId(PrePostHotel prePostHotel);

}
