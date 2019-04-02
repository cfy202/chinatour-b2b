package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Hotel;
import com.chinatour.entity.HotelPriceInfo;
import com.chinatour.persistence.HotelMapper;
import com.chinatour.persistence.HumanraceMapper;
import com.chinatour.service.HotelService;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 29, 2014 4:51:20 PM
 * @revision  3.0
 */
@Service("hotelServiceImpl")
public class HotelServiceImpl extends BaseServiceImpl<Hotel, String> implements HotelService{
    
	
	@Autowired
	private HotelMapper hotelMapper;
	/**
	 * HotelMapper注入
	 * @param hotelMapper
	 */
	@Autowired
	public void setHotelMapper(HotelMapper hotelMapper){
		this.setBaseMapper(hotelMapper);
	}

	@Override
	public List<Hotel> find(Hotel hotel) {
		return hotelMapper.find(hotel);
	}

	@Override
	public List<Hotel> findSelect(Hotel hotel) {
		return hotelMapper.findSelect(hotel);
	}
	
}
