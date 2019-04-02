package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Hotel;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 29, 2014 2:47:33 PM
 * @revision  3.0
 */
@Repository
public interface HotelMapper extends BaseMapper<Hotel, String> {
	
	List<Hotel> find(Hotel hotel);

	List<Hotel> findSelect(Hotel hotel);

}
