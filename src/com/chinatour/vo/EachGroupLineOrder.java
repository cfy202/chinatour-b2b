package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.TourInfoForOrder;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 28, 2014 1:11:40 PM
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class EachGroupLineOrder {
	
	private Order order;
	
	private TourInfoForOrder tourInfoForOrder;
	
	private ReceivableInfoOfOrder receivableInfoOfOrder;
	
	private List<List<CustomerFlight>> customerFlightList;
	
	private List<OrderReceiveItem> orderReceiveItemList;
	
	private List<OrderReceiveItem> otherFeeList;
	
	private List<OrderReceiveItem> discountList;
}
