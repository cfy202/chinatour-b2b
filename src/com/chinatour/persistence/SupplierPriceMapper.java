package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.Tour;

/**
 * Dao --团账单表
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:30:42
 * @revision 3.0
 */
@Repository
public interface SupplierPriceMapper extends BaseMapper<SupplierPrice, String> {

	List<Tour> findForPage(@Param("record")Tour tour, @Param("page") Pageable pageable);

	int findForPageCount(@Param("record")Tour tour, @Param("page") Pageable pageable);

	SupplierPrice findByTourId(String tourId);

	SupplierPrice findSumSupplierOfTourOfAcc(SupplierPrice supplierPrice);

	SupplierPrice findBillChangeSumSupplierOfTourOfAcc(
			SupplierPrice supplierPrice);

	List<SupplierPrice> findForAccPage(@Param("record")SupplierPrice supplierPrice,
			@Param("page")Pageable pageable);

	int findForAccPageCount(@Param("record")SupplierPrice supplierPrice, @Param("page")Pageable pageable);

	List<SupplierPrice> findForAgentPage(@Param("record")SupplierPrice supplierPrice,
			@Param("page")Pageable pageable);

	int findForAgentPageCount(@Param("record")SupplierPrice supplierPrice, @Param("page")Pageable pageable);
	
	List<SupplierPrice> queryOrderBillOfExplorAndDept(SupplierPrice supplierPrice);

	List<SupplierPrice> findUnCheckTour(SupplierPrice supplierPrice);

	List<SupplierPrice> findForAccGroupPage(@Param("record")SupplierPrice supplierPrice,
			@Param("page")Pageable pageable);

	int findForAccGroupPageCount(@Param("record")SupplierPrice supplierPrice, @Param("page")Pageable pageable);

	List<SupplierPrice> findBillOfExplor(SupplierPrice supplierPrice);

	List<SupplierPrice> findBillOfExplorFlight(SupplierPrice supplierPrice);

	List<SupplierPrice> findSupplierOfTourOfOp(SupplierPrice supplierPrice);

	List<SupplierPrice> findSupplierPriceRemarkDept(SupplierPrice supplierPrice);

	List<SupplierPrice> findSupplierPriceRemarkSupplierName(
			SupplierPrice supplierPrice);

	List<SupplierPrice> findBillOfTourAndAgent(SupplierPrice supplierPrice);
	
	int findCount(SupplierPrice supplierPrice);

	List<SupplierPrice> findCheckSupplierPriceTour();
	/**
	 * Team Agent账单
	 * */
	List<SupplierPrice> findForAgentGroupPage(@Param("record")SupplierPrice supplierPrice,@Param("page")Pageable pageable);
	int findForAgentGroupPageCount(@Param("record")SupplierPrice supplierPrice, @Param("page")Pageable pageable);
	
	/**OP Group录账单*/
	List<Tour> findForPageforGroup(@Param("record")Tour tour, @Param("page") Pageable pageable);

	int findForPage_sqlforGroupCount(@Param("record")Tour tour, @Param("page") Pageable pageable);

}