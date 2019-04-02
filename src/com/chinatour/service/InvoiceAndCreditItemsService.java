/**
 * 
 */
package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.InvoiceAndCreditItems;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-11 下午6:46:25
 * @revision  3.0
 */

public interface InvoiceAndCreditItemsService extends BaseService<InvoiceAndCreditItems, String>{
	/**
	 * 根据invoiceAndCreditId查找
	 * */
	List<InvoiceAndCreditItems> queryByInvoiceAndCreditId(String invoiceAndCreditId);
}
