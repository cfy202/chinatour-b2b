/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.FinanceSubject;
import com.chinatour.entity.GlobalFinanceSubject;

/**
 * 会计科目设置
 * @author chinatour
 *
 */

public interface FinanceSubjectService extends BaseService<FinanceSubject, String> {
	/**
	 * 获取该部门未选择的会计科目
	 * @param globalFinanceSubject
	 * @return
	 */
	List<GlobalFinanceSubject> queryGlobalFinanceSubject(GlobalFinanceSubject globalFinanceSubject);
	/**
	 * 获取该部门已选择的会计科目
	 * @param financeSuject
	 * @return
	 */
	List<FinanceSubject> queryFinanceSubjectForDept(FinanceSubject financeSuject);
	/**
	 * 增添会计科目
	 * @param financeSubjectList
	 */
	void addFinanceToDept(List<FinanceSubject> financeSubjectList);
	/**
	 * 移除会计科目
	 * @param financeSubjectIds
	 */
	void deleteFinanceFromDept(String[] financeSubjectIds);
}
