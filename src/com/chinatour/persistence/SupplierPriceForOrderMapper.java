package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.SupplierPriceForOrder;

@Repository
public interface SupplierPriceForOrderMapper extends BaseMapper<SupplierPriceForOrder, String> {

	List<SupplierPriceForOrder> airTicekExcle(
			@Param("record") SupplierPriceForOrder supplierPriceForOrder);

	SupplierPriceForOrder findAirPepole(
			SupplierPriceForOrder supplierPriceForOrder);

	List<SupplierPriceForOrder> findForStatisticalPage(
			@Param("record")SupplierPriceForOrder so, @Param("page")Pageable pageable);


	int findForStatisticalCount(@Param("record")SupplierPriceForOrder so, @Param("page")Pageable pageable);

	SupplierPriceForOrder findAirPepoleStatistical(SupplierPriceForOrder so);

	List<SupplierPriceForOrder> airTicekItemExcle(
			@Param("record") SupplierPriceForOrder supplierPriceForOrder);

	List<SupplierPriceForOrder> findForStatisticalPrint(@Param("record") SupplierPriceForOrder so);
	
	SupplierPriceForOrder findByInvoiceNo(String InvoiceNo);
	
	SupplierPriceForOrder findByInvoiceNum(String InvoiceNum);

}
