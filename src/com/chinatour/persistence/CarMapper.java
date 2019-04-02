package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Car;
@Repository
public interface CarMapper extends BaseMapper<Car, String>{
	List<Car> findByTourId(String tourId);
}
