/**
 * 
 */
package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.InvoiceAndCreditItems;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-11 下午7:02:53
 * @revision  3.0
 */
@Repository
public interface InvoiceAndCreditItemsMapper extends BaseMapper<InvoiceAndCreditItems, String>{
		
	/**
	 * 根据invoiceAndCreditId查找
	 * */
	List<InvoiceAndCreditItems> queryByInvoiceAndCreditId(String invoiceAndCreditId);
}
