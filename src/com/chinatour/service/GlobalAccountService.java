package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.GlobalAccount;
/**
 * 
 * @author chinatour
 *
 */

public interface GlobalAccountService extends BaseService<GlobalAccount, String> {
	List<GlobalAccount> find(GlobalAccount globalAccount);
	List<GlobalAccount> queryNoChooseglobalAccount(GlobalAccount globalAccount);
}
