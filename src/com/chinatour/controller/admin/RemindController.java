/**
 * 
 */
package com.chinatour.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinatour.entity.Admin;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerConsult;
import com.chinatour.entity.NoticeContact;
import com.chinatour.entity.Order;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.service.AdminService;
import com.chinatour.service.CustomerConsultService;
import com.chinatour.service.CustomerService;
import com.chinatour.service.NoticeService;
import com.chinatour.service.OrderService;
import com.chinatour.service.SupplierCheckService;
import com.chinatour.service.SupplierPriceService;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 上午10:10:10
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/remind")
public class RemindController  extends BaseController{
	
	@Resource(name = "noticeServiceImpl")
	private NoticeService noticeService;
	
	@Resource(name = "supplierCheckServiceImpl")
	private SupplierCheckService supplierCheckService;
	
	@Resource(name = "supplierPriceServiceImpl")
	private SupplierPriceService supplierPriceService;
	
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	
	@Resource(name = "customerServiceImpl")
	private CustomerService customerService;
	
	@Resource(name = "orderServiceImpl")
	private OrderService orderService;
	
	@Resource(name = "customerConsultServiceImpl")
	private CustomerConsultService customerConsultService;
	
	/**
	 * 异步查询未读站内信
	 */
	@RequestMapping(value = "/unRead", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> unRead() {
		Admin admin = adminService.getCurrent();
		NoticeContact noticeContact = new NoticeContact();
		noticeContact.setReceiveUser(admin.getId());
		noticeContact.setState(0);		//查询未查看站内信
		int unReadNum = noticeService.unReadTotal(noticeContact);
		
		SupplierCheck supplierCheck = new SupplierCheck();
		supplierCheck.setUserIdOfAgent(admin.getId());
		supplierCheck.setCheckOfAgent(0);	//查询Agent未审核账单
		int supCheckNum = supplierCheckService.findCount(supplierCheck);
		
		SupplierPrice supplierPrice = new SupplierPrice();
		supplierPrice.setAllCheck(2);		//查询OP被拒绝账单
		supplierPrice.setUserId(admin.getId());
		int supPriceNum=supplierPriceService.findCount(supplierPrice);		
		
		Calendar calendar   =   new   GregorianCalendar(); 
    	calendar.setTime(new Date());
    	calendar.add(Calendar.DAY_OF_MONTH, 30);//把日期往后增加一天.整数往后推,负数往前移动
    	
    	Order order = new Order();
    	order.setBeginningDate(new Date());
    	order.setEndingDate(calendar.getTime());
    	order.setUserId(admin.getId());
    	int orderSum=orderService.findCount(order);
    	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
    	CustomerConsult customerConsult = new CustomerConsult();
    	customerConsult.setUserId(admin.getId());
    	int customerConsultSum = customerConsultService.findForEndDate(customerConsult);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("unReadNum", unReadNum);
		map.put("supCheckNum", supCheckNum);
		map.put("supPriceNum", supPriceNum);
		map.put("orderSum", orderSum);
		map.put("beginningDate", dateFormat.format(order.getBeginningDate()));
		map.put("endingDate", dateFormat.format(order.getEndingDate()));
		map.put("customerConsultSum", customerConsultSum);
		return map;
	}
	
	/**
	 * 搜索咨询客人
	 * @param customer
	 * @returni
	 */
	@RequestMapping(value = "/findCustomerList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> findCustomerList( String customerInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Customer customer = new Customer();
		if(customerInfo.matches("[0-9]{1,}")){
			customer.setTel(customerInfo);
		}else{
			String[] customerInfos = customerInfo.split("/");
			customer.setLastName(customerInfos[0]);
			if(customerInfos.length==2){
				customer.setFirstName(customerInfos[1]);
			}
		}
		List<Customer> customerList = customerService.findCustomerList(customer);
		int customerCount = customerService.findCountCustomerList(customer);
		map.put("customerList", customerList);
		map.put("customerCount", customerCount);
		return map;
	}
}
