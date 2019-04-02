/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Admin;
import com.chinatour.entity.FinanceSubject;
import com.chinatour.entity.GlobalFinanceSubject;
import com.chinatour.persistence.FinanceSubjectMapper;
import com.chinatour.persistence.GlobalFinanceSubjectMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.FinanceSubjectService;
import com.chinatour.util.UUIDGenerator;


/**
 * 会计科目设置
 * @author chinatour
 *
 */
@Service("financeSubjectServiceImpl")
public class FinanceSubjectServiceImpl extends BaseServiceImpl<FinanceSubject, String> implements FinanceSubjectService {
	@Autowired
	private GlobalFinanceSubjectMapper globalFinanceSubjectMapper;
	@Autowired
	private FinanceSubjectMapper financeSubjectMapper;
	@Autowired
	private AdminService adminService;
	@Autowired
	public void setFinanceSubjectMapper(FinanceSubjectMapper financeSubjectMapper){
		this.setBaseMapper(financeSubjectMapper);
	}
	@Override
	public List<GlobalFinanceSubject> queryGlobalFinanceSubject(GlobalFinanceSubject globalFinanceSubject) {
		return globalFinanceSubjectMapper.queryGlobalFinanceSubject(globalFinanceSubject);
	}
	
	@Override
	public List<FinanceSubject> queryFinanceSubjectForDept(
			FinanceSubject financeSuject) {
		return financeSubjectMapper.find(financeSuject);
	}

	@Override
	public void addFinanceToDept(List<FinanceSubject> financeSubjectList) {
		Admin admin = adminService.getCurrent();
		for(FinanceSubject financeSubject:financeSubjectList){
			financeSubject.setFinanceSubjectId(UUIDGenerator.getUUID());
			financeSubject.setDeptId(admin.getDeptId());
		}
		financeSubjectMapper.saveBatch(financeSubjectList);
	}
	@Override
	public void deleteFinanceFromDept(String[] financeSubjectIds) {
		Admin admin = adminService.getCurrent();
		for(int i=0;i<financeSubjectIds.length;i++){
			financeSubjectMapper.removeById(financeSubjectIds[i]);
		}
		
		
	}
	
	
	
	
	
}
