package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.AccountSubject;
import com.chinatour.entity.BusinessFlow;
/**
 * 报表科目
 * @author chinatour
 *
 */
@Repository
public interface AccountSubjectMapper extends BaseMapper<AccountSubject, String> {
	 void addAccountToDept(List<AccountSubject> accountSubjectList);
	 List<AccountSubject> query(AccountSubject accountSubject);
	 List<AccountSubject>  queryDeptAccountSubject(AccountSubject accountSubject);
	 List<BusinessFlow> queryTotalMonth(AccountSubject accountSubject);
	 BusinessFlow queryTotalYear(AccountSubject accountSubject);
	 List<AccountSubject> likeAccountSubject(String subjectCode);
}
