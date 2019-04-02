package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.AirticketItems;
@Repository
public interface AirticketItemsMapper  extends BaseMapper<AirticketItems,String> {

	void batchSave(List<AirticketItems> airticketItemsList);

	List<AirticketItems> findByOrderId(String id);
}