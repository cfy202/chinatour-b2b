package com.chinatour.vo;

import java.util.List;

import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.entity.HotelPriceInfo;
import com.chinatour.entity.InsurancePriceInfo;
import com.chinatour.entity.SupplierPriceInfo;
import com.chinatour.entity.SupplierPriceRemark;

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
public class SupplierOfAgentVO {
	
	private List<FlightPriceInfo> flightPriceInfoList;
	
	private List<InsurancePriceInfo> insurancePriceInfoList;
	
	private List<HotelPriceInfo> hotelPriceInfoList;
	
	private List<SupplierPriceInfo> supplierPriceInfoList;
	
	private List<SupplierPriceRemark> supplierPriceRemarkList;
}
