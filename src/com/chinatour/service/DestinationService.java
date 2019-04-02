package com.chinatour.service;
import java.util.List;

import com.chinatour.entity.Destination;

/**
 * @copyright   Copyright: 2015 
 * 目的地
 * @author Aries
 * @create-time Jul 3, 2015 11:19:01 AM
 * @revision  3.0
 */
public interface DestinationService extends BaseService<Destination, String> {
	List<Destination> findByDes(Destination destination);
}
