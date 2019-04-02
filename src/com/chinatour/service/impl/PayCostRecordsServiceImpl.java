package com.chinatour.service.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Dept;
import com.chinatour.entity.EuropeTourPrice;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPriceRemark;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourType;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.EuropeTourPriceMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.PayCostRecordsMapper;
import com.chinatour.persistence.SupplierCheckMapper;
import com.chinatour.persistence.SupplierPriceMapper;
import com.chinatour.persistence.SupplierPriceRemarkMapper;
import com.chinatour.persistence.TourMapper;
import com.chinatour.persistence.TourTypeMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.PayCostRecordsService;
import com.chinatour.vo.SettlementTotalVO;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 17, 2014 3:36:37 PM
 * @revision  3.0
 */

@Service("payCostRecordsServiceImpl")
public class PayCostRecordsServiceImpl extends BaseServiceImpl<PayCostRecords, String> implements PayCostRecordsService {
    
	
	@Autowired
	private PayCostRecordsMapper payCostRecordsMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private TourMapper tourMapper;
	
	@Autowired
	private SupplierPriceRemarkMapper supplierPriceRemarkMapper;
	
	@Autowired
	private DeptMapper deptMapper;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private SupplierPriceMapper supplierPriceMapper;
	
	@Autowired
	private SupplierCheckMapper supplierCheckMapper;
	
	@Autowired
	private EuropeTourPriceMapper europeTourPriceMapper;
	@Autowired
	private TourTypeMapper tourTypeMapper;
	 
	
	@Autowired
	public void setPayCostRecordsMapper(PayCostRecordsMapper payCostRecordsMapper){
		this.setBaseMapper(payCostRecordsMapper);
	}

	@Override
	public List<PayCostRecords> find(PayCostRecords payCostRecords) {
		return payCostRecordsMapper.find(payCostRecords);
	}
	
	//结算总订单
	@Override
	public SettlementTotalVO settlementOrdersTotal(OrdersTotal ordersTotal) {
		
		SettlementTotalVO settlementTotalVO=new SettlementTotalVO();
		//收入支出集合
		List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
		// 账单变更单页面数据
		List<SupplierPriceRemark> supplierPriceRemarkList = new ArrayList<SupplierPriceRemark>();
		//op组团订单号
		HashSet<String> tourIdStrings = new HashSet<String>();
		//存放组团的op ID
		HashSet<String> opUserIdStrings = new HashSet<String>();

		//查询总订单下的所有子订单
		List<Order> ordersList=orderMapper.findByOrdersTotalId(ordersTotal.getOrdersTotalId());
		//自组团订单
		List<Order> singleOrdersList=new ArrayList<Order>();
		//存储订单金额
		Order orderS = new Order();
		//用于页面判断 是否结算
		Tour tourS=new Tour();
		//存放订单利润
		List<Order> orderListS=new ArrayList<Order>();
		//存放应收款金额
		BigDecimal tourFeeSum = new BigDecimal(0.00);
		
		for (Order order : ordersList) {
			//if(order.getState()!=5&&order.getState()!=6){
				//判断是自组 还是op组
				if(order.getIsSelfOrganize()==0){
					if(order.getTourId()!=null&&order.getTourId().length()!=0){
						tourIdStrings.add(order.getTourId());
					}else{
						//只要有一个订单未组团不能申请结算
						if(order.getState()!=5&&order.getState()!=6){
							tourS.setAllCheck(2);
						}
					}
					//判断是否有op团订单
					orderS.setIsSelfOrganize(0);
				}else{
					singleOrdersList.add(order);
				}
				tourFeeSum=tourFeeSum.add(order.getCommonTourFee());
			//}
		}
		orderS.setCommonTourFee(tourFeeSum);
		
		BigDecimal costTotalSum = new BigDecimal(0.00);
		BigDecimal payTotalSum = new BigDecimal(0.00);
		//BigDecimal billSum = new BigDecimal(0.00);//变更单 金额
		BigDecimal profitSum = new BigDecimal(0.00);//5%操作费
		//op组团订单
		if(tourIdStrings!=null&&tourIdStrings.size()!=0){
			 Iterator<String> it=tourIdStrings.iterator();
			 Order order=new Order(); 
			 while(it.hasNext()){
				//tourIdString	团id
				String tourIdString=it.next();
				order.setOrdersTotalId(ordersTotal.getOrdersTotalId());
				order.setUserId(ordersTotal.getUserId());
				order.setTourId(tourIdString);
				List<Order> orderList = orderMapper.findOrderOfPayOrCost(order);
				
				//抵达日期2016-01-01 后 不发 5%
				Tour t = tourMapper.findById(tourIdString);
				if(t!=null&&t.getArriveDateTime()!=null&&compareDate(t.getArriveDateTime())){
					for (Order o : orderList) {
						o.setPriceExpression(new BigDecimal(0));
					}
				}
				
				//Order o=new Order();
				BigDecimal costOrderSum = new BigDecimal(0.00);
				BigDecimal payOrderSum = new BigDecimal(0.00);
				BigDecimal billSum = new BigDecimal(0.00);//变更单 金额
				Tour tour=new Tour();
				// 判断是否录入账单 
				// 没有录入账单 并且不是欧洲团订单
				if (tourMapper.findAllCheckByTourId(tourIdString) == null) {
					tour = tourMapper.findById(tourIdString);
					// 3表示未录入账单
					if(tour!=null){
						EuropeTourPrice ep=new EuropeTourPrice(); 
						//tourS.setAllCheck(3);
						for (Order o : orderList) {
							if(o.getState()!=5&&o.getState()!=6){
								ep.setOrderId(o.getId());
								int count=europeTourPriceMapper.findCount(ep);
								//count为0 表示 不是欧洲团订单， 直接跳出循环
								if (count<=0){
									// 2 未审核通过 
									tourS.setAllCheck(2);
									//有未审核账单
									tourS.setAccCheck(2);
									break;
								}
								ep.setCompleteState(1);
								int number=europeTourPriceMapper.findCount(ep);
								// number 大于0 说明还有未审核的订单 不能结算，直接跳出循环
								if(number>0){
									// 2 未审核通过 
									tourS.setAllCheck(2);
									//有未审核账单
									tourS.setAccCheck(2);
									break;
								}
							}
						}
					}
					
				} else {
					tour = tourMapper.findAllCheckByTourId(tourIdString);
					//汇率
					SupplierCheck sck=new SupplierCheck();
					sck.setSupplierPriceId(tour.getSupplierPriceId());
					sck.setUserIdOfAgent(order.getUserId());
					List<SupplierCheck> supplierCheckList=supplierCheckMapper.find(sck);
					if (supplierCheckList.size() != 0) {
						settlementTotalVO.setSupplierCheck(supplierCheckList.get(0));
					}
					SupplierPriceRemark spr = new SupplierPriceRemark();
					spr.setTourId(order.getTourId());
					spr.setUserId(order.getUserId());
					// 账单变更单页面数据
					List<SupplierPriceRemark> supplierPriceRemarkListS=(supplierPriceRemarkMapper.findAgentTax(spr));
					
					//去除一个agent下的两个订单在一个团下，变更单重复
					List<SupplierPriceRemark> supplierPriceRemarks = new ArrayList<SupplierPriceRemark>();
					if(supplierPriceRemarkListS.size() != 0) {
						
						for(SupplierPriceRemark supplierPriceRemark :supplierPriceRemarkListS) {
							Order RemarkOrder = orderMapper.findById(supplierPriceRemark.getOrderId());
							if((RemarkOrder.getOrdersTotalId()).equals( order.getOrdersTotalId())) {
								supplierPriceRemarks.add(supplierPriceRemark);
							}
						}
						supplierPriceRemarkListS.removeAll(supplierPriceRemarkListS);
						supplierPriceRemarkListS.addAll(supplierPriceRemarks);
					}

					if (supplierPriceRemarkListS.size() != 0) {
						for (int a = 0; a < supplierPriceRemarkListS.size(); a++) {
							if((supplierPriceRemarkListS.get(a).getSprCheck()==1)||(supplierPriceRemarkListS.get(a).getSprCheck()==5)){
								costOrderSum=costOrderSum.add(
										supplierPriceRemarkListS.get(a).getDifferenceSum());
								billSum=billSum.add(
										supplierPriceRemarkListS.get(a).getDifferenceSum());
							}
						}
					}
					//存储变更单数据
					supplierPriceRemarkList.addAll(supplierPriceRemarkListS);
					// 判断agent和财务是否审核通过
					if(tour!=null&&(tour.getAllCheck()!=1||tour.getAccCheck()!=1)){
						//判断是否有取消的订单， 取消订单不需要做 团的成本 ，就可以结算。
						for (Order o : orderList) {
							if(o.getState()!=5&&o.getState()!=6){
								// 2 未审核通过 
								tourS.setAllCheck(2);
								//有未审核账单
								tourS.setAccCheck(2);
							}
						}
					}
				}
				//订单成本收入
				for (Order ord : orderList) {
					if(ord.getPayCostRecords()!=null&&ord.getPayCostRecords().size()!=0){
						for (PayCostRecords payCostRecords : ord.getPayCostRecords()) {
							payCostRecords.setTourCode(ord.getTourCode());
						}
						//存储收入支出
						payCostRecordsList.addAll(ord.getPayCostRecords());
					}
					// 查出团下每个订单的总收入支出
					ord.setType(9);//去除变更单成本
					Order orderProfit = orderMapper.findOrderProfit(ord);// left join
					if(orderProfit!=null&&orderProfit.getCostTotalSum()!=null){
						costOrderSum = costOrderSum.add(orderProfit.getCostTotalSum());
					}
					if(orderProfit!=null&&orderProfit.getPayTotalSum()!=null){
						payOrderSum = payOrderSum.add(orderProfit.getPayTotalSum());
					}
					//判断是否有账单未审核  用于页面显示
					if(ord.getTax()==0){
						orderS.setTax(0);
					}
					
					//单个订单利润
					if(ord.getState()!=5&&ord.getState()!=6){
						ord.setProfit(payOrderSum.subtract(costOrderSum.subtract(billSum)));//发 对账，减去变更单金额。，  
						BigDecimal tempSum=(payOrderSum.subtract(costOrderSum)).multiply(ord.getPriceExpression());//一个订单5%操作费 页面显示 要加上 变更单金额
						profitSum=profitSum.add(tempSum);//总订单5%操作费
					}
					orderListS.add(ord);
				}
				
				//保存组团op名
				if(tour!=null){
					opUserIdStrings.add(tour.getUserId());
				}
				//收入
				if(payOrderSum!=null){
					payTotalSum=payTotalSum.add(payOrderSum);
				}
				// 支出
				if(costOrderSum!=null){
					costTotalSum=costTotalSum.add(costOrderSum);
				}
			}
		}
		//自组订单
		BigDecimal singleCostOrderSum = new BigDecimal(0.00);
		BigDecimal singlePayOrderSum = new BigDecimal(0.00);
		for(Order singleorder:singleOrdersList){
			// 查找所有对应订单的缴款信息
			PayCostRecords payCostRecords=new PayCostRecords();
			payCostRecords.setOrderId(singleorder.getId());
			//payCostRecords.setType(9);//去除变更单成本 
			payCostRecordsList.addAll(payCostRecordsMapper.find(payCostRecords));
			
			// 订单收入支出
			Order ord=new Order();
			ord.setId(singleorder.getId());
			ord.setType(9);//去除变更单成本
			Order orderProfit = orderMapper.findOrderProfit(ord);
			if(orderProfit!=null&&orderProfit.getCostTotalSum()!=null){
				singleCostOrderSum = singleCostOrderSum.add(orderProfit.getCostTotalSum());
			}
			if(orderProfit!=null&&orderProfit.getPayTotalSum()!=null){
				singlePayOrderSum = singlePayOrderSum.add(orderProfit.getPayTotalSum());
			}
			//判断是否有账单未审核 用于页面显示
			if(singleorder.getTax()==0){
				orderS.setTax(0);
			}
		}
		orderS.setPayTotalSum(payTotalSum);
		orderS.setCostTotalSum(costTotalSum);
		//计算团订单利润（op组）
		if(orderS.getPayTotalSum()!=null||orderS.getCostTotalSum()!=null){
			orderS.setProfit(orderS.getPayTotalSum().subtract(orderS.getCostTotalSum()));
		}
		//计算非团订单利润（自组）
		if(singleCostOrderSum!=null||singlePayOrderSum!=null){
			orderS.setSingleProfit(singlePayOrderSum.subtract(singleCostOrderSum));
		}
		//agent利润	团去除5%操作费 
		if(orderS.getProfit()!=null){
			//orderS.setAgentProfit(orderS.getSingleProfit().add(orderS.getProfit().multiply(Constant.AGENT_PROFIT)));
			orderS.setAgentProfit(orderS.getSingleProfit().add(orderS.getProfit().subtract(profitSum)));
		}
		
		//部门数
		BigDecimal dept = new BigDecimal(opUserIdStrings.size());
		
		//op利润 收取操作费
		if(orderS.getProfit()!=null&&opUserIdStrings.size()!=0){
			//orderS.setOpProfit(orderS.getProfit().multiply(Constant.OP_PROFIT).divide(dept));
			orderS.setOpProfit(profitSum.divide(dept,2));
		}
		//显示总  收入  支出 总小计
		orderS.setPayTotalSum(payTotalSum.add(singlePayOrderSum));
		orderS.setCostTotalSum(costTotalSum.add(singleCostOrderSum));
		//判断是否有自组订单
		if(singleOrdersList.size()==0){
			orderS.setIsSelfOrganize(1);
		}
		settlementTotalVO.setOrder(orderS);
		settlementTotalVO.setTour(tourS);
		settlementTotalVO.setTourIdStrings(tourIdStrings);
		settlementTotalVO.setOpUserIdStrings(opUserIdStrings);
		settlementTotalVO.setOrderList(orderListS);
		settlementTotalVO.setOrdList(ordersList);
		settlementTotalVO.setPayCostRecordsList(payCostRecordsList);
		settlementTotalVO.setSupplierPriceRemarkList(supplierPriceRemarkList);
		settlementTotalVO.setSingleOrdersList(singleOrdersList);
		return settlementTotalVO;
	}

	@Override
	public Page<PayCostRecords> findForGroupPage(PayCostRecords payCostRecords,
			Pageable pageable) {
		if (pageable == null) {
            pageable = new Pageable();
        }
        List<PayCostRecords> page = payCostRecordsMapper.findForGroupPage(payCostRecords, pageable);
        int pageCount = payCostRecordsMapper.findForGroupPageCount(payCostRecords, pageable);
        return new Page<PayCostRecords>(page, pageCount, pageable);
	}
	
	//Agent团下的相关费用
		@Override
		public SettlementTotalVO chackFeeByTourId(Order ord) {
			SettlementTotalVO settlementTotalVO=new SettlementTotalVO();
			//收入支出集合
			List<PayCostRecords> payCostRecordsList = new ArrayList<PayCostRecords>();
			// 账单变更单页面数据
			List<SupplierPriceRemark> supplierPriceRemarkList = new ArrayList<SupplierPriceRemark>();
			//op组团订单号
			HashSet<String> tourIdStrings = new HashSet<String>();
			//存放组团的op ID
			HashSet<String> opUserIdStrings = new HashSet<String>();
			//存储订单金额
			Order orderS = new Order();
			//用于页面判断 是否结算
			Tour tourS=new Tour();
			//存放订单利润
			List<Order> orderListS=new ArrayList<Order>();
			//存放应收款金额
			BigDecimal tourFeeSum = new BigDecimal(0.00);
			//操作费结算方式
			BigDecimal priceExpression = new BigDecimal(0.00);
			//查询该Agent此团下的订单
			orderS.setUserId(ord.getUserId());
			orderS.setTourId(ord.getTourId());
			List<Order> ordersList=orderMapper.find(orderS);
			for (Order order : ordersList) {
				//判断是自组 还是op组
				tourFeeSum=tourFeeSum.add(order.getCommonTourFee());
			}
			orderS.setCommonTourFee(tourFeeSum);
			
			BigDecimal costTotalSum = new BigDecimal(0.00);
			BigDecimal payTotalSum = new BigDecimal(0.00);
			BigDecimal billSum = new BigDecimal(0.00);//变更单 金额
			BigDecimal profitSum = new BigDecimal(0.00);//5%操作费
			//op组团订单
			 Order order=new Order(); 
			order.setOrdersTotalId(ord.getOrdersTotalId());
			order.setUserId(ord.getUserId());
			order.setTourId(ord.getTourId());
			List<Order> orderList = orderMapper.findOrderOfPayOrCost(order);
			
			//Order o=new Order();
			BigDecimal costOrderSum = new BigDecimal(0.00);
			BigDecimal payOrderSum = new BigDecimal(0.00);
			Tour tour=new Tour();
			// 判断是否录入账单 
			// 没有录入账单 并且不是欧洲团订单
			if (tourMapper.findAllCheckByTourId(ord.getTourId()) == null) {
				tour = tourMapper.findById(ord.getTourId());
				// 3表示未录入账单
				if(tour!=null){
					EuropeTourPrice ep=new EuropeTourPrice(); 
					//tourS.setAllCheck(3);
					for (Order o : orderList) {
						if(o.getState()!=5&&o.getState()!=6){
							ep.setOrderId(o.getId());
							int count=europeTourPriceMapper.findCount(ep);
							//count为0 表示 不是欧洲团订单， 直接跳出循环
							if (count<=0){
								// 2 未审核通过 
								tourS.setAllCheck(2);
								//有未审核账单
								tourS.setAccCheck(2);
								break;
							}
							ep.setCompleteState(1);
							int number=europeTourPriceMapper.findCount(ep);
							// number 大于0 说明还有未审核的订单 不能结算，直接跳出循环
							if(number>0){
								// 2 未审核通过 
								tourS.setAllCheck(2);
								//有未审核账单
								tourS.setAccCheck(2);
								break;
							}
						}
					}
				}
				
			} else {
				tour = tourMapper.findAllCheckByTourId(ord.getTourId());
				//汇率
				SupplierCheck sck=new SupplierCheck();
				sck.setSupplierPriceId(tour.getSupplierPriceId());
				sck.setUserIdOfAgent(order.getUserId());
				List<SupplierCheck> supplierCheckList=supplierCheckMapper.find(sck);
				if (supplierCheckList.size() != 0) {
					settlementTotalVO.setSupplierCheck(supplierCheckList.get(0));
				}
				SupplierPriceRemark spr = new SupplierPriceRemark();
				spr.setTourId(order.getTourId());
				spr.setUserId(order.getUserId());
				// 账单变更单页面数据
				List<SupplierPriceRemark> supplierPriceRemarkListS=(supplierPriceRemarkMapper.findAgentTax(spr));
				if (supplierPriceRemarkListS.size() != 0) {
					for (int a = 0; a < supplierPriceRemarkListS.size(); a++) {
						if((supplierPriceRemarkListS.get(a).getSprCheck()==1)||(supplierPriceRemarkListS.get(a).getSprCheck()==5)){
							costOrderSum=costOrderSum.add(supplierPriceRemarkListS.get(a).getDifferenceSum());
							billSum=billSum.add(supplierPriceRemarkListS.get(a).getDifferenceSum());
						}
					}
				}
				//存储变更单数据
				supplierPriceRemarkList.addAll(supplierPriceRemarkListS);
				// 判断agent和财务是否审核通过
				if(tour!=null&&(tour.getAllCheck()!=1||tour.getAccCheck()!=1)){
					//判断是否有取消的订单， 取消订单不需要做 团的成本 ，就可以结算。
					for (Order o : orderList) {
						if(o.getState()!=5&&o.getState()!=6){
							// 2 未审核通过 
							tourS.setAllCheck(2);
							//有未审核账单
							tourS.setAccCheck(2);
						}
					}
				}
			}
			//订单成本收入
			for (Order ords : ordersList) {
				TourType tourType=tourTypeMapper.findById(ords.getTourTypeId());
				ords.setPriceExpression(tourType.getPriceExpression());
				Order or=new Order(); 
				PayCostRecords payCost=new PayCostRecords();
				payCost.setOrderId(ords.getId());
				List<PayCostRecords> pList=new ArrayList<PayCostRecords>();
				pList=payCostRecordsMapper.find(payCost);
				ords.setPayCostRecords(pList);
				// 查出团下每个订单的总收入支出
				ords.setType(9);//去除变更单成本
				Order orderProfit = orderMapper.findOrderProfit(ords);// left join
				if(orderProfit!=null&&orderProfit.getCostTotalSum()!=null){
					costOrderSum = costOrderSum.add(orderProfit.getCostTotalSum());
				}
				if(orderProfit!=null&&orderProfit.getPayTotalSum()!=null){
					payOrderSum = payOrderSum.add(orderProfit.getPayTotalSum());
				}
				//判断是否有账单未审核  用于页面显示
				if(ords.getTax()==0){
					orderS.setTax(0);
				}
				
				//单个订单利润
				if(ords.getState()!=5&&ords.getState()!=6){
					ords.setProfit(payOrderSum.subtract(costOrderSum.subtract(billSum)));//发 对账，减去变更单金额。，  
					BigDecimal tempSum=(payOrderSum.subtract(costOrderSum)).multiply(ords.getPriceExpression());//一个订单5%操作费 页面显示 要加上 变更单金额
					profitSum=profitSum.add(tempSum);//总订单5%操作费
				}
				orderListS.add(ords);//放入List里
			}
			
			//保存组团op名
			if(tour!=null){
				opUserIdStrings.add(tour.getUserId());
			}
			//收入
			if(payOrderSum!=null){
				payTotalSum=payTotalSum.add(payOrderSum);
			}
			// 支出
			if(costOrderSum!=null){
				costTotalSum=costTotalSum.add(costOrderSum);
			}
			orderS.setPayTotalSum(payTotalSum);
			orderS.setCostTotalSum(costTotalSum);
			//计算团订单利润（op组）
			if(orderS.getPayTotalSum()!=null||orderS.getCostTotalSum()!=null){
				orderS.setProfit(orderS.getPayTotalSum().subtract(orderS.getCostTotalSum()));
			}
			//agent利润	团去除5%操作费 
			if(orderS.getProfit()!=null){
				orderS.setAgentProfit(orderS.getProfit().subtract(profitSum));
			}
			
			//部门数
			BigDecimal dept = new BigDecimal(opUserIdStrings.size());
			
			//op利润 收取操作费
			if(orderS.getProfit()!=null&&opUserIdStrings.size()!=0){
				//orderS.setOpProfit(orderS.getProfit().multiply(Constant.OP_PROFIT).divide(dept));
				orderS.setOpProfit(profitSum.divide(dept,2));
			}
			settlementTotalVO.setOrder(orderS);
			settlementTotalVO.setTour(tourS);
			settlementTotalVO.setTourIdStrings(tourIdStrings);
			settlementTotalVO.setOpUserIdStrings(opUserIdStrings);
			settlementTotalVO.setOrderList(orderListS);
			settlementTotalVO.setOrdList(ordersList);
			settlementTotalVO.setPayCostRecordsList(payCostRecordsList);
			settlementTotalVO.setSupplierPriceRemarkList(supplierPriceRemarkList);
			return settlementTotalVO;
		}
		
		 /** 
	     * 比较两个日期之间的大小 
	     *  
	     * @param d1 
	     * @param d2 
	     * @return 前者大于后者返回true 反之false 
	     */  
	    public boolean compareDate(Date d2) {  
	        Calendar c1 = Calendar.getInstance();  
	        Calendar c2 = Calendar.getInstance();  
	        c2.set(2015,11,31);// 月份 0 开始计算
	        c1.setTime(d2);  
	      
	        int result = c1.compareTo(c2);  
	        if (result > 0)  
	            return true;  
	        else  
	            return false;  
	    }

		@Override
		public Page<PayCostRecords> findCostForPage(
				PayCostRecords payCostRecords, Pageable pageable) {
			if (pageable == null) {
	            pageable = new Pageable();
	        }
	        List<PayCostRecords> page = payCostRecordsMapper.findCostForPage(payCostRecords, pageable);
	        int pageCount = payCostRecordsMapper.findCostForPageCount(payCostRecords, pageable);
	        return new Page<PayCostRecords>(page, pageCount, pageable);
		}

		@Override
		public List<PayCostRecords> findPayOrCostByOrders(
				PayCostRecords payCostRecords) {
			return payCostRecordsMapper.findPayOrCostByOrders(payCostRecords);
		}


}
