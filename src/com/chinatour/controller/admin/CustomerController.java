package com.chinatour.controller.admin;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.DateEditor;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AdminRegion;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerConsult;
import com.chinatour.entity.CustomerExcle;
import com.chinatour.entity.CustomerSource;
import com.chinatour.entity.Dept;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.Order;
import com.chinatour.entity.Region;
import com.chinatour.entity.RegionDeptRel;
import com.chinatour.entity.Zipcode;
import com.chinatour.service.AdminRegionService;
import com.chinatour.service.AdminService;
import com.chinatour.service.CityService;
import com.chinatour.service.CountryService;
import com.chinatour.service.CustomerConsultService;
import com.chinatour.service.CustomerService;
import com.chinatour.service.CustomerSourceService;
import com.chinatour.service.DeptService;
import com.chinatour.service.LanguageService;
import com.chinatour.service.OrderService;
import com.chinatour.service.RegionService;
import com.chinatour.service.StateService;
import com.chinatour.util.UUIDGenerator;

/**
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-9-18 上午11:00:21
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/customer")
public class CustomerController extends BaseController {

	@InitBinder
	protected void initBinder(HttpServletRequest request,
			ServletRequestDataBinder binder) throws Exception {
		// 对于需要转换为Date类型的属性，使用DateEditor进行处理
		binder.registerCustomEditor(Date.class, new DateEditor(true));
	}
	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/customer";

	/*
	 * 客人信息的业务层注入
	 */
	@Autowired
	private CustomerService customerService;

	/*
	 * 国家的业务层注入
	 */
	@Autowired
	private CountryService countryService;

	/*
	 * 城市的业务层注入
	 */
	@Autowired
	private CityService cityService;

	/*
	 * 州的业务层注入
	 */
	@Autowired
	private StateService stateService;

	/*
	 * 语种的业务层注入
	 */
	@Autowired
	private LanguageService languageService;
	
	@Autowired
	private OrderService orderService;

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private CustomerConsultService customerConsultService;
	
	@Autowired
	private CustomerSourceService customerSourceService;
	
	@Autowired
	private DeptService deptService;
	
	@Autowired
	private AdminRegionService adminRegionService;
	
	@Autowired
	private RegionService regionService;
	/**
	 * 将menuId值设为1302存入model，去Customer展示页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "1301");
		return BaseTemplateURL + "/list";
	}

	/**
	 * 异步 根据传来的Pageable对象和Customer对象查出Customer数据并以map返回
	 * 
	 * @param pageable
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, Customer customer) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Customer> page = customerService.findPage(customer, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 添加Customer信息，并且加载语种国家城市信息 去客人信息添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		model.addAttribute("menuId", "1301");
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("cityList", cityService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		return BaseTemplateURL + "/add";
	}

	/**
	 * 根据传来的Customer对象进行添加操作
	 * 
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Customer customer) {
		Admin admin = adminService.getCurrent();
		customer.setPeerId(admin.getId());
		customer.setCustomerId(UUIDGenerator.getUUID());
		customer.setModifyDate(new Date());
		customerService.save(customer);
		return "redirect:list.jhtml";
	}

	/**
	 * 删除 根据传来的id执行删除操作
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		Customer customer=customerService.findById(id);
		customer.setIsDel(1);
		customerService.update(customer);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据传来的id查询出Customer对象存入model中 转去修改客人信息页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", "1301");
		model.addAttribute("customer", customerService.findById(id));
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("cityList", cityService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		return BaseTemplateURL + "/edit";
	}

	/**
	 * 根据传来的Customer对象进行更新操作
	 * 
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Customer customer) {
		customerService.update(customer);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据客人Id查找相应的订单
	 * */
	@RequestMapping(value="/orderByCusId", method=RequestMethod.GET)
	public String orderByCusId(String id,Model model){
		List<Order> orderList=orderService.getOrderByCusId(id);
		Admin admin = adminService.getCurrent(); 
		model.addAttribute("orderList", orderList);
		model.addAttribute("admin", admin);
		return BaseTemplateURL+"/customerOrderList";
	}
	
	/**
	 * 导出客人信息
	 */
	@RequestMapping(value="/exportCustomer",method = RequestMethod.POST)
	public ModelAndView exportCustomer(Customer customer, Model model){
		List<Customer> customerList = customerService.findCustomerForOrder(customer);
		CustomerExcle excle = new CustomerExcle();
		excle.setCustomerList(customerList);
		return new ModelAndView(excle); 
	}

/*	*//**
	 * 搜索咨询客人
	 * @param customer
	 * @return
	 *//*
	@RequestMapping(value = "/findCustomerList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> findCustomerList( Customer customer) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Customer> customerList = customerService.findCustomerList(customer);
		map.put("customerList", customerList);
		return map;
	}*/
	
	/**
	 *  咨询时添加新客人(基本信息)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="addCustomerWithBasicInfo", method = RequestMethod.GET)
	public String addCustomerWithBasicInfo(Model model){
		CustomerSource customerSource = new CustomerSource();
		customerSource.setDeptId(adminService.getCurrent().getDeptId());
		model.addAttribute("menuId", "1302");
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("cityList", cityService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		model.addAttribute("customerSourceList", customerSourceService.find(customerSource));
		return BaseTemplateURL+"/addCustomerWithBasicInfo";
	}
	
	/**
	 *  咨询时添加新客人(咨询信息)
	 * @param model
	 * @return
	 */
	@RequestMapping(value="addCustomerWithConsulation", method = RequestMethod.GET)
	public String addCustomerWithConsulation(Model model,String id){
		model.addAttribute("customerId", id);
		model.addAttribute("menuId", "1302");
		return BaseTemplateURL+"/addCustomerWithConsulation";
	}
	
	/**
	 *  咨询时添加新客人(基本信息)
	 * @param model
	 * @return
	 * isNew判断是新增客人还是修改客人如果为0则为新增
	 */
	@RequestMapping(value="saveCustomerWithBasicInfo", method = RequestMethod.POST)
	public String saveCustomerWithBasicInfo(Model model,Customer customer){
		Admin admin = adminService.getCurrent();
		customer.setPeerId(admin.getId());
		customer.setCustomerId(UUIDGenerator.getUUID());
		customerService.save(customer);
		model.addAttribute("customer", customer);
		return "redirect:editCustomerWithBasicInfo.jhtml?id="+customer.getCustomerId()+"&isNew=0";
	}
	
	/**
	 * 保存客人咨询资料
	 * @return
	 */
	@RequestMapping(value="saveCustomerWithConsulation", method = RequestMethod.POST)
	public String saveCustomerWithConsulation(Customer customer){
		customer.setCustomerId(UUIDGenerator.getUUID());
		customer.setModifyDate(new Date());
		CustomerConsult customerWithConsulation = customer.getCustomerConsultList().get(0);
		customerWithConsulation.setCustomerId(customer.getCustomerId());
		customerWithConsulation.setCustomerConsultId(UUIDGenerator.getUUID());
		customerWithConsulation.setUserId(adminService.getCurrent().getId());
		customerConsultService.save(customerWithConsulation);
		customerService.save(customer);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 修改客人咨询资料(基本信息)---保存客人信息之后进入该页面
	 * @return
	 */
	@RequestMapping(value="editCustomerWithBasicInfo", method = RequestMethod.GET)
	public String editCustomerWithBasicInfo(String id,int isNew,Model model){
		int isShow = 0;
		Customer customer = customerService.findById(id);
		String agentId = customer.getPeerId();
		if(agentId!=null&&agentId.length()!=0){
			Admin admin = adminService.getCurrent();
			Admin agentForCustomer = adminService.findById(customer.getPeerId());
			Subject currentUser = SecurityUtils.getSubject();
			//划分Agent所有的权限
			if (currentUser.isPermitted("admin:CEO")) {  
				isShow = 1;
			}else if (currentUser.isPermitted("admin:Region")){
				AdminRegion adminRegion = adminRegionService.findByAdminId(admin.getId());
				Region regionForDept = regionService.findRegionForDept(adminRegion.getRegionId());
				List<RegionDeptRel> regionDeptRelList = regionForDept.getRegionDeptRel();
				for(RegionDeptRel regionDeptRel:regionDeptRelList){
					if(regionDeptRel.getDeptId().equals(admin.getDeptId())){
						isShow = 1;
					}
				}
			}else if (currentUser.isPermitted("admin:Office")&&admin.getDeptId().equals(agentForCustomer.getDeptId())){
				isShow = 1;
			}else if(admin.getId().equals(customer.getPeerId())){
				isShow = 1;
			}
		}
		CustomerSource customerSource = new CustomerSource();
		customerSource.setDeptId(adminService.getCurrent().getDeptId());
		model.addAttribute("menuId", "1302");
		model.addAttribute("isNew", isNew);
		model.addAttribute("customer", customerService.findById(id));
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("cityList", cityService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		model.addAttribute("customerSourceList", customerSourceService.find(customerSource));
		model.addAttribute("consulationList",customerConsultService.findByCustomerId(id));
		model.addAttribute("isShow", isShow);
		return BaseTemplateURL+"/editCustomerWithBasicInfo";
	}
	
	/**
	 * 修改客人咨询资料(基本信息)
	 * @return
	 */
	@RequestMapping(value="updateCustomerWithBasicInfo", method = RequestMethod.POST)
	public String updateCustomerWithBasicInfo(Customer customer,int flag,Model model){
		int isNew = 0;
		if(flag!=1){
			isNew = customer.getIsNew();
		}
		customerService.update(customer);
		customer = customerService.findById(customer.getCustomerId());
		if(flag==1){//修改DetailedInfo的客人信息
			return "redirect:editDetailedInfo.jhtml?id="+customer.getCustomerId();
		}
			return "redirect:editCustomerWithBasicInfo.jhtml?id="+customer.getCustomerId()+"&isNew="+isNew;
	}
	
	/**
	 * 修改客人详细资料
	 * @return
	 */
	@RequestMapping(value="editDetailedInfo", method = RequestMethod.GET)
	public String editDetailedInfo(String id,Model model){
		CustomerSource customerSource = new CustomerSource();
		customerSource.setDeptId(adminService.getCurrent().getDeptId());
		model.addAttribute("menuId", "1302");
		model.addAttribute("customer", customerService.findById(id));
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("cityList", cityService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		model.addAttribute("customerSourceList", customerSourceService.find(customerSource));
		model.addAttribute("consulationList",customerConsultService.findByCustomerId(id));
		model.addAttribute("customerId", id);
		model.addAttribute("customer", customerService.findById(id));
		return BaseTemplateURL+"/editDetailedInfo";
	}
	
	/**
	 * 修改客人咨询资料(咨询信息)
	 * @return
	 */
	@RequestMapping(value="editCustomerWithOrderInfo", method = RequestMethod.GET)
	public String editCustomerWithOrderInfo(String id,Model model){
		int isShow = 0;
		Customer customer = customerService.findById(id);
		String agentId = customer.getPeerId();
		if(agentId!=null&&agentId.length()!=0){
			Admin admin = adminService.getCurrent();
			Admin agentForCustomer = adminService.findById(customer.getPeerId());
			Subject currentUser = SecurityUtils.getSubject();
			//划分Agent所有的权限
			if (currentUser.isPermitted("admin:CEO")) {  
				isShow = 1;
			}else if (currentUser.isPermitted("admin:Region")){
				AdminRegion adminRegion = adminRegionService.findByAdminId(admin.getId());
				Region regionForDept = regionService.findRegionForDept(adminRegion.getRegionId());
				List<RegionDeptRel> regionDeptRelList = regionForDept.getRegionDeptRel();
				for(RegionDeptRel regionDeptRel:regionDeptRelList){
					if(regionDeptRel.getDeptId().equals(admin.getDeptId())){
						isShow = 1;
					}
				}
			}else if (currentUser.isPermitted("admin:Office")&&admin.getDeptId().equals(agentForCustomer.getDeptId())){
				isShow = 1;
			}else if(admin.getId().equals(customer.getPeerId())){
				isShow = 1;
			}
		}
		List<Order> orderList=orderService.getOrderByCusId(id);
		CustomerSource customerSource = new CustomerSource();
		customerSource.setDeptId(adminService.getCurrent().getDeptId());
		model.addAttribute("menuId", "1302");
		model.addAttribute("orderList", orderList);
		model.addAttribute("customerId", id);
		model.addAttribute("admin", adminService.getCurrent());
		model.addAttribute("isShow", isShow);
		return BaseTemplateURL+"/editCustomerWithOrderInfo";
	}
	
	@RequestMapping(value = "/saveCustomerConsulation", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> saveCustomerConsulation( CustomerConsult customerConsult,int isNew) {
		String source = Constant.CUSTOMERSOURCE;
		if(isNew==0){//如果是新客人
			Customer customer = customerService.findById(customerConsult.getCustomerId());
			CustomerSource cs = customerSourceService.findById(customer.getCustomerSource());
			if(cs!=null){
				source = cs.getSourceName();
			}
		}
		Admin admin = adminService.getCurrent();
		Dept dept = deptService.findById(admin.getDeptId());
		customerConsult.setCustomerConsultId(UUIDGenerator.getUUID());
		customerConsult.setUserId(admin.getId());
		customerConsult.setUserName(admin.getUsername());
		customerConsult.setDeptId(dept.getDeptId());
		customerConsult.setDeptName(dept.getDeptName());
		customerConsult.setCustomerSource(source);
		Integer endDateForString = 0;
		if(customerConsult.getEndDateForString()!=null){
			endDateForString = customerConsult.getEndDateForString();
		}
		Date endDate = getdate(endDateForString);
		customerConsult.setEndDate(endDate);
		customerConsultService.save(customerConsult);
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date=dateFormat.format(new Date());
		customerConsult.setCreateDateStr(date);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("customerConsult", customerConsult);
		return map;
	}
	
	/**
	 * agent权限
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlist", method = RequestMethod.GET)
	public String customerConsultlist(Model model) {
		model.addAttribute("menuId", "1302");
		return BaseTemplateURL + "/customerConsultlist";
	}

	/**
	 * 异步 根据传来的Pageable对象和Customer对象查出Customer数据并以map返回
	 * 
	 * @param pageable
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlist", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> customerConsultlist(Pageable pageable, CustomerConsult customerConsult) {
		Admin admin = adminService.getCurrent();
		customerConsult.setUserId(admin.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		Page<CustomerConsult> page = customerConsultService.findPage(customerConsult, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		if(page.getContent().size()>0){
			CustomerConsult ic = new CustomerConsult();
			long sum = page.getTotal();
			ic.setCustomerSource(Long.toString(sum));
			page.getContent().add(ic);
		}
		return map;
	}
	
	/**
	 * office权限
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForOffice", method = RequestMethod.GET)
	public String customerConsultlistForOffice(Model model) {
		model.addAttribute("menuId", "1303");
		return BaseTemplateURL + "/customerConsultlistForOffice";
	}

	/**
	 * 异步 根据传来的Pageable对象和Customer对象查出Customer数据并以map返回
	 * 
	 * @param pageable
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForOffice", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> customerConsultlistForOffice(Pageable pageable, CustomerConsult customerConsult) {
		Admin admin = adminService.getCurrent();
		customerConsult.setDeptId(admin.getDeptId());
		Map<String, Object> map = new HashMap<String, Object>();
		Page<CustomerConsult> page = customerConsultService.findPage(customerConsult, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		if(page.getContent().size()>0){
			CustomerConsult ic = new CustomerConsult();
			long sum = page.getTotal();
			ic.setCustomerSource(Long.toString(sum));
			page.getContent().add(ic);
		}
		return map;
	}
	
	/**
	 * region权限
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForRegion", method = RequestMethod.GET)
	public String customerConsultlistForRegion(Model model) {
		model.addAttribute("menuId", "1304");
		return BaseTemplateURL + "/customerConsultlistForRegion";
	}

	/**
	 * 异步 根据传来的Pageable对象和Customer对象查出Customer数据并以map返回
	 * 
	 * @param pageable
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForRegion", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> customerConsultlistForRegion(Pageable pageable, CustomerConsult customerConsult) {
		Admin admin = adminService.getCurrent();
		customerConsult.setUserId(admin.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		Page<CustomerConsult> page = customerConsultService.findRegionForPage(customerConsult, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		if(page.getContent().size()>0){
			CustomerConsult ic = new CustomerConsult();
			long sum = page.getTotal();
			ic.setCustomerSource(Long.toString(sum));
			page.getContent().add(ic);
		}
		return map;
	}
	
	/**
	 * region权限
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForCEO", method = RequestMethod.GET)
	public String customerConsultlistForCEO(Model model) {
		model.addAttribute("menuId", "1305");
		return BaseTemplateURL + "/customerConsultlistForCEO";
	}

	/**
	 * 异步 根据传来的Pageable对象和Customer对象查出Customer数据并以map返回
	 * 
	 * @param pageable
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForCEO", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> customerConsultlistForCEO(Pageable pageable, CustomerConsult customerConsult) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<CustomerConsult> page = customerConsultService.findPage(customerConsult, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		if(page.getContent().size()>0){
			CustomerConsult ic = new CustomerConsult();
			long sum = page.getTotal();
			ic.setCustomerSource(Long.toString(sum));
			page.getContent().add(ic);
		}
		return map;
	}
	
	
	/**
	 * crm点击show more 时显示全部数据
	 * @return
	 */
	@RequestMapping(value = "/findAllCustomerList", method = RequestMethod.GET)
	public String findAllCustomerList(Model model ,String customerInfo){
		model.addAttribute("menuId", "1301");
		model.addAttribute("customerInfo", customerInfo);
		return "/admin/basic/customer/findAllCustomerList";
	}
	
	/**
	 * crm点击show more 时显示全部数据
	 * @return
	 */
	@RequestMapping(value = "/findAllCustomerList", method = RequestMethod.POST)
	public  @ResponseBody
	Map<String, Object>  findAllCustomerList(Pageable pageable,String customerInfo){
		Map<String,Object> map = new HashMap<String,Object>();
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
		Page<Customer> page = customerService.findAllCustomerListForPage(customer, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * region权限
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForNow", method = RequestMethod.GET)
	public String customerConsultlistForNow(Model model) {
		return BaseTemplateURL + "/customerConsultlistForNow";
	}

	/**
	 * 异步 根据传来的Pageable对象和Customer对象查出Customer数据并以map返回
	 * 
	 * @param pageable
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/customerConsultlistForNow", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> customerConsultlistForNow(Pageable pageable, CustomerConsult customerConsult) {
		Admin admin = adminService.getCurrent();
		customerConsult.setUserId(admin.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		Page<CustomerConsult> page = customerConsultService.findPage(customerConsult, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		if(page.getContent().size()>0){
			CustomerConsult ic = new CustomerConsult();
			long sum = page.getTotal();
			ic.setCustomerSource(Long.toString(sum));
			page.getContent().add(ic);
		}
		return map;
	}
	
	private Date getdate(int i) // //获取前后日期 i为正数 向后推迟i天，负数时向前提前i天
	 {
	 Date dat = null;
	 Calendar cd = Calendar.getInstance();
	 cd.add(Calendar.DATE, i);
	 dat = cd.getTime();
	 SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	 Timestamp date = Timestamp.valueOf(dformat.format(dat));
	 return date;
	 }
	
	/**
	 * 异步查询所有酒店
	 */
	@RequestMapping(value = "/listSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelect(Zipcode zipcode) {
		List<Zipcode> zipList = customerService.findSelect(zipcode);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("zipList", zipList);
		return map;
	}
	
	/**
	 * 异步 根据传来的客人名称 查找客人
	 * 
	 * @param pageable
	 * @param Customer
	 * @return
	 */
	@RequestMapping(value = "/findCustomerTourInfo", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> findCustomerTourInfo( Customer customer) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(customer!=null&&(customer.getLastName()!=null||customer.getFirstName()!=null||customer.getPassportNo()!=null)){
			Customer c = customerService.findCustomerTourInfo(customer);
			map.put("customer", c);
		}
		return map;
	}

}
