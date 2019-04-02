package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.AirticketItems;

/**
 * 
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2015-7-21 下午2:48:37
 * @revision  3.0
 */
public interface AirticketItemsService extends BaseService<AirticketItems, String> {

	void batchSave(List<AirticketItems> airticketItemsList);

	List<AirticketItems> findByOrderId(String id);
}
