package com.chinatour.controller.admin;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chinatour.entity.Dept;
import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.entity.InsurancePriceInfo;
import com.chinatour.entity.Order;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.SupPriceInfoRel;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierOfAgent;
import com.chinatour.entity.SupplierOfOrder;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.Tour;
import com.chinatour.service.AdminService;
import com.chinatour.service.DeptService;
import com.chinatour.service.FlightPriceInfoService;
import com.chinatour.service.InsurancePriceInfoService;
import com.chinatour.service.OrderService;
import com.chinatour.service.RateOfCurrencyService;
import com.chinatour.service.SupPriceInfoRelService;
import com.chinatour.service.SupplierCheckService;
import com.chinatour.service.SupplierOfAgentService;
import com.chinatour.service.SupplierOfOrderService;
import com.chinatour.service.SupplierPriceService;
import com.chinatour.service.TourService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.SupplierOfAgentVO;

/**
 * 团账单保险
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-23 下午3:56:56
 * @revision 3.0
 */
@Controller
@RequestMapping("/admin/insurancePriceInfo")
public class InsurancePriceInfoController extends BaseController {

	@Resource(name = "adminServiceImpl")
	private AdminService adminService;

	@Resource(name = "insurancePriceInfoServiceImpl")
	private InsurancePriceInfoService insurancePriceInfoService;

	@Resource(name = "supPriceInfoRelServiceImpl")
	private SupPriceInfoRelService supPriceInfoRelService;

	@Resource(name = "supplierPriceServiceImpl")
	private SupplierPriceService supplierPriceService;

	@Resource(name = "tourServiceImpl")
	private TourService tourService;

	@Resource(name = "orderServiceImpl")
	private OrderService orderService;

	@Resource(name = "supplierCheckServiceImpl")
	private SupplierCheckService supplierCheckService;
	
	@Resource(name = "supplierOfOrderServiceImpl")
	private SupplierOfOrderService supplierOfOrderService;
	
	@Resource(name = "supplierOfAgentServiceImpl")
	private SupplierOfAgentService supplierOfAgentService;
	
	@Resource(name = "rateOfCurrencyServiceImpl")
	private RateOfCurrencyService rateOfCurrencyService;
	
	@Resource(name = "deptServiceImpl")
	private DeptService deptService;

	private String SUPPLIER_TYPE = "4";// 供应商类型 4代表保险

	/**
	 * 加载
	 */
	@RequestMapping(value = "/orderInsuranceAdd", method = RequestMethod.GET)
	public String orderInsuranceAdd(ModelMap model, Tour tour) {
		model.addAttribute("menuId", "404");
		model.addAttribute("tour", tour);
		model.addAttribute("customerList",
				supPriceInfoRelService.findCustomerByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderInsuranceAdd";
	}
	/**
	 * OP Group录账单
	 * @param model
	 * @param tour
	 * @return
	 */
	@RequestMapping(value = "/orderInsuranceAddGroup", method = RequestMethod.GET)
	public String orderInsuranceAddGroup(ModelMap model, Tour tour) {
		model.addAttribute("menuId", "414");
		model.addAttribute("tour", tour);
		model.addAttribute("customerList",
				supPriceInfoRelService.findCustomerByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderInsuranceAddGroup";
	}

	/**
	 * 保存数据
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(ModelMap model,SupplierOfAgentVO supplierOfAgentVO,
			SupPriceInfoRel supPriceInfoRel, Order order) {

		SupplierPrice supplierPrice = supplierPriceService.findByTourId(order
				.getTourId());
		boolean temp=false;
		if (supplierPrice != null) {

			if (supPriceInfoRel.getRemark() != null
					&& supplierPrice.getRemark() != null) {
				supplierPrice.setRemark(supplierPrice.getRemark() + "\n"
						+ supPriceInfoRel.getRemark());
			} else if (supplierPrice.getRemark() == null
					&& supPriceInfoRel.getRemark() != null) {
				supplierPrice.setRemark(supPriceInfoRel.getRemark());
			}
			// 判断 是否包含4 4代表 账单中已经录入 保险
			if (!supplierPrice.getSupType().contains(SUPPLIER_TYPE)) {
				supplierPrice.setSupType(supplierPrice.getSupType()+SUPPLIER_TYPE);
			}
		} else {
			temp=true;
			supplierPrice = new SupplierPrice();
			supplierPrice.setTourId(order.getTourId());
			supplierPrice.setTourCode(order.getTourCode());
			supplierPrice.setCreateTime(new Date());
			supplierPrice.setAllCheck(0);
			supplierPrice.setAccCheck(0);
			supplierPrice.setInvoiceState(0);
			supplierPrice.setCompleteState(0);
			supplierPrice.setSupType(SUPPLIER_TYPE);
			if (supPriceInfoRel.getRemark() != null) {
				supplierPrice.setRemark(supPriceInfoRel.getRemark() + "\n");
			}
		}
		supPriceInfoRel.setSupPriceInfoRelId(UUIDGenerator.getUUID());
		supPriceInfoRel.setTourId(order.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(SUPPLIER_TYPE));
		supPriceInfoRel.setSupplierState(0);
		supPriceInfoRel.setCreateTime(new Date());

		// 查找团下的Agent
		List<Order> agentOfOrderList = orderService.findUserOfOrder(order);

		// 查找团下的Order
		List<Order> orderOfOrderList = orderService.find(order);

		// Agent团账单供应商 集合
		List<SupplierOfOrder> supplierOfOrderList = new ArrayList<SupplierOfOrder>();

		// Agent团账单供应商订单集合
		List<SupplierOfAgent> supplierOfAgentList = new ArrayList<SupplierOfAgent>();
		
		//Agent账单审核
		List<SupplierCheck> supplierCheckList=new ArrayList<SupplierCheck>();

		for(int i=0;i<agentOfOrderList.size();i++){
			SupplierOfAgent supplierOfAgentS = new SupplierOfAgent();
			supplierOfAgentS.setSupplierOfAgentId(UUIDGenerator.getUUID());
			supplierOfAgentS.setUserId(agentOfOrderList.get(i).getUserId());
			supplierOfAgentS.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
			
			//每个Agent收入总数（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			//每个Agent收客人数
			Integer totalPeople =0;
			String customerNos="";
			
			for (int j = 0; j < orderOfOrderList.size(); j++) {
				if (agentOfOrderList.get(i).getUserId().equals(orderOfOrderList.get(j).getUserId())) {
					BigDecimal orderSum = new BigDecimal(0.00);
					SupplierOfOrder supplierOfOrderS =new SupplierOfOrder();
					supplierOfOrderS.setSupplierOfOrderId(UUIDGenerator.getUUID());
					supplierOfOrderS.setOrderId(orderOfOrderList.get(j).getId());
					supplierOfOrderS.setSupplierOfAgentId(supplierOfAgentS.getSupplierOfAgentId());
					//supplierOfAgentVO.getInsurancePriceInfoList().get(j).setOrderId(orderOfOrderList.get(j).getId());
					for (int k = 0; k < supplierOfAgentVO.getInsurancePriceInfoList().size(); k++) {
						if (agentOfOrderList.get(i).getUserId().equals(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getUserId()) && orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getOrderId())) {
							
							supplierOfAgentVO.getInsurancePriceInfoList().get(k).setInsurancePriceInfoId(UUIDGenerator.getUUID());
							supplierOfAgentVO.getInsurancePriceInfoList().get(k).setSupplierOfAgentId(supplierOfAgentS.getSupplierOfAgentId());
							BigDecimal totalsum=supplierOfAgentVO.getInsurancePriceInfoList().get(k).getReceivable();
							if(!totalsum.equals(BigDecimal.ZERO)){
								sum =sum.add(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getReceivable());
							}
							if(!supplierOfAgentVO.getInsurancePriceInfoList().get(k).getIsDel().equals("1")){
								totalPeople++;
								customerNos+=(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getCustomerNo()+",");
							}
							orderSum=orderSum.add(totalsum);
						}
					}
				
					supplierOfOrderS.setSum(orderSum);
					supplierOfOrderList.add(supplierOfOrderS);
				}
			}

			supplierOfAgentS.setSum(sum);
			supplierOfAgentList.add(supplierOfAgentS);
			
			SupplierCheck supplierCheckS = new SupplierCheck();
			supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
			supplierCheckS.setUserIdOfAgent(agentOfOrderList.get(i).getUserId());
			List<SupplierCheck> supplierCheckListS = supplierCheckService.find(supplierCheckS);
			supplierCheckS.setCustomerNos(customerNos);
			supplierCheckS.setTotalPeople(totalPeople);
			
			//查找本部门的汇率
			RateOfCurrency rateOfCurrency=new RateOfCurrency();
			Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
			rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
			Dept deptS=deptService.findById(agentOfOrderList.get(i).getDeptId());
			rateOfCurrency.setToCurrencyId(deptS.getCurrencyTypeId());
			rateOfCurrency.setIsAvailable(0);// 0 可 用
			List<RateOfCurrency> rateOfCurrencyList = rateOfCurrencyService.find(rateOfCurrency);
			
			if (rateOfCurrencyList.size()>0) {
				
				supplierCheckS.setRateOfCurrencyId(rateOfCurrencyList.get(0).getId());
			}
			//查找对方本部门的汇率
			RateOfCurrency toRateOfCurrency=new RateOfCurrency();
			toRateOfCurrency.setCurrencyId(deptS.getCurrencyTypeId());
			toRateOfCurrency.setToCurrencyId(dept.getCurrencyTypeId());
			toRateOfCurrency.setIsAvailable(0);// 0 可 用
			List<RateOfCurrency> toRateOfCurrencyList = rateOfCurrencyService.find(toRateOfCurrency);
			
			if (toRateOfCurrencyList.size()>0) {
				supplierCheckS.setToRateOfCurrencyId(toRateOfCurrencyList.get(0).getId());
			}
			//判断团下是否有agent
			if(temp){
				supplierCheckS.setCheckOfAgent(0);
				supplierCheckList.add(supplierCheckS);
			}else{
				for(int j=0;j<supplierCheckListS.size();j++){
					supplierCheckList.add(supplierCheckListS.get(j));
				}
			}
			
			supplierPrice.setTotalPeople(totalPeople);
		}

		supPriceInfoRelService.save(supplierPrice, supPriceInfoRel, supplierOfAgentList, supplierCheckList, null, null, null, supplierOfAgentVO.getInsurancePriceInfoList(), supplierOfOrderList);
		
		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplier.jhtml";
	}
	/**
	 * OP group录账单功能
	 * @param model
	 * @param supplierOfAgentVO
	 * @param supPriceInfoRel
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/saveGroup", method = RequestMethod.POST)
	public String saveGroup(ModelMap model,SupplierOfAgentVO supplierOfAgentVO,
			SupPriceInfoRel supPriceInfoRel, Order order) {

		SupplierPrice supplierPrice = supplierPriceService.findByTourId(order
				.getTourId());
		boolean temp=false;
		if (supplierPrice != null) {

			if (supPriceInfoRel.getRemark() != null
					&& supplierPrice.getRemark() != null) {
				supplierPrice.setRemark(supplierPrice.getRemark() + "\n"
						+ supPriceInfoRel.getRemark());
			} else if (supplierPrice.getRemark() == null
					&& supPriceInfoRel.getRemark() != null) {
				supplierPrice.setRemark(supPriceInfoRel.getRemark());
			}
			// 判断 是否包含4 4代表 账单中已经录入 保险
			if (!supplierPrice.getSupType().contains(SUPPLIER_TYPE)) {
				supplierPrice.setSupType(supplierPrice.getSupType()+SUPPLIER_TYPE);
			}
		} else {
			temp=true;
			supplierPrice = new SupplierPrice();
			supplierPrice.setTourId(order.getTourId());
			supplierPrice.setTourCode(order.getTourCode());
			supplierPrice.setCreateTime(new Date());
			supplierPrice.setAllCheck(0);
			supplierPrice.setAccCheck(0);
			supplierPrice.setInvoiceState(0);
			supplierPrice.setCompleteState(0);
			supplierPrice.setSupType(SUPPLIER_TYPE);
			if (supPriceInfoRel.getRemark() != null) {
				supplierPrice.setRemark(supPriceInfoRel.getRemark() + "\n");
			}
		}
		supPriceInfoRel.setSupPriceInfoRelId(UUIDGenerator.getUUID());
		supPriceInfoRel.setTourId(order.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(SUPPLIER_TYPE));
		supPriceInfoRel.setSupplierState(0);
		supPriceInfoRel.setCreateTime(new Date());

		// 查找团下的Agent
		List<Order> agentOfOrderList = orderService.findUserOfOrder(order);

		// 查找团下的Order
		List<Order> orderOfOrderList = orderService.find(order);

		// Agent团账单供应商 集合
		List<SupplierOfOrder> supplierOfOrderList = new ArrayList<SupplierOfOrder>();

		// Agent团账单供应商订单集合
		List<SupplierOfAgent> supplierOfAgentList = new ArrayList<SupplierOfAgent>();
		
		//Agent账单审核
		List<SupplierCheck> supplierCheckList=new ArrayList<SupplierCheck>();

		for(int i=0;i<agentOfOrderList.size();i++){
			SupplierOfAgent supplierOfAgentS = new SupplierOfAgent();
			supplierOfAgentS.setSupplierOfAgentId(UUIDGenerator.getUUID());
			supplierOfAgentS.setUserId(agentOfOrderList.get(i).getUserId());
			supplierOfAgentS.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
			
			//每个Agent收入总数（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			//每个Agent收客人数
			Integer totalPeople =0;
			String customerNos="";
			
			for (int j = 0; j < orderOfOrderList.size(); j++) {
				if (agentOfOrderList.get(i).getUserId().equals(orderOfOrderList.get(j).getUserId())) {
					BigDecimal orderSum = new BigDecimal(0.00);
					SupplierOfOrder supplierOfOrderS =new SupplierOfOrder();
					supplierOfOrderS.setSupplierOfOrderId(UUIDGenerator.getUUID());
					supplierOfOrderS.setOrderId(orderOfOrderList.get(j).getId());
					supplierOfOrderS.setSupplierOfAgentId(supplierOfAgentS.getSupplierOfAgentId());
					//supplierOfAgentVO.getInsurancePriceInfoList().get(j).setOrderId(orderOfOrderList.get(j).getId());
					for (int k = 0; k < supplierOfAgentVO.getInsurancePriceInfoList().size(); k++) {
						if (agentOfOrderList.get(i).getUserId().equals(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getUserId()) && orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getOrderId())) {
							
							supplierOfAgentVO.getInsurancePriceInfoList().get(k).setInsurancePriceInfoId(UUIDGenerator.getUUID());
							supplierOfAgentVO.getInsurancePriceInfoList().get(k).setSupplierOfAgentId(supplierOfAgentS.getSupplierOfAgentId());
							BigDecimal totalsum=supplierOfAgentVO.getInsurancePriceInfoList().get(k).getReceivable();
							if(!totalsum.equals(BigDecimal.ZERO)){
								sum =sum.add(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getReceivable());
							}
							if(!supplierOfAgentVO.getInsurancePriceInfoList().get(k).getIsDel().equals("1")){
								totalPeople++;
								customerNos+=(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getCustomerNo()+",");
							}
							orderSum=orderSum.add(totalsum);
						}
					}
				
					supplierOfOrderS.setSum(orderSum);
					supplierOfOrderList.add(supplierOfOrderS);
				}
			}

			supplierOfAgentS.setSum(sum);
			supplierOfAgentList.add(supplierOfAgentS);
			
			SupplierCheck supplierCheckS = new SupplierCheck();
			supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
			supplierCheckS.setUserIdOfAgent(agentOfOrderList.get(i).getUserId());
			List<SupplierCheck> supplierCheckListS = supplierCheckService.find(supplierCheckS);
			supplierCheckS.setCustomerNos(customerNos);
			supplierCheckS.setTotalPeople(totalPeople);
			
			//查找本部门的汇率
			RateOfCurrency rateOfCurrency=new RateOfCurrency();
			Dept dept=deptService.findById(adminService.getCurrent().getDeptId());
			rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
			Dept deptS=deptService.findById(agentOfOrderList.get(i).getDeptId());
			rateOfCurrency.setToCurrencyId(deptS.getCurrencyTypeId());
			rateOfCurrency.setIsAvailable(0);// 0 可 用
			List<RateOfCurrency> rateOfCurrencyList = rateOfCurrencyService.find(rateOfCurrency);
			
			if (rateOfCurrencyList.size()>0) {
				
				supplierCheckS.setRateOfCurrencyId(rateOfCurrencyList.get(0).getId());
			}
			//查找对方本部门的汇率
			RateOfCurrency toRateOfCurrency=new RateOfCurrency();
			toRateOfCurrency.setCurrencyId(deptS.getCurrencyTypeId());
			toRateOfCurrency.setToCurrencyId(dept.getCurrencyTypeId());
			toRateOfCurrency.setIsAvailable(0);// 0 可 用
			List<RateOfCurrency> toRateOfCurrencyList = rateOfCurrencyService.find(toRateOfCurrency);
			
			if (toRateOfCurrencyList.size()>0) {
				supplierCheckS.setToRateOfCurrencyId(toRateOfCurrencyList.get(0).getId());
			}
			//判断团下是否有agent
			if(temp){
				supplierCheckS.setCheckOfAgent(0);
				supplierCheckList.add(supplierCheckS);
			}else{
				for(int j=0;j<supplierCheckListS.size();j++){
					supplierCheckList.add(supplierCheckListS.get(j));
				}
			}
			
			supplierPrice.setTotalPeople(totalPeople);
		}

		supPriceInfoRelService.save(supplierPrice, supPriceInfoRel, supplierOfAgentList, supplierCheckList, null, null, null, supplierOfAgentVO.getInsurancePriceInfoList(), supplierOfOrderList);
		
		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplierGroup.jhtml";
	}
	/**
	 * 跳转修改地接社账单
	 */
	@RequestMapping(value = "/updateInsurance", method = RequestMethod.GET)
	public String updateInsurance(ModelMap model, Tour tour,
			SupPriceInfoRel supPriceInfoRel) {
		model.addAttribute("menuId", "404");
		model.addAttribute("Tour", tour);
		InsurancePriceInfo insurancePriceInfo = new InsurancePriceInfo();
		//insurancePriceInfo.setUserId(adminService.getCurrent().getId());
		insurancePriceInfo.setSupPriceInfoRelId(supPriceInfoRel
				.getSupPriceInfoRelId());
		model.addAttribute("InsuranceList" ,
		insurancePriceInfoService.findInsuranceAndCustomer(insurancePriceInfo));
		model.addAttribute("supPriceInfoRel", supPriceInfoRelService
				.findById(supPriceInfoRel.getSupPriceInfoRelId()));
		model.addAttribute("supplierPrice" , supplierPriceService.findByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderInsuranceUpdate";
	}
	/**OP Group录账单功能
	 * 跳转修改地接社账单
	 */
	@RequestMapping(value = "/updateInsuranceGroup", method = RequestMethod.GET)
	public String updateInsuranceGroup(ModelMap model, Tour tour,
			SupPriceInfoRel supPriceInfoRel) {
		model.addAttribute("menuId", "414");
		model.addAttribute("Tour", tour);
		InsurancePriceInfo insurancePriceInfo = new InsurancePriceInfo();
		//insurancePriceInfo.setUserId(adminService.getCurrent().getId());
		insurancePriceInfo.setSupPriceInfoRelId(supPriceInfoRel
				.getSupPriceInfoRelId());
		model.addAttribute("InsuranceList" ,
		insurancePriceInfoService.findInsuranceAndCustomer(insurancePriceInfo));
		model.addAttribute("supPriceInfoRel", supPriceInfoRelService
				.findById(supPriceInfoRel.getSupPriceInfoRelId()));
		model.addAttribute("supplierPrice" , supplierPriceService.findByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderInsuranceUpdateGroup";
	}
	
	/**
	 * 修改数据
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ModelMap model,SupplierOfAgentVO supplierOfAgentVO,
			SupPriceInfoRel supPriceInfoRel, Order order,SupplierPrice supplierPrice) {
		supplierPrice = supplierPriceService.findById(supplierPrice.getSupplierPriceId());
		if (supPriceInfoRel.getRemark() != null && supplierPrice.getRemark() != null) {
			supplierPrice.setRemark(supplierPrice.getRemark() + "\n" + supPriceInfoRel.getRemark());
		} else if (supplierPrice.getRemark() == null && supPriceInfoRel.getRemark() != null) {
			supplierPrice.setRemark(supPriceInfoRel.getRemark());
		}

		supPriceInfoRel.setSupplierState(0);
		supPriceInfoRel.setTourId(order.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(SUPPLIER_TYPE));
		supPriceInfoRel.setCreateTime(supPriceInfoRelService.findById(supPriceInfoRel.getSupPriceInfoRelId()).getCreateTime());
		SupplierOfAgent supplierOfAgent=new SupplierOfAgent();
		supplierOfAgent.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
		
		//Agent团账单供应商订单集合
		List<SupplierOfAgent> supplierOfAgentList = supplierOfAgentService.find(supplierOfAgent);
		
		//Agent团账单供应商 集合
		List<SupplierOfOrder> supplierOfOrderList = new ArrayList<SupplierOfOrder>();
		
		List<Order> orderList = new ArrayList<Order>();
		for (int i = 0; i < supplierOfAgentList.size(); i++) {
			// 每个Agent收入总数（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			
			// 查找团下的Order
			order.setUserId(supplierOfAgentList.get(i).getUserId());
			List<Order> orderOfOrderList = orderService.find(order);
			for (int j = 0; j < orderOfOrderList.size(); j++) {
				//将申请结算状态置为为结算状态
				Order orders = orderService.findById(orderOfOrderList.get(j).getId());
				if(orders.getTax() == 3){
					orders.setTax(1);
				}
				orderList.add(orders);
				
				BigDecimal orderSum= new BigDecimal(0.00);
				
				SupplierOfOrder supplierOfOrderS = new SupplierOfOrder();
				supplierOfOrderS.setOrderId(orderOfOrderList.get(j).getId());
				supplierOfOrderS.setSupplierOfAgentId(supplierOfAgentList.get(i).getSupplierOfAgentId());
				supplierOfOrderS = supplierOfOrderService.find(supplierOfOrderS).get(0);

				// 每个Agent收客人数
				for (int k = 0; k < supplierOfAgentVO.getInsurancePriceInfoList().size(); k++) {
					if (orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getOrderId())) {
						BigDecimal totalsum = supplierOfAgentVO.getInsurancePriceInfoList().get(k).getReceivable();

						sum=sum.add(totalsum);
						orderSum=orderSum.add(totalsum);
					}
					supplierOfOrderS.setSum(orderSum);
				}
				supplierOfOrderList.add(supplierOfOrderS);
			}
			
			supplierOfAgentList.get(i).setSum(sum);
		}

		supplierPrice.setAllCheck(0);
		supplierPrice.setAccCheck(0);

		SupplierCheck supplierCheckS = new SupplierCheck();
		supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
		List<SupplierCheck> supplierCheckList = supplierCheckService.find(supplierCheckS);
		for (int j = 0; j < supplierCheckList.size(); j++) {
			if (supplierCheckList.get(j).getCheckOfAgent() != 0) {
				supplierCheckList.get(j).setCheckOfAgent(0);
			}
		}
		supPriceInfoRelService.updateSupplier(supplierPrice, supPriceInfoRel,
				supplierOfAgentList, supplierCheckList, null, null,null, supplierOfAgentVO.getInsurancePriceInfoList(),
				supplierOfOrderList, orderList);
		
		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplier.jhtml";
	}
	/**
	 * OP Group录账单功能
	 * @param model
	 * @param supplierOfAgentVO
	 * @param supPriceInfoRel
	 * @param order
	 * @param supplierPrice
	 * @return
	 */
	@RequestMapping(value = "/updateGroup", method = RequestMethod.POST)
	public String updateGroup(ModelMap model,SupplierOfAgentVO supplierOfAgentVO,
			SupPriceInfoRel supPriceInfoRel, Order order,SupplierPrice supplierPrice) {
		supplierPrice = supplierPriceService.findById(supplierPrice.getSupplierPriceId());
		if (supPriceInfoRel.getRemark() != null && supplierPrice.getRemark() != null) {
			supplierPrice.setRemark(supplierPrice.getRemark() + "\n" + supPriceInfoRel.getRemark());
		} else if (supplierPrice.getRemark() == null && supPriceInfoRel.getRemark() != null) {
			supplierPrice.setRemark(supPriceInfoRel.getRemark());
		}

		supPriceInfoRel.setSupplierState(0);
		supPriceInfoRel.setTourId(order.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(SUPPLIER_TYPE));
		supPriceInfoRel.setCreateTime(supPriceInfoRelService.findById(supPriceInfoRel.getSupPriceInfoRelId()).getCreateTime());
		SupplierOfAgent supplierOfAgent=new SupplierOfAgent();
		supplierOfAgent.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
		
		//Agent团账单供应商订单集合
		List<SupplierOfAgent> supplierOfAgentList = supplierOfAgentService.find(supplierOfAgent);
		
		//Agent团账单供应商 集合
		List<SupplierOfOrder> supplierOfOrderList = new ArrayList<SupplierOfOrder>();
		
		List<Order> orderList = new ArrayList<Order>();
		for (int i = 0; i < supplierOfAgentList.size(); i++) {
			// 每个Agent收入总数（应收美国收入）
			BigDecimal sum= new BigDecimal(0.00);
			
			// 查找团下的Order
			order.setUserId(supplierOfAgentList.get(i).getUserId());
			List<Order> orderOfOrderList = orderService.find(order);
			for (int j = 0; j < orderOfOrderList.size(); j++) {
				//将申请结算状态置为为结算状态
				Order orders = orderService.findById(orderOfOrderList.get(j).getId());
				if(orders.getTax() == 3){
					orders.setTax(1);
				}
				orderList.add(orders);
				
				BigDecimal orderSum= new BigDecimal(0.00);
				
				SupplierOfOrder supplierOfOrderS = new SupplierOfOrder();
				supplierOfOrderS.setOrderId(orderOfOrderList.get(j).getId());
				supplierOfOrderS.setSupplierOfAgentId(supplierOfAgentList.get(i).getSupplierOfAgentId());
				supplierOfOrderS = supplierOfOrderService.find(supplierOfOrderS).get(0);

				// 每个Agent收客人数
				for (int k = 0; k < supplierOfAgentVO.getInsurancePriceInfoList().size(); k++) {
					if (orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getInsurancePriceInfoList().get(k).getOrderId())) {
						BigDecimal totalsum = supplierOfAgentVO.getInsurancePriceInfoList().get(k).getReceivable();

						sum=sum.add(totalsum);
						orderSum=orderSum.add(totalsum);
					}
					supplierOfOrderS.setSum(orderSum);
				}
				supplierOfOrderList.add(supplierOfOrderS);
			}
			
			supplierOfAgentList.get(i).setSum(sum);
		}

		supplierPrice.setAllCheck(0);
		supplierPrice.setAccCheck(0);

		SupplierCheck supplierCheckS = new SupplierCheck();
		supplierCheckS.setSupplierPriceId(supplierPrice.getSupplierPriceId());
		List<SupplierCheck> supplierCheckList = supplierCheckService.find(supplierCheckS);
		for (int j = 0; j < supplierCheckList.size(); j++) {
			if (supplierCheckList.get(j).getCheckOfAgent() != 0) {
				supplierCheckList.get(j).setCheckOfAgent(0);
			}
		}
		supPriceInfoRelService.updateSupplier(supplierPrice, supPriceInfoRel,
				supplierOfAgentList, supplierCheckList, null, null,null, supplierOfAgentVO.getInsurancePriceInfoList(),
				supplierOfOrderList, orderList);
		
		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplierGroup.jhtml";
	}
}
