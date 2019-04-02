package com.chinatour.vo;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.EuropeTourPrice;
@Data
@EqualsAndHashCode(callSuper = false)
public class EuropeTourPriceVO {
	private List<EuropeTourPrice> europeTourPriceList;
	private BigDecimal actualCostForTour;
	private Integer isComplete;
	private String tourId;
}
