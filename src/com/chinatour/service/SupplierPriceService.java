package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.Tour;

/**
 * Service 团账单
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午11:00:23
 * @revision 3.0
 */
public interface SupplierPriceService extends
		BaseService<SupplierPrice, String> {

	Page<Tour> findPage(Tour tour, Pageable pageable);

	SupplierPrice findByTourId(String tourId);

	List<SupplierPrice> find(SupplierPrice supplierPrice);

	SupplierPrice findSumSupplierOfTourOfAcc(SupplierPrice supplierPrice);

	SupplierPrice findBillChangeSumSupplierOfTourOfAcc(
			SupplierPrice supplierPrice);

	Page<SupplierPrice> findAccPage(SupplierPrice supplierPrice,
			Pageable pageable);
	
	Page<SupplierPrice> findAgentPage(SupplierPrice supplierPrice,
			Pageable pageable);

	Page<SupplierPrice> findForAccGroupPage(SupplierPrice supplierPrice,
			Pageable pageable);

	List<SupplierPrice> findBillOfExplor(SupplierPrice supplierPrice);

	List<SupplierPrice> findBillOfExplorFlight(SupplierPrice supplierPrice);

	List<SupplierPrice> findOrderBillOfExplorAndDept(SupplierPrice supplierPrice);

	List<SupplierPrice> findSupplierOfTourOfOp(SupplierPrice supplierPrice);

	List<SupplierPrice> findSupplierPriceRemarkDept(SupplierPrice supplierPrice);
    List<SupplierPrice> findSupplierPriceRemarkSupplierName(
			SupplierPrice supplierPrice);

	List<SupplierPrice> findBillOfTourAndAgent(SupplierPrice supplierPriceS);
	
	/* (non-Javadoc)
	 * 查找未审核账单条数
	 */
	int findCount(SupplierPrice supplierPrice);

	List<SupplierPrice> findCheckSupplierPriceTour();
	/**
     * 账单（Agent Team）
     * */
	Page<SupplierPrice> findForAgentGroupPage(SupplierPrice supplierPrice,Pageable pageable);
	/**Group OP录账单*/
	Page<Tour> findPageforGroup(Tour tour, Pageable pageable);
}
