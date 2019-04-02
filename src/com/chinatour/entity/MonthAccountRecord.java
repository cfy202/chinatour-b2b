/**
 * 
 */
package com.chinatour.entity;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**对方用来统计月份（不存在数据库表）
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-11-3 上午11:29:29
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class MonthAccountRecord {

	@JsonProperty
	private	String		billToDeptId;			//对方公司
	private	String		billToReceiver;		//对方公司
	@JsonProperty
	private	String		year;				//年
	@JsonProperty
	private	BigDecimal	beginningValue;
	@JsonProperty
	private	BigDecimal	jan;				//一月
	@JsonProperty
	private	BigDecimal	feb;				//二月
	@JsonProperty
	private	BigDecimal	mar;				//三月
	@JsonProperty
	private	BigDecimal  apr;				//四月
	@JsonProperty
	private	BigDecimal  may;				//五月
	@JsonProperty
	private	BigDecimal	june;				//六月
	@JsonProperty
	private	BigDecimal	july;				//七月
	@JsonProperty
	private	BigDecimal	aug;				//八月
	@JsonProperty
	private	BigDecimal	sept;				//九月
	@JsonProperty
	private	BigDecimal	oct;				//十月
	@JsonProperty
	private	BigDecimal	nov;				//十一月
	@JsonProperty
	private	BigDecimal	dec;				//十二月
	@JsonProperty
	private	BigDecimal	subtotal=new BigDecimal(0);//总额
	@JsonProperty
	private	String		deptId;				//部门Id

}
