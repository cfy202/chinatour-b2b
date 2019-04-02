package com.chinatour.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.EuropeTourPrice;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.InvoiceAndCreditItems;
import com.chinatour.entity.Order;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.persistence.AdminMapper;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.EuropeTourPriceMapper;
import com.chinatour.persistence.InvoiceAndCreditItemsMapper;
import com.chinatour.persistence.InvoiceAndCreditMapper;
import com.chinatour.persistence.RateOfCurrencyMapper;
import com.chinatour.service.EuropeTourPriceService;
import com.chinatour.util.UUIDGenerator;
@Service("europeTourPriceServiceImpl")
public class EuropeTourPriceServiceImpl extends BaseServiceImpl<EuropeTourPrice, String> implements EuropeTourPriceService {

	@Autowired
	private EuropeTourPriceMapper europeTourPriceMapper;
	@Autowired
	private AdminMapper adminMapper;
	@Autowired
	public void setBaseMapper(EuropeTourPriceMapper europeTourPriceMapper) {
	    	super.setBaseMapper(europeTourPriceMapper);
	}
	@Autowired
	private InvoiceAndCreditMapper invoiceAndCreditMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private InvoiceAndCreditItemsMapper invoiceAndCreditItemMapper;
	@Autowired
	private RateOfCurrencyMapper rateOfCurrencyMapper;
	@Override
	public List<EuropeTourPrice> findByTourId(String tourId) {
		return europeTourPriceMapper.findByTourId(tourId);
	}
	@Override
	public void billInvoice(EuropeTourPrice europeTourPrice) {
				RateOfCurrency rateOfCurrency = rateOfCurrencyMapper.findById(europeTourPrice.getRateOfCurrencyId());
				BigDecimal enterCurrency = new BigDecimal(0);
				Integer businessNo =invoiceAndCreditMapper.getBusinessNo(europeTourPrice.getDeptIdForTour());
				InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
				invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
				invoiceAndCredit.setIfBeginningValue(1);
				invoiceAndCredit.setDeptId(europeTourPrice.getDeptIdForTour());
				invoiceAndCredit.setPrefix(deptMapper.findById(europeTourPrice.getDeptIdForTour()).getDeptName());
				invoiceAndCredit.setBillToDeptId(europeTourPrice.getDeptIdForOrder());
				invoiceAndCredit.setBillToReceiver(deptMapper.findById(europeTourPrice.getDeptIdForOrder()).getDeptName());
				invoiceAndCredit.setBusinessNo(businessNo);
				invoiceAndCredit.setCreateDate(new Date());
				invoiceAndCredit.setMonth(new Date());
				invoiceAndCredit.setConfirmStatus("NEWAUTO");
				invoiceAndCredit.setTourCode(europeTourPrice.getTourCode());
				invoiceAndCredit.setTourId(europeTourPrice.getTourId());
				invoiceAndCredit.setRateOfCurrencyId(europeTourPrice.getRateOfCurrencyId());
				
				InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
				invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
				invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
				invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
				invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
				invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
				invoiceAndCreditItems.setIfBeginningValue(1);
				invoiceAndCreditItems.setAmount(europeTourPrice.getReceivableAmount());
				invoiceAndCreditItems.setDollarAmount(europeTourPrice.getReceivableAmount().divide(rateOfCurrency.getUsRate(),2));
				invoiceAndCreditItems.setRemarks(europeTourPrice.getOrderNo());
				invoiceAndCreditItems.setDescription(adminMapper.findById(europeTourPrice.getUserIdForOrder()).getUsername());
				enterCurrency = enterCurrency.add(europeTourPrice.getReceivableAmount());
				invoiceAndCreditItemMapper.save(invoiceAndCreditItems);
				
				if(enterCurrency.compareTo(new BigDecimal(0))>0||enterCurrency.compareTo(new BigDecimal(0))==0){
					invoiceAndCredit.setRecordType(Constant.INVOICE);
					invoiceAndCredit.setEnterCurrency(enterCurrency);
					invoiceAndCredit.setDollar(enterCurrency.divide(rateOfCurrency.getUsRate(),2));
				}else{
					invoiceAndCredit.setRecordType(Constant.CREDIT);
					invoiceAndCredit.setEnterCurrency(new BigDecimal(0).subtract(enterCurrency));
					invoiceAndCredit.setDollar(new BigDecimal(0).subtract(enterCurrency.divide(rateOfCurrency.getUsRate(),2)));
				}
				invoiceAndCreditMapper.save(invoiceAndCredit);
			}
	
	
	@Override
	public List<EuropeTourPrice> find(EuropeTourPrice europeTourPrice) {
		return europeTourPriceMapper.find(europeTourPrice);
	}
	@Override
	public Page<EuropeTourPrice> findForAgentPage(EuropeTourPrice europeTourPrice, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<EuropeTourPrice> page = europeTourPriceMapper.findForAgentPage(europeTourPrice, pageable);
        int pageCount = europeTourPriceMapper.findForAgentPageCount(europeTourPrice, pageable);
        return new Page<EuropeTourPrice>(page, pageCount, pageable);
	}
	@Override
	public Page<EuropeTourPrice> findForAccOPPage(
			EuropeTourPrice europeTourPrice, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<EuropeTourPrice> page = europeTourPriceMapper.findForAccOPPage(europeTourPrice, pageable);
        int pageCount = europeTourPriceMapper.findForAccOPPageCount(europeTourPrice, pageable);
        return new Page<EuropeTourPrice>(page, pageCount, pageable);
	}
	@Override
	public int findForAgentPageCount(EuropeTourPrice europeTourPrice,
			Pageable pageable) {
		return europeTourPriceMapper.findForAgentPageCount(europeTourPrice, pageable);
	}
	@Override
	public Page<EuropeTourPrice> findForOPAccPage(
			EuropeTourPrice europeTourPrice, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<EuropeTourPrice> page = europeTourPriceMapper.findForOPAccPage(europeTourPrice, pageable);
        int pageCount = europeTourPriceMapper.findForOPAccPageCount(europeTourPrice, pageable);
        return new Page<EuropeTourPrice>(page, pageCount, pageable);
	}
	@Override
	public int findForOPAccPageCount(EuropeTourPrice europeTourPrice,
			Pageable pageable) {
		return europeTourPriceMapper.findForOPAccPageCount(europeTourPrice, pageable);
	}
	@Override
	public int findSumForAgent(String userIdForOrder) {
		return europeTourPriceMapper.findSumForAgent(userIdForOrder);
	}
	@Override
	public Page<EuropeTourPrice> findForGroupPage(EuropeTourPrice europeTourPrice, Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<EuropeTourPrice> page = europeTourPriceMapper.findForGroupPage(europeTourPrice, pageable);
        int pageCount = europeTourPriceMapper.findForGroupPageCount(europeTourPrice, pageable);
        return new Page<EuropeTourPrice>(page, pageCount, pageable);
	}
}
