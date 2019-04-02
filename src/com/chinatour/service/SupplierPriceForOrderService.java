package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.entity.SupplierPriceForOrder;

public interface SupplierPriceForOrderService extends BaseService<SupplierPriceForOrder, String> {

	List<SupplierPriceForOrder> airTicekExcle(
			SupplierPriceForOrder supplierPriceForOrder);

	SupplierPriceForOrder findAirPepole(
			SupplierPriceForOrder supplierPriceForOrder);

	List<SupplierPriceForOrder> airTicekItemExcle(
			SupplierPriceForOrder supplierPriceForOrder);
	//机票账单重复提示
	SupplierPriceForOrder findByInvoiceNo(String invoiceNo);
	/** 机票账单生成Invoice，FindByInvoiceNum */
	SupplierPriceForOrder findByInvoiceNum(String InvoiceNum);

}
