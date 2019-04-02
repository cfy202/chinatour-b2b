package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.Supplier;
import com.chinatour.persistence.SupplierMapper;
import com.chinatour.service.SupplierService;

/**
 * Service - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-28 下午14:07:24
 * @revision  3.0
 */

@Service("supplierServiceImpl")
public class SupplierServiceImpl extends BaseServiceImpl<Supplier, String> implements SupplierService {

	@Autowired
	private SupplierMapper supplierMapper;

	@Autowired
	public void setBaseMapper(SupplierMapper supplierMapper) {
	    	super.setBaseMapper(supplierMapper);
	}
	
	
	@Transactional(readOnly = true)
	public List<Supplier> findAll() {
		return supplierMapper.findAll();
	}
	
	@Override
	@Transactional(readOnly = true)
	public Supplier findById(String id) {
		return super.findById(id);
	}

	@Override
	@Transactional
	public int update(Supplier entity) {
		return super.update(entity);
	}

    @Override
    @Transactional
    public void save(Supplier entity) {
    	super.save(entity);
    }

    @Override
    @Transactional
    public void delete(String id) {
    	super.delete(id);
    }


	@Override
	public List<Supplier> findSelect(Supplier supplier) {
		return supplierMapper.findSelect(supplier);
	}
	
}