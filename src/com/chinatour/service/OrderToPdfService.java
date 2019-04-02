package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.Customer;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.Invoice;
import com.chinatour.entity.Order;

/**
 * 
 * @author Andy
 *
 * @date
 */
public interface OrderToPdfService {
	String createPdf(Invoice invoice);
	
	/**
	 * op修改之后的invoice
	 * @param customers
	 * @return
	 */
	String createNewPdf(String itineraryInfoId,List<Hotel> hotel,String tourId,Order order );
	
	
	/**
	 * op修改之前的invoice
	 * @param customers
	 * @return
	 */
	String createOldPdf(String orderId);
	/**
	 * B2B修改之前的invoice
	 * @param customers
	 * @return
	 */
	String createBPdf(String orderId);
	
	String createB2BPdf(String groupLineId);
	
	String createBPdfforOpConfirm(String orderId);

	String createOldPdfOfOpConfirm(String orderId);
}
