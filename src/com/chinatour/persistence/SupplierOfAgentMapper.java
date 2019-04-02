package com.chinatour.persistence;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.SupplierOfAgent;

/**
 * Dao--Agent团账单供应商
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:13:04
 * @revision 3.0
 */
@Repository
public interface SupplierOfAgentMapper extends
		BaseMapper<SupplierOfAgent, String> {


	SupplierOfAgent findSumUSARateOfAgentAndTour(
			SupplierOfAgent supplierOfAgentS);

	BigDecimal findSumOfAgentAndTourExceptInsurance(SupplierOfAgent supplierOfAgentS);

	BigDecimal findInsuranceTotalFeeOfAgentAndTour(
			SupplierOfAgent supplierOfAgentS);

	BigDecimal findSumOfAgentAndTour(SupplierOfAgent supplierOfAgentS);
	
	SupplierOfAgent querySumAndRateOfAgentAndTour(SupplierOfAgent supplierOfAgent);

	void batchSave(List<SupplierOfAgent> supplierOfAgentList);

}