package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.GlobalAccount;
/**
 * 
 * @author chinatour
 *
 */
@Repository
public interface GlobalAccountMapper extends BaseMapper<GlobalAccount, String> {
	/**
	 * 查找未选择的会计科目
	 * @param globalAccount
	 * @return
	 */
	List<GlobalAccount> queryNoChooseglobalAccount(GlobalAccount globalAccount);
}
