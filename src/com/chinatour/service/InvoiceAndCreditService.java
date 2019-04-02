/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.AccData;
import com.chinatour.entity.AccountRecord;
import com.chinatour.entity.AccountRow;
import com.chinatour.entity.Dept;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.StasticAccount;


/**
 * 对账
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-9 下午4:33:55
 * @revision  3.0
 */

public interface InvoiceAndCreditService extends BaseService<InvoiceAndCredit, String> {
	/**
	 * 找出最大的业务编码
	 * */
	int getBusinessNo(String deptId);
	/**
	 * 保存InvoiceAndCredit及InvoiceAndCreditItems数据
	 * */
	void save(InvoiceAndCredit invoiceAndCredit);
	/**
	 *根据传入条件查找 
	 */
	List<InvoiceAndCredit> find(InvoiceAndCredit invoiceAndCredit);
	
	int findCount(InvoiceAndCredit invoiceAndCredit);
	
	/**
	 * 批量审核
	 * */
	void verifyMulty(List<InvoiceAndCredit> listInvoiceAndCredit);
	
	List<AccountRow>	getAccountRow(AccountRecord accountRecord);
	List<AccountRow>    getBeginningVal(AccountRecord accountRecord);
	
	/**
	 * 获取分公司所有的汇总往来账统计信息
	 * @param accountRecord
	 * @return
	 */
	List<StasticAccount>	getStasticAccountList(AccountRecord accountRecord);
	List<StasticAccount>	getAllStasticAccountList(AccountRecord accountRecord);
	
	/**
	 * 查询出明细往来账
	 * @param accountRecord
	 * @return
	 */
	List<AccountRecord> searchAccount(AccountRecord accountRecord);
	
	/**
	 * 查处未录期初的部门
	 * 
	 */
	List<Dept> queryDeptForBegVal(String deptId);
	
	/**
	 * 导出时用来查询年总额
	 * @param accountRecord
	 * @return
	 */
	AccountRecord querySumYearly (AccountRecord accountRecord);
	
	/**
	 * 查询对账总额
	 */
	
	InvoiceAndCredit querySum(InvoiceAndCredit invoiceAndCredit);
	
}
