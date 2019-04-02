package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.Hotel;

/**
 * 
 * @author chinatour
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class HotelListVO {
	private List<Hotel> hotelList;
}
