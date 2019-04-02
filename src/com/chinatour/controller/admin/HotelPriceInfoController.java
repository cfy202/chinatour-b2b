package com.chinatour.controller.admin;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Dept;
import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.entity.HotelPriceInfo;
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
import com.chinatour.service.HotelPriceInfoService;
import com.chinatour.service.HotelService;
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
import com.chinatour.vo.TourOrderListVO;

/**
 * 团账单机票
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-23 下午3:56:56
 * @revision 3.0
 */
@Controller
@RequestMapping("/admin/hotelPriceInfo")
public class HotelPriceInfoController extends BaseController {

	@Resource(name = "adminServiceImpl")
	private AdminService adminService;

	@Resource(name = "hotelPriceInfoServiceImpl")
	private HotelPriceInfoService hotelPriceInfoService;

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
	
	@Resource(name = "hotelServiceImpl")
	private HotelService hotelService;
	
	@Resource(name = "rateOfCurrencyServiceImpl")
	private RateOfCurrencyService rateOfCurrencyService;
	
	@Resource(name = "deptServiceImpl")
	private DeptService deptService;
	
	private String SUPPLIER_TYPE = "2";// 供应商类型 2代表酒店
	/**
	 * 加载
	 */
	@RequestMapping(value = "/orderHotelAdd", method = RequestMethod.GET)
	public String orderHotelAdd(ModelMap model, Tour tour) {
		model.addAttribute("menuId", "404");
		model.addAttribute("tour", tour);
		model.addAttribute("hotelS" , hotelService.findAll());
		model.addAttribute("customerList",
				supPriceInfoRelService.findCustomerByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderHotelAdd";
	}
	/**
	 * Op Group录账单
	 */
	@RequestMapping(value = "/orderHotelAddGroup", method = RequestMethod.GET)
	public String orderHotelAddGroup(ModelMap model, Tour tour) {
		model.addAttribute("menuId", "414");
		model.addAttribute("tour", tour);
		model.addAttribute("hotelS" , hotelService.findAll());
		model.addAttribute("customerList",
				supPriceInfoRelService.findCustomerByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderHotelAddGroup";
	}
	/**
	 * 保存数据
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(ModelMap model,SupplierOfAgentVO supplierOfAgentVO,
			SupPriceInfoRel supPriceInfoRel, Order order) {
		
		SupplierPrice supplierPrice=supplierPriceService.findByTourId(order.getTourId());	
		boolean temp=false;
		if(supplierPrice!=null){
			
			 if(supPriceInfoRel.getRemark()!=null&&supplierPrice.getRemark()!=null){
				 supplierPrice.setRemark(supplierPrice.getRemark()+"\n"+supPriceInfoRel.getRemark());
				}else if(supplierPrice.getRemark()==null&&supPriceInfoRel.getRemark()!=null){
			    	supplierPrice.setRemark(supPriceInfoRel.getRemark());
			    }
			 //判断 是否包含2    2代表  账单中已经录入 酒店
			 if(!supplierPrice.getSupType().contains(SUPPLIER_TYPE)){
				 supplierPrice.setSupType(supplierPrice.getSupType()+SUPPLIER_TYPE);
			 }
		}else{
			 temp=true;
			supplierPrice=new SupplierPrice();
			supplierPrice.setTourId(order.getTourId());
			supplierPrice.setTourCode(order.getTourCode());
			supplierPrice.setCreateTime(new Date());
			supplierPrice.setAllCheck(0);
			supplierPrice.setAccCheck(0);
			supplierPrice.setInvoiceState(0);
			supplierPrice.setCompleteState(0);
			supplierPrice.setSupType(SUPPLIER_TYPE);
			if(supPriceInfoRel.getRemark()!=null){
				supplierPrice.setRemark(supPriceInfoRel.getRemark()+"\n");
			}
		}
		supPriceInfoRel.setSupPriceInfoRelId(UUIDGenerator.getUUID());
		supPriceInfoRel.setTourId(order.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(SUPPLIER_TYPE));
		supPriceInfoRel.setSupplierState(0);
		supPriceInfoRel.setCreateTime(new Date());
		
		//查找团下的Agent
		List<Order> agentOfOrderList  = orderService.findUserOfOrder(order);
		
		// 查找团下的Order
		List<Order> orderOfOrderList = orderService.find(order);
		
		//Agent团账单供应商 集合
		List<SupplierOfOrder> supplierOfOrderList = new ArrayList<SupplierOfOrder>();
		
		//Agent团账单供应商订单集合
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
					//supplierOfAgentVO.getHotelPriceInfoList().get(j).setOrderId(orderOfOrderList.get(j).getId());
					for (int k = 0; k < supplierOfAgentVO.getHotelPriceInfoList().size(); k++) {
						if (agentOfOrderList.get(i).getUserId().equals(supplierOfAgentVO.getHotelPriceInfoList().get(k).getUserId()) && orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getHotelPriceInfoList().get(k).getOrderId())) {
							
							supplierOfAgentVO.getHotelPriceInfoList().get(k).setHotelPriceInfoId(UUIDGenerator.getUUID());
							supplierOfAgentVO.getHotelPriceInfoList().get(k).setSupplierOfAgentId(supplierOfAgentS.getSupplierOfAgentId());
							
							BigDecimal totalsum = (supplierOfAgentVO.getHotelPriceInfoList().get(k).getRoomPrice().add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBed()).add(
									supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithOutBed()).add( supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBreakFirstPrice()).add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getSinglePrice()));
							if(!totalsum.equals(BigDecimal.ZERO)){
								sum =sum.add(totalsum);
							}
							if(!supplierOfAgentVO.getHotelPriceInfoList().get(k).getIsDel().equals("1")){
								totalPeople++;
								customerNos+=(supplierOfAgentVO.getHotelPriceInfoList().get(k).getCustomerNo()+",");
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
		supPriceInfoRelService.save(supplierPrice, supPriceInfoRel, supplierOfAgentList, supplierCheckList, null, supplierOfAgentVO.getHotelPriceInfoList(), null, null, supplierOfOrderList);
		
		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplier.jhtml";
	}
	/**Op Group录账单
	 * 保存数据
	 */
	@RequestMapping(value = "/saveGroup", method = RequestMethod.POST)
	public String saveGroup(ModelMap model,SupplierOfAgentVO supplierOfAgentVO,
			SupPriceInfoRel supPriceInfoRel, Order order) {
		
		SupplierPrice supplierPrice=supplierPriceService.findByTourId(order.getTourId());	
		boolean temp=false;
		if(supplierPrice!=null){
			
			 if(supPriceInfoRel.getRemark()!=null&&supplierPrice.getRemark()!=null){
				 supplierPrice.setRemark(supplierPrice.getRemark()+"\n"+supPriceInfoRel.getRemark());
				}else if(supplierPrice.getRemark()==null&&supPriceInfoRel.getRemark()!=null){
			    	supplierPrice.setRemark(supPriceInfoRel.getRemark());
			    }
			 //判断 是否包含2    2代表  账单中已经录入 酒店
			 if(!supplierPrice.getSupType().contains(SUPPLIER_TYPE)){
				 supplierPrice.setSupType(supplierPrice.getSupType()+SUPPLIER_TYPE);
			 }
		}else{
			 temp=true;
			supplierPrice=new SupplierPrice();
			supplierPrice.setTourId(order.getTourId());
			supplierPrice.setTourCode(order.getTourCode());
			supplierPrice.setCreateTime(new Date());
			supplierPrice.setAllCheck(0);
			supplierPrice.setAccCheck(0);
			supplierPrice.setInvoiceState(0);
			supplierPrice.setCompleteState(0);
			supplierPrice.setSupType(SUPPLIER_TYPE);
			if(supPriceInfoRel.getRemark()!=null){
				supplierPrice.setRemark(supPriceInfoRel.getRemark()+"\n");
			}
		}
		supPriceInfoRel.setSupPriceInfoRelId(UUIDGenerator.getUUID());
		supPriceInfoRel.setTourId(order.getTourId());
		supPriceInfoRel.setType(Integer.valueOf(SUPPLIER_TYPE));
		supPriceInfoRel.setSupplierState(0);
		supPriceInfoRel.setCreateTime(new Date());
		
		//查找团下的Agent
		List<Order> agentOfOrderList  = orderService.findUserOfOrder(order);
		
		// 查找团下的Order
		List<Order> orderOfOrderList = orderService.find(order);
		
		//Agent团账单供应商 集合
		List<SupplierOfOrder> supplierOfOrderList = new ArrayList<SupplierOfOrder>();
		
		//Agent团账单供应商订单集合
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
					//supplierOfAgentVO.getHotelPriceInfoList().get(j).setOrderId(orderOfOrderList.get(j).getId());
					for (int k = 0; k < supplierOfAgentVO.getHotelPriceInfoList().size(); k++) {
						if (agentOfOrderList.get(i).getUserId().equals(supplierOfAgentVO.getHotelPriceInfoList().get(k).getUserId()) && orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getHotelPriceInfoList().get(k).getOrderId())) {
							
							supplierOfAgentVO.getHotelPriceInfoList().get(k).setHotelPriceInfoId(UUIDGenerator.getUUID());
							supplierOfAgentVO.getHotelPriceInfoList().get(k).setSupplierOfAgentId(supplierOfAgentS.getSupplierOfAgentId());
							
							BigDecimal totalsum = (supplierOfAgentVO.getHotelPriceInfoList().get(k).getRoomPrice().add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBed()).add(
									supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithOutBed()).add( supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBreakFirstPrice()).add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getSinglePrice()));
							if(!totalsum.equals(BigDecimal.ZERO)){
								sum =sum.add(totalsum);
							}
							if(!supplierOfAgentVO.getHotelPriceInfoList().get(k).getIsDel().equals("1")){
								totalPeople++;
								customerNos+=(supplierOfAgentVO.getHotelPriceInfoList().get(k).getCustomerNo()+",");
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
		supPriceInfoRelService.save(supplierPrice, supPriceInfoRel, supplierOfAgentList, supplierCheckList, null, supplierOfAgentVO.getHotelPriceInfoList(), null, null, supplierOfOrderList);
		
		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplierGroup.jhtml";
	}
	/**
	 * 跳转修改酒店账单
	 */
	@RequestMapping(value = "/updateHotel", method = RequestMethod.GET)
	public String updateHotel(ModelMap model, Tour tour,SupPriceInfoRel supPriceInfoRel) {
		model.addAttribute("menuId", "404");
		model.addAttribute("Tour", tour);
		model.addAttribute("hotelS" , hotelService.findAll());
		HotelPriceInfo hotelPriceInfo =new HotelPriceInfo();
		//hotelPriceInfo.setUserId(adminService.getCurrent().getId());
		hotelPriceInfo.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
		model.addAttribute("hotelList" , hotelPriceInfoService.findHotelAndCustomer(hotelPriceInfo));
		model.addAttribute("supPriceInfoRel" , supPriceInfoRelService.findById(supPriceInfoRel.getSupPriceInfoRelId()));
		model.addAttribute("supplierPrice" , supplierPriceService.findByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderHotelUpdate";
	}
	/**
	 * 跳转修改酒店账单
	 */
	@RequestMapping(value = "/updateHotelGroup", method = RequestMethod.GET)
	public String updateHotelGroup(ModelMap model, Tour tour,SupPriceInfoRel supPriceInfoRel) {
		model.addAttribute("menuId", "414");
		model.addAttribute("Tour", tour);
		model.addAttribute("hotelS" , hotelService.findAll());
		HotelPriceInfo hotelPriceInfo =new HotelPriceInfo();
		//hotelPriceInfo.setUserId(adminService.getCurrent().getId());
		hotelPriceInfo.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
		model.addAttribute("hotelList" , hotelPriceInfoService.findHotelAndCustomer(hotelPriceInfo));
		model.addAttribute("supPriceInfoRel" , supPriceInfoRelService.findById(supPriceInfoRel.getSupPriceInfoRelId()));
		model.addAttribute("supplierPrice" , supplierPriceService.findByTourId(tour.getTourId()));
		return "/admin/orderSupplier/orderHotelUpdateGroup";
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
				for (int k = 0; k < supplierOfAgentVO.getHotelPriceInfoList().size(); k++) {
					if (orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getHotelPriceInfoList().get(k).getOrderId())) {
						BigDecimal totalsum = (supplierOfAgentVO.getHotelPriceInfoList().get(k).getRoomPrice().add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBed()).add(
								supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithOutBed()).add( supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBreakFirstPrice()).add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getSinglePrice()));
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
				supplierOfAgentList, supplierCheckList, null,supplierOfAgentVO.getHotelPriceInfoList(), null, null,
				supplierOfOrderList, orderList);

		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplier.jhtml";
	}
	/**
	 * 修改数据
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
				for (int k = 0; k < supplierOfAgentVO.getHotelPriceInfoList().size(); k++) {
					if (orderOfOrderList.get(j).getId().equals(supplierOfAgentVO.getHotelPriceInfoList().get(k).getOrderId())) {
						BigDecimal totalsum = (supplierOfAgentVO.getHotelPriceInfoList().get(k).getRoomPrice().add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBed()).add(
								supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithOutBed()).add( supplierOfAgentVO.getHotelPriceInfoList().get(k).getWithBreakFirstPrice()).add(supplierOfAgentVO.getHotelPriceInfoList().get(k).getSinglePrice()));
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
				supplierOfAgentList, supplierCheckList, null,supplierOfAgentVO.getHotelPriceInfoList(), null, null,
				supplierOfOrderList, orderList);

		model.addAttribute("tourId",order.getTourId());
		model.addAttribute("tourCode",order.getTourCode());
		model.addAttribute("type",SUPPLIER_TYPE);
		return "redirect:/admin/supplierPrice/searchSupplierGroup.jhtml";
	}
}
