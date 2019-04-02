package com.chinatour.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.EuropeTourPrice;
import com.chinatour.entity.Order;
import com.chinatour.vo.TourOrderListVO;

public interface EuropeTourPriceService extends BaseService<EuropeTourPrice, String> {
	List<EuropeTourPrice> findByTourId(String tourId);
	void billInvoice(EuropeTourPrice europeTourPrice);
	List<EuropeTourPrice> find(EuropeTourPrice europeTourPrice);
	public Page<EuropeTourPrice> findForAgentPage(EuropeTourPrice europeTourPrice, Pageable pageable);
	int findForAgentPageCount(EuropeTourPrice europeTourPrice,Pageable pageable);
	public Page<EuropeTourPrice> findForAccOPPage(EuropeTourPrice europeTourPrice, Pageable pageable);
	public Page<EuropeTourPrice> findForOPAccPage(EuropeTourPrice europeTourPrice,Pageable pageable);
	int findForOPAccPageCount(EuropeTourPrice europeTourPrice,Pageable pageable);
	int findSumForAgent(String userIdForOrder);
	/**
	 * Team权限
	 * */
	public Page<EuropeTourPrice> findForGroupPage(EuropeTourPrice europeTourPrice, Pageable pageable);
}