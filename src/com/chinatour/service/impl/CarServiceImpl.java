package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Car;
import com.chinatour.persistence.CarMapper;
import com.chinatour.service.CarService;
@Service("carServiceImpl")
public class CarServiceImpl extends BaseServiceImpl<Car, String> implements CarService {
	@Autowired
	private CarMapper carMapper;
	@Autowired
	public void setCarMapper(CarMapper carMapper){
		this.setBaseMapper(carMapper);
	}

	@Override
	public List<Car> findByTourId(String tourId) {
		return carMapper.findByTourId(tourId);
	}
}
