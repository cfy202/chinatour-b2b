/**
 * 
 */
package com.chinatour.persistence;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Dept;
import com.chinatour.entity.InvoiceAndCredit;


/**
 * 对账
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-9 下午4:18:55
 * @revision  3.0
 */
@Repository
public interface InvoiceAndCreditMapper extends BaseMapper<InvoiceAndCredit, String>{
	/**
	 * 找出最大的业务编码
	 * */
	int getBusinessNo(String deptId);
	
	/**
	 * 根据传入条件查找
	 */
	List<InvoiceAndCredit> find(InvoiceAndCredit invoiceAndCredit);
	List<Dept> queryDeptForBegVal(String DeptId);
	InvoiceAndCredit querySum(InvoiceAndCredit invoiceAndCredit);
	int findCount(InvoiceAndCredit invoiceAndCredit);
}
