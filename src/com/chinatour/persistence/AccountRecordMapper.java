/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.entity.AccountRecord;
import com.chinatour.entity.AccountRow;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-22 下午4:53:35
 * @revision  3.0
 */
@Repository
public interface AccountRecordMapper extends BaseMapper<AccountRecord, String>{
	List<AccountRow>	getAccountRow(@Param("record") AccountRecord accountRecord);
	List<AccountRow>    getBeginningVal(@Param("record") AccountRecord accountRecord);
	AccountRecord	getBeginningValueOfYear(AccountRecord accountRecord);
	//查询年总额
	AccountRecord querySumYearly (AccountRecord accountRecord);
}
