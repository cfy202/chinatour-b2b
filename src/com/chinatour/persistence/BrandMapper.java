package com.chinatour.persistence;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Brand;
import com.chinatour.entity.City;

/**
 * @copyright   Copyright: 2014 
 * @author Cery
 * @create-time Aug 29, 2014 2:46:26 PM
 * @revision  3.0
 */
@Repository
public interface BrandMapper extends BaseMapper<Brand, String> {

}
