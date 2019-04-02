package com.chinatour.persistence;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Country;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 28, 2014 3:28:51 PM
 * @revision  3.0
 */

@Repository
public interface CountryMapper extends BaseMapper<Country, String> {

}
