package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.persistence.SupplierPriceForOrderMapper;
import com.chinatour.service.SupplierPriceForOrderService;
@Service("supplierPriceForOrderServiceImpl")
public class SupplierPriceForOrderServiceImpl extends BaseServiceImpl<SupplierPriceForOrder, String> implements SupplierPriceForOrderService {
	@Autowired
	private SupplierPriceForOrderMapper supplierPriceForOrderMapper;
	
	@Autowired
	public void setAccountInfoMapper(SupplierPriceForOrderMapper supplierPriceForOrderMapper){
		this.setBaseMapper(supplierPriceForOrderMapper);
	}

	@Override
	public List<SupplierPriceForOrder> airTicekExcle(
			SupplierPriceForOrder supplierPriceForOrder) {
		return supplierPriceForOrderMapper.airTicekExcle(supplierPriceForOrder);
	}

	@Override
	public SupplierPriceForOrder findAirPepole(
			SupplierPriceForOrder supplierPriceForOrder) {
		return supplierPriceForOrderMapper.findAirPepole(supplierPriceForOrder);
	}

	@Override
	public List<SupplierPriceForOrder> airTicekItemExcle(
			SupplierPriceForOrder supplierPriceForOrder) {
		return supplierPriceForOrderMapper.airTicekItemExcle(supplierPriceForOrder);
	}

	@Override
	public SupplierPriceForOrder findByInvoiceNo(String invoiceNo) {
		return supplierPriceForOrderMapper.findByInvoiceNo(invoiceNo);
	}

	@Override
	public SupplierPriceForOrder findByInvoiceNum(String InvoiceNum) {
		return supplierPriceForOrderMapper.findByInvoiceNum(InvoiceNum);
	}
}
