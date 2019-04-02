package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.EuropeCustomerFee;
import com.chinatour.entity.EuropeTourPrice;

@Data
@EqualsAndHashCode(callSuper = false)
public class EuropeCustomerFeeVO {
	private List<EuropeCustomerFee> europeCustomerFeeList ;
	private EuropeTourPrice europeTourPrice;
	
}
