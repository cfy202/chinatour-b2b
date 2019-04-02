/*package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.Company;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.vo.ProductVO;
import com.chinatour.vo.SingleOrdersVO;
import com.intuit.ipp.services.DataService;


public interface DataFactoryService {
	public DataService getDataService(Company domainCompany);
	
	*//**
	 * 向财务系统生成invoice
	 *//*
	
	String getInvoice(InvoiceAndCredit invoiceAndCredit);
	
	*//**
	 * 将分公司视为customer
	 * @param invoiceAndCredit
	 * @return
	 *//*
	String createInvoice(InvoiceAndCredit invoiceAndCredit);
	
	*//**
	 * 收入支出审核进入财务系统
	 * @param pay
	 * @return
	 *//*
	Boolean orderToAccData(PayCostRecords pay);
	
	*//**
	 * 下单成功之后向qb中插入一条invoice
	 * @param 团order
	 * @return
	 *//*
	Boolean saveOrderToAccData(ProductVO productVO);
	
	*//**
	 * op组团之后对invoice的class进行修改
	 * @param orderIds
	 * @return
	 *//*
	Boolean updateClass(String orderIds);
	
	
	*//**
	 * 非团订单下单之后进入财务系统
	 * @param singleOrdersVO
	 * @return
	 *//*
	public Boolean saveSingleOrderToAccData(SingleOrdersVO singleOrdersVO);
	
	public Boolean updateTourOrderInfo(ProductVO productVO);
	
	public Boolean updateSingleOrderInfo(SingleOrdersVO singleOrdersVO);
	
	*//**
	 * 机票部门数据进入qb
	 * @return
	 *//*
	public Boolean airTicToQb(List<SupplierPriceForOrder> supplierPriceForOrderList);
	
}
*/