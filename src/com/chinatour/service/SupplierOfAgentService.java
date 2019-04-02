package com.chinatour.service;

import java.math.BigDecimal;
import java.util.List;

import com.chinatour.entity.SupplierOfAgent;



/**
 * Service Agent团账单供应商
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-23 下午3:53:26
 * @revision 3.0
 */
public interface SupplierOfAgentService extends
		BaseService<SupplierOfAgent, String> {

	List<SupplierOfAgent> find(SupplierOfAgent supplierOfAgent);

	BigDecimal findSumOfAgentAndTourExceptInsurance(SupplierOfAgent supplierOfAgentS);

	SupplierOfAgent findSumUSARateOfAgentAndTour(
			SupplierOfAgent supplierOfAgentS);

	BigDecimal findInsuranceTotalFeeOfAgentAndTour(
			SupplierOfAgent supplierOfAgentS);

	BigDecimal findSumOfAgentAndTour(SupplierOfAgent supplierOfAgentS);


}
