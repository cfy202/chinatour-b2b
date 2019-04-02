package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.vo.SettlementTotalVO;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 17, 2014 3:35:25 PM
 * @revision  3.0
 */
public interface PayCostRecordsService extends BaseService<PayCostRecords, String> {

	List<PayCostRecords> find(PayCostRecords payCostRecords);

	SettlementTotalVO settlementOrdersTotal(OrdersTotal ordersTotal);

	Page<PayCostRecords> findForGroupPage(PayCostRecords payCostRecords,
			Pageable pageable);
	public SettlementTotalVO chackFeeByTourId(Order order);
	
	Page<PayCostRecords> findCostForPage(PayCostRecords payCostRecords,
			Pageable pageable);

	public List<PayCostRecords> findPayOrCostByOrders(PayCostRecords payCostRecords);
}
