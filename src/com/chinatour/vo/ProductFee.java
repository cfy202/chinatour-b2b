package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.ReceivableInfoOfOrder;

@Data
@EqualsAndHashCode
public class ProductFee {
	
	private OrderReceiveItem adultItem; //大人应收款项
	
	private OrderReceiveItem childrenItem; //小孩应收款项
	
	private ReceivableInfoOfOrder receivableInfoOfOrder; //
	
	private List<OrderReceiveItem> otherFeeList; // 其他费用
	
	private List<OrderReceiveItem> discountList; // 折扣
	
}
