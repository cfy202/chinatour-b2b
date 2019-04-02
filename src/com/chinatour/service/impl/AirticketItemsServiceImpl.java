package com.chinatour.service.impl;

import java.util.List;

import com.chinatour.entity.AirticketItems;
import com.chinatour.persistence.AirticketItemsMapper;
import com.chinatour.persistence.HotelPriceInfoMapper;
import com.chinatour.service.AirticketItemsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2015-7-21 下午2:49:37
 * @revision 3.0
 */
@Service("airticketItemsServiceImpl")
public class AirticketItemsServiceImpl extends
		BaseServiceImpl<AirticketItems, String> implements
		AirticketItemsService {
	@Autowired
	private AirticketItemsMapper airticketItemsMapper;

	@Autowired
	public void setBaseMapper(AirticketItemsMapper airticketItemsMapper) {
		super.setBaseMapper(airticketItemsMapper);
	}

	@Override
	public void batchSave(List<AirticketItems> airticketItemsList) {
		airticketItemsMapper.batchSave(airticketItemsList);
	}

	@Override
	public List<AirticketItems> findByOrderId(String id) {
		return airticketItemsMapper.findByOrderId(id);
	}
}
