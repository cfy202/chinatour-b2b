package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.AccountRecord;
import com.chinatour.entity.GlobalFinanceSubject;

@Repository
public interface GlobalFinanceSubjectMapper extends BaseMapper<GlobalFinanceSubject, String> {
	//查询本单位未选择的会计科目
	List<GlobalFinanceSubject> queryGlobalFinanceSubject(GlobalFinanceSubject globalFinanceSubject);
}
