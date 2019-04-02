package com.chinatour.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.chinatour.Constant;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Order;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.SupPriceInfoRel;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.entity.Tour;
import com.chinatour.persistence.AdminMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.PayCostRecordsMapper;
import com.chinatour.persistence.SupPriceInfoRelMapper;
import com.chinatour.persistence.SupplierCheckMapper;
import com.chinatour.persistence.SupplierPriceMapper;
import com.chinatour.persistence.SupplierPriceRemarkMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.service.NoticeService;
import com.chinatour.service.SupPriceInfoRelService;
import com.chinatour.service.SupplierCheckService;
import com.chinatour.service.SupplierPriceRemarkService;



public class TimeTask {

	@Autowired
	private SupplierPriceMapper supplierPriceMapper;
	
	@Autowired
	private SupplierCheckMapper supplierCheckMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private TourMapper tourMapper;
	
	@Autowired
	private SupPriceInfoRelMapper supPriceInfoRelMapper;
	
	@Autowired
	private PayCostRecordsMapper payCostRecordsMapper;
	
	@Resource(name = "supPriceInfoRelServiceImpl")
	private SupPriceInfoRelService supPriceInfoRelService;
	
	@Resource(name = "supplierCheckServiceImpl")
	private SupplierCheckService supplierCheckService;
	
	@Autowired
	private SupplierPriceRemarkMapper supplierPriceRemarkMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Resource(name = "noticeServiceImpl")
	private NoticeService noticeService;
	
	
	/**
	 * 会计审核通过后,4个工作日将未审核通过的agent账单置为审核,并将成本录入订单.
	 * 
	 * @return
	 */
	public void supOrderCost() {
		WorkdayUtils workdayUtils = new WorkdayUtils();
		Date date = workdayUtils.getWorkday(new Date(), -3);
	    
		// 查找会计通过3天后Agent未审核的账单
		SupplierPrice supplierPriceS = new SupplierPrice();
		supplierPriceS.setCheckTime(date);
		supplierPriceS.setAccCheck(1);
		supplierPriceS.setAllCheck(0);
		supplierPriceS.setInvoiceState(0);
		List<SupplierPrice> supplierPriceList=supplierPriceMapper.findUnCheckTour(supplierPriceS);
		
		//存放未通过的agent审核,并将其改为审核通过
		List<SupplierCheck> supplierCheckList = new ArrayList<SupplierCheck>();
		List<SupplierPrice> supplierPriceListS= new ArrayList<SupplierPrice>();
		
		// 存放系统添加的支出
		List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
		
		for (SupplierPrice supplierPrice : supplierPriceList) {
			supplierPrice = supplierPriceMapper.findByTourId(supplierPrice.getTourId());
			
			if(supplierPrice.getAllCheck() != 2){
				supplierPrice.setAllCheck(1);
			}
			
			// 审核全部通过则在对应订单增加缴款支出
			SupplierCheck sc = new SupplierCheck();
			sc.setSupplierPriceId(supplierPrice.getSupplierPriceId());
			List<SupplierCheck> scList = supplierCheckMapper.find(sc);
			for(SupplierCheck scl : scList){
				scl.setCheckOfAgent(1);
				supplierCheckList.add(scl);

				SupPriceInfoRel supPriceInfoRel = new SupPriceInfoRel();
				supPriceInfoRel.setTourId(supplierPrice.getTourId());
				supPriceInfoRel.setUserId(scl.getUserIdOfAgent());
				//查询团下的所有账单成本
				List<SupPriceInfoRel> supPriceInfoRelList = supPriceInfoRelMapper.findSupplierOfOrderOfTour(supPriceInfoRel);
			
				// 如果Agent全部审核  则 录入全部agent成本
				//循环录入成本账单
				for (SupPriceInfoRel supPriceInfoRelS : supPriceInfoRelList) {
					PayCostRecords payCostRecords = new PayCostRecords();
					payCostRecords.setId(UUIDGenerator.getUUID());
					payCostRecords.setOrderId(supPriceInfoRelS.getOrderId());
					
					BigDecimal bg = supPriceInfoRelS.getSum().multiply(supPriceInfoRelS.getRateUp()).divide(supPriceInfoRelS.getRateDown(),2);
					payCostRecords.setSum(bg.setScale(2, BigDecimal.ROUND_HALF_UP));
					payCostRecords.setWay(supPriceInfoRelS.getSupplierName());
					
					payCostRecords.setTime(new Date());
					payCostRecords.setType(supPriceInfoRelS.getType());
					payCostRecords.setStatus(4);//系统审核
					payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.BILLREMARKS);
					if (supPriceInfoRelS.getType() == 2) {
						payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.HOTELPRICE + supPriceInfoRelS.getSupplierName());
						payCostRecords.setItem(Constant.HOTEL);
					} else if (supPriceInfoRelS.getType() == 3) {
						payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.FLIGHTPRICE + supPriceInfoRelS.getSupplierName());
						payCostRecords.setItem(Constant.FLIGHT);
					} else if (supPriceInfoRelS.getType() == 1) {
						payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.SUPPLIERPRICE + supPriceInfoRelS.getSupplierName());
						payCostRecords.setItem(Constant.CHINAPRICE);
					} else if (supPriceInfoRelS.getType() == 4) {
						payCostRecords.setWay(Constant.INSURANCE);
						payCostRecords.setRemark(Constant.SYSTEMPINPUT + supplierPrice.getTourCode() + Constant.INSURANCEPRICE);
						payCostRecords.setItem(Constant.CHINAPRICE);
					}
					payCostRecords.setPayOrCost(2);
					
					
					if(!payCostRecords.getSum().equals(BigDecimal.ZERO)){
						payCostRecordsList.add(payCostRecords);
					}
					
				}
			}
			//自动发Invoice
			if (supplierPrice.getAllCheck() == 1 && supplierPrice.getInvoiceState() == 0 ) {
				Tour tour1 = tourMapper.findById(supplierPrice.getTourId());
				supplierPrice.setArriveDateTime(tour1.getArriveDateTime());
				// 判断团下agent是否已全部审核通过，通过则发出Invoice
				SupplierCheck supCheck = new SupplierCheck();
				supCheck.setSupplierPriceId(supplierPrice.getSupplierPriceId());
				List<SupplierCheck> supCheckListTemp=supplierCheckService.queryOfDept(supCheck);
				//发invoice
				supplierCheckService.billInvoice(null, supplierPrice,supCheckListTemp);
					
			}
			supplierPrice.setInvoiceState(1);
			supplierPriceListS.add(supplierPrice);
		}
		
		if(supplierPriceListS!=null){
			for(int i=0;i<supplierPriceListS.size();i++){
				supplierPriceMapper.update(supplierPriceListS.get(i));
			}
		}
		
		if(supplierCheckList!=null){
			for(int i=0;i<supplierCheckList.size();i++){
				supplierCheckMapper.update(supplierCheckList.get(i));
			}
		}
		
		if(payCostRecordsList!=null){
			for(int i=0;i<payCostRecordsList.size();i++){
				payCostRecordsMapper.save(payCostRecordsList.get(i));
			}
		}
	}
	/**
	 * 
	 * 变更单
	 * 会计审核通过后,4个工作日将未审核通过的agent变更单置为审核,并将成本录入订单.
	 * 
	 * @return
	 */
	public void billChange() {
		WorkdayUtils workdayUtils = new WorkdayUtils();
		Date date = workdayUtils.getWorkday(new Date(), -3);
		// 查找会计通过3天后Agent未审核的账单
		SupplierPriceRemark supplierPriceRemark=new SupplierPriceRemark();
		supplierPriceRemark.setType(1);
		supplierPriceRemark.setSprCheck(3);
		supplierPriceRemark.setIsDel(0);
		supplierPriceRemark.setAccCheckTime(date);
		supplierPriceRemark.setInvoiceState(0);
			
		//所有需要审核的变更单
		List<SupplierPriceRemark> supplierPriceRemarkList=supplierPriceRemarkMapper.findBill(supplierPriceRemark);
		
		//判断是否有未审核变更单
		if (supplierPriceRemarkList != null&& supplierPriceRemarkList.size() > 0) {
			for(SupplierPriceRemark spr : supplierPriceRemarkList){
				spr.setInvoiceState(0);
				spr.setSprCheck(1);
				supplierPriceRemarkMapper.update(spr);
				SupplierPriceRemark remark=new SupplierPriceRemark();
				remark.setTourId(spr.getTourId());
				remark.setType(1);
				remark.setIsDel(0);
				remark.setInvoiceState(0);
				
				//一个账单 下所有变更单 
				List<SupplierPriceRemark> supplierPriceRemarkListTemp=supplierPriceRemarkMapper.findSupplierPriceRemark(remark);
					
				//判断所有变更单是否全部审核通过 是 为true 否 为 false
				boolean checekTemp=true;
				for(int i=0;i<supplierPriceRemarkListTemp.size();i++){
					if(supplierPriceRemarkListTemp.get(i).getSprCheck()!=1){
						checekTemp=false;
					}
				}
				Tour tourTemp = tourMapper.findById(spr.getTourId());
				Admin op = adminMapper.findById(tourTemp.getUserId()); 
				//全部审核通过 ， 订单均摊变更单成本
				SupplierPriceRemark sk = new SupplierPriceRemark();
				// 存放系统添加的支出
				List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
				//变更单list
				//List<SupplierPriceRemark> supplierPriceRemarkListT=new ArrayList<SupplierPriceRemark>();
				//supplierPriceRemarkListT.add(spr);
				//checekTemp 是否全部审核通过
				if(checekTemp){
					//全部审核通过发invoice
					remark.setSprCheck(1);
					List<SupplierPriceRemark> supplierPriceRemarkListT=supplierPriceRemarkMapper.find(remark);
					supplierCheckService.billCheckInvoice(op, spr.getTourId(), supplierPriceRemarkListT);
					for(int a=0;a<supplierPriceRemarkListTemp.size();a++){
						sk=supplierPriceRemarkMapper.findRateById(supplierPriceRemarkListTemp.get(a).getSupplierPriceRemarkId());
						Order o = new Order();
						o.setTourCode(sk.getTourCode());
						o.setTourId(sk.getTourId());
						//List<Order> orderList = orderMapper.find(o);
						//BigDecimal n = new BigDecimal(orderList.size());
						BigDecimal total = sk.getUsaDifferenceSum();
						PayCostRecords payCostRecords = new PayCostRecords();
						payCostRecords.setId(UUIDGenerator.getUUID());
						payCostRecords.setOrderId(sk.getOrderId());
						payCostRecords.setWay(Constant.CHECKBILLCHANGE);
						
						payCostRecords.setTime(new Date());
						payCostRecords.setType(9); //代表变更单录入
						payCostRecords.setPayOrCost(2); //代表成本
						payCostRecords.setStatus(4);//系统审核
						payCostRecords.setConfirmRemark(Constant.SYSTEMPINPUT+Constant.AUTOCHECKBILL);
						payCostRecords.setRemark(Constant.SYSTEMPINPUT+Constant.CHECKBILLINFO);
						payCostRecords.setItem(Constant.CHECKBILLCHANGE);
						
						BigDecimal balance = total;
						balance=balance.setScale(2, BigDecimal.ROUND_HALF_UP);
						payCostRecords.setSum(balance);//四舍五入
						
						payCostRecordsList.add(payCostRecords);
					}
					if(payCostRecordsList.size()!=0){
						for(PayCostRecords item:payCostRecordsList){
							payCostRecordsMapper.save(item);
						}
					}
				}
			}
		}
	}
	/**
	 * 客户航班信息为空的发站内信
	 * @return
	 */
	public void sendEmailAndNotice() {
		Calendar calendar   =   new   GregorianCalendar(); 
    	calendar.setTime(new Date());
    	calendar.add(Calendar.DAY_OF_MONTH, 5);//把日期往后增加一天.整数往后推,负数往前移动
    	
    	Order order = new Order();
    	order.setArriveDateTime(calendar.getTime());
    	List<Order> orderList=orderMapper.findOrderInfo(order);
    	for(int j=0;j<orderList.size();j++){
    		Order ord=orderList.get(j);
    		List<CustomerOrderRel> customerOrderRelList=ord.getCustomerOrderRel();
    		String str="";
			boolean flag=false;
			for(int k=0;k<customerOrderRelList.size();k++){
				if(customerOrderRelList.get(k).getIsDel()!=1){
					List<CustomerFlight> customerFlightList = customerOrderRelList.get(k).getCustomerFlightList();
					for(int l=0;l<customerFlightList.size();l++){
						if(customerFlightList.get(l).getFlightCode()==null||customerFlightList.get(l).getFlightNumber()==null||
						customerFlightList.get(l).getFlightCode().equals("")	||customerFlightList.get(l).getFlightNumber().equals("")){
							str="(系统通知) "+ord.getTourCode()+"团距离出发日期还有5天请补全订单"+ord.getOrderNo()+"的航班信息和护照信息。"
									+"团队抵达前三天，如果客人航班信息不全，默认客人自行入住，不予安排接机.";
							flag=true;
						}
					}
					
        			//组团与为组团  订单的客人
					 Customer customer  = customerOrderRelList.get(k).getCustomer();
        			if(customer.getPassportNo()==null||customer.getPassportNo().equals("")){
        				str="(系统通知) "+ord.getTourCode()+"团距离出发日期还有5天请补全订单"+ord.getOrderNo()+"的航班信息和护照信息。"
								+"团队抵达前三天，如果客人航班信息不全，默认客人自行入住，不予安排接机.";
        				flag=true;
        			}
				}
			}
			
			if(flag==true){
				/* 发送站内信  */
				noticeService.sendMail("(系统通知)：补全订单"+ord.getOrderNo()+"的客人信息",str.toString(), ord.getPeerUserId(), ord.getUserId());
			}
    	}
	}
}