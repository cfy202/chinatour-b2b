package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.AccountSubject;
import com.chinatour.entity.FinanceSubject;

@Data
@EqualsAndHashCode(callSuper = false)
public class AccountSubjectVO {
	private List<AccountSubject> accountSubjectList;
}
