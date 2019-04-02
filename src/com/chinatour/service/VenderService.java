package com.chinatour.service;

import java.util.List;


import com.chinatour.entity.Vender;


/**
 * Service - 地接
 * 
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 下午14:07:24
 * @revision  3.0
 */

public interface VenderService extends BaseService<Vender, String> {
	
	public List<Vender> findAllPeer();

	public List<Vender> find(Vender vender);
	
	public List<Vender> findAllSupplier();
	
	public List<Vender> findSelect(Vender vender); 
	
	public List<Vender> findSelectAll(Vender vender);
	
	public List<Vender> findExcel(Vender vender);
	
	List<Vender> findVenderUserName(Vender vender);
	
	List<Vender> findByDept(String DeptId);//用于添加产品时根据操作中心dept选择vender
	
	String findMaxCode(Vender vender);
}