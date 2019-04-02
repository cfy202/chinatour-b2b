/**
 * 
 */
package com.chinatour.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.InvoiceAndCreditItems;
import com.chinatour.persistence.InvoiceAndCreditItemsMapper;
import com.chinatour.service.InvoiceAndCreditItemsService;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-11 下午6:52:53
 * @revision  3.0
 */
@Service("invoiceAndCreditItemsServiceImpl")
public class InvoiceAndCreditItemsServiceImpl extends BaseServiceImpl<InvoiceAndCreditItems, String> implements InvoiceAndCreditItemsService {
	@Autowired
	private InvoiceAndCreditItemsMapper invoiceAndCreditItemsMapper;
	@Autowired
	public void setInvoiceAndCreditItemsMapper(InvoiceAndCreditItemsMapper invoiceAndCreditItemsMapper){
		this.setBaseMapper(invoiceAndCreditItemsMapper);
	}
	
	/**
	 * 根据invoiceAndCreditId查找
	 * */
	@Override
	@Transactional
	public List<InvoiceAndCreditItems> queryByInvoiceAndCreditId(
			String invoiceAndCreditId) {
		
		return invoiceAndCreditItemsMapper.queryByInvoiceAndCreditId(invoiceAndCreditId);
	}
}
