package com.chinatour.vo;

import java.util.List;
import java.util.Set;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.Order;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.TourInfoForOrder;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 11, 2014 8:25:40 PM
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SingleOrdersVO {
	
	private String ordersTotalId;
	
	private String groupLineId;
	
	private Order order;
	
	private TourInfoForOrder tourInfoForOrder;
	
	private ReceivableInfoOfOrder receivableInfoOfOrder;
	
	private List<OrderReceiveItem> visaFeeList;
	
	private List<OrderReceiveItem> flightTicketFeeList;
	
	private List<OrderReceiveItem> hotelFeeList;
	
	private List<OrderReceiveItem> ticketFeeList;
	
	private List<OrderReceiveItem> insuranceFeeList;
	
	private List<OrderReceiveItem> otherFeeList;
	
	private List<OrderReceiveItem> busTourFeeList;
	
	private List<OrderReceiveItem> cruiseFeeList;
	
	private List<PayCostRecords> payRecordsList;
	
	private List<PayCostRecords> costRecordsList; 
	
	private Set<String> nonGroupTypeSet;
}
