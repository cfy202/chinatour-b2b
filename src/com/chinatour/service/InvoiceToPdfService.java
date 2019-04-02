package com.chinatour.service;

import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;

public interface InvoiceToPdfService {
	//总单确认单
	String createInvoicePdf(String orderId,String logo);
	
	//子单确认单
	String createInvoicePdfForChild(String ordersTotalId);
	
	String CreateInvoicePdfForTicket(String id);
	
	//给自组订单的invoice
	public String createInvoiceForSelf(String ordersTotalId,String logo);
	
	//自组子单
	public String createSelfInvoicePdfForChild(String orderId);
	
	//同行订单invoice
	String createInvoicePdfForVender(String orderId);
	//B2B Invoice(总单)
	String createInvoicePdfB(String orderId,String logo);

	String CreateInvoicePdfForRevise(String orderId,Order order,OrdersTotal ordersTotal);
	
	String CreateInvoicePdfForReviseWholeSale(String orderId);
	
}
