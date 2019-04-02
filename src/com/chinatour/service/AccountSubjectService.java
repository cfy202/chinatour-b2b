package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.AccountSubject;
import com.chinatour.entity.BusinessFlow;
import com.chinatour.entity.StatisticalProfit;
/**
 * 会计科目
 * @author chinatour
 *
 */
public interface AccountSubjectService extends BaseService<AccountSubject, String> {
	List<AccountSubject> find(AccountSubject accountSuject);
	void addAccountToDept(List<AccountSubject> accountSubjectList);
	void deleteAccountSubjectFromDept(String[] accountSubjectIds);
	List<AccountSubject> query(AccountSubject accountSubject);
	List<AccountSubject> queryDeptBusinessSubject(AccountSubject accountSubject);
	List<AccountSubject> searchDeptAccountSubject(AccountSubject accountSubject);
	//获取月度总和
	 List<BusinessFlow> queryTotalMonth(AccountSubject accountSubject);
	 //年度综合
	 BusinessFlow queryTotalYear(AccountSubject accountSubject);
	 //模糊匹配一二级科目
	 List<AccountSubject> likeAccountSubject(String subjectCode);
}
