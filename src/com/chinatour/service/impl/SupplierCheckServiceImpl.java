package com.chinatour.service.impl;



import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Constant;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Dept;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.InvoiceAndCreditItems;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierOfAgent;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.entity.Tour;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.InvoiceAndCreditItemsMapper;
import com.chinatour.persistence.InvoiceAndCreditMapper;
import com.chinatour.persistence.RateOfCurrencyMapper;
import com.chinatour.persistence.SupplierCheckMapper;
import com.chinatour.persistence.SupplierOfAgentMapper;
import com.chinatour.persistence.SupplierPriceMapper;
import com.chinatour.persistence.SupplierPriceRemarkMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.SupplierCheckService;
import com.chinatour.util.FormatUtil;
import com.chinatour.util.UUIDGenerator;
/**
 * Service 团账单
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision  3.0
 */

@Service("supplierCheckServiceImpl")
public class SupplierCheckServiceImpl extends BaseServiceImpl<SupplierCheck, String> implements SupplierCheckService {

	@Autowired
	private SupplierCheckMapper supplierCheckMapper;
	
	@Autowired
	private DeptMapper deptMapper;
	
	@Autowired
	private InvoiceAndCreditMapper invoiceAndCreditMapper;
	
	@Autowired
	private RateOfCurrencyMapper rateOfCurrencyMapper;
	
	@Autowired
	private SupplierOfAgentMapper supplierOfAgentMapper;
	
	@Autowired
	private InvoiceAndCreditItemsMapper invoiceAndCreditItemsMapper;
	
	@Autowired
	private SupplierPriceMapper supplierPriceMapper;
	
	@Autowired
	private SupplierPriceRemarkMapper supplierPriceRemarkMapper;
	
	@Autowired
	private TourMapper tourMapper;
	
	
	@Autowired
	private AdminService adminService;

	@Autowired
	public void setBaseMapper(SupplierCheckMapper supplierCheckMapper) {
	    	super.setBaseMapper(supplierCheckMapper);
	}

	@Override
	public List<SupplierCheck> find(SupplierCheck supplierCheckS) {
		return supplierCheckMapper.find(supplierCheckS);
	}

	@Override
	public List<SupplierCheck> findCheckAndTaxOfOrder(
			SupplierCheck supplierCheck) {
		return supplierCheckMapper.findCheckAndTaxOfOrder(supplierCheck);
	}

	@Override
	public List<SupplierCheck> findUserInfo(SupplierCheck supplierCheck) {
		return supplierCheckMapper.findUserInfo(supplierCheck);
	}

	/* (non-Javadoc)
	 * 查找未审核账单条数
	 */
	@Override
	public int findCount(SupplierCheck supplierCheck) {
		return supplierCheckMapper.findCount(supplierCheck);
	}

	@Override
	public void billInvoice(Admin user, SupplierPrice supplierPrice,
			List<SupplierCheck> supplierCheckList) {
	synchronized (this){
		Admin userAcc = adminService.findById(supplierPrice.getCheckUserId());  //审核该账单的op的财务
		Dept dept = deptMapper.findById(userAcc.getDeptId());
		/*Calendar calendar   =   new   GregorianCalendar(); 
	    calendar.setTime(supplierPrice.getArriveDateTime());
	    calendar.add(Calendar.MONTH, +1); */
	    //将agent按部门分类
	   
	   
		for(SupplierCheck item:supplierCheckList){
			InvoiceAndCredit invoiceAndCreditTemp = new InvoiceAndCredit();
			invoiceAndCreditTemp.setDeptId(userAcc.getDeptId());
			Integer businessNo =invoiceAndCreditMapper.getBusinessNo(invoiceAndCreditTemp.getDeptId());
			Admin userTemp=adminService.findById(item.getUserIdOfAgent());
			Dept deptTemp = deptMapper.findById(userTemp.getDeptId());
			if(!userTemp.getDeptId().equals(userAcc.getDeptId())){
				InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
				invoiceAndCredit.setDeptId(userAcc.getDeptId());
				invoiceAndCredit.setPrefix(dept.getDeptName());
				invoiceAndCredit.setBusinessNo(businessNo);
				invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
				invoiceAndCredit.setCreateDate(new Date());
				invoiceAndCredit.setMonth(new Date());
				invoiceAndCredit.setBillToDeptId(userTemp.getDeptId());
				invoiceAndCredit.setBillToReceiver(deptTemp.getDeptName());
				invoiceAndCredit.setConfirmStatus("NEWAUTO");
				invoiceAndCredit.setTourCode(supplierPrice.getTourCode());
				invoiceAndCredit.setTourId(supplierPrice.getTourId());
				Tour tour = tourMapper.findById(supplierPrice.getTourId());
				invoiceAndCredit.setArriveDateTime(tour.getArriveDateTime());
				invoiceAndCredit.setIfBeginningValue(1);
				invoiceAndCredit.setEmailTo(userAcc.getEmail());
				invoiceAndCredit.setRemarks(FormatUtil.getMonth(supplierPrice.getArriveDateTime()).substring(4)+Constant.TOURFEEFORMONTH);
				invoiceAndCredit.setRateOfCurrencyId(item.getRateOfCurrencyId());
				
				SupplierPrice supplierPriceTemp = new SupplierPrice();
				supplierPriceTemp.setTourId(supplierPrice.getTourId());
				//supplierOfAgentTemp.setDeptId(item.getDeptId());
				supplierPriceTemp.setToDeptId(adminService.findById(item.getUserIdOfAgent()).getDeptId());
				
				Boolean flag = new Boolean(true);
				BigDecimal sum = new BigDecimal(0);
				List<SupplierPrice> supplierPriceList = supplierPriceMapper.queryOrderBillOfExplorAndDept(supplierPriceTemp);
				if(supplierPriceList!=null&&supplierPriceList.size()!=0){
					supplierPriceTemp = supplierPriceList.get(0);
				}
				 sum = supplierPriceTemp.getSupplierPrice();
				if(sum.compareTo(new BigDecimal(0))>0||sum.compareTo(new BigDecimal(0))==0){
					invoiceAndCredit.setRecordType(Constant.INVOICE);
					invoiceAndCredit.setEnterCurrency(sum);
					invoiceAndCredit.setDollar(supplierPriceTemp.getSupplierUSAPrice());
				}else{
					invoiceAndCredit.setRecordType(Constant.CREDIT);
					invoiceAndCredit.setEnterCurrency(new BigDecimal(0).subtract(sum));
					invoiceAndCredit.setDollar(new BigDecimal(0).subtract(supplierPriceTemp.getSupplierUSAPrice()));
					flag=false;
				}
				
				SupplierCheck supCheck = new SupplierCheck();
				List<SupplierCheck> supCheckList = new ArrayList<SupplierCheck>();
				supCheck.setSupplierPriceId(supplierPrice.getSupplierPriceId());//查询该部门对应的所有Agent账单明细
				supCheck.setDeptId(item.getDeptId());
				//supCheck.setUserIdOfAgent(item.getUserIdOfAgent());
				supCheckList = supplierCheckMapper.findAgentForDept(supCheck);
				for(SupplierCheck item2:supCheckList){
					
					SupplierOfAgent supplierOfAgentTemp = new SupplierOfAgent();
					supplierOfAgentTemp.setTourId(supplierPrice.getTourId());
					supplierOfAgentTemp.setDeptId(item2.getDeptId());
					supplierOfAgentTemp.setUserId(item2.getUserIdOfAgent());
					
					InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
					invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
					invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
					invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
					invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
					invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
					invoiceAndCreditItems.setIfBeginningValue(1);
					
					supplierOfAgentTemp = supplierOfAgentMapper.querySumAndRateOfAgentAndTour(supplierOfAgentTemp);
					BigDecimal Dollar = supplierOfAgentTemp.getSum();
					if(flag){
						invoiceAndCreditItems.setAmount(supplierOfAgentTemp.getTotal());
						invoiceAndCreditItems.setDollarAmount(Dollar);
					}else{
						invoiceAndCreditItems.setAmount(new BigDecimal(0).subtract(supplierOfAgentTemp.getTotal()));
						invoiceAndCreditItems.setDollarAmount(new BigDecimal(0).subtract(Dollar));
					}
					
					invoiceAndCreditItems.setRemarks(Constant.TOURFEE);
					invoiceAndCreditItems.setDescription(item2.getUserNameOfAgent());
					List<InvoiceAndCreditItems> listInvoiceAndCreditItems = invoiceAndCredit.getListInvoiceAndCreditItems();
					if(listInvoiceAndCreditItems==null){
						listInvoiceAndCreditItems = new ArrayList<InvoiceAndCreditItems>();
						listInvoiceAndCreditItems.add(invoiceAndCreditItems);
						invoiceAndCredit.setListInvoiceAndCreditItems(listInvoiceAndCreditItems);
					}else{
						listInvoiceAndCreditItems.add(invoiceAndCreditItems);
						invoiceAndCredit.setListInvoiceAndCreditItems(listInvoiceAndCreditItems);
					}
					
					}
				if(invoiceAndCredit.getListInvoiceAndCreditItems()!=null){
					for(InvoiceAndCreditItems invoiceItem:invoiceAndCredit.getListInvoiceAndCreditItems()){
						invoiceAndCreditItemsMapper.save(invoiceItem);
					}
				}
				invoiceAndCreditMapper.save(invoiceAndCredit);
			}
		}
	  }
	}

	@Override
	public void billCheckInvoice(Admin op, String tourId,
			List<SupplierPriceRemark> supplierPriceRemarkList) {
		SupplierPrice supplierPrice = new SupplierPrice();
		supplierPrice.setTourId(tourId);
		supplierPrice=supplierPriceMapper.findByTourId(tourId);
		
		for(SupplierPriceRemark item:supplierPriceRemarkList){
			//获取该变更对应的op
			if(item.getSupplierPriceRemarkId()!=null){
				item = supplierPriceRemarkMapper.findById(item.getSupplierPriceRemarkId());
				SupplierCheck supplierCheck = supplierCheckMapper.findById(item.getSupplierCheckId());
				Admin agent = adminService.findById(supplierCheck.getUserIdOfAgent());
				Dept dept = deptMapper.findById(op.getDeptId());
				if(!op.getDeptId().equals(agent.getDeptId())){
					Dept toDept = deptMapper.findById(agent.getDeptId());
					InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
					invoiceAndCredit.setDeptId(op.getDeptId());
					invoiceAndCredit.setPrefix(dept.getDeptName());
					Integer businessNo = invoiceAndCreditMapper.getBusinessNo(op.getDeptId());
					invoiceAndCredit.setBusinessNo(businessNo);
					invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
					invoiceAndCredit.setCreateDate(new Date());
					invoiceAndCredit.setMonth(item.getInsertTime());
					
					invoiceAndCredit.setBillToDeptId(agent.getDeptId());
					invoiceAndCredit.setBillToReceiver(toDept.getDeptName());
					invoiceAndCredit.setConfirmStatus("NEWAUTO");
					invoiceAndCredit.setTourCode(supplierPrice.getTourCode());
					invoiceAndCredit.setTourId(supplierPrice.getTourId());
					invoiceAndCredit.setIfBeginningValue(1);
					invoiceAndCredit.setEmailTo(agent.getEmail());
					invoiceAndCredit.setRemarks(agent.getUsername()+Constant.EXCHANGEOFBILL);
					List<InvoiceAndCreditItems> listInvoiceAndCreditItems = invoiceAndCredit.getListInvoiceAndCreditItems();
					RateOfCurrency rateOfCurrency = rateOfCurrencyMapper.findById(supplierCheck.getRateOfCurrencyId());
					invoiceAndCredit.setRateOfCurrencyId(supplierCheck.getRateOfCurrencyId());
					
					
					Boolean flag = new Boolean(true);
					BigDecimal sum = new BigDecimal(0);
					sum = item.getDifferenceSum();
					if(sum.compareTo(new BigDecimal(0))>0||sum.compareTo(new BigDecimal(0))==0){
						invoiceAndCredit.setRecordType(Constant.INVOICE);
						invoiceAndCredit.setEnterCurrency(sum);
					}else{
						invoiceAndCredit.setRecordType(Constant.CREDIT);
						invoiceAndCredit.setEnterCurrency(new BigDecimal(0).subtract(sum));
						flag=false;
					}
					InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
					invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
					invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
					invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
					invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
					invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
					invoiceAndCreditItems.setIfBeginningValue(1);
					
					if(flag){
						invoiceAndCreditItems.setAmount(sum);
					}else{
						invoiceAndCreditItems.setAmount(new BigDecimal(0).subtract(sum));
					}
					
					invoiceAndCreditItems.setDollarAmount(invoiceAndCreditItems.getAmount().divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));
					invoiceAndCreditItems.setRemarks(Constant.EXCHANGEITEMSOFREMARKS+ item.getUserName());
					invoiceAndCreditItems.setDescription(Constant.EXCHANGEITEMSOFDESCREPTION);
					if(listInvoiceAndCreditItems==null){
						
						listInvoiceAndCreditItems = new ArrayList<InvoiceAndCreditItems>();
						listInvoiceAndCreditItems.add(invoiceAndCreditItems);
					}else{
						listInvoiceAndCreditItems.add(invoiceAndCreditItems);
					}
					
				
					invoiceAndCredit.setDollar(invoiceAndCredit.getEnterCurrency().divide(rateOfCurrency.getUsRate(), 2, BigDecimal.ROUND_HALF_UP));
					invoiceAndCredit.setListInvoiceAndCreditItems(listInvoiceAndCreditItems);
					invoiceAndCreditMapper.save(invoiceAndCredit);
					
					for(InvoiceAndCreditItems invoiceItem:invoiceAndCredit.getListInvoiceAndCreditItems()){
						invoiceAndCreditItemsMapper.save(invoiceItem);
					}
				}
				item.setInvoiceState(1);
				//supplierPrice.setInvoiceState(1);
				//supplierPriceMapper.update(supplierPrice);
				supplierPriceRemarkMapper.update(item);
			} 
		}
	}

	@Override
	public List<SupplierCheck> queryOfDept(SupplierCheck supplierCheck) {
		return supplierCheckMapper.queryOfDept(supplierCheck);
	}
	@Override
	public boolean billInvoice( Dept dept,Dept toDept,String retaOfCurrencyId,BigDecimal sum,BigDecimal dollarPrice,String agentName,String invoiceNo,Date date) {
		synchronized (this){
	    //将agent按部门分类
			if(!dept.getDeptId().equals(toDept.getDeptId())){
				Integer businessNo =invoiceAndCreditMapper.getBusinessNo(dept.getDeptId());
				InvoiceAndCredit invoiceAndCredit = new InvoiceAndCredit();
				invoiceAndCredit.setDeptId(dept.getDeptId());
				invoiceAndCredit.setPrefix(dept.getDeptName());
				invoiceAndCredit.setBusinessNo(businessNo);
				invoiceAndCredit.setInvoiceAndCreditId(UUIDGenerator.getUUID());
				invoiceAndCredit.setCreateDate(new Date());
				invoiceAndCredit.setMonth(date);
				
				invoiceAndCredit.setBillToDeptId(toDept.getDeptId());
				invoiceAndCredit.setBillToReceiver(toDept.getDeptName());
				invoiceAndCredit.setConfirmStatus("NEWAUTO");
			//			invoiceAndCredit.setTourCode(invoiceNo);
		//				invoiceAndCredit.setTourId(supplierPrice.getTourId());
				invoiceAndCredit.setIfBeginningValue(1);
		//				invoiceAndCredit.setEmailTo(userAcc.getEmail());
				invoiceAndCredit.setRemarks(invoiceNo+Constant.AIRTICKETMONTH);
				invoiceAndCredit.setRateOfCurrencyId(retaOfCurrencyId);
				
				Boolean flag = new Boolean(true);
				if(sum.compareTo(new BigDecimal(0))>0||sum.compareTo(new BigDecimal(0))==0){
					invoiceAndCredit.setRecordType(Constant.INVOICE);
					invoiceAndCredit.setEnterCurrency(sum);
					invoiceAndCredit.setDollar(dollarPrice);
				}else{
					invoiceAndCredit.setRecordType(Constant.CREDIT);
					invoiceAndCredit.setEnterCurrency(new BigDecimal(0).subtract(sum));
					invoiceAndCredit.setDollar(new BigDecimal(0).subtract(dollarPrice));
					flag=false;
				}
				InvoiceAndCreditItems invoiceAndCreditItems = new InvoiceAndCreditItems();
				invoiceAndCreditItems.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
				invoiceAndCreditItems.setItemsId(UUIDGenerator.getUUID());
				invoiceAndCreditItems.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
				invoiceAndCreditItems.setBusinessNo(invoiceAndCredit.getBusinessNo());
				invoiceAndCreditItems.setDeptId(invoiceAndCredit.getDeptId());
				invoiceAndCreditItems.setIfBeginningValue(1);
				
				if(flag){
					invoiceAndCreditItems.setAmount(sum);
					invoiceAndCreditItems.setDollarAmount(dollarPrice);
				}else{
					invoiceAndCreditItems.setAmount(new BigDecimal(0).subtract(sum));
					invoiceAndCreditItems.setDollarAmount(new BigDecimal(0).subtract(dollarPrice));
				}
					
				invoiceAndCreditItems.setRemarks(Constant.TOURFEE);
				invoiceAndCreditItems.setDescription(agentName);
				invoiceAndCreditMapper.save(invoiceAndCredit);
				invoiceAndCreditItemsMapper.save(invoiceAndCreditItems);
			}
		}
		return true;
	}
}