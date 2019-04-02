package com.chinatour.persistence;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Supplier;

/**
 * Dao - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午14:07:24
 * @revision  3.0
 */

@Repository
public interface SupplierMapper extends BaseMapper<Supplier, String> {

	List<Supplier> findSelect(Supplier supplier);
}