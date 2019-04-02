package com.chinatour.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.AccountSubject;
import com.chinatour.entity.BusinessFlow;
import com.chinatour.persistence.AccountSubjectMapper;
import com.chinatour.service.AccountSubjectService;

@Service("accountSubjectServiceImpl")
public class AccountSubjectServiceImpl extends BaseServiceImpl<AccountSubject, String> implements AccountSubjectService {
	@Autowired
	private AccountSubjectMapper accountSubjectMapper;
	
	@Autowired
	public void setAccountSubjectMapper(AccountSubjectMapper accountSubjectMapper){
		this.setBaseMapper(accountSubjectMapper);
	}
	
	@Override
	public List<AccountSubject> find(AccountSubject accountSuject) {
		return accountSubjectMapper.find(accountSuject);
	}
	@Override
	public void addAccountToDept(List<AccountSubject> accountSubjectList) {
		accountSubjectMapper.addAccountToDept(accountSubjectList);
		
	}
	@Override
	public void deleteAccountSubjectFromDept(String[] accountSubjectIds) {
		for(int i=0;i<accountSubjectIds.length;i++){
			accountSubjectMapper.removeById(accountSubjectIds[i]);
		}
		
	}

	@Override
	public List<AccountSubject> query(AccountSubject accountSubject) {
		return accountSubjectMapper.query(accountSubject);
	}

	@Override
	public List<AccountSubject> queryDeptBusinessSubject(
			AccountSubject accountSubject) {
		return accountSubjectMapper.find(accountSubject);
	}

	@Override
	public List<AccountSubject> searchDeptAccountSubject(
			AccountSubject accountSubject) {
		return accountSubjectMapper.queryDeptAccountSubject(accountSubject);
	}

	@Override
	public List<BusinessFlow> queryTotalMonth(AccountSubject accountSubject) {
		return accountSubjectMapper.queryTotalMonth(accountSubject);
	}

	@Override
	public BusinessFlow queryTotalYear(AccountSubject accountSubject) {
		return accountSubjectMapper.queryTotalYear(accountSubject);
	}

	@Override
	public List<AccountSubject> likeAccountSubject(
			String subjectCode) {
		return accountSubjectMapper.likeAccountSubject(subjectCode);
	}

}
