package com.chinatour.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.Tour;
import com.chinatour.service.SupplierPriceService;
import com.chinatour.persistence.SupplierPriceMapper;
/**
 * Service 团账单
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("supplierPriceServiceImpl")
public class SupplierPriceServiceImpl extends BaseServiceImpl<SupplierPrice, String> implements SupplierPriceService {

	@Autowired
	private SupplierPriceMapper supplierPriceMapper;

	@Autowired
	public void setBaseMapper(SupplierPriceMapper SupplierPriceMapper) {
	    	super.setBaseMapper(SupplierPriceMapper);
	}

	@Override
	public Page<Tour> findPage(Tour tour, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
		List<Tour> tourList = supplierPriceMapper.findForPage(tour, pageable);
		int pageCount = supplierPriceMapper.findForPageCount(tour, pageable);
		return new Page<Tour>(tourList,pageCount,pageable);
	}

	@Override
	public SupplierPrice findByTourId(String tourId) {
		return supplierPriceMapper.findByTourId(tourId);
	}

	@Override
	public List<SupplierPrice> find(SupplierPrice supplierPrice) {
		return supplierPriceMapper.find(supplierPrice);
	}
	
	/* (non-Javadoc)
	 * 查找未审核账单条数
	 */
	@Override
	public int findCount(SupplierPrice supplierPrice) {
		return supplierPriceMapper.findCount(supplierPrice);
	}

	@Override
	public SupplierPrice findSumSupplierOfTourOfAcc(SupplierPrice supplierPrice) {
		return supplierPriceMapper.findSumSupplierOfTourOfAcc(supplierPrice);
	}

	@Override
	public SupplierPrice findBillChangeSumSupplierOfTourOfAcc(
			SupplierPrice supplierPrice) {
		return supplierPriceMapper.findBillChangeSumSupplierOfTourOfAcc(supplierPrice);
	}

	@Override
	public Page<SupplierPrice> findAccPage(SupplierPrice supplierPrice,
			Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
		List<SupplierPrice> SupplierOfTourOfAccList = supplierPriceMapper.findForAccPage(supplierPrice, pageable);
		int pageCount = supplierPriceMapper.findForAccPageCount(supplierPrice, pageable);
		return new Page<SupplierPrice>(SupplierOfTourOfAccList,pageCount,pageable);
	}

	@Override
	public Page<SupplierPrice> findAgentPage(SupplierPrice supplierPrice,
			Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
		List<SupplierPrice> SupplierOfTourOfAccList = supplierPriceMapper.findForAgentPage(supplierPrice, pageable);
		int pageCount = supplierPriceMapper.findForAgentPageCount(supplierPrice, pageable);
		return new Page<SupplierPrice>(SupplierOfTourOfAccList,pageCount,pageable);
	}

	@Override
	public Page<SupplierPrice> findForAccGroupPage(SupplierPrice supplierPrice,
			Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
		List<SupplierPrice> SupplierOfTourOfAccList = supplierPriceMapper.findForAccGroupPage(supplierPrice, pageable);
		int pageCount = supplierPriceMapper.findForAccGroupPageCount(supplierPrice, pageable);
		return new Page<SupplierPrice>(SupplierOfTourOfAccList,pageCount,pageable);
	}

	@Override
	public List<SupplierPrice> findBillOfExplor(SupplierPrice supplierPrice) {
		return supplierPriceMapper.findBillOfExplor(supplierPrice);
	}

	@Override
	public List<SupplierPrice> findBillOfExplorFlight(
			SupplierPrice supplierPrice) {
		return supplierPriceMapper.findBillOfExplorFlight(supplierPrice);
	}

	@Override
	public List<SupplierPrice> findOrderBillOfExplorAndDept(
			SupplierPrice supplierPrice) {
		return supplierPriceMapper.queryOrderBillOfExplorAndDept(supplierPrice);
	}

	@Override
	public List<SupplierPrice> findSupplierOfTourOfOp(
			SupplierPrice supplierPrice) {
		return supplierPriceMapper.findSupplierOfTourOfOp(supplierPrice);
	}

	@Override
	public List<SupplierPrice> findSupplierPriceRemarkDept(
			SupplierPrice supplierPrice) {
		return supplierPriceMapper.findSupplierPriceRemarkDept(supplierPrice);
	}

	@Override
	public List<SupplierPrice> findSupplierPriceRemarkSupplierName(
			SupplierPrice supplierPrice) {
		return supplierPriceMapper.findSupplierPriceRemarkSupplierName(supplierPrice);
	}

	@Override
	public List<SupplierPrice> findBillOfTourAndAgent(
			SupplierPrice supplierPrice) {
		return supplierPriceMapper.findBillOfTourAndAgent(supplierPrice);
	}

	@Override
	public List<SupplierPrice> findCheckSupplierPriceTour() {
		return supplierPriceMapper.findCheckSupplierPriceTour();
	}

	@Override
	public Page<SupplierPrice> findForAgentGroupPage(
			SupplierPrice supplierPrice, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
		List<SupplierPrice> SupplierOfTourOfAgentList = supplierPriceMapper.findForAgentGroupPage(supplierPrice, pageable);
		int pageCount = supplierPriceMapper.findForAgentGroupPageCount(supplierPrice, pageable);
		return new Page<SupplierPrice>(SupplierOfTourOfAgentList,pageCount,pageable);
	}
	@Override
	public Page<Tour> findPageforGroup(Tour tour, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
		List<Tour> tourList = supplierPriceMapper.findForPageforGroup(tour, pageable);
		int pageCount = supplierPriceMapper.findForPage_sqlforGroupCount(tour, pageable);
		return new Page<Tour>(tourList,pageCount,pageable);
	}
}