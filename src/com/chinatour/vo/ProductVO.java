package com.chinatour.vo;

import java.math.BigDecimal;
import java.util.List;


import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Discount;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderAgencyRemark;
import com.chinatour.entity.OrderFeeItems;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.OrderRemark;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.TourInfoForOrder;
import com.fasterxml.jackson.annotation.JsonProperty;

@Data
@EqualsAndHashCode
public class ProductVO {
	
	private String ordersTotalId; //总订单ID(新加产品时) 订单ID(修改产品时)
	
	private Order order; //子订单信息
	
	private OrdersTotal ordersTotal; //总订单信息
	
	private GroupLine groupLine; //订单修改传输产品信息
	
	private TourInfoForOrder tourInfoForOrder; //产品信息
	
	private List<CustomerOrderRel> customerFlights; //客人航班信息
	
	private OrderReceiveItem adultItem; //大人应收款项
	
	private OrderReceiveItem childrenItem; //小孩应收款项
	
	private ReceivableInfoOfOrder receivableInfoOfOrder; //
	
	private List<OrderReceiveItem> otherFeeList; // 其他费用
	
	private List<OrderReceiveItem> discountList; // 折扣
	
	private OrderRemark orderRemark; //订单修改记录
	
	private int isSelfOrganize; //编辑子订单时传递参数，是否自组
	
	private Integer newState;//OP通知字段
	
	private Integer warnState;//财务通知字段
	
	private String preInfoList;//提前续住酒店的数组集合
	
	private String postInfoList;//续住酒店的数组集合

	private BigDecimal price;//订单页面合计
	
	private Discount discount;//折扣

	private OrderAgencyRemark orderAgencyRemark; //同行订单修改记录
	
	private String feeItems;//费用Json信息

	@JsonProperty
	private List<Customer> customer;
	private List<CustomerOrderRel> rel;
	
	private List<OrderFeeItems> orderFeeItems;//B2B费用详情
	
	
}
