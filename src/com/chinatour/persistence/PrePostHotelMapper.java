package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.City;
import com.chinatour.entity.PrePostHotel;


@Repository
public interface PrePostHotelMapper extends BaseMapper<PrePostHotel, String> {
	List<PrePostHotel> findByOrderId(PrePostHotel prePostHotel);

}
