package com.chinatour.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.chinatour.DateEditor;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Customer;
import com.chinatour.entity.Order;
import com.chinatour.entity.State;
import com.chinatour.service.AdminService;
import com.chinatour.service.CountryService;
import com.chinatour.service.LanguageService;
import com.chinatour.service.OrderService;
import com.chinatour.service.PayCostRecordsService;
import com.chinatour.service.SOrderReceiveItemService;
import com.chinatour.service.StateService;
import com.chinatour.service.VenderService;
import com.chinatour.vo.PayCostEditVO;
import com.chinatour.vo.SingleOrdersVO;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

/**
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Sep 5, 2014 1:59:52 PM
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/sinord")
public class SingleOrdersController extends BaseController {

	public static final TemplateHashModel CONSTANT;
	
	static {
		TemplateHashModel constant = null;
		try {
			constant = BeansWrapper.getDefaultInstance().getStaticModels();
			constant = (TemplateHashModel)constant.get("com.chinatour.Constant");
		} catch (TemplateModelException e) {
			e.printStackTrace();
		}
		CONSTANT = constant;
	}
	
	@InitBinder
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		// 对于需要转换为Date类型的属性，使用DateEditor进行处理
		binder.registerCustomEditor(Date.class, new DateEditor(true));
	}

	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/singleOrder";

	/*
	 * 订单业务层注入
	 */
	@Autowired
	private OrderService orderService;

	/*
	 * 州业务层注入
	 */
	@Autowired
	private StateService stateService;

	/*
	 * 国家业务层注入
	 */
	@Autowired
	private CountryService countryService;
	
	/*
	 * 语言业务层注入
	 */
	@Autowired
	private LanguageService languageService;

	/*
	 * 费用业务层注入
	 */
	@Autowired
	private SOrderReceiveItemService sOrderReceiveItemService;
	
	@Autowired
	private PayCostRecordsService payCostRecordsService;
	
	/*
	 * 供应商业务层注入
	 */
	@Autowired
	private VenderService venderService;
	
	@Autowired
	private AdminService adminService;
	
	/**
	 * 非团订单列表页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "302");
		return BaseTemplateURL + "/list";
	}
	
	/**
	 * 非团订单列表页面异步获取数据
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, Order order) {
		order.setOrderType(5);
		Map<String, Object> map = new HashMap<String, Object>();
		String groupIdString=adminService.getCurrent().getGroupId();
		Page<Order> page;
		//判断是否分组 	groupIdString 为空未分组
		if(groupIdString==null){
			order.setUserId(adminService.getCurrent().getId());
			page = orderService.findPage(order, pageable);
		}else{
			order.setGroupId(groupIdString);
			page = orderService.findForGrouPage(order, pageable);
		}
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 非团订单新增页面
	 * 
	 * @param model
	 * @return
	 * @throws TemplateModelException 
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) throws TemplateModelException {
		model.addAttribute("menuId", "302");
		model.addAttribute("constant",CONSTANT);
		model.addAttribute("languages",languageService.findAll());
		model.addAttribute("countrys", countryService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("venderList", venderService.findAll());
		return BaseTemplateURL + "/add";
	}
	
	/**
	 * 根据国家ID获取相应的州
	 * 
	 * @param countryId
	 * @return
	 */
	@RequestMapping(value="/states",method=RequestMethod.POST)
	public @ResponseBody Map<String,String> getStatesByCountryId(String countryId){
		Map<String,String> stateIdAndNames = new HashMap<String,String>();
		List<State> states = stateService.findByCountryId(countryId);
		for(State state : states){
			stateIdAndNames.put(state.getId(), state.getStateName());
		}
	    return stateIdAndNames;
	}

	/**
	 * 非团订单收入支出修改页面
	 * 
	 * @param orderId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editPayCost", method = RequestMethod.GET)
	public String loadPayCost(String id, Model model) {
		model.addAttribute("menuId", "302");
		model.addAttribute("payCost", orderService.findPayCostByOrderId(id));
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("venderList", venderService.findAll());
		return "/admin/singleOrder/payCostEdit";
	}

	/**
	 * 收入支出异步删除
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/deletePayCost", method = RequestMethod.POST)
	public @ResponseBody String deletePayCost(String id) {
		payCostRecordsService.delete(id);
		return "OK";
	}

	/**
	 * 修改团订单收入支出
	 * 
	 * @param tourOrderPayCostVO
	 * @return
	 */
	@RequestMapping(value = "/updatePayCost", method = RequestMethod.POST)
	public String updatePayCost(PayCostEditVO payCostEditVO) {
		orderService.updatePayCost(payCostEditVO);
		return "redirect:list";
	}
	
	/**
	 * 非团订单客人查看页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/customers", method = RequestMethod.GET)
	public String customer(String id, Model model) {
		model.addAttribute("menuId", "302");
		model.addAttribute("orderId", id);
		return "/admin/singleOrder/customerList";
	}

	/**
	 * 非团订单客人查看页面异步获取数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/customerList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> customerList(Pageable pageable, String orderId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Customer> page = orderService.findCustomerPagesByOrderId(pageable, orderId);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 取消订单
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/cencelOrder", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		orderService.cancelOrder(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 恢复订单
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/recoverOrder", method = RequestMethod.GET)
	public String recover(String id, RedirectAttributes redirectAttributes){
		orderService.recoverOrder(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 确认结算
	 * 
	 * @param id
	 * @return
	 
	@RequestMapping(value = "/updateOrderTax", method = RequestMethod.GET)
	public String updateOrderTax(String id) {
		Order order=new Order();
		order.setId(id);
		order.setTax(1);
		orderService.update(order);
		return "redirect:list.jhtml";
	}*/
}
