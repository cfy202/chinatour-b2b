package com.chinatour.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.hsqldb.User;

import com.chinatour.entity.Admin;
import com.chinatour.entity.Dept;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.SupplierPriceRemark;

/**
 * Service 账单审核
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午11:00:23
 * @revision 3.0
 */
public interface SupplierCheckService extends
		BaseService<SupplierCheck, String> {

	List<SupplierCheck> find(SupplierCheck supplierCheckS);
	
	//按部门分类
	List<SupplierCheck> queryOfDept(SupplierCheck supplierCheck);
	
	List<SupplierCheck> findCheckAndTaxOfOrder(SupplierCheck supplierCheck);

	List<SupplierCheck> findUserInfo(SupplierCheck supplierCheck);
	
	/* (non-Javadoc)
	 * 查找未审核账单条数
	 */
	int findCount(SupplierCheck supplierCheck);
	
	/**
	 * agent 全部审核完成发invoice(账单)
	 * @param user
	 * @param supplierPrice
	 * @param supplierCheckList
	 */
	public  void billInvoice(Admin user, SupplierPrice supplierPrice, List<SupplierCheck> supplierCheckList);
	
	/**
	 * agent 全部审核完成发invoice(变更单)
	 * @param user
	 * @param tourId
	 * @param supplierPriceRemarkList
	 */
	public  void billCheckInvoice(Admin user,String tourId, List<SupplierPriceRemark> supplierPriceRemarkList);
	
	public  boolean billInvoice( Dept dept,Dept toDept,String retaOfCurrencyId,BigDecimal sum,BigDecimal dollarPrice,String agentName,String invoiceNo,Date date);
	
	
}
