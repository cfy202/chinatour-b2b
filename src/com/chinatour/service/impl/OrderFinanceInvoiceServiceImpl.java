package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.chinatour.entity.OrderFinanceInvoice;
import com.chinatour.persistence.OrderFinanceInvoiceMapper;
import com.chinatour.service.OrderFinanceInvoiceService;

/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time Jan 30, 2015 9:48:04 AM
 * @revision  3.0
 */
@Service("orderFinanceInvoiceServiceImpl")
public class OrderFinanceInvoiceServiceImpl extends BaseServiceImpl<OrderFinanceInvoice, String> implements OrderFinanceInvoiceService{

	@Autowired
	private OrderFinanceInvoiceMapper orderFinanceInvoiceMapper;
	/**
	 * 根据用户，返回订单收入成本统计信息
	 * */
	@Override
	public List<OrderFinanceInvoice> bookingPCStatistical(OrderFinanceInvoice orderFinanceInvoice) {
		return orderFinanceInvoiceMapper.bookingPCStatistical(orderFinanceInvoice);
	}

	/*@Override
	public List<OrderFinanceInvoice> bookingPCStatistical(String userId) {
		return orderFinanceInvoiceMapper.bookingPCStatistical(userId);
	}*/
}
