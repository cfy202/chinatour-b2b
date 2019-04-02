package com.chinatour.vo;

import java.util.HashSet;
import java.util.List;

import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.entity.HotelPriceInfo;
import com.chinatour.entity.InsurancePriceInfo;
import com.chinatour.entity.Order;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPriceInfo;
import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.entity.Tour;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * Agent团账单   供应商vo
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-24 下午3:15:07
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SettlementTotalVO {
	
	//收入支出集合
	private List<PayCostRecords> payCostRecordsList;
	
	// 账单变更单页面数据
	private List<SupplierPriceRemark> supplierPriceRemarkList;
	
	// 自组订单数
	private List<Order> orderList;
	
	//op用户id
	private HashSet<String> opUserIdStrings;
	
	//op组团订单号
	private HashSet<String> tourIdStrings;
	//订单
	private Order order;
	
	//团
	private Tour tour;
	
	//订单集合  （页面显示 订单号 团号）
	private List<Order> ordList;
	
	// 自组订单LIST 集合
	private List<Order> singleOrdersList;
	
	//汇率
	private SupplierCheck supplierCheck;
}
