package com.chinatour.service;


import java.util.List;

import com.chinatour.entity.Supplier;

/**
 * Service - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午14:07:24
 * @revision  3.0
 */

public interface SupplierService extends BaseService<Supplier, String> {

	List<Supplier> findSelect(Supplier supplier);
	
}