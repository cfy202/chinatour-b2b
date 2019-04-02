package com.chinatour.vo;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.PayCostRecords;

@Data
@EqualsAndHashCode(callSuper = false)
public class PayCostEditVO {
	
	private String orderId;
	
	private BigDecimal sumPay;
	
	private BigDecimal sumCost;
	
	private List<PayCostRecords> payRecordsList;
	
	private List<PayCostRecords> costRecordsList; 
}
