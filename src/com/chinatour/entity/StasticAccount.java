/**
 * 
 */
package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * 本部门用来统计月份（不存在数据库表）
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-11-3 上午10:36:31
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class StasticAccount {
	
	@JsonProperty
	private	String		deptId;					//本公司ID
	@JsonProperty
	private	String		deptName;				//本公司名称
	@JsonProperty
	private	List<MonthAccountRecord> listMonth=new ArrayList<MonthAccountRecord>();//月份列表
	@JsonProperty
	private	BigDecimal	beginningValueSub=new BigDecimal(0); //期初
	@JsonProperty
	private	BigDecimal	janSub=new BigDecimal(0);//一月
	@JsonProperty
	private	BigDecimal	febSub=new BigDecimal(0);//二月
	@JsonProperty
	private	BigDecimal	marSub=new BigDecimal(0);//三月
	@JsonProperty
	private	BigDecimal  aprSub=new BigDecimal(0);//四月
	@JsonProperty
	private	BigDecimal  maySub=new BigDecimal(0);//五月
	@JsonProperty
	private	BigDecimal	juneSub=new BigDecimal(0);//六月
	@JsonProperty
	private	BigDecimal	julySub=new BigDecimal(0);//七月
	@JsonProperty
	private	BigDecimal	augSub=new BigDecimal(0);//八月
	@JsonProperty
	private	BigDecimal	septSub=new BigDecimal(0);//九月
	@JsonProperty
	private	BigDecimal	octSub=new BigDecimal(0);//十月
	@JsonProperty
	private	BigDecimal	novSub=new BigDecimal(0);//十一月
	@JsonProperty
	private	BigDecimal	decSub=new BigDecimal(0);//十二月
	@JsonProperty
	private	BigDecimal	grandTotal=new BigDecimal(0);//总额

}
