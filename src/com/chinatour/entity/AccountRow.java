/**
 * 
 */
package com.chinatour.entity;

import java.math.BigDecimal;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**(不存在数据库表)
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-11-3 下午2:24:31
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class AccountRow {
	private	String		billToDeptId;			//对方公司
	private	String		billToReceiver;		//对方公司
	private	BigDecimal	balance;
	private	String		month;
	private	String		deptId;

}
