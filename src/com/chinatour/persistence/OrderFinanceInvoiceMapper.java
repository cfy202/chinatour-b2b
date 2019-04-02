package com.chinatour.persistence;

import java.util.List;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderFinanceInvoice;

/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time Jan 30, 2015 9:48:04 AM
 * @revision  3.0
 */
@Repository
public interface OrderFinanceInvoiceMapper extends BaseMapper<OrderFinanceInvoice, String> {
	
	List<OrderFinanceInvoice> bookingPCStatistical(@Param("record")OrderFinanceInvoice orderFinanceInvoice);
	/*List<OrderFinanceInvoice> bookingPCStatistical(String userId);*/
}
