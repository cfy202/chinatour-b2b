package com.chinatour.service;

import com.chinatour.entity.InvoiceMail;


public interface SendMailService {
	public  void sender(InvoiceMail invoiceMail) throws Exception;
	
	//op 修改最终确认单
	public  void senderForOpConfirm(InvoiceMail invoiceMail) throws Exception;
	
	//机票部门Invoice
	public  void senderForAir(InvoiceMail invoiceMail) throws Exception;
}
