package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Zipcode;

@Repository
public interface ZipcodeMapper extends BaseMapper<Zipcode, String> {

	List<Zipcode> findSelect(Zipcode zipcode);
}