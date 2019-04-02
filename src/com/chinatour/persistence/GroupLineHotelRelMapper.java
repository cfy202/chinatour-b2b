package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.GroupLineHotelRel;

@Repository
public interface GroupLineHotelRelMapper extends BaseMapper<GroupLineHotelRel, String> {
	List<GroupLineHotelRel> findByGroupLineId(String groupLineHotelRelId);
	GroupLineHotelRel findGroupLineHotelRelByHotelId(String hotelId);
	void deleteByGroupLineId(String groupLineId);
}
