package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.Vender;
import com.chinatour.persistence.VenderMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.VenderService;


/**
 * Service - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

@Service("venderServiceImpl")
public class VenderServiceImpl extends BaseServiceImpl<Vender, String> implements VenderService {

	@Autowired
	private VenderMapper venderMapper;
	
	@Autowired
	private AdminService adminService;

	@Autowired
	public void setBaseMapper(VenderMapper venderMapper) {
	    	super.setBaseMapper(venderMapper);
	}
	
	@Transactional(readOnly = true)
	public List<Vender> findAll() {
		return venderMapper.findAll();
	}
	
	@Override
	@Transactional(readOnly = true)
	public Vender findById(String id) {
		return super.findById(id);
	}

	@Override
	@Transactional
	public int update(Vender entity) {
		return super.update(entity);
	}

    @Override
    @Transactional
    public void save(Vender entity) {
    	super.save(entity);
    }

    @Override
    @Transactional
    public void delete(String id) {
    	super.delete(id);
    }

	@Override
	@Transactional(readOnly = true)
	public List<Vender> findAllPeer(){
		Vender vender = new Vender();
		vender.setDeptId(adminService.getCurrent().getDeptId());
		vender.setType(1);
		return venderMapper.find(vender);
	}

	@Override
	@Transactional(readOnly = true)
	public List<Vender> find(Vender vender) {
		return venderMapper.find(vender);
	}
	
	@Override
	@Transactional(readOnly = true)
	public List<Vender> findAllSupplier(){
		Vender vender = new Vender();
		vender.setDeptId(adminService.getCurrent().getDeptId());
		vender.setType(2);
		return venderMapper.find(vender);	
	}
	
	@Override
	public List<Vender> findSelect(Vender vender) {
		return venderMapper.findSelect(vender);
	}

	@Override
	public List<Vender> findSelectAll(Vender vender) {
		return venderMapper.findSelectAll(vender);
	}

	@Override
	public List<Vender> findExcel(Vender vender) {
		return null;
	}

	@Override
	public List<Vender> findVenderUserName(Vender vender) {
		return venderMapper.findVenderUserName(vender);
	}

	@Override
	public List<Vender> findByDept(String DeptId) {
		return venderMapper.findByDept(DeptId);
	}

	@Override
	public String findMaxCode(Vender vender) {
		return venderMapper.findMaxCode(vender);
	}
}