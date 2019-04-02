package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.OrderFinanceInvoice;

/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time Jan 30, 2015 9:48:04 AM
 * @revision  3.0
 */
public interface OrderFinanceInvoiceService extends BaseService<OrderFinanceInvoice, String> {
	/**
	 * 根据用户，返回订单收入成本统计信息
	 * */
	public List<OrderFinanceInvoice> bookingPCStatistical(OrderFinanceInvoice orderFinanceInvoice);
	/*public List<OrderFinanceInvoice> bookingPCStatistical(String userId);*/
}
