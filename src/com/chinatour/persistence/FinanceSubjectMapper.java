package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.FinanceSubject;
@Repository
public interface FinanceSubjectMapper extends BaseMapper<FinanceSubject, String> {
	List<FinanceSubject> find(FinanceSubject financeSuject);
	void saveBatch(List<FinanceSubject> financeSubjectList);
}
