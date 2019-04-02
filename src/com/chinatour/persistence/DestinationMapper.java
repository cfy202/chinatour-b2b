package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.City;
import com.chinatour.entity.Destination;
/**
 * @copyright   Copyright: 2015 
 * 目的地
 * @author Aries
 * @create-time Jul 3, 2015 11:19:01 AM
 * @revision  3.0
 */
@Repository
public interface DestinationMapper extends BaseMapper<Destination, String> {
	List<Destination> findByDes(Destination destination);

}
