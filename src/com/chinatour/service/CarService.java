package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.Car;

public interface CarService extends BaseService<Car, String> {
	List<Car> findByTourId(String tourId);
}
