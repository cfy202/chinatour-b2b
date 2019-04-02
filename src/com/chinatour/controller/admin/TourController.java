package com.chinatour.controller.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.FileInfo.FileType;
import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Appendix;
import com.chinatour.entity.Car;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.CustomerSheetExcle;
import com.chinatour.entity.FlightWithCustomers;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.ItineraryInfo;
import com.chinatour.entity.Notice;
import com.chinatour.entity.NoticeContact;
import com.chinatour.entity.OptionalExcurition;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.StatisticsSheetExcle;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.TourType;
import com.chinatour.persistence.ReceivableInfoOfOrderMapper;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.CarService;
import com.chinatour.service.CityService;
import com.chinatour.service.CustomerFlightService;
import com.chinatour.service.CustomerOrderRelService;
import com.chinatour.service.CustomerService;
//import com.chinatour.service.DataFactoryService;
import com.chinatour.service.FileService;
import com.chinatour.service.GroupLineService;
import com.chinatour.service.HotelService;
import com.chinatour.service.ItineraryInfoService;
import com.chinatour.service.NoticeService;
import com.chinatour.service.OrderRemarkService;
import com.chinatour.service.OrderService;
import com.chinatour.service.OrderToPdfService;
import com.chinatour.service.OrdersTotalService;
import com.chinatour.service.TourInfoForOrderService;
import com.chinatour.service.TourService;
import com.chinatour.service.TourTypeService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.CustomerFlightVO;
import com.chinatour.vo.HotelListVO;
import com.chinatour.vo.TourVO;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

@Controller
@RequestMapping("/admin/tour")
public class TourController extends BaseController {
	
	@Autowired
	private TourService tourService;
    
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private ItineraryInfoService itineraryInfoService;
	
	@Autowired
	private CityService cityService;
	
	@Autowired
	private OrderToPdfService orderToPdfService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private TourTypeService tourTypeService;
	
	@Autowired
	private CustomerOrderRelService customerOrderRelService;
	
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private GroupLineService groupLineService;
	
	@Resource(name = "fileServiceImpl")
	private FileService fileService;
	
	@Resource(name = "tourInfoForOrderServiceImpl")
	private TourInfoForOrderService tourInfoForOrderService;
	
	@Resource(name = "ordersTotalServiceImpl")
	private OrdersTotalService ordersTotalService;
	
	@Autowired
	private OrderRemarkService orderRemarkService;
	
	@Autowired
	private CustomerFlightService customerFlightService;
	
	@Autowired
	private CarService carService;
	@Autowired
	private TOrderReceiveItemMapper tOrderReceiveItemMapper;
	@Autowired
	private ReceivableInfoOfOrderMapper receivableInfoOfOrderMapper;
	/*@Autowired
	private DataFactoryService dataFactoryService;*/


	@Resource(name = "noticeServiceImpl")
	private NoticeService noticeService;
	
	public static final TemplateHashModel CONSTANT;

	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/tour";
	
	static {
		TemplateHashModel constant = null;
		try {
			constant = BeansWrapper.getDefaultInstance().getStaticModels();
			constant = (TemplateHashModel) constant.get("com.chinatour.Constant");
		} catch (TemplateModelException e) {
			e.printStackTrace();
		}
		CONSTANT = constant;
	}
	/**
	 * 团功能团订单页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String tourOrdersList(Model model){
		model.addAttribute("menuId", 401);
		return BaseTemplateURL + "/tourOrderList";
	}
	
	/**
	 * 团功能非团订单页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/singleOrdersList", method = RequestMethod.GET)
	public String singleOrdersList(Model model){
		model.addAttribute("menuId", 405);
		return BaseTemplateURL + "/singleOrdersList";
	}
	
	/**
	 * 查出非团订单
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/singleOrderList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> singleOrderList(Order order,Pageable pageable){
		//order.setOrderType(5);
		order.setIsSelfOrganize(1);//查出agent自组订单
		//order.setTourCode(tourCode);
		return getOrderPage(order,pageable);
	}
	
	/**
	 * 查出团订单
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/tourOrderList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> tourOrderList(Pageable pageable,Order order){
		//order.setOrderType(1);
		//此处查找包含Inbound
		//order.setIsSelfOrganize(0);//查出op组团订单
		//order.setTourCode(tourCode);
		return getOrderPage(order,pageable);
	}
	
	/**
	 * 根据团号查看团列表
	 * 
	 * @param tourCode
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/tourInfo", method = RequestMethod.GET)
	public String findTourByTourCode(String tourCode,Model model){
		model.addAttribute("menuId", 401);
		model.addAttribute("tourCode", tourCode);
		return BaseTemplateURL + "/tourInfo";
	}
	
	/**
	 * 根据团号查看团下的订单
	 * 
	 * @param tourCode
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
	public String findOrdersByTourCode(String tourCode,Model model){
		model.addAttribute("menuId", 401);
		model.addAttribute("tourCode", tourCode);
		return BaseTemplateURL + "/orderListByTour";
	}
	
	/**
	 * 转去添加团的页面
	 * 
	 * @param orderIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/group", method = RequestMethod.POST)
	public String group(String[] orderIds,Model model){
		model.addAttribute("menuId", 401);
		Order order=orderService.findById(orderIds[0]);
		if(order!=null){
			model.addAttribute("order",order);
			model.addAttribute("tourType",tourTypeService.findById(order.getTourTypeId()));
			model.addAttribute("tourInfoForOrder",tourInfoForOrderService.findByOrderId(order.getId()));
		}
		model.addAttribute("orderIds", StringUtils.join(orderIds, ","));
		return BaseTemplateURL + "/add";
	}
	
	
	/**
	 * 转去添加团的页面
	 * 
	 * @param orderIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/singleGroup", method = RequestMethod.POST)
	public String singleGroup(String[] orderIds,Model model){
		model.addAttribute("menuId", 405);
		Order order=orderService.findById(orderIds[0]);
		if(order!=null){
			model.addAttribute("order",order);
			model.addAttribute("tourType",tourTypeService.findById(order.getTourTypeId()));
			model.addAttribute("tourInfoForOrder",tourInfoForOrderService.findByOrderId(order.getId()));
		}
		model.addAttribute("orderIds", StringUtils.join(orderIds, ","));
		return BaseTemplateURL + "/addSingle";
	}
	/**
	 * 根据tourCode检查团知否存在
	 * 若存在,返回tourId
	 * 若不存在，返回空字符串
	 * 
	 * @param tourCode
	 * @return
	 */
	@RequestMapping(value = "/checkTourCode", method = RequestMethod.POST)
	public @ResponseBody Tour checkTourCode(String tourCode){
		Tour tour = tourService.findByTourCode(tourCode);
		if(tour == null){
			return null;
		}
		return tour;
	}

	/**
	 * 创建团并对若干团订单进行组团
	 * 
	 * @param tour
	 * @param orderIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String addTour(Tour tour,String str, String orderIds, Model model){
		model.addAttribute("menuId", 401);
		if(str!=null&&str.equals("on")){
			tour.setIsDeparture(0);
		}else{
			tour.setIsDeparture(1);
		}
		String tourId = tourService.addTour(tour, orderIds.split(","));
		//dataFactoryService.updateClass(orderIds);
	    model.addAttribute("tourId", tourId);
	    if(tour.getTourType()==2){
	    	return "redirect:singleTourList.jhtml";
	    }
	    return "redirect:list.jhtml";
	    
	}
	
	/**
	 * 对现有的团添加订单
	 * 
	 * @param existTourId
	 * @param orderIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/addOrders", method = RequestMethod.POST)
	public String addOrders(String existTourId,String tourId, String orderIds, Model model,RedirectAttributes redirectAttributes){
		model.addAttribute("menuId", 401);
		String menuId="401";
		String sTourId=null;
		if(tourId!=null){
			sTourId=tourId;
		}
		sTourId=existTourId;
		model.addAttribute("tourId", sTourId); 
		tourService.addOrders(sTourId, orderIds.split(","));
		//dataFactoryService.updateClass(orderIds);
		return "redirect:tourCustomerList.jhtml?tourId="+sTourId+"&menuId="+menuId;
	}
	
	/**
	 * 转去查看每条订单的客人的页面
	 * 
	 * @param orderId
	 * @param model
	 * @return
	 
	@RequestMapping(value = "/orderCustomerList", method = RequestMethod.GET)
	public String listCustomer(String orderId, Model model){
		model.addAttribute("menuId", 401);
		model.addAttribute("orderId", orderId);
		return BaseTemplateURL + "/orderCustomerList";
	}
	
	*
	 * 根据orderId查询出客人
	 * 
	 * @param pageable
	 * @param customer
	 * @param orderId
	 * @return
	 
	@RequestMapping(value = "/orderCustomerList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> orderCustomerList(Pageable pageable,String orderId){
		Map<String,Object> map = new HashMap<String,Object>();
		List<TourVO> tourVOList = tourService.findTourVOByOrderId(orderId,pageable);
		map.put("recordsTotal", tourVOList.size());
		map.put("recordsFiltered", tourVOList.size());
		map.put("data", tourVOList);
		return map;
	}*/
	
	/**
	 * 根据团ID查询出客人
	 * @param tourId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/tourCustomerList", method = RequestMethod.GET)
	public String customerList(Order order,Model model,String menuId){
		//List<Order> orderList=orderService.findCustomerForTourId(tourId);
		List<Order> orderList = orderService.findCustomerListByTourId(order);
		/*List<TourVO> tourVOList = new ArrayList<TourVO>();
		for (int i = 0; i <orderList.size(); i++) {
			Order ord=orderList.get(i);
			TourVO	tourVO = new TourVO();
			tourVO.setOrderNo(ord.getOrderNo());
			tourVO.setTourCode(ord.getTourCode());
			tourVO.setState(ord.getState());
			tourVO.setAgent(ord.getUserName());
			tourVO.setCustomerOrderNo(ord.getCustomerTourNo());
			tourVO.setIsDel(ord.getIsDel());
			tourVO.setId(order.getCustomerOrderRelId());
			tourVO.setLastName(ord.getCustomer().getLastName());
			tourVO.setFirstName(ord.getCustomer().getFirstName());
			tourVO.setOrdersTotalId(ord.getOrdersTotalId());
			tourVO.setOrderId(ord.getId());
			tourVOList.add(tourVO);
		}*/
		List<Car> carList = carService.findByTourId(order.getTourId());
		model.addAttribute("menuId", menuId);
		model.addAttribute("admin", adminService.getCurrent());
	    model.addAttribute("tourId", order.getTourId());
	    model.addAttribute("tourCode", order.getTourCode());
	    model.addAttribute("orderList", orderList);
	    model.addAttribute("carList", carList);
	    return BaseTemplateURL + "/tourCustomerList";
	}
	
	/**
	 * 废弃
	 * 根据tourId查询出客人
	 * 
	 * @param pageable
	 * @param tourId
	 * @return
	 
	@RequestMapping(value = "/tourCustomerList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> customerList(Pageable pageable,String tourId){
		Map<String,Object> map = new HashMap<String,Object>();
		List<TourVO> tourVOList = tourService.findTourVOByTourId(tourId,pageable);
		map.put("recordsTotal", tourVOList.size());
		map.put("recordsFiltered", tourVOList.size());
		map.put("data", tourVOList);
		return map;
	}*/
	
	/**
	 * 查出该用户下所有团
	 * 
	 * @return
	 */
	@RequestMapping(value="/tourList", method = RequestMethod.GET)
	public String tourList(Model model){
		model.addAttribute("menuId", 402);
		model.addAttribute("userName", adminService.getCurrent().getUsername());
		return BaseTemplateURL + "/tourList";
	}
	
	/**
	 * 查询对应OP下的团
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/tourList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> tourList(Pageable pageable,Tour tour){
		tour.setDeptId(adminService.getCurrent().getDeptId());
		//不在区分inbound
		//tour.setTourType(1);//op 组团
		return this.pageMap(pageable, tour);
	}
	
	/**
	 * 查出所有团(默认当前用户，搜索将搜索所有的团)
	 * 
	 * @return
	 */
	@RequestMapping(value="/tourAllList", method = RequestMethod.GET)
	public String tourAllList(Model model){
		model.addAttribute("menuId", 409);
		model.addAttribute("userName", adminService.getCurrent().getUsername());
		return BaseTemplateURL + "/tourAllList";
	}
	
	/**
	 * 查出所有团(默认当前用户，搜索将搜索所有的团)
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/tourAllList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> tourAllList(Pageable pageable,Tour tour){
		return this.pageMap(pageable, tour);
	}
	
	/**
	 * 查出该用户下所有团
	 * 
	 * @return
	 */
	@RequestMapping(value="/singleTourList", method = RequestMethod.GET)
	public String singleTourList(Model model){
		model.addAttribute("menuId", 510);
		model.addAttribute("userName", adminService.getCurrent().getUsername());
		return BaseTemplateURL + "/singleTourList";
	}
	
	
	/**
	 * 查询对应 非团
	 * 
	 * 自组
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/singleTourList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> singleTourList(Pageable pageable,Tour tour){
		Map<String,Object> map = new HashMap<String,Object>();
		tour.setDeptId(adminService.getCurrent().getDeptId());
		tour.setTourType(2);//自组  （非团）
		Page<Tour> page = tourService.findPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 团分页
	 * @param pageable
	 * @param tour
	 * @return
	 */
	public Map<String,Object> pageMap(Pageable pageable,Tour tour){
		Map<String,Object> map = new HashMap<String,Object>();
		Page<Tour> page = tourService.findTourOfUserForPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(tourService.findTourOfUserSumPepole(tour));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	
	/**
	 * 转去修改团页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(String id, Model model,String menuId) {
		model.addAttribute("menuId", menuId);
		Tour tour=tourService.findById(id);
		model.addAttribute("tourType",tourTypeService.findById(tour.getType()));
		model.addAttribute("tour", tourService.findById(id));
		ItineraryInfo itineraryInfo=itineraryInfoService.findByTourIdWhithDel(id);
		if(itineraryInfo!=null){
			model.addAttribute("itineraryInfo", itineraryInfo);
		}
		return BaseTemplateURL + "/edit";
	}
	
	/**
	 * 修改团
	 * 
	 * @param tour
	 * 
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Tour tour,String menuId,String str,String addOther,RedirectAttributes redirectAttributes) {
		if(str!=null&&str.equals("on")){
			tour.setIsDeparture(0);
		}else{
			tour.setIsDeparture(1);
		}
		if(addOther!=null&&str.equals("on")){
			if(tour.getFinalRemarks()!="" || tour.getOtherRemarks()!=""){
			//查询从修改页面传入的数据  isDel=1
			ItineraryInfo itineraryInfo=itineraryInfoService.findByTourIdWhithDel(tour.getTourId());
			if(itineraryInfo!=null){
				itineraryInfo.setTourId(tour.getTourId());
				itineraryInfo.setHotelInfo(tour.getFinalRemarks());
				itineraryInfo.setItineraryInfo(tour.getOtherRemarks());
				itineraryInfo.setIsDel(1);
				List<Order> orders=orderService.findByTourId(tour.getTourId());
				if(orders.size()!=0){
					for(Order order:orders){
						order.setItInfo("1");
						orderService.update(order);
					}
				}
				itineraryInfoService.update(itineraryInfo);
			}else{
				ItineraryInfo info=new ItineraryInfo();
					info.setItineraryInfoId(UUIDGenerator.getUUID());
					info.setTourId(tour.getTourId());
					info.setHotelInfo(tour.getFinalRemarks());
					info.setItineraryInfo(tour.getOtherRemarks());
					info.setIsDel(1);
					List<Order> orders=orderService.findByTourId(tour.getTourId());
					if(orders.size()!=0){
						for(Order order:orders){
							order.setItInfo("1");
							orderService.update(order);
						}
					}
					itineraryInfoService.save(info);
				}
			//查询团下所有的订单agent(过滤重复)
			List<Order> orders=orderService.findByTourId(tour.getTourId());
			HashSet<String> receiveUser= new HashSet<String>();
			if(orders.size()!=0){
				for(Order order:orders){
					receiveUser.add(order.getUserId());
				}
				NoticeContact noteContact=new NoticeContact();
				Notice notice=new Notice();
				notice.setTitle("TourCode:"+tour.getTourCode()+" 修改团信息，生成最终确认单！");
				notice.setContent("Final Remarks:"+tour.getFinalRemarks()+"Other Remarks:"+tour.getOtherRemarks());
				noteContact.setNotice(notice);
				//调用站内信功能
				SendMail(noteContact,receiveUser);
				}
			}
		}
		/*if(menuId!=null&&menuId.equals("510")){
			return "redirect:singleTourList.jhtml";
		}*/
		tourService.update(tour);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:edit.jhtml?id="+tour.getTourId()+"&menuId="+menuId;
	}
	/**
	 * op修改团信息，站内信通知agent
	 * @param noticeContact
	 * @param receiveUser
	 */
	public void SendMail(NoticeContact noticeContact, HashSet<String> receiveUser) {
		Admin admin = adminService.getCurrent();
		if(admin!=null){
			Notice notice = noticeContact.getNotice();
			notice.setNoticeId(UUIDGenerator.getUUID());
			
			List<NoticeContact> saveList = new ArrayList<NoticeContact>();
			List<NoticeContact> updateList = new ArrayList<NoticeContact>();
			List<Appendix> appendixList = new ArrayList<Appendix>();
			String delNotice = null;
			//发件箱保存
			if(receiveUser!=null){
				for(String receiveU:receiveUser){
					NoticeContact nc = new NoticeContact();
					nc.setNoticeContactId(UUIDGenerator.getUUID());
					nc.setSendUser(admin.getId());
					nc.setReceiveUser(receiveU);
					nc.setType(1);
					nc.setState(0);
					nc.setNoticeId(notice.getNoticeId());
					saveList.add(nc);
				}
			}
			noticeService.save(saveList,updateList, notice,delNotice,appendixList);
		}
	}
	/**
	 * 根据团号查看团下的订单
	 * 
	 * @param tourCode
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/modifyOrders", method = RequestMethod.GET)
	public String modifyOrdersByTourCode(String tourId,Model model,String menuId){
		List<Order> orderList=orderService.findByTourId(tourId);
		String tourCode="";
		if(orderList.size()>0){
			tourCode=orderList.get(0).getTourCode();
		}
		
		model.addAttribute("menuId", menuId);
		model.addAttribute("tourId", tourId);
		model.addAttribute("orderList",orderList);
		model.addAttribute("tourCode",tourCode );
		return BaseTemplateURL + "/modifyOrders";
	}
	
	/**
	 * 在团中取消订单
	 * 
	 * @param orderIds
	 * @param tourCode
	 * @return
	 */
	/*@RequestMapping(value = "/removeOrdersFromTour",method = RequestMethod.POST)
	public String removeOrdersFromTour(String[] orderIds,String tourCode){
		tourService.removeOrdersFromTour(orderIds,tourCode);
		return "redirect:modifyOrders?tourCode=" + tourCode;
	}
	*/
	@RequestMapping(value = "/removeOrdersFromTour",method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> removeOrdersFromTour(String orderIds,String tourId){
		String [] stringArr= orderIds.split(",");
		tourService.removeOrdersFromTour(stringArr,tourId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Ok","Booking Removed");//Arrival(Y)
		return map;
	}
	/**
	 * 上传
	 * @param file 上传文件
	 * @param id 
	 * @param redirectAttributes
	 * @param menuId   判断是非团还是团
	 * @return
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(MultipartFile file, Tour tour,
			HttpServletRequest request, String menuId,
			RedirectAttributes redirectAttributes) {
	
		String fileString= fileService.uploadLocal(FileType.tourQuotePath,file);
		if(fileString!=null){
			tour.setTourQuoteUrl(fileString);
			tourService.update(tour);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		if(menuId!=null&&menuId.equals("510")){
			return "redirect:singleTourList";
		}
		return "redirect:tourList";
	}
	/**
	 * 下载
	 * 
	 * @author
	 * @date
	 * @param attachment
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "download")
	public ModelAndView download(HttpServletRequest request,
			HttpServletResponse response,String id) throws Exception {
		
		Tour tour=tourService.findById(id);
		String downLoadPath =tour.getTourQuoteUrl();
		String contentType = "application/octet-stream";
		/*if(downLoadPath.isEmpty()){
			return null;
		}*/
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	
	/**
	 * 查出非团订单
	 * 
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/singleOrdersList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> singleOrdersList(Pageable pageable,Order order){
		Map<String,Object> map = new HashMap<String,Object>();
		order.setOrderType(5);
		order.setIsSelfOrganize(2);
		//String groupIdString=adminService.getCurrent().getGroupId();
		Page<Order> page;
		//判断是否分组 	groupIdString 为空未分组
	//	if(groupIdString==null){
		//	order.setUserId(adminService.getCurrent().getId());
			page = orderService.findPage(order, pageable);
		//}else{
		//	order.setGroupId(groupIdString);
		//	page = orderService.findForGrouPage(order, pageable);
		//}
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		for(Order od : page.getContent()){
			od.setUserId(adminService.findById(od.getUserId()).getUsername());
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 非团
	 * 
	 * 创建团并对若干团订单进行组团
	 * 
	 * @param tour
	 * @param orderIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/saveSingleTour", method = RequestMethod.POST)
	public String addSingleTour(Tour tour, String[] recordsId, Model model,RedirectAttributes redirectAttributes){
		model.addAttribute("menuId", 405);
		//tour.setType("F9E6DF2B-A315-4A8A-A20C-61A0CD1EB602");
		tour.setTourType(2);//组团类型  2 自组
	    String tourId = tourService.addTour(tour, recordsId);
	    model.addAttribute("tourId", tourId); 
	    addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
	    return "redirect:singleOrdersList.jhtml";
	}
	
	/**
	 * 非团
	 * 对现有的团添加订单
	 * 
	 * @param existTourId
	 * @param orderIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/addSingleOrders", method = RequestMethod.POST)
	public String addSingleOrders(String existTourId, String[] recordsId, Model model,RedirectAttributes redirectAttributes){
		model.addAttribute("menuId", 405);
		model.addAttribute("tourId", existTourId); 
		tourService.addOrders(existTourId, recordsId);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:singleOrdersList.jhtml";
	}
	
	/**
	 * 根据查找条件和分页信息查找出订单
	 * 
	 * @param order
	 * @param pageable
	 * @return
	 */
	private Map<String,Object> getOrderPage(Order order,Pageable pageable){
		Map<String,Object> map = new HashMap<String,Object>();
		Page<Order> page = tourService.findOrderPage(order,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(orderService.findForTourPageTotalPepole(order));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 查出region下所有团
	 * 
	 * @return
	 */
	@RequestMapping(value="/regionTourList", method = RequestMethod.GET)
	public String regionTourList(Model model){
		model.addAttribute("menuId", 406);
		return BaseTemplateURL + "/regionTourList";
	}
	
	/**
	 * 查询region下所有团
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/regionTourList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> regionTourList(Pageable pageable,Tour tour){
		Map<String,Object> map = new HashMap<String,Object>();
		tour.setUserId(adminService.getCurrent().getId());
		Page<Tour> page = tourService.findTourOfRegionPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(tourService.findTourOfRegionSumPepole(tour));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 查出office下所有团
	 * 
	 * @return
	 */
	@RequestMapping(value="/officeTourList", method = RequestMethod.GET)
	public String officeTourList(Model model,Integer isChanged){
		model.addAttribute("menuId", 407);
		if(isChanged==1){
			return BaseTemplateURL + "/officeTourList";
		}
		else{
			return BaseTemplateURL + "/officeTourList1";
		}
		
	}
	
	/**
	 * 查询office下所有团
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/officeTourList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> officeTourList(Pageable pageable,Tour tour){
		Map<String,Object> map = new HashMap<String,Object>();
		/*tour.setDeptId(adminService.getCurrent().getDeptId());*/
		Page<Tour> page = tourService.findTourOfOrderPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 查出ceo下所有团
	 * 
	 * @return
	 */
	@RequestMapping(value="/ceoTourList", method = RequestMethod.GET)
	public String ceoTourList(Model model){
		model.addAttribute("menuId", 408);
		return BaseTemplateURL + "/ceoTourList";
	}
	
	/**
	 * 查询ceo下所有团
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/ceoTourList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> ceoTourList(Pageable pageable,Tour tour){
		Map<String,Object> map = new HashMap<String,Object>();
		Page<Tour> page = tourService.findTourOfOrderPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(tourService.findTourOfOrderSumPepole(tour));
		}
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 查出本小组下所有团 
	 * 如果没有小组则查出当前用户的团
	 * 
	 * @return
	 */
	@RequestMapping(value="/groupTourList", method = RequestMethod.GET)
	public String groupTourList(Model model){
		model.addAttribute("menuId", 403);
		return BaseTemplateURL + "/groupTourList";
	}
	
	/**
	 * 查询group下所有团
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/groupTourList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> groupTourList(Pageable pageable,Tour tour){
		Map<String,Object> map = new HashMap<String,Object>();
		String groupIdString = adminService.getCurrent().getGroupId();
		if(groupIdString==null){
			groupIdString="";
		}
		tour.setGroupId(groupIdString);
		Page<Tour> page = tourService.findTourOfGroupPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(tourService.findTourOfGroupSumPepole(tour));
		}
		map.put("data", page.getContent());
		return map;
	}
	/**
	 *
	 * 查出当前用户的团
	 * 
	 * @return
	 */
	@RequestMapping(value="/agentTourList", method = RequestMethod.GET)
	public String agentTourList(Model model){
		model.addAttribute("menuId", 410);
		return BaseTemplateURL + "/agentTourList";
	}
	
	/**
	 * 查询agent下所有团
	 * 
	 * @param pageable
	 * @param tour
	 * @return
	 */
	@RequestMapping(value="/agentTourList", method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> agentTourList(Pageable pageable,Tour tour){
		Map<String,Object> map = new HashMap<String,Object>();
		tour.setUserId(adminService.getCurrent().getId());
		Page<Tour> page = tourService.findTourOfOrderPage(tour, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(tourService.findTourOfOrderSumPepole(tour));//计算总人数
		}
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Tour tour,String menuId,
			RedirectAttributes redirectAttributes) {
		if(tour.getTourId()!=null){
			tour.setIsDel(1);//1代表删除 取消
			tourService.update(tour);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		if(menuId!=null&&menuId.equals("510")){
			return "redirect:singleTourList.jhtml";
		}
		return "redirect:tourList.jhtml";
	}
	
	/**
	 * 导出客人
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/exportCustomer", method = RequestMethod.GET)
	public String exportCustomer(Model model,Order order,String menuId){
		/**
		 * 查看团下所有的Optional Excursion
		 */
			/*List<Order> ordersOfTour = orderService.findByTourId(order.getTourId());
			List<ReceivableInfoOfOrder> receivableInfoOfOrders=new ArrayList<ReceivableInfoOfOrder>();
			for(Order orders:ordersOfTour){
				ReceivableInfoOfOrder receivableInfoOfOrder=receivableInfoOfOrderMapper.findByOrderId(orders.getId());
				receivableInfoOfOrder.setOrderNo(orders.getOrderNo());
				List<OrderReceiveItem> orderReceiveItems=tOrderReceiveItemMapper.findByReceivableInfoOfOptional(receivableInfoOfOrder.getId());
				receivableInfoOfOrder.setOrderReceiveItemList(orderReceiveItems);
				receivableInfoOfOrder.setTourInfoForOrder(tourInfoForOrderService.findByOrderId(orders.getId()));
				receivableInfoOfOrders.add(receivableInfoOfOrder);
			}*/
		order.setIsDel(0);//未删除的客人
		List<Order> orderList=orderService.findCustomerListByTourId(order);
		List<Customer> customerList =new ArrayList<Customer>();
		List<CustomerFlight> customerFlightListS = new ArrayList<CustomerFlight>();
		//List<CustomerOrderRel> customerOrderRelList=new ArrayList<CustomerOrderRel>();
		if(orderList.size()>0){
			for (int i = 0; i <orderList.size(); i++) {
				Order ord=orderList.get(i);
				//判断删除的订单
				if(ord.getState()==0||ord.getState()==2||ord.getState()==3){
					//if(ord.getIsDel()!=1){
						List<CustomerFlight> customerFlightListST= ord.getCustomerFlightList();
						for (int t = 0; t < customerFlightListST.size(); t++) {
							customerFlightListST.get(t).setUserId(ord.getUserName());
							customerFlightListST.get(t).setCustomerNo(ord.getCustomerTourNo().toString());
						}
						//客人航班信息
						customerFlightListS.addAll(customerFlightListST);
						//团下客人
						Customer customer= new Customer();
						customer=ord.getCustomer();
						if(customer!=null&&ord.getGuestRoomType()!=null){
							customer.setGuestRoomType(ord.getGuestRoomType());
						}
						ord.getCustomerOrderRelId();
						customer.setTicketType(ord.getTicketType());
						customer.setCustomerCode(ord.getCustomerTourNo().toString());
						customer.setCarName(ord.getCarName());
						customer.setVoucherStr(ord.getWr());
						customer.setCustomerFlight(customerFlightListST);
						customer.setOrderNo(ord.getOrderNo());
						customer.setCompanyName(ord.getTourCode());
						customer.setDisplayName(ord.getUserName());
						customer.setOtherInfo(ord.getOtherInfo());
						customer.setPayHistoryInfo(ord.getLineName());
						customer.setRoomNumber(ord.getSprCheck());
						customerList.add(customer);
					//}
				}
			}
		}
		model.addAttribute("tourId", order.getTourId());
		model.addAttribute("menuId", menuId);
		model.addAttribute("customerList", customerList);
		model.addAttribute("customerFlightList", addList(customerFlightListS));
//		model.addAttribute("receivableInfoOfOrders",receivableInfoOfOrders);
		return BaseTemplateURL + "/viewCustomerOrderInfo";
	}
	
	public  List<CustomerFlight> sortList(List<CustomerFlight> cfList){
    	List<CustomerFlight> list=new ArrayList<CustomerFlight>();
    	
    	for(CustomerFlight cf:cfList){
    		String strd=cf.getCustomerNos();
    		String[] cusNo=strd.split(",");
    		if(cusNo.length>0){
	    		int[] cusSortNo=sortStr(cusNo);
	    		String cusT=cusStrNo(cusSortNo);
	    		cf.setCustomerNos(cusT);
	    		list.add(cf);
    		}
    	}
    	
    	return list;
    }
    
    public  String cusStrNo(int[] str){
		String strs="";
		int c=1;
		int d=1;
		if(str.length==1){
			strs+=String.valueOf(str[0]);
		}
		for(int i=0;i<str.length-1;i++){
			int a=str[i];
			int b=str[i+1];
			if((b-a)==1){
				if(c==1){
					strs+=String.valueOf(a)+"-";
					c++;
				}
				
			}else if((b-a)==0){
				if(d==1){
					//strs+=String.valueOf(a)+",";
					d++;
				}
			}else{
				strs+=String.valueOf(a)+",";
				c=1;
				d=1;
			}
			if((i+2)==str.length){
				strs+=String.valueOf(b)+",";
			}

		}
		String s=strs.substring((strs.length()-1),strs.length());
		if(s.equals(",")){
			strs=strs.substring(0,strs.length()-1);
		}
		return strs;
    }
    
    public  int[] sortStr(String [] str){
		
		int[] strs=new int[str.length];
		
		for(int i=0;i<str.length;i++){
			if(!str[i].equals(""))
				strs[i]=Integer.parseInt(str[i]);
		}
		
		Arrays.sort(strs);
		return strs;
    }
    
    public List<CustomerFlight> addList(List<CustomerFlight> cList){
	 	List<CustomerFlight> list=new ArrayList<CustomerFlight>();
	 	List<CustomerFlight> lista=new ArrayList<CustomerFlight>();
	 	List<CustomerFlight> lists=new ArrayList<CustomerFlight>();
	 	
	 	lists.addAll(cList);
	 	for(int i=0;i<cList.size();i++){
	 		CustomerFlight cf=cList.get(i);
	 		String str="";
	 		int flag=0;
	 		for(int j=lists.size()-1;j>=0;j--){
	 			CustomerFlight cuf=lists.get(j);
	 			
	 			cuf.setFlightNumber(cuf.getFlightNumber()==null ?"":cuf.getFlightNumber());
	 			cf.setFlightNumber(cf.getFlightNumber()==null ?"":cf.getFlightNumber());
	 			cuf.setFlightCode(cuf.getFlightCode()==null ?"":cuf.getFlightCode());
	 			cf.setFlightCode(cf.getFlightCode()==null ?"":cf.getFlightCode());
				if(cf.getArriveDate()!=null&&cuf.getArriveDate()!=null&&cf.getArriveDate().compareTo(cuf.getArriveDate())==0&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()!=null&& cuf.getUserId()!=null&& cf.getUserId().equals(cuf.getUserId())&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			} else if(cf.getArriveDate()!=null&&cuf.getArriveDate()!=null&&cf.getArriveDate().compareTo(cuf.getArriveDate())==0&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()==null&& cuf.getUserId()==null&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}else if(cf.getArriveDate()==null&&cuf.getArriveDate()==null&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()!=null&& cuf.getUserId()!=null&& cf.getUserId().equals(cuf.getUserId())&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}else if(cf.getArriveDate()==null&&cuf.getArriveDate()==null&&cf.getFlightCode().equals(cuf.getFlightCode()) && cf.getFlightNumber().equals(cuf.getFlightNumber()) && cf.getIfPickUp()==cuf.getIfPickUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getIfSendUp()==cuf.getIfSendUp()&& cf.getUserId()==null&& cuf.getUserId()==null&&cf.getOutOrEnter()==cuf.getOutOrEnter()){
	 				str+=String.valueOf(cuf.getCustomerNo())+",";
	 				flag=1;
	 				lists.remove(j);
	 			}
	 		}
	
	 		if(str.length()>=1){
	 			str=str.substring(0,str.length()-1);
	 		}
	 		
	 		cf.setCustomerNos(str);
	 		if(flag==1){
	 			lista.add(cf);
	 		}
	 	}
	 	
	   	if(lista.size()==1){
	   		CustomerFlight cf=lista.get(0);
	   		cf.setCustomerNos(String.valueOf(cf.getCustomerNo()));
	   		lists.add(cf);
	 	}
 	
	   	list=sortList(lista);
	 	return list;
	 }
    
	/**
	 * 异步
	 * 根据订单ID查询出客人
	 * @param tourId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/orderCustomerList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> orderCustomerList(String orderId){
		Map<String,Object> map = new HashMap<String,Object>();
		Order ord=orderService.findCustomerForOrderId(orderId);
		List<TourVO> tourVOList = new ArrayList<TourVO>();
			//
		List<CustomerOrderRel> customerOrderRelList=ord.getCustomerOrderRel();
		for(int j=0;j<customerOrderRelList.size();j++){
			CustomerOrderRel customerOrderRel=customerOrderRelList.get(j);
			//订单下下客人
			Customer customer= customerOrderRel.getCustomer();
			TourVO	tourVO = new TourVO();
			tourVO.setOrderNo(ord.getOrderNo());
			tourVO.setTourCode(ord.getTourCode());
			tourVO.setState(ord.getState());
			tourVO.setAgent(ord.getUserName());
			tourVO.setCustomerOrderNo(customerOrderRel.getCustomerTourNo());
			tourVO.setIsDel(customerOrderRel.getIsDel());
			tourVO.setId(customer.getCustomerId());
			tourVO.setLastName(customer.getLastName());
			tourVO.setFirstName(customer.getFirstName());
			tourVO.setMiddleName(customer.getMiddleName());
			tourVO.setDateOfBirth(customer.getDateOfBirth());
			tourVO.setNationalityOfPassport(customer.getNationalityOfPassport());
			tourVO.setPassportNo(customer.getPassportNo());
			tourVOList.add(tourVO);
		}
		map.put("tourVOList", tourVOList);
		return map;
	}
	/**
	 *
	 * 根据订单ID查询出客人
	 * @param tourId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/viewOrderCustomerList", method = RequestMethod.GET)
	public String viewOrderCustomerList(Model model,String orderId,String menuId){
		Order ord=orderService.findCustomerForOrderId(orderId);
		List<TourVO> tourVOList = new ArrayList<TourVO>();
		if(ord!=null){
			List<CustomerOrderRel> customerOrderRelList=ord.getCustomerOrderRel();
			if(customerOrderRelList.size()>0){
				for(int j=0;j<customerOrderRelList.size();j++){
					CustomerOrderRel customerOrderRel=customerOrderRelList.get(j);
					//订单下下客人
					Customer customer= customerOrderRel.getCustomer();
					TourVO	tourVO = new TourVO();
					tourVO.setOrderNo(ord.getOrderNo());
					tourVO.setTourCode(ord.getTourCode());
					tourVO.setState(ord.getState());
					tourVO.setAgent(ord.getUserName());
					if(ord.getTourId()!=null&&ord.getTourId()!=""){
						tourVO.setCustomerOrderNo(customerOrderRel.getCustomerTourNo());
					}else{
						tourVO.setCustomerOrderNo(customerOrderRel.getCustomerOrderNo());
					}
					tourVO.setIsDel(customerOrderRel.getIsDel());
					tourVO.setCustomerOrderRelId(customerOrderRel.getId());
					tourVO.setId(customer.getCustomerId());
					tourVO.setLastName(customer.getLastName());
					tourVO.setFirstName(customer.getFirstName());
					tourVO.setDateOfBirth(customer.getDateOfBirth());
					tourVO.setNationalityOfPassport(customer.getNationalityOfPassport());
					tourVO.setPassportNo(customer.getPassportNo());
					tourVO.setTicketType(customerOrderRel.getTicketType());
					tourVO.setVoucherStr(customerOrderRel.getVoucherStr());
					tourVOList.add(tourVO);
				}
			}
		}
		model.addAttribute("menuId", menuId);
		model.addAttribute("tourVOList", tourVOList);
		model.addAttribute("order", ord);
		return BaseTemplateURL + "/viewCustomerInfo";
	}
	/**
	 * 根据订单号查出自选项
	 * @param model
	 * @param orderId
	 * @param menuId
	 * @return
	 */
	@RequestMapping(value = "/viewOrderOptional", method = RequestMethod.GET)
	public String viewOrderOptional(Model model,String orderId,String menuId){
		
		Order ord=orderService.findCustomerForOrderId(orderId);
		TourInfoForOrder tourInfoForOrder=tourInfoForOrderService.findByOrderId(orderId);
		ReceivableInfoOfOrder receivableInfoOfOrder=receivableInfoOfOrderMapper.findByOrderId(orderId);
		List<OrderReceiveItem> orderReceiveItems=tOrderReceiveItemMapper.findByReceivableInfoOfOptional(receivableInfoOfOrder.getId());
		model.addAttribute("orderReceiveItemsList",orderReceiveItems);
		model.addAttribute("menuId", menuId);
		model.addAttribute("tourInfoForOrder", tourInfoForOrder);
		model.addAttribute("order", ord);
		return BaseTemplateURL + "/optionalItems";
	}
	
	/**
	 * 查看团下所有的Optional Excursion
	 */
	@RequestMapping(value = "/viewTourOptional", method = RequestMethod.GET)
	public String viewTourOptional(Model model,String tourId,String menuId){
		//ReceivableInfoOfOrder receivableInfoOfOrder =null;
		List<OrderReceiveItem> orderReceiveItems=tOrderReceiveItemMapper.findByReceivableInfoOfOptional(tourId);
		/*List<Order> ordersOfTour = orderService.findByTourId(tourId);
		List<ReceivableInfoOfOrder> receivableInfoOfOrders=new ArrayList<ReceivableInfoOfOrder>();
		for(Order order:ordersOfTour){
			receivableInfoOfOrder=receivableInfoOfOrderMapper.findByOrderId(order.getId());
			//receivableInfoOfOrder.setOrderNo(order.getOrderNo());
			
			receivableInfoOfOrder.setOrderReceiveItemList(orderReceiveItems);
			//receivableInfoOfOrder.setTourInfoForOrder(tourInfoForOrderService.findByOrderId(order.getId()));
			receivableInfoOfOrders.add(receivableInfoOfOrder);
		}*/
		
		model.addAttribute("orderReceiveItems",orderReceiveItems);
		model.addAttribute("menuId", menuId);
		return BaseTemplateURL + "/optionalOfTour";
	}
	/**
	 * 删除订单
	 * 修改订单状态
	 * @param tourId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateOrderState", method = RequestMethod.POST)
	public @ResponseBody String updateOrderState(Order order){
		try {
			if (order == null || order.getId() == null||order.getOrdersTotalId() == null) {
				return "ERROR";
			}
		/*	Tour tour=tourService.findById(order.getTourId());
			CustomerOrderRel customerOrderRel=new CustomerOrderRel();
			customerOrderRel.setOrderId(order.getId());
			customerOrderRel.setIsDel(1);//不计算已经删除的订单
			int people =customerOrderRelService.findCountCustomerByOrderId(customerOrderRel);
			if(tour.getTotalPeople()<people){
				return "ERROR";
			}
			tourService.changeTotalPeople(-people,tour.getTourCode());*/
			orderService.confirmCancelOrder(order);
		} catch (Exception e) {
			return "ERROR";
		}
		return "SUCCESS";
	}
	
	/**
	 * 恢复订单
	 * @param tourId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/recoverCustomer", method = RequestMethod.POST)
	public @ResponseBody String recoverCustomer(Order order){
		try {
			if (order == null || order.getId() == null||order.getOrdersTotalId() == null) {
				return "ERROR";
			}
			orderService.confirmRecoverOrder(order);
		/*	Tour tour=tourService.findById(order.getTourId());
			CustomerOrderRel customerOrderRel=new CustomerOrderRel();
			customerOrderRel.setOrderId(order.getId());
			customerOrderRel.setIsDel(0);//不计算已经恢复的订单
			int people =customerOrderRelService.findCountCustomerByOrderId(customerOrderRel);
			tourService.changeTotalPeople(people,tour.getTourCode());*/
		} catch (Exception e) {
			return "ERROR";
		}
		return "SUCCESS";
	}
	/**
	 * 查看该订单的酒店信息
	 * @param orderId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/hotelsForGroupLine", method = RequestMethod.GET)
	public String hotelsForGroupLine(String tourId,Model model,String menuId){
		List<Order> orders = orderService.findByTourId(tourId);
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(orders.get(0).getId());
		String groupLineId = tourInfoForOrder.getGroupLineId();
		GroupLine groupLine = groupLineService.findHotelByGroupLineId(groupLineId);
		List<GroupLineHotelRel> groupLineHotelRels = groupLine.getGroupLineHotelRel();
		List<Hotel> hotels = new ArrayList<Hotel>();
		for(GroupLineHotelRel groupLineHotelRel:groupLineHotelRels){
			Hotel hotel = groupLineHotelRel.getHotel();
			hotel.setDayNum(groupLineHotelRel.getDayNum());
			hotels.add(hotel);
		}
		List<Integer> dayNums = new ArrayList<Integer>();
		for(int i=1;i<=20;i++){
			dayNums.add(i);
		}
		model.addAttribute("groupLine", groupLineService.findById(groupLineId));
		model.addAttribute("hotels", hotels);
		model.addAttribute("citys", cityService.findAll());
		model.addAttribute("hotelList", hotelService.findAll());
		model.addAttribute("dayNums", dayNums);
		model.addAttribute("dayNums", dayNums);
		model.addAttribute("menuId", menuId);
		return BaseTemplateURL + "/hotelsForGroupLine";
	}
	
	/**
	 * 进入酒店编辑页面
	 * @param id
	 * @param groupLineId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editInvoiceForGroupLine", method = RequestMethod.GET)
	public String editInvoiceForGroupLine( String menuId,String isChanged, String tourId,ItineraryInfo itineraryInfo,Model model) {
		List<Order> orders = orderService.findByTourId(tourId);
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(orders.get(0).getId());
		String groupLineId = tourInfoForOrder.getGroupLineId();
		GroupLine groupLine = groupLineService.findHotelByGroupLineId(groupLineId);
		List<GroupLineHotelRel> groupLineHotelRels = groupLine.getGroupLineHotelRel();
		List<Hotel> hotels = new ArrayList<Hotel>();
		if(isChanged.equals("1")){
			 itineraryInfo = itineraryInfoService.findByTourWithIsDel(tourId);
			String stringForHotel = itineraryInfo.getHotelInfo();
			String[] ho = stringForHotel.split("#");
			for(int i=0;i<ho.length;i++){
				Hotel hotel = new Hotel();
				String[] hoForinfo = ho[i].split("%");
				for(int j=0;j<hoForinfo.length;j++){
					hotel.setDayNum(Integer.parseInt(hoForinfo[0]));
					hotel.setHotelName(hoForinfo[1]);
					hotel.setStandard(hoForinfo[2]);
					hotel.setCityName(hoForinfo[3]);
					hotel.setAddress(hoForinfo[4]);
					hotel.setTel(hoForinfo[5]);
				}
				hotels.add(hotel);
			}
		}else{
			for(int i=0;i<groupLineHotelRels.size();i++){
				Hotel hotel = groupLineHotelRels.get(i).getHotel();
				hotel.setDayNum(groupLineHotelRels.get(i).getDayNum());
				hotels.add(hotel);
				hotel=null;
			}
		}
		List<GroupRoute> groupRoutes = groupLineService.findGroupRouteByGroupLineId(groupLineId);
		model.addAttribute("hotels",hotels);
		model.addAttribute("groupRoutes",groupRoutes);
		model.addAttribute("groupLine",groupLine);
		model.addAttribute("menuId", menuId);
		model.addAttribute("tourId", tourId);
		model.addAttribute("itineraryInfo", itineraryInfo);
		model.addAttribute("isChanged", isChanged);
		return BaseTemplateURL + "/editInvoiceForGroupLine";
	}
	
	
	@RequestMapping(value = "/saveInfomationForOp", method = RequestMethod.POST)
	public String saveInfomationForOp(HotelListVO hotelListVO,Tour tour,ItineraryInfo itineraryInfo,Model model){
		List<Order> orderList = orderService.findCustomerForTourId(tour.getTourId());
		List<Hotel> hotelList = hotelListVO.getHotelList();
		String hotelInfo = "";
		if(hotelList!=null){
			for(int i=0;i<hotelList.size();i++){
				Hotel hotel = hotelList.get(i);
				if(i==hotelList.size()-1){
					hotelInfo+=hotel.getDayNum()+"%"+hotel.getHotelName()+"%"+hotel.getStandard()+"%"+hotel.getCityName()+"%"+hotel.getAddress()+"%"+hotel.getTel();
				}else{
					hotelInfo+=hotel.getDayNum()+"%"+hotel.getHotelName()+"%"+hotel.getStandard()+"%"+hotel.getCityName()+"%"+hotel.getAddress()+"%"+hotel.getTel()+"#";
				}
			}
		}
		itineraryInfo.setHotelInfo(hotelInfo);
		itineraryInfo.setTourId(tour.getTourId());
		itineraryInfo.setIsDel(0);
		if(tour.getIsChanged()==0){
			itineraryInfo.setItineraryInfoId(UUIDGenerator.getUUID());
			itineraryInfoService.save(itineraryInfo);
		}else{
			itineraryInfoService.update(itineraryInfo);
		}
		String destPath = orderToPdfService.createNewPdf(itineraryInfo.getItineraryInfoId(),hotelList,tour.getTourId(),orderList.get(0));
		tour.setIsChanged(1);//说明已修改
		tourService.update(tour);
		model.addAttribute("destPath", destPath);
		model.addAttribute("tourId", tour.getTourId());
		model.addAttribute("isChanged", tour.getIsChanged());
		model.addAttribute("menuId", "402");
		return BaseTemplateURL + "/orderReview";
	}
	
	@RequestMapping(value = "/neworderReview", method = RequestMethod.GET)
	public String neworderReview(String isChanged,String tourId,String menuId, Model model) {
		List<Order> orderList = orderService.findCustomerForTourId(tourId);
		List<Hotel> hotelList = new ArrayList<Hotel>();
		String itineraryInfoId = null;
		if(isChanged.equals("1")){
			ItineraryInfo itineraryInfo = itineraryInfoService.findByTourWithIsDel(tourId);
			String stringForHotel = itineraryInfo.getHotelInfo();
			String[] ho = stringForHotel.split("#");
			for(int i=0;i<ho.length;i++){
				Hotel hotel = new Hotel();
				String[] hoForinfo = ho[i].split("%");
				for(int j=0;j<hoForinfo.length;j++){
					hotel.setDayNum(Integer.parseInt(hoForinfo[0]));
					hotel.setHotelName(hoForinfo[1]);
					hotel.setStandard(hoForinfo[2]);
					hotel.setCityName(hoForinfo[3]);
					hotel.setAddress(hoForinfo[4]);
					hotel.setTel(hoForinfo[5]);
				}
				hotelList.add(hotel);
			}
			itineraryInfoId = itineraryInfo.getItineraryInfoId();
		}
		Order order = null;
		if(orderList.size()!=0){
			 order = orderList.get(0);
		}
		String destPath = orderToPdfService.createNewPdf(itineraryInfoId,hotelList,tourId,order);
		model.addAttribute("destPath", destPath);
		model.addAttribute("tourId", tourId);
		model.addAttribute("isChanged",isChanged );
		model.addAttribute("menuId", menuId);
		return BaseTemplateURL + "/orderReview";
	}
	
	/**
	 * 修改客人状态
	 * 删除客人
	 * @param tourId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateCustomerRel", method = RequestMethod.POST)
	public @ResponseBody String updateCustomerRel(CustomerOrderRel customerOrderRel,String tourId){
		try {
			if(customerOrderRel.getOrderId()==null||customerOrderRel.getOrdersTotalId()==null){
				return "ERROR";
			}
			//取消团下客人方法
			orderService.confirmCancelTourCustomer(customerOrderRel);
			//团减少客人
			/*Tour tour=tourService.findById(tourId);
			tourService.changeTotalPeople(-1,tour.getTourCode());*/
		} catch (Exception e) {
			return "ERROR";
		}
		return "SUCCESS";
	}
	
	
	@RequestMapping(value = "/viewCustomerOptional", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> viewCustomerOptional(String customerOrderRelId){
		List<OrderReceiveItem> orderReceiveItems=tOrderReceiveItemMapper.findCustomerOptional(customerOrderRelId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderReceiveItemsList", orderReceiveItems);
		return map;
	}
	
	
	/**
	 * 恢复客人
	 * @param tourId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/recoverCustomerRel", method = RequestMethod.POST)
	public @ResponseBody String recoverCustomerRel(CustomerOrderRel customerOrderRel,String tourId){
		try {
			if(customerOrderRel.getOrderId()==null||customerOrderRel.getOrdersTotalId()==null){
				return "ERROR";
			}
			orderService.confirmRecoverTourCustomer(customerOrderRel);
			//团减少客人
			/*Tour tour=tourService.findById(tourId);
			tourService.changeTotalPeople(1,tour.getTourCode());*/
		} catch (Exception e) {
			return "ERROR";
		}
		return "SUCCESS";
	}
	
	
	/**
	 * 团订单客人航班信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/orderInfo", method = RequestMethod.GET)
	public String loadTourOrder(Model model,Order order,String menuId) {
		List<Customer> customerList =new ArrayList<Customer>();
		List<CustomerFlight> customerFlightListS = new ArrayList<CustomerFlight>();
		//客人航班信息
		order.setIsDel(0);//未删除的客人
		List<Order> orderList=orderService.findCustomerListByTourId(order);
		//订单
		Order orderS=orderService.findById(order.getId());
		//判断是否组团 	是显示客人团队编号  否显示客人订单编号
		if(orderS!=null&&orderS.getTourId()!=null&&orderS.getTourId()!=""){
			//判断客人是否删除
			if(orderList.size()>0){
				for (int i = 0; i <orderList.size(); i++) {
					Order ord=orderList.get(i);
					if(ord!=null&&(ord.getState()==0||ord.getState()==2||ord.getState()==3)){
						List<CustomerFlight> customerFlightListST= ord.getCustomerFlightList();
						for (int t = 0; t < customerFlightListST.size(); t++) {
							customerFlightListST.get(t).setUserId(ord.getUserName());
							customerFlightListST.get(t).setCustomerNo(ord.getCustomerTourNo().toString());
						}
						//客人航班信息
						customerFlightListS.addAll(customerFlightListST);
						//团下客人
						Customer customer= ord.getCustomer();
						customer.setGuestRoomType(ord.getGuestRoomType());
						customer.setCustomerCode(ord.getCustomerTourNo().toString());
						customer.setTicketType(ord.getTicketType());
						customer.setVoucherStr(ord.getWr());
						customer.setOrderNo(ord.getOrderNo());
						customer.setCompanyName(ord.getTourCode());
						customer.setDisplayName(ord.getUserName());
						customer.setOtherInfo(ord.getOtherInfo());
						customer.setPayHistoryInfo(ord.getLineName());
						customer.setRoomNumber(ord.getSprCheck());
						customerList.add(customer);
						
						//获取团队类型
						if(ord.getTourTypeId()!=null){
							TourType tourType=tourTypeService.findById(ord.getTourTypeId());
							ord.setTourTypeId(tourType.getTypeName());
						}
					}
				}
			}
		}else{
			//判断客人是否删除
			if(orderList.size()>0){
				for (int i = 0; i <orderList.size(); i++) {
					Order ord=orderList.get(i);
					if(ord!=null&&(ord.getState()==0||ord.getState()==2||ord.getState()==3)){
						List<CustomerFlight> customerFlightListST= ord.getCustomerFlightList();
						for (int t = 0; t < customerFlightListST.size(); t++) {
							customerFlightListST.get(t).setUserId(ord.getUserName());
							customerFlightListST.get(t).setCustomerNo(ord.getCustomerOrderNo().toString());
						}
						//客人航班信息
						customerFlightListS.addAll(customerFlightListST);
						//团下客人
						Customer customer= ord.getCustomer();
						customer.setGuestRoomType(ord.getGuestRoomType());
						customer.setCustomerCode(ord.getCustomerOrderNo().toString());
						customer.setTicketType(ord.getTicketType());
						customerList.add(customer);
						
						//获取团队类型
						if(ord.getTourTypeId()!=null){
							TourType tourType=tourTypeService.findById(ord.getTourTypeId());
							ord.setTourTypeId(tourType.getTypeName());
						}
					}
				}
			}
		}
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(order.getId());
		//自主线路行程
		List<GroupRoute> groupRouteList=new ArrayList<GroupRoute>();
		if(tourInfoForOrder.getGroupLineId()!=null){
			groupRouteList=groupLineService.findGroupRouteByGroupLineId(tourInfoForOrder.getGroupLineId());
		}
		if(orderS.getTourTypeId()!=""){
			//查询线路类型
			orderS.setTourTypeId(tourTypeService.findById(orderS.getTourTypeId()).getTypeName());
		}
		
		model.addAttribute("orderRemark", orderRemarkService.findRemarkByOrderId(order.getId()));
		model.addAttribute("menuId", menuId);
		model.addAttribute("order", orderS);
		model.addAttribute("customerList", customerList);
		model.addAttribute("groupRouteList", groupRouteList);
		model.addAttribute("customerFlightList", addList(customerFlightListS));
		model.addAttribute("tourInfoForOrder", tourInfoForOrder);
		return BaseTemplateURL + "/orderInfo";
	}
	
	/**
	 * 异步查询团
	 */
	@RequestMapping(value = "/listSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelect(Tour tour) {
		List<Tour> tourList = tourService.findList(tour);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tourList", tourList);
		return map;
	}
	
	/**
	 * 异步查询自组团
	 */
	@RequestMapping(value = "/listSelectForSingle", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelectForSingle(Tour tour) {
		List<Tour> tourList = tourService.findListForSingle(tour);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tourList", tourList);
		return map;
	}
	/**
	 * 根据团ID，或订单ID修改订单状态
	 * 
	 * */
	@RequestMapping(value = "/updateState", method = RequestMethod.GET)
	public String updateState(String orderId,String tourId,String type) {
		String url="";
		if(type.equals("order")){
			Order order=new Order();
			order=orderService.findById(orderId);
			order.setNoticeState(2);//OP已查看过订单
			orderService.update(order);
			
			List<Order> orderList=orderService.findByTourId(tourId);
			int i=0;
			for(Order orders:orderList){
				i +=0;
				if(order.getNoticeState()==1){
					i +=1;
				}
			}
			if(i==0){//该团下没有了通知的订单状态；对应的团newstate更改状态
				Tour tour=new Tour();
				tour=tourService.findById(tourId);
				tour.setNewState(2);
				tourService.update(tour);
			}
			
			/*url="modifyOrders.jhtml?menuId=402&tourId="+tourId;*/
			url="redirect:tourList.jhtml";
		}
		if(type.equals("tour")){
			List<Order> orderList=orderService.findByTourId(tourId);
			Tour tour=new Tour();
			tour=tourService.findById(tourId);
			tour.setNewState(2);
			tourService.update(tour);
			for(Order order:orderList){
				if(order.getNoticeState()==1){
					order.setNoticeState(2);//OP已查看过订单
					orderService.update(order);
				}
			}
			url="redirect:tourList.jhtml";
		}
		return url;
	}
	
	//op录入航班
	@RequestMapping(value = "/impotFlightInfo", method = RequestMethod.POST)
	public String importFlight(Order order,Model model){
		model.addAttribute("menuId", "402");
		model.addAttribute("order", order);
		model.addAttribute("constant", CONSTANT);
		return BaseTemplateURL + "/impotFlightInfo";
	}
	
	//保存op所录入的航班信息
	@RequestMapping(value = "/saveFlightInfo", method = RequestMethod.POST)
	public String saveFlightInfo(CustomerFlightVO customerFlightVO){
		String customerOrderRelIds = customerFlightVO.getCustomerOrderRelIds();
		List<CustomerFlight> customerFlightList = customerFlightVO.getCustomerFlightList();
		String[] customerOrderIdList = customerOrderRelIds.split(",");
		CustomerFlight  cfTemp = new CustomerFlight();
		for(int i=0;i<customerOrderIdList.length;i++){
			if(customerFlightVO.getTicketType()!=null&&customerFlightVO.getTicketType()!=""){
				CustomerOrderRel cor= customerOrderRelService.findById(customerOrderIdList[i]);
				cor.setTicketType(customerFlightVO.getTicketType());
				customerOrderRelService.update(cor);
			}
			for(CustomerFlight cf:customerFlightList){
				if(cf.getFlightCode()!=null&&cf.getFlightCode()!=""){
					cf.setCustomerOrderRelId(customerOrderIdList[i]);
					cfTemp.setCustomerOrderRelId(cf.getCustomerOrderRelId());
					cfTemp.setOutOrEnter(cf.getOutOrEnter());
					List<CustomerFlight> cfList = customerFlightService.find(cfTemp);
					if(cfList!=null&&cfList.size()>0){
						customerFlightService.removeById(cfList.get(0).getId());
					}
					cf.setId(UUIDGenerator.getUUID());
					customerFlightService.save(cf);
					
				}
			}
		}
		return "redirect:tourCustomerList.jhtml?tourId="+customerFlightVO.getTourId()+"&menuId=402";
	}
	
	/*@RequestMapping(value = "/exportFlightInfo", method = RequestMethod.GET)
	public String exportFlightInfo(Model model,String tourId,CustomerFlight customerFlight){
		Tour tour = tourService.findById(tourId);
		List<FlightWithCustomers> flightWithCustomersList = tourService.getCustomerFlightList(tour,customerFlight);
		model.addAttribute("flightWithCustomersList", flightWithCustomersList);
		model.addAttribute("tourId", tourId);
		model.addAttribute("menuId", "402");
		return BaseTemplateURL + "/exportFlightInfo";
	}*/
	
	
	
	@RequestMapping(value = "/flightList", method = RequestMethod.GET)
	public String flightList(Model model){
		//默认显示为接机
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String today = df.format(new Date());
		model.addAttribute("menuId", "409");
		model.addAttribute("today", today);
		return BaseTemplateURL+"/flightList";
	}
	
	@RequestMapping(value = "/flightList", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> flightList(Pageable pageable,CustomerFlight customerFlightTemp){
		//默认显示为接机
		Admin op = adminService.getCurrent();
		customerFlightTemp.setDeptId(op.getDeptId());
		return this.pageMapForFlight(pageable, customerFlightTemp);
	}
	
	@RequestMapping(value = "/flightListForAjax", method = RequestMethod.POST)
	public  @ResponseBody Map<String,Object> flightListForAjax(Model model,CustomerFlight customerFlight){
		Map<String,Object> map = new HashMap<String,Object>();
		Admin op = adminService.getCurrent();
		if(customerFlight.getBeginningDate()==null){
			customerFlight.setBeginningDate(new Date());
		}
		Tour tour = new Tour();
		tour.setUserId(op.getId());
		List<Tour> tourList = tourService.findList(tour);
		//输入团号搜索时
		if(customerFlight.getTourCode()!=null&&customerFlight.getTourCode()!=""){
			 tour = tourService.findByTourCode(customerFlight.getTourCode());
			 tourList.clear();
			 tourList.add(tour);
		}
		
		List<FlightWithCustomers> flightWithCustomersList = new ArrayList<FlightWithCustomers>();
		/*for(Tour t:tourList){
			List<FlightWithCustomers> fcList = tourService.getCustomerFlightList(t,customerFlight);
			flightWithCustomersList.addAll(fcList);
		}
		for(FlightWithCustomers flights:flightWithCustomersList){
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			flights.getCustomerFlight().setArriveDateStr(df.format(flights.getCustomerFlight().getArriveDate()));
		}*/
		int flag = 1;
		if(customerFlight.getOutOrEnter()!=null){
			flag = customerFlight.getOutOrEnter();
		}
		map.put("flag", flag);
		map.put("fcListForAjax", flightWithCustomersList);
		return map;
	}
	
	@RequestMapping(value = "/printFlightWithCus", method = RequestMethod.POST)
	public String printFlightWithCus(Model model,CustomerFlight customerFlight){
		Admin admin = adminService.getCurrent();
		customerFlight.setDeptId(admin.getDeptId());
		List<FlightWithCustomers> flightWithCustomersList = tourService.getCustomerFlightList(customerFlight);
		int flag = 3;
		if(customerFlight.getOutOrEnter()!=null){
			flag = customerFlight.getOutOrEnter();
		}
		model.addAttribute("flightWithCustomersList", flightWithCustomersList);
		model.addAttribute("flag", flag);
		return BaseTemplateURL + "/printFlightWithCus";
	}
	
	/**
	 * 航班信息分页
	 * @param pageable
	 * @param tour
	 * @return
	 */
	
	public Map<String,Object> pageMapForFlight(Pageable pageable,CustomerFlight customerFlight){
		Map<String,Object> map = new HashMap<String,Object>();
		Page<CustomerFlight> page = tourService.findFlightForOpForPage(customerFlight, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 录入拼车信息
	 * @param order
	 * @param model
	 * @return
	 */
		@RequestMapping(value = "/impotCarInfo", method = RequestMethod.POST)
		public String impotCarInfo(Order order,Model model){
			model.addAttribute("menuId", "402");
			model.addAttribute("order", order);
			return BaseTemplateURL + "/impotCarInfo";
		}
		
		/**
		 * 保存拼车信息
		 * @param customerFlightVO
		 * @return
		 *//*
		@RequestMapping(value = "/saveCarInfo", method = RequestMethod.POST)
		public String saveCarInfo(CustomerFlightVO customerFlightVO){
			String customerOrderRelIds = customerFlightVO.getCustomerOrderRelIds();
			String[] customerOrderIdList = customerOrderRelIds.split(",");
			CarInfo carInfo = new CarInfo();
			carInfo.setCarName(customerFlightVO.getCarName());
			carInfo.setSeats(customerFlightVO.getSeats());
			carInfo.setCarRemark(customerFlightVO.getCarRemark());
			customerOrderRelService.saveCarInfo(carInfo,customerOrderIdList);
			return "redirect:tourCustomerList.jhtml?tourId="+customerFlightVO.getTourId()+"&menuId=402";
		}*/
		
		
		@RequestMapping(value = "/carList", method = RequestMethod.GET)
		public String carList(Model model,String tourId) {
			Tour tour = tourService.findById(tourId);
			model.addAttribute("tour", tour);
			model.addAttribute("menuId", "402");
			return BaseTemplateURL + "/carList";
		}

		/**
		 * 根据传来的Pageable对象和Car对象查出city数据并以map返回
		 * 
		 * @param pageable
		 * @param car
		 * @return
		 */
		@RequestMapping(value = "/carList", method = RequestMethod.POST)
		public @ResponseBody Map<String, Object> carList(Pageable pageable, Car car) {
			Map<String, Object> map = new HashMap<String, Object>();
			Page<Car> page = carService.findPage(car, pageable);
			map.put("recordsTotal", page.getTotal());
			map.put("recordsFiltered", page.getTotal());
			map.put("data", page.getContent());
			return map;
		}
		
		/**
		 * 给团增加车辆页面
		 * @param model
		 * @return
		 */
		@RequestMapping(value = "/addCar", method = RequestMethod.GET)
		public String add(Model model,String tourId) {
			Tour tour = tourService.findById(tourId);
			model.addAttribute("tour", tour);
			model.addAttribute("menuId", "402");
			return BaseTemplateURL + "/addCar";
		}
		
		//保存团车辆信息
		@RequestMapping(value = "/saveCar", method = RequestMethod.POST)
		public String saveCar(Car car) {
			car.setCarId(UUIDGenerator.getUUID());
			carService.save(car);
			return "redirect:carList.jhtml?tourId="+car.getTourId();
		}
		
		//修改团车辆信息
		@RequestMapping(value = "/editCar", method = RequestMethod.GET)
		public String editCar(String carId,Model model) {
			Car car = carService.findById(carId);
			model.addAttribute("car", car);
			model.addAttribute("menuId", "402");
			return BaseTemplateURL + "/editCar";
		}
		
		//修改团车辆信息
		@RequestMapping(value = "/updateCar", method = RequestMethod.POST)
		public String updateCar(Car car,Model model) {
			carService.update(car);
			model.addAttribute("menuId", "402");
			return "redirect:carList.jhtml?tourId="+car.getTourId();
		}
		
		/**
		 * 更新客人对应的车辆信息
		 * @param carInfo
		 * @return
		 */
		@RequestMapping(value = "/updateCarInfoForCustomer", method = RequestMethod.POST)
		public String updateCarInfoForCustomer(Order order){
			String[] customerOrderRelIds = order.getCustomerOrderRelId().split(",");
			Car car = carService.findById(order.getCarId());
			customerOrderRelService.saveCarInfo(car, customerOrderRelIds);
			return "redirect:tourCustomerList.jhtml?tourId="+order.getTourId()+"&menuId=402";
		}
		/**
		 * 导出客人excel
		 * 
		 * @param model
		 * @return
		 */
		@RequestMapping(value = "/exportCustomerExcel", method = RequestMethod.GET)
		public ModelAndView exportCustomerExcel(Model model,String tourId,String menuId){
			Order order=new Order();
			order.setTourId(tourId);
			/**
			 * 查看团下所有的Optional Excursion
			 */
				List<Order> ordersOfTour = orderService.findByTourId(order.getTourId());
				List<ReceivableInfoOfOrder> receivableInfoOfOrders=new ArrayList<ReceivableInfoOfOrder>();
				for(Order orders:ordersOfTour){
					ReceivableInfoOfOrder receivableInfoOfOrder=receivableInfoOfOrderMapper.findByOrderId(orders.getId());
					receivableInfoOfOrder.setOrderNo(orders.getOrderNo());
					List<OrderReceiveItem> orderReceiveItems=tOrderReceiveItemMapper.findByReceivableInfoOfOptional(receivableInfoOfOrder.getId());
					receivableInfoOfOrder.setOrderReceiveItemList(orderReceiveItems);
					receivableInfoOfOrder.setTourInfoForOrder(tourInfoForOrderService.findByOrderId(orders.getId()));
					receivableInfoOfOrders.add(receivableInfoOfOrder);
				}
			order.setIsDel(0);//未删除的客人
			List<Order> orderList=orderService.findCustomerListByTourId(order);
			List<Customer> customerList =new ArrayList<Customer>();
			List<CustomerFlight> customerFlightListS = new ArrayList<CustomerFlight>();
			//List<CustomerOrderRel> customerOrderRelList=new ArrayList<CustomerOrderRel>();
			if(orderList.size()>0){
				for (int i = 0; i <orderList.size(); i++) {
					Order ord=orderList.get(i);
					//判断删除的订单
					if(ord.getState()==0||ord.getState()==2||ord.getState()==3){
						//if(ord.getIsDel()!=1){
							/*List<CustomerFlight> customerFlightListST= ord.getCustomerFlightList();
							for (int t = 0; t < customerFlightListST.size(); t++) {
								customerFlightListST.get(t).setUserId(ord.getUserName());
								customerFlightListST.get(t).setCustomerNo(ord.getCustomerTourNo().toString());
								customerFlightListST.get(t).setCustomer(ord.getCustomer());
							}
							//客人航班信息
							customerFlightListS.addAll(customerFlightListST);*/
							//团下客人
							Customer customer= ord.getCustomer();
							if(customer!=null&&ord.getGuestRoomType()!=null){
								customer.setGuestRoomType(ord.getGuestRoomType());
							}
							customer.setTicketType(ord.getTicketType());
							customer.setCustomerCode(ord.getCustomerTourNo().toString());
							customer.setCarName(ord.getCarName());
							customer.setVoucherStr(ord.getWr());
							customer.setOrderNo(ord.getOrderNo());
							customer.setCompanyName(ord.getTourCode());
							customer.setDisplayName(ord.getUserName());
							customer.setOtherInfo(ord.getOtherInfo());
							customer.setPayHistoryInfo(ord.getLineName());
							customer.setCustomerFlightList(ord.getCustomerFlightList());
							customer.setRoomNumber(ord.getSprCheck());
							customerList.add(customer);
						//}
					}
				}
			}
			order.setReceivableInfoOfOrders(receivableInfoOfOrders);
			order.setCustomerList(customerList);
			//order.setCustomerFlightList(customerFlightListS);
			
			CustomerSheetExcle ss=new CustomerSheetExcle();
			ss.setOrder(order);
			return new ModelAndView(ss);
		}
}
