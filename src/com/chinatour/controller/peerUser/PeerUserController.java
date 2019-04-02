package com.chinatour.controller.peerUser;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.Principal;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AgeOfPrice;
import com.chinatour.entity.Contacts;
import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.CustomerOrderRel;
import com.chinatour.entity.Destination;
import com.chinatour.entity.Discount;
import com.chinatour.entity.ExportOrderExcle;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Language;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderFeeItems;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.OrderRemark;
import com.chinatour.entity.OrdersTotal;
import com.chinatour.entity.Payment;
import com.chinatour.entity.PeerUser;
import com.chinatour.entity.PrePostHotel;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.RatePeer;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.ContactsMapper;
import com.chinatour.persistence.CustomerOrderRelMapper;
import com.chinatour.persistence.OrdersTotalMapper;
import com.chinatour.persistence.TOrderReceiveItemMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.AgeOfPriceService;
import com.chinatour.service.CountryService;
import com.chinatour.service.CurrencyTypeService;
import com.chinatour.service.CustomerFlightService;
import com.chinatour.service.CustomerOrderRelService;
import com.chinatour.service.CustomerService;
import com.chinatour.service.DestinationService;
import com.chinatour.service.DiscountService;
import com.chinatour.service.FileService;
import com.chinatour.service.GroupLineService;
import com.chinatour.service.InvoiceToPdfService;
import com.chinatour.service.LanguageService;
import com.chinatour.service.NationalityService;
import com.chinatour.service.OrderFeeItemsService;
import com.chinatour.service.OrderRemarkService;
import com.chinatour.service.OrderService;
import com.chinatour.service.OrderToPdfService;
import com.chinatour.service.OrdersTotalService;
import com.chinatour.service.PDFService;
import com.chinatour.service.PaymentService;
import com.chinatour.service.PeerUserRateService;
import com.chinatour.service.PeerUserService;
import com.chinatour.service.PrePostHotelService;
import com.chinatour.service.ProductAreaService;
import com.chinatour.service.RateOfCurrencyService;
import com.chinatour.service.RatePeerService;
import com.chinatour.service.ReceivableInfoOfOrderService;
import com.chinatour.service.TOrderReceiveItemService;
import com.chinatour.service.TourInfoForOrderService;
import com.chinatour.service.TourTypeService;
import com.chinatour.service.VenderService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.ProductVO;
import com.chinatour.vo.TourOrderListVO;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;
/**
 * Service - 同行用户
 * @copyright   Copyright: 2015
 * @author Aries
 * @create-time 2015-5-06 上午 11:52:20
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/peerUser")
public class PeerUserController  extends com.chinatour.controller.admin.BaseController{
	@Autowired
	private TourTypeService tourTypeService;
	@Autowired
	private GroupLineService  groupLineService;
	@Autowired
	private OrdersTotalService ordersTotalService;
	@Resource(name="peerUserServiceImpl")
	private PeerUserService peerUserService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private VenderService venderService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private LanguageService languageService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrdersTotalMapper ordersTotalMapper;
	@Autowired
	private OrderRemarkService orderRemarkService;
	@Autowired
	private TourInfoForOrderService tourInfoForOrderService;
	@Autowired
	private CustomerOrderRelService customerOrderRelService;
	@Autowired
	private CustomerFlightService customerFlightservice;
	@Autowired
	private PDFService pdfService;
	@Autowired
	private PeerUserRateService peerUserRateService;
	@Autowired
	private AgeOfPriceService ageOfPriceService;
	@Autowired
	private ProductAreaService productAreaService;
	@Autowired
	private CurrencyTypeService currencyTypeService;
	@Autowired
	private RateOfCurrencyService rateOfCurrencyService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private ReceivableInfoOfOrderService receivableInfoOfOrderService;
	@Autowired
	private InvoiceToPdfService invoiceToPdfService;
	@Autowired
	private DestinationService destinationService;
	@Autowired
	private OrderToPdfService orderToPdfService;
	@Autowired
	private CountryService countryService;
	@Autowired
	private CustomerOrderRelMapper customerOrderRelMapper;
	@Resource(name = "fileServiceImpl")
	private FileService fileService;
	@Autowired
	private TOrderReceiveItemMapper tOrderReceiveItemMapper;
	@Autowired
	private DiscountService discountService;
	@Autowired
	private PrePostHotelService prePostHotelService;
	@Autowired
	private ContactsMapper contactsMapper;
	@Autowired
	private OrderFeeItemsService orderFeeItemsService;
	@Autowired
	private RatePeerService ratePeerService;
	@Resource(name = "nationalityServiceImpl")
	private NationalityService nationalityService;
	
	public static final TemplateHashModel CONSTANT;
	
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
	
	
	@RequestMapping(value = "/web", method = RequestMethod.GET)
	public String web(Model model) {
		return "/admin/peerUser/index";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model,GroupLine groupLine,String menuId,Pageable pageable) {
		PeerUser peerUser=peerUserService.getCurrent();
		if(groupLine.getArea()!=null&&groupLine.getArea().equals("zhongguo")){
			groupLine.setArea("中国美(中国及亚洲)");
		}
		if(groupLine.getDegree()!=null&&groupLine.getDegree().equals("key")){
			groupLine.setDegree("超值特价");
		}
		//查找目的地列表
		Destination destination=new Destination();
		destination.setArea(groupLine.getArea());
		destination.setYear(groupLine.getTourName().substring(0, 4));
		List<Destination> destinationList=destinationService.findByDes(destination);
		//根据数据循环出品牌
		String[] brandMange=null;
		List<GroupLine> groupLineList=new ArrayList<GroupLine>();
		Page<GroupLine> page=null;
		pageable.setLength(100);//每页显示数量
		pageable.setPageSize(100);//每页显示数量
		if(peerUser.getBrandMange()!=""){
			brandMange=peerUser.getBrandMange().split(",");
			groupLine.setCurrencyId(peerUser.getCurrencyTypeId());//默认每个产品价格的货币类型
			if(groupLine.getDepartureTime()==null){
				groupLine.setDepartureTime(new Date());
			}
			if(groupLine.getDateTime()!=null){
				groupLine.setDepartureTime(null);
			}
			if(groupLine.getDepartureDate()!=null){//由头部传来的值
				groupLine.setTourCode(groupLine.getDepartureDate());
				groupLine.setDepartureDate(null);
				page=groupLineService.findGroupLineList(groupLine,pageable,brandMange);
				if(page.getTotal()==0){
					groupLine.setTourName(groupLine.getTourCode());
					groupLine.setTourCode(null);
					page=groupLineService.findGroupLineList(groupLine,pageable,brandMange);
				}
			}else{
				page=groupLineService.findGroupLineList(groupLine,pageable,brandMange);
			}
			model.addAttribute("tourTypeList", tourTypeService.findByBrand(groupLine.getBrand()));
			model.addAttribute("groupLine", groupLine);
			model.addAttribute("groupLineList1", groupLineList);
			model.addAttribute("pageSize", page.getTotalPages());
			model.addAttribute("groupLineList", page.getContent());
			model.addAttribute("pageable", pageable);
			model.addAttribute("destinationList", destinationList);
			model.addAttribute("peerUser", peerUser);
			model.addAttribute("area",productAreaService.findAll());
			model.addAttribute("brand", brandMange);
		}
		model.addAttribute("menuId", "1001");
		return "/admin/peerUser/orders/productList";
	}
	/**
	 * 填写产品信息页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/bookProduct", method = RequestMethod.GET)
	public String bookProduct(Model model, GroupLine groupLines) {
		PeerUser p=peerUserService.getCurrent();
		Vender vender=venderService.findById(p.getPeerId());
		Admin admin=adminService.findById(vender.getUserId());
		//总订单
		OrdersTotal ordersTotal=new OrdersTotal();
		ordersTotal.setOrdersTotalId(UUIDGenerator.getUUID());
		ordersTotal.setWr("wholeSale");
		ordersTotal.setCompanyId(vender.getVenderId());
		ordersTotal.setCompany(vender.getName());
		ordersTotal.setAddress(vender.getAddress());
		ordersTotal.setTel(vender.getTel());
		ordersTotal.setEmail(vender.getEmail());
		ordersTotal.setUserId(admin.getId());
		ordersTotal.setDeptId(admin.getDeptId());
		ordersTotal.setAgent(admin.getUsername());
		ordersTotal.setServer(Constant.SERVER);
		ordersTotal.setTotalPeople(0);//暂时的
		ordersTotal.setPeerUserId(p.getPeerUserId());
		ordersTotalMapper.save(ordersTotal);
		ordersTotal.setOrderNumber(ordersTotalMapper.findById(ordersTotal.getOrdersTotalId()).getOrderNumber());
		ordersTotal.setBookingDate(new Date());
		List<Language> language=languageService.findAll();
		//品牌团或者入境团
		//如果groupline的departureDate有多个时间就用departureDateArray传输到页面，是一个就用departureDate传输到页面
		GroupLine groupLine = groupLineService.findById(groupLines.getId());
		model.addAttribute("groupLine", groupLine);
		String departureDate = groupLine.getDepartureDate();
		if(departureDate != null && departureDate.length() != 0){
			String[] departureDates = departureDate.split(",");
			if(departureDates.length == 1){
				model.addAttribute("departureDate", departureDate);
			}
		}
		/*model.addAttribute("brand", groupLines.getBrand());*/
		//使用汇率
		RatePeer rate=new RatePeer();
		rate.setCurrencyId(p.getCurrencyTypeId());
		rate.setToCurrencyId("D696159C-C1B1-49CF-A332-284B6A24CF5D");//美元
		rate.setIsAvailable(0);//B2B的专用汇率
		rate=ratePeerService.findByCurrency(rate);
		List<Contacts> cList=contactsMapper.findByPeerUserId(p.getPeerUserId());
		model.addAttribute("currency", currencyTypeService.findById(p.getCurrencyTypeId()));
		model.addAttribute("language", language);
		//model.addAttribute("country", countryService.findAll());
		model.addAttribute("country", nationalityService.findAll());
		model.addAttribute("peerUser",p);
		model.addAttribute("rate",rate);
		model.addAttribute("memos",Constant.CUSTOMER_MEMOS );
		model.addAttribute("ticketType", Constant.TICKET_TYPES);
		model.addAttribute("ordersTotal",ordersTotal);
		model.addAttribute("groupLines", groupLines);
		model.addAttribute("groupL", groupLineService.findById(groupLines.getId()));
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("cList", cList);
		return "/admin/peerUser/orders/addProduct";
	}
	
	/**
	 * 异步获取关系表信息
	 * */
	@RequestMapping(value = "/backUpForSpecial", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> backUpForSpecial(Pageable pageable,String ordersTotalId,AgeOfPrice ageOfPrice) {
		PeerUser peerUser=peerUserService.getCurrent();
		ageOfPrice.setCurrencyId(peerUser.getCurrencyTypeId());
		Map<String, Object> map = new HashMap<String, Object>();
		/*List<Customer> customerList=ordersTotalService.findCustomersByOrdersTotalId(ordersTotalId);*/
		//循环处理（已有的客人数据和新添加的客人）
		List<Customer> customerList=new ArrayList<Customer>();//没有分房型的客人
		List<Customer> customerRoomList=new ArrayList<Customer>();//有分房型的客人
		List<CustomerOrderRel> crel=customerOrderRelMapper.findByOrdersTotalIdRoomNum(ordersTotalId);
		if(crel.size()>0){
			for(int i=0;i<crel.size();i++){
				if(crel.get(i).getGuestRoomType()!=null&&crel.get(i).getGuestRoomType()!=""){//有房型
					CustomerFlight cf=new CustomerFlight();
					cf.setCustomerOrderRelId(crel.get(i).getId());
					List<CustomerFlight> cfList=customerFlightservice.find(cf);
					Customer Customer=customerService.findById(crel.get(i).getCustomerId());
					Customer.setCustomerFlight(cfList);
					customerRoomList.add(Customer);
				}else{
					CustomerFlight cf=new CustomerFlight();
					cf.setCustomerOrderRelId(crel.get(i).getId());
					List<CustomerFlight> cfList=customerFlightservice.find(cf);
					Customer Customer=customerService.findById(crel.get(i).getCustomerId());
					Customer.setCustomerFlight(cfList);
					Customer.setTicketType(crel.get(i).getId());
					customerList.add(Customer);
				}
			}
		}
		double price=0;//初始化所以年龄阶段价格
		double commission=0;
		String msg=null;
		int priceLeast=0;//几套价格
		List<AgeOfPrice> priceList=ageOfPriceService.findByPrice(ageOfPrice);
		if(priceList.size()==1){
			msg="No change";
		}else{
			if(customerList.size()==0){//所以客人已分房型：开始重新计算价格
				if(priceList.get(priceList.size()-1).getTypeNo()==1){//有三人房价格
					priceLeast=1;
				}else{//有第四人房价格
					priceLeast=2;
				}
				//价格计算
				Map<String, List<CustomerOrderRel>> crn=new HashMap<String, List<CustomerOrderRel>>();
				for(int i=0;i<crel.get(crel.size()-1).getRoomNumber();i++){
					List<CustomerOrderRel> customerOrderRel = new ArrayList<CustomerOrderRel>();
					crn.put("customerOrderRoomNo"+(i+1), customerOrderRel);
				}
				if(crel.size()>0){
					for(Map.Entry<String, List<CustomerOrderRel>> entry : crn.entrySet()){
						List<CustomerOrderRel> customerOrderRoomNo = new ArrayList<CustomerOrderRel>();
						String key=entry.getKey();
						for(int i=0;i<crel.size();i++){
							if( ("customerOrderRoomNo"+crel.get(i).getRoomNumber() ).equals(key)){
								customerOrderRoomNo.add(crel.get(i));
								crn.put(key, customerOrderRoomNo);
							}
						}
						
					}
				}
				if(!crn.isEmpty()){
					for(Map.Entry<String, List<CustomerOrderRel>> entry : crn.entrySet()){
						List<CustomerOrderRel> CustomerOrderRelist=entry.getValue();
						
							List<CustomerOrderRel> adultList=new ArrayList<CustomerOrderRel>();
							List<CustomerOrderRel> childNoBedList=new ArrayList<CustomerOrderRel>();
							List<CustomerOrderRel> infantList=new ArrayList<CustomerOrderRel>();
							List<CustomerOrderRel> RoomShareList=new ArrayList<CustomerOrderRel>();
							
							for(int i=0;i<CustomerOrderRelist.size();i++){
								if(i>0){
									if(RoomShareList.size()>1){
										msg="Please check the Room Sharing pax.";
										break;
									}
									if(CustomerOrderRelist.get(i).getCustomer().getType()==1){
										infantList.add(CustomerOrderRelist.get(i));
									}else if(CustomerOrderRelist.get(i).getCustomer().getType()==2){
										childNoBedList.add(CustomerOrderRelist.get(i));
									}else if(CustomerOrderRelist.get(i).getCustomer().getType()>2&&"Room Sharing".equals(CustomerOrderRelist.get(i).getGuestRoomType())){
										RoomShareList.add(CustomerOrderRelist.get(i));
									}else if(CustomerOrderRelist.get(i).getCustomer().getType()>2&& ! "Room Sharing".equals(CustomerOrderRelist.get(i).getGuestRoomType())){
										adultList.add(CustomerOrderRelist.get(i));
									}
									
								}else{
									if(CustomerOrderRelist.get(i).getCustomer().getType()==1){
										infantList.add(CustomerOrderRelist.get(i));
									}else if(CustomerOrderRelist.get(i).getCustomer().getType()==2){
										childNoBedList.add(CustomerOrderRelist.get(i));
									}else if(CustomerOrderRelist.get(i).getCustomer().getType()>2&&"Room Sharing".equals(CustomerOrderRelist.get(i).getGuestRoomType())){
										RoomShareList.add(CustomerOrderRelist.get(i));
									}else if(CustomerOrderRelist.get(i).getCustomer().getType()>2&& ! "Room Sharing".equals(CustomerOrderRelist.get(i).getGuestRoomType())){
										adultList.add(CustomerOrderRelist.get(i));
									}
								}
								
							}
							if(adultList.size()>3&&priceLeast==1){//房间人数超出
								msg="Please check the room number.";
								break;
							}
							if(adultList.size()>4&&priceLeast==2){//房间人数超出
								msg="Please check the room number.";
								break;
							}
							if(adultList.size()!=0){
									for(int i=0;i<adultList.size();i++){
										if(i==0){
											price=price+calculate(adultList.get(i).getCustomer().getType(),0,ageOfPrice,0);
											commission=commission+calculateComm(4, 0, ageOfPrice);
										}else if(i==1){
											price=price+calculate(adultList.get(i).getCustomer().getType(),0,ageOfPrice,0);
											commission=commission+calculateComm(4, 0, ageOfPrice);
										}else if(i==2){
											price=price+calculate(adultList.get(i).getCustomer().getType(),1,ageOfPrice,0);
											commission=commission+calculateComm(4, 1, ageOfPrice);
										}else if(i==3){
											price=price+calculate(adultList.get(i).getCustomer().getType(),2,ageOfPrice,0);
											commission=commission+calculateComm(4, 2, ageOfPrice);
										}
									}
								}
							if(childNoBedList.size()!=0){
								for(int i=0;i<childNoBedList.size();i++){
									price=price+calculate(childNoBedList.get(i).getCustomer().getType(),0,ageOfPrice,0);
								}
							}
							if(infantList.size()!=0){
								for(int i=0;i<infantList.size();i++){
									price=price+calculate(infantList.get(i).getCustomer().getType(),0,ageOfPrice,0);
								}
							}
							if(RoomShareList.size()!=0){
								for(int i=0;i<RoomShareList.size();i++){
									price=price+calculate(RoomShareList.get(i).getCustomer().getType(),0,ageOfPrice,7);
							}
						}
					}
				}
			}
		}

		map.put("customerList", customerList);
		map.put("customerRoomList", customerRoomList);
		map.put("number", customerList.size());
		map.put("roomNumber", customerRoomList.size());
		map.put("price", price);
		map.put("comm", commission);
		map.put("msg", msg);
		return map;
	}
	

	/**
	 * 异步获取关系表信息
	 * */
	@RequestMapping(value = "/backUp", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> backUp(Pageable pageable,String ordersTotalId,AgeOfPrice ageOfPrice) {
		PeerUser peerUser=peerUserService.getCurrent();
		ageOfPrice.setCurrencyId(peerUser.getCurrencyTypeId());
		Map<String, Object> map = new HashMap<String, Object>();
		/*List<Customer> customerList=ordersTotalService.findCustomersByOrdersTotalId(ordersTotalId);*/
		//循环处理（已有的客人数据和新添加的客人）
		List<Customer> customerList=new ArrayList<Customer>();//没有分房型的客人
		List<Customer> customerRoomList=new ArrayList<Customer>();//有分房型的客人
		List<CustomerOrderRel> crel=customerOrderRelMapper.findByOrdersTotalIdRoomNum(ordersTotalId);
		if(crel.size()>0){
			for(int i=0;i<crel.size();i++){
				if(crel.get(i).getGuestRoomType()!=null&&crel.get(i).getGuestRoomType()!=""){//有房型
					CustomerFlight cf=new CustomerFlight();
					cf.setCustomerOrderRelId(crel.get(i).getId());
					List<CustomerFlight> cfList=customerFlightservice.find(cf);
					Customer Customer=customerService.findById(crel.get(i).getCustomerId());
					Customer.setCustomerFlight(cfList);
					customerRoomList.add(Customer);
				}else{
					CustomerFlight cf=new CustomerFlight();
					cf.setCustomerOrderRelId(crel.get(i).getId());
					List<CustomerFlight> cfList=customerFlightservice.find(cf);
					Customer Customer=customerService.findById(crel.get(i).getCustomerId());
					Customer.setCustomerFlight(cfList);
					Customer.setTicketType(crel.get(i).getId());
					customerList.add(Customer);
				}
			}
		}
		double price=0;//初始化所以年龄阶段价格
		String msg=null;
		List<AgeOfPrice> priceList=ageOfPriceService.findByPrice(ageOfPrice);
		if(priceList.size()==1){
			msg="No change";
		}else{
			if(customerList.size()==0){//所以客人已分房型：开始重新计算价格
				int priceLeast=0;//几套价格
				if(priceList.get(priceList.size()-1).getTypeNo()==1){//有三人房价格
					priceLeast=1;
				}else{//有第四人房价格
					priceLeast=2;
				}
				int l=1;//相同房号的的个数
				int sum=1;//相同房号的的个数
				if(crel.size()==1){
						price=price+calculate(crel.get(0).getCustomer().getType(),0,ageOfPrice,0);
				}else{
					for(int a=0;a<crel.size();a++){
						if(a>0){//a>0说明不是第一个数据
							sum=sum+1;
							if(crel.get(a).getRoomNumber()==crel.get(a-1).getRoomNumber()){//房号相等
								if(crel.get(a).getCustomer().getType()>2){
									l=l+1;
								}
								if(l>3&&priceLeast==1){//房间人数超出
									msg="Please check the room number.";
									break;
								}
								if(l>4&&priceLeast==2){//房间人数超出
									msg="Please check the room number.";
									break;
								}
								if(a==crel.size()-1){//a是最后一位客人
									if(l==3){//三人间价格
										for(int y=0;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),1,ageOfPrice,1);
										}
									}else if(l==4){//四人间价格
										for(int y=0;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),2,ageOfPrice,1);
										}
									}else{
										for(int y=0;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),0,ageOfPrice,1);
										}
									}
								}
							}else{
								if(l==3){//三人间价格
									if(a==crel.size()-1){
										for(int y=1;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),1,ageOfPrice,1);
										}
										price=price+calculate(crel.get(a).getCustomer().getType(),0,ageOfPrice,1);
									}else{
										for(int y=1;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),0,ageOfPrice,1);
										}
									}
								}else if(l==4){//四人间价格
									if(a==crel.size()-1){
										for(int y=1;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),2,ageOfPrice,1);
										}
										price=price+calculate(crel.get(a).getCustomer().getType(),0,ageOfPrice,1);
									}else{
										for(int y=1;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),2,ageOfPrice,1);
										}
									}
								}else{//当l达不到3以上的值说明是标间价格
									if(a==crel.size()-1){
										for(int y=0;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),0,ageOfPrice,1);
										}
									}else{
										for(int y=1;y<sum;y++){
											price=price+calculate(crel.get(a-y).getCustomer().getType(),0,ageOfPrice,1);
										}
									}
								}
								if(crel.get(a).getCustomer().getType()<=2){//儿童一下和不占床时,都视为不占床否则以占床处理
									sum=1;
									l=0;
								}else{
									l=1;
									sum=1;
								}
							}
						}else{//判断第一个客人的类型
							if(crel.get(a).getCustomer().getType()<=2){//儿童一下和不占床时,都视为不占床否则以占床处理
								sum=1;
								l=0;
							}else{
								l=1;
								sum=1;
							}
						}
					}
				}
			}
		}
		map.put("customerList", customerList);
		map.put("customerRoomList", customerRoomList);
		map.put("number", customerList.size());
		map.put("roomNumber", customerRoomList.size());
		map.put("price", price);
		map.put("msg", msg);
		return map;
	}

	
	@RequestMapping(value="/calculate",method=RequestMethod.GET)
	public double calculate(Integer type,Integer paxType,AgeOfPrice ageOfPrice,Integer haveBed){
		double price=0;
		List<AgeOfPrice> priceList=ageOfPriceService.findByPrice(ageOfPrice);
		/*if(type==1){//婴儿
			price=priceList.get(paxType).getBaby().doubleValue();
		}else if(type==2){//儿童
			price=priceList.get(paxType).getChildren().doubleValue();
		}else if(type==3){//小孩
			if(haveBed==1){//占床
				price=priceList.get(paxType).getBed().doubleValue();
			}else{//不占床
				price=priceList.get(paxType).getNotBed().doubleValue();
			}
		}else{//成人
			price=priceList.get(paxType).getAdult().doubleValue();
		}*/
		if(haveBed==7){
			price=priceList.get(paxType).getRoomSharing().doubleValue();
			return price;
		}
		if(type==1){//婴儿
			price=priceList.get(paxType).getBaby().doubleValue();
		}else if(type==2){//儿童
			price=priceList.get(paxType).getNotBed().doubleValue();
		}else if(type==3){//小孩
				price=priceList.get(paxType).getBed().doubleValue();
		}else{//成人
			price=priceList.get(paxType).getAdult().doubleValue();
		}
		return price;
	}
	/**
	 * 澳洲要求的二十个产品佣金计算
	 * forCommission
	 */
	public double calculateComm(Integer paxType,Integer type,AgeOfPrice ageOfPrice){
		double comm=0;
		GroupLine groupline=groupLineService.findById(ageOfPrice.getGroupLineId());
		List<AgeOfPrice> priceList=ageOfPriceService.findByPrice(ageOfPrice);
		if(paxType==1){//婴儿
			
		}else if(paxType==2){//儿童
			
		}else if(paxType==3){//小孩
			comm=priceList.get(type).getChildComm().doubleValue();
		}else{//成人
			comm=priceList.get(type).getCommission().doubleValue();
		}
		return comm;
	}

//	
//	public double calculateChil(Integer agePriceIndex,AgeOfPrice ageOfPrice){
//		double commChil=0;
//		GroupLine groupline=groupLineService.findById(ageOfPrice.getGroupLineId());
//		List<AgeOfPrice> priceList=ageOfPriceService.findByPrice(ageOfPrice);
//		if(groupline.getType()==1){
//			commChil=priceList.get(agePriceIndex).getBed().doubleValue()*priceList.get(agePriceIndex).getChildComm().doubleValue()/100;
//		}else{
//			commChil=priceList.get(agePriceIndex).getChildComm().doubleValue();
//		}
//		return commChil;
//	}
	/**
	 * 保存订单
	 * */
	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addProduct(Pageable pageable,PeerUser peerUser,String brand) {
		Map<String, Object> map = new HashMap<String, Object>();
		ProductVO productVO=peerUser.getProductVO();
		//给订单添加Brand
		GroupLine g=groupLineService.findById(productVO.getTourInfoForOrder().getGroupLineId());
		productVO.getOrder().setBrand(g.getBrand());
		//添加产品时，更改总订单人数
		OrdersTotal ordersTotal=ordersTotalService.findById(productVO.getOrdersTotalId());
		ordersTotal.setTotalPeople(customerOrderRelService.countExistCustomersInOrdersTotal(productVO.getOrdersTotalId()));
		ordersTotal.setContactName(productVO.getOrdersTotal().getContactName());//联系人
		ordersTotalService.updateOrdersTotal(ordersTotal);
		productVO.getOrder().setReviewState(1);//申请通过
		if(productVO.getTourInfoForOrder().getScheduleOfArriveTime()==null){
			productVO.getTourInfoForOrder().setScheduleOfArriveTime(productVO.getTourInfoForOrder().getDepartureDate());
		}
		//设置该订单的佣金=产品佣金*人数
		productVO.getOrder().setCusPrice(productVO.getPrice());//页面传来的团款
		double prices=0;
		for(int a=0;a<productVO.getOtherFeeList().size();a++){
			prices =prices+productVO.getOtherFeeList().get(a).getItemFee().doubleValue();
		}
		productVO.getReceivableInfoOfOrder().setTotalFeeOfOthers(new BigDecimal(prices));//其他费用信息
		productVO.getReceivableInfoOfOrder().setTotalCommonTourFee(new BigDecimal(productVO.getPrice().doubleValue()));//常规团款(页面总价[团款])
		productVO.getReceivableInfoOfOrder().setSumFee(new BigDecimal(productVO.getPrice().doubleValue()+prices-productVO.getOrder().getPeerUserFee().doubleValue()));//结算价格=应付总额-佣金
		//明细
		OrderReceiveItem adultItem=new OrderReceiveItem();
		adultItem.setType(1);
		adultItem.setItemFee(new BigDecimal(productVO.getReceivableInfoOfOrder().getTotalCommonTourFee().doubleValue()/ordersTotal.getTotalPeople()));
		adultItem.setItemFeeNum(ordersTotal.getTotalPeople());
		adultItem.setNum(101);
		adultItem.setRemark("");
		productVO.setAdultItem(adultItem);
		if(productVO.getDiscount()!=null){
			double dis=productVO.getDiscount().getDiscountPrice().doubleValue();
			if(dis!=0){
				productVO.getDiscount().setId(UUIDGenerator.getUUID());
			}else{
				productVO.setDiscount(null);
			}
		}
		orderService.saveProduct(productVO);
		map.put("message", "OK");
		return map;
	}
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String tourList(ModelMap model,String menuId) {
		model.addAttribute("menuId", "1002");
		return  "/admin/peerUser/orders/tourOrderList";
	}
	/**
	 * 订单列表
	 * */
	@RequestMapping(value = "/tourList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tourList(Pageable pageable, Order order) {
		Map<String, Object> map = new HashMap<String, Object>();
		PeerUser peerUser=peerUserService.getCurrent();
		if(peerUser.getAuthority()!=null && peerUser.getAuthority().equals("1")){
			order.setPeerUserName(peerUser.getPeerId());
		}else{
			order.setPeerUserId(peerUser.getPeerUserId());
		}
		Page<TourOrderListVO> page = orderService.findTourOrderListVO(order, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		if(page.getContent().size()>0){
			page.getContent().add(orderService.findOrderSumPepole(order));
		}
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 修改跳转页面
	 * */
	@RequestMapping(value = "/tourOrderEdit", method = RequestMethod.GET)
	public String loadTourOrder(Model model, String id) {
		ProductVO productVO = orderService.loadProduct(id);
		Order order=orderService.findById(id);
		PeerUser p=peerUserService.getCurrent();
		GroupLine groupLine=groupLineService.findById(productVO.getTourInfoForOrder().getGroupLineId());
		AgeOfPrice ageOfPrice=new AgeOfPrice();
		ageOfPrice.setCurrencyId(p.getCurrencyTypeId());
		ageOfPrice.setDepartureTime(productVO.getTourInfoForOrder().getDepartureDate());
		ageOfPrice.setGroupLineId(productVO.getTourInfoForOrder().getGroupLineId());
		AgeOfPrice price=ageOfPriceService.findByDepartureTime(ageOfPrice);
		RateOfCurrency rate=new RateOfCurrency();
		rate.setCurrencyId(p.getCurrencyTypeId());
		rate.setToCurrencyId("D696159C-C1B1-49CF-A332-284B6A24CF5D");//美元
		rate=rateOfCurrencyService.getRate(rate);
		OrdersTotal ordersTotal=ordersTotalService.findById(order.getOrdersTotalId());
		Map<String, Object> result = ordersTotalService.findTotalOrder(order.getOrdersTotalId());
		

		Discount discount=discountService.findByOrder(order.getId());
		PrePostHotel prePostHotel=new PrePostHotel();
		prePostHotel.setOrderId(order.getId());
		List<PrePostHotel> prePostList=prePostHotelService.findByOrderId(prePostHotel);
		model.addAttribute("customerOrderRelList", result.get("customerOrderRelList"));
		model.addAttribute("tourTypeList", tourTypeService.findByBrand(productVO.getOrder().getBrand()));
		model.addAttribute("tourType", tourTypeService.findById(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLineList", groupLineService.findByTourTypeId(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLine",groupLine);
		model.addAttribute("ordersTotal", ordersTotalService.findById(productVO.getOrder().getOrdersTotalId()));
		model.addAttribute("customerList", ordersTotalService.findCustomersByOrderId(productVO.getOrdersTotalId()));
		model.addAttribute("productVO", productVO);
		model.addAttribute("ageOfPrice", price);
		model.addAttribute("ordersTotal",ordersTotal);
		model.addAttribute("currency", currencyTypeService.findById(p.getCurrencyTypeId()));
		model.addAttribute("rate",rate);
		model.addAttribute("discount",discount);
		model.addAttribute("prePostList",prePostList);
		model.addAttribute("orderRemark",orderRemarkService.findRemarkByOrderId(productVO.getOrdersTotalId()));
		return  "/admin/peerUser/orders/editProduct";
	}
	/**
	 * 修改跳转页面
	 * */
	@RequestMapping(value = "/tourEdit", method = RequestMethod.GET)
	public String loadTourEdit(Model model, String id) {
		ProductVO productVO = orderService.loadProduct(id);
		Order order=orderService.findById(id);
		PeerUser p=peerUserService.getCurrent();
		GroupLine groupLine=groupLineService.findById(productVO.getTourInfoForOrder().getGroupLineId());
		AgeOfPrice ageOfPrice=new AgeOfPrice();
		ageOfPrice.setCurrencyId(p.getCurrencyTypeId());
		ageOfPrice.setDepartureTime(productVO.getTourInfoForOrder().getDepartureDate());
		ageOfPrice.setGroupLineId(productVO.getTourInfoForOrder().getGroupLineId());
		AgeOfPrice price=ageOfPriceService.findByDepartureTime(ageOfPrice);
		if(groupLine.getType()==1){
			price.setCommission(new BigDecimal(price.getAdult().doubleValue()*price.getCommission().doubleValue()/100));
			price.setChildComm(new BigDecimal(price.getBed().doubleValue()*price.getChildComm().doubleValue()/100));
		}
		RateOfCurrency rate=new RateOfCurrency();
		rate.setCurrencyId(p.getCurrencyTypeId());
		rate.setToCurrencyId("D696159C-C1B1-49CF-A332-284B6A24CF5D");//美元
		rate=rateOfCurrencyService.getRate(rate);
		OrdersTotal ordersTotal=ordersTotalService.findById(order.getOrdersTotalId());
		Map<String, Object> result = ordersTotalService.findTotalOrder(order.getOrdersTotalId());
		List<CustomerOrderRel> relList=(List<CustomerOrderRel>) result.get("customerOrderRelList");
		int singleNum=0;
		//判断不同年龄段的人数
		int adult=0,bed=0,nobed=0,child=0,infant=0;
		if(relList.size()>0){
			/*for(int i=0;i<relList.size();i++){
				if(relList.get(i).getGuestRoomType().equals("Single")){
					singleNum=singleNum+1;
				}
				int type=relList.get(i).getCustomer().getType();
				if(type==1){
					infant+=1;
				}else if(type==2){
					child+=1;
				}else if(type==3){
					if(relList.get(i).getGuestRoomType()=="Single"){
						singleNum=singleNum+1;
						nobed+=1;
					}else{
						bed+=1;
					}
				}else{
					adult+=1;
				}
			}*/
			for(int i=0;i<relList.size();i++){
				if(relList.get(i).getGuestRoomType().equals("Single")){
					singleNum=singleNum+1;
				}
				int type=relList.get(i).getCustomer().getType();
				if(type==1){
					infant+=1;
				}else if(type==2){
					nobed+=1;
				}else if(type==3){
					bed+=1;
				}else if(type==4){
					adult+=1;
				}else{
				}
			}
		}
		int[] pax=new int[]{adult,bed,nobed,infant};
		Discount discount=discountService.findByOrder(order.getId());
		PrePostHotel prePostHotel=new PrePostHotel();
		prePostHotel.setOrderId(order.getId());
		List<PrePostHotel> prePostList=prePostHotelService.findByOrderId(prePostHotel);
		int num=0;//半价数量
		int numPax=0;//房间的数量
		int nightH=0;
		int night=0;
		
		PrePostHotel p1=new PrePostHotel();
		p1.setOrderId(order.getId());
		p1.setType(0);
		List<PrePostHotel> list1=prePostHotelService.findByOrderId(p1);
		if(list1.size()>0){
			for(int i=0;i<list1.size();i++){
				if(list1.get(i).getRoomType().equals("Extra Bed")){
					num=num+1;
					nightH=nightH+list1.get(i).getNights();
				}
				if(i==0){
					numPax=numPax+1;
					night=list1.get(i).getNights();
				}else{
					if(list1.get(i).getRoomNo()!=list1.get(i-1).getRoomNo()){
						numPax=numPax+1;
						night=night+list1.get(i).getNights();
					}
				}
			}
		}
		PrePostHotel p2=new PrePostHotel();
		p2.setOrderId(order.getId());
		p2.setType(1);
		List<PrePostHotel> list2=prePostHotelService.findByOrderId(p2);
		if(list2.size()>0){
			for(int i=0;i<list2.size();i++){
				if(list2.get(i).getRoomType().equals("Extra Bed")){
					num=num+1;
					nightH=nightH+list2.get(i).getNights();
				}
				if(i==0){
					numPax=numPax+1;
					night=night+list2.get(i).getNights();
				}else{
					if(list2.get(i).getRoomNo()!=list2.get(i-1).getRoomNo()){
						numPax=numPax+1;
						num+=1;
						night=night+list2.get(i).getNights();
					}
				}
			}
		}
		model.addAttribute("cList", contactsMapper.findByPeerUserId(p.getPeerUserId()));
		model.addAttribute("customerOrderRelList", relList);
		model.addAttribute("tourTypeList", tourTypeService.findByBrand(productVO.getOrder().getBrand()));
		model.addAttribute("tourType", tourTypeService.findById(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLineList", groupLineService.findByTourTypeId(productVO.getOrder().getTourTypeId()));
		model.addAttribute("groupLine",groupLine);
		model.addAttribute("ordersTotal", ordersTotalService.findById(productVO.getOrder().getOrdersTotalId()));
		model.addAttribute("customerList", ordersTotalService.findCustomersByOrderId(productVO.getOrdersTotalId()));
		model.addAttribute("productVO", productVO);
		model.addAttribute("ageOfPrice", price);
		model.addAttribute("language",languageService.findAll());
		model.addAttribute("country",countryService.findAll());
		model.addAttribute("ordersTotal",ordersTotal);
		model.addAttribute("singleNum",singleNum);
		model.addAttribute("currency", currencyTypeService.findById(p.getCurrencyTypeId()));
		model.addAttribute("rate",rate);
		model.addAttribute("pax",pax);
		model.addAttribute("discount",discount);
		model.addAttribute("prePostList",prePostList);
		model.addAttribute("night",night);
		model.addAttribute("nightH",nightH);
		model.addAttribute("peerUser",p);
		model.addAttribute("orderRemark",orderRemarkService.findRemarkByOrderId(productVO.getOrdersTotalId()));
		if(order.getTourId().equals("")){
			return  "/admin/peerUser/orders/productEdit";
		}else{
			return  "/admin/peerUser/orders/editFlight";
		}
	}
	@RequestMapping(value = "/tourOrderUpdate",method = RequestMethod.POST)
	public String editTourOrder(Model model,PeerUser peerUser){
		PeerUser u=peerUserService.getCurrent();
		ProductVO productVO=peerUser.getProductVO();
		//删除已用的数据
		if(peerUser.getDelOrl()!=null){
			
			String[] delId=peerUser.getDelOrl().split(",");
			for(int x=0;x<delId.length;x++){
				//删除航班
				CustomerFlight f=new CustomerFlight();
				f.setCustomerOrderRelId(delId[x]);
				List<CustomerFlight> fList=customerFlightservice.find(f);
				for(int y=0;y<fList.size();y++){
					customerFlightservice.deleteById(fList.get(y).getId());
				}
				//删除关系
				customerOrderRelService.deleteId(delId[x]);
			}
		}
		//修改总订单
		OrdersTotal orderTotals=productVO.getOrdersTotal();
		OrdersTotal orderTotal=ordersTotalService.findById(productVO.getOrdersTotalId());
		orderTotal.setTotalPeople(customerOrderRelService.countExistCustomersInOrdersTotal(productVO.getOrdersTotalId()));//新人数
		orderTotal.setContactName(orderTotals.getContactName());
		ordersTotalService.update(orderTotal);
		Order order=productVO.getOrder();
		Order orders=orderService.findById(productVO.getOrder().getOrderId());
		//总订单人数
		orders.setTotalPeople(orderTotal.getTotalPeople());
		orders.setContact(orderTotals.getContactName());
		orders.setRefNo(order.getRefNo());
		orders.setCusPrice(productVO.getPrice());//页面传来的团款
		orders.setPeerUserFee(productVO.getOrder().getPeerUserFee());//新佣金
		if(orders.getReviewState()!=1){
			orders.setReviewState(5);
		}
		orderService.update(orders);
		//更改关系表
		List<CustomerOrderRel> relList=customerOrderRelService.CustomerOrderRel(orderTotal.getOrdersTotalId());
		for(int rel=0;rel<relList.size();rel++){
			CustomerOrderRel r=relList.get(rel);
			if(r.getOrderId()==null){
				r.setOrderId(order.getOrderId());
				customerOrderRelService.update(r);
			}
		}
		//修改订单团信息
		TourInfoForOrder tourInfoForOrder=productVO.getTourInfoForOrder();
		TourInfoForOrder tourInfoForOrders=tourInfoForOrderService.findById(productVO.getTourInfoForOrder().getId());
		tourInfoForOrders.setGroupLineId(tourInfoForOrder.getGroupLineId());
		//根据新的产品  进行赋值
		GroupLine groupLine=groupLineService.findGroupLineById(tourInfoForOrder.getGroupLineId());
		tourInfoForOrders.setTourInfo(tourInfoForOrder.getTourInfo());
		tourInfoForOrders.setSpecialRequirements(tourInfoForOrder.getSpecialRequirements());
		tourInfoForOrderService.update(tourInfoForOrder);
		
		List<CustomerOrderRel> customerFlights=productVO.getCustomerFlights();
		/*
		 * 更新航班信息
		 */
		if(customerFlights!=null){
			//for(CustomerOrderRel customerOrderRel : productVO.getCustomerFlights()){
				for(int c=0;c< productVO.getCustomerFlights().size();c++){
				List<CustomerFlight> list=productVO.getCustomerFlights().get(c).getCustomerFlightList();
				if(list!=null){
					for(CustomerFlight customerFlight :list ){//更改每个航班列表
						if(customerFlight.getId() == null || customerFlight.getId().equals("")){//如果航班不存在，保存一条记录
							/*CustomerFlight customerFlight1=new CustomerFlight();
							customerFlight1.setCustomerOrderRelId(productVO.getCustomerFlights().get(c).getId());
							customerFlight1.setOutOrEnter(customerFlight.getOutOrEnter());
							List<CustomerFlight> lists=customerFlightservice.find(customerFlight1);*/
							customerFlight.setId(UUIDGenerator.getUUID());
							customerFlight.setCustomerOrderRelId(productVO.getCustomerFlights().get(c).getId());
							customerFlightservice.save(customerFlight);
						}else{
							customerFlightservice.update(customerFlight);//如果航班存在 更新一条记录
						}
					}
				}
			}
		}
		/** 修改费用信息*/
		//删除原本的费用记录
		List<OrderReceiveItem> item=tOrderReceiveItemMapper.findByReceivableInfoOfOrderId(receivableInfoOfOrderService.findByOrderId(order.getOrderId()).getId());
		for(int it=0;it<item.size();it++){
			tOrderReceiveItemMapper.removeById(item.get(it).getId());
		}
		receivableInfoOfOrderService.delete(receivableInfoOfOrderService.findByOrderId(order.getOrderId()).getId());
		//重新生成相关费用
		double prices=0;
		for(int a=0;a<productVO.getOtherFeeList().size();a++){
			prices =prices+productVO.getOtherFeeList().get(a).getItemFee().doubleValue();
		}
		ReceivableInfoOfOrder receivableInfoOfOrder=new ReceivableInfoOfOrder();
		receivableInfoOfOrder.setTotalFeeOfOthers(new BigDecimal(prices));//其他费用信息
		receivableInfoOfOrder.setTotalCommonTourFee(new BigDecimal(productVO.getPrice().doubleValue()));//常规团款(页面总价[团款])
		receivableInfoOfOrder.setSumFee(new BigDecimal(productVO.getPrice().doubleValue()+prices-productVO.getOrder().getPeerUserFee().doubleValue()));//结算价格=应付总额-佣金
		receivableInfoOfOrder.setId(UUIDGenerator.getUUID());
		receivableInfoOfOrder.setTotalPeople(orderTotal.getTotalPeople());
		receivableInfoOfOrder.setOrderId(order.getOrderId());
		receivableInfoOfOrderService.save(receivableInfoOfOrder);
		//明细
		List<OrderReceiveItem> orderReceiveItemList=new ArrayList<OrderReceiveItem>();
		OrderReceiveItem adultItem=new OrderReceiveItem();
		adultItem.setType(1);
		adultItem.setItemFee(new BigDecimal(productVO.getReceivableInfoOfOrder().getTotalCommonTourFee().doubleValue()/orderTotal.getTotalPeople()));
		adultItem.setItemFeeNum(orderTotal.getTotalPeople());
		adultItem.setNum(101);
		adultItem.setRemark("");
		productVO.setAdultItem(adultItem);
		
		orderReceiveItemList.add(productVO.getAdultItem());
		orderReceiveItemList.addAll(productVO.getOtherFeeList());
		for(OrderReceiveItem orderReceiveItem : orderReceiveItemList){
			if(orderReceiveItem!=null){
				orderReceiveItem.setId(UUIDGenerator.getUUID());
				orderReceiveItem.setReceivableInfoOfOrderId(receivableInfoOfOrder.getId());
				tOrderReceiveItemMapper.save(orderReceiveItem);
			}
		}
		//修改续住信息
		PrePostHotel pp=new PrePostHotel();
		pp.setOrderId(productVO.getOrdersTotalId());//总订单查找出来的记录更改成子订单Id
		List<PrePostHotel> ppList=prePostHotelService.findByOrderId(pp);
		if(ppList.size()>0){
			for(PrePostHotel prePostHotel:ppList){
				prePostHotel.setOrderId(order.getOrderId());
				prePostHotelService.update(prePostHotel);
			}
		}
		OrderRemark orderRemark = productVO.getOrderRemark();
		if(orderRemark!=null){
			String remark="("+u.getPeerUserName()+"   Modify Record):   ";
			remark=remark+orderRemark.getUpdateRemark();
			orderRemark.setOrderRemarksId(UUIDGenerator.getUUID());
			orderRemark.setModifyDate(new Date());
			orderRemark.setUpdateRemark(remark);
			orderRemark.setOrderId(orders.getId());
			orderRemark.setUserId(u.getUserId());
			orderRemark.setUserName(adminService.findById(u.getUserId()).getUsername());
			orderRemarkService.save(orderRemark);
		}
		//产生辅助表
		if(productVO.getFeeItems()!=null){
			//删除已产生的数据
			orderFeeItemsService.delByOrderId(productVO.getOrder().getOrderId());
			//新建辅助数据
			String[] fee=productVO.getFeeItems().split(",");
			for(int a=0;a<fee.length;a++){
				String[] items=fee[a].split(":");
				OrderFeeItems ofi=new OrderFeeItems();
				ofi.setId(UUIDGenerator.getUUID());
				ofi.setFeeTitle(items[0]);
				ofi.setNum(Integer.parseInt(items[1]));
				ofi.setPrice(new BigDecimal(items[2]));
				ofi.setPax(Integer.parseInt(items[3]));
				ofi.setOrderId(productVO.getOrder().getOrderId());
				orderFeeItemsService.save(ofi);
			}
		}
		model.addAttribute("menuId", "301");
		return "redirect:tourEdit.jhtml?id="+order.getOrderId();
	}
	/**
	 * 编辑总订单页面
	 * @param model
	 * @param ordersTotalId
	 * @param menuId 判断哪个页面跳转的
	 * @return
	 */
	@RequestMapping(value = "/editCustomer", method = RequestMethod.GET)
	public String editTotalOrder(Model model, String id,String menuId) {
		//加载OrdersTotal对象和CustomerOrderRelList(包含Customer)
		Order order=orderService.findById(id);
		Map<String, Object> result = ordersTotalService.findTotalOrder(order.getOrdersTotalId());
		OrdersTotal ordersTotal = (OrdersTotal)result.get("ordersTotal");
		model.addAttribute("ordersTotal", ordersTotal);
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("customerOrderRelList", result.get("customerOrderRelList"));
		return  "/admin/peerUser/orders/editCustomer";
	}
	/**
	 * 佣金页面跳转
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/commission",method=RequestMethod.GET)
	public String commission(Model model,Order order,Pageable pageable) throws ParseException{
		PeerUser peerUser=peerUserService.getCurrent();
		order.setPeerUserId(peerUser.getPeerUserId());
		List<Order> orderList=orderService.statementList(order);
		Order orders=orderService.statementCount(order);
		model.addAttribute("orderList", orderList);
		model.addAttribute("orders", orders);
		model.addAttribute("menuId", "1003");
		model.addAttribute("order", order);
		return "/admin/peerUser/orders/commission";
	}
	/**
	 * 生成PDF
	 */
	@RequestMapping(value="/toFdf",method = RequestMethod.GET)
	public String toPDF(Model model,String groupLineId) {
		String destPath = pdfService.createPdf(groupLineId);
		model.addAttribute("path", destPath);
		model.addAttribute("menuId", "801");
		 return "/admin/peerUser/orders/toPdf";
	}
	/**
	 * 异步获取对应价格
	 * */
	@RequestMapping(value = "/arrPrice", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> arrPrice(AgeOfPrice ageOfPrice) {
		Map<String, Object> map = new HashMap<String, Object>();
			PeerUser peerUser=peerUserService.getCurrent();
			ageOfPrice.setCurrencyId(peerUser.getCurrencyTypeId());
			List<AgeOfPrice> priceList=ageOfPriceService.findByPrice(ageOfPrice);
			/*AgeOfPrice price=ageOfPriceService.findByDepartureTime(ageOfPrice);*/
			AgeOfPrice price=priceList.get(0);
			GroupLine groupline=groupLineService.findById(ageOfPrice.getGroupLineId());
			map.put("ageOfPrice", price);
			map.put("adult", price.getAdult());
			map.put("bed", price.getBed());
			map.put("notBed", price.getNotBed());
			map.put("children", price.getChildren());
			map.put("baby", price.getBaby());
			map.put("priceList",priceList);
			map.put("num",priceList.size());
			map.put("dayNum",groupline.getRemark());
			if(groupline.getType()==1){
				map.put("commission", price.getAdult().doubleValue()*price.getCommission().doubleValue()/100);
				map.put("childComm", price.getBed().doubleValue()*price.getChildComm().doubleValue()/100);
			}else{
				map.put("commission", price.getCommission());
				map.put("childComm", price.getChildComm());
			}
			map.put("hotelPrice", price.getHotelPrice());
			map.put("supplement", price.getSupplement());
		return map;
	}
	
	@RequestMapping(value = "/paymentList", method = RequestMethod.GET)
	public String paymentList(String orderId,Model model) {
		String[] payTypes = Constant.PAYTYPES;
		List<String> payTypeList = new ArrayList<String>(Arrays.asList(payTypes));
		Order order = orderService.findById(orderId);
		ReceivableInfoOfOrder receivableInfoOfOrder = new ReceivableInfoOfOrder();
		receivableInfoOfOrder.setOrderId(orderId);
		receivableInfoOfOrder=receivableInfoOfOrderService.findByOrderId(orderId);
		Discount discount=discountService.findByOrder(orderId);
		double totalFee=0;
		if(discount!=null){
			totalFee = receivableInfoOfOrder.getTotalCommonTourFee().doubleValue()+receivableInfoOfOrder.getTotalFeeOfOthers().doubleValue()-discount.getDiscountPrice().doubleValue();
		}else{
			totalFee = receivableInfoOfOrder.getTotalCommonTourFee().doubleValue()+receivableInfoOfOrder.getTotalFeeOfOthers().doubleValue();
		}
		Payment payment = new Payment();
		payment.setOrderId(orderId);
		List<Payment> paymentList = paymentService.find(payment);
		Payment lastPay = new Payment();
		if(paymentList.size()!=0){
			 lastPay =  paymentList.get(paymentList.size()-1);
		}else{
			lastPay.setPayment(new BigDecimal(0.00));
			lastPay.setBalance(new BigDecimal(totalFee));
		}
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("order", order);
		model.addAttribute("totalFee", totalFee);
		model.addAttribute("lastPay", lastPay);
		model.addAttribute("payTypeList", payTypeList);
		return "/admin/peerUser/orders/paymentList";
	}
	
	@RequestMapping(value = "/savePayment", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> savePayment(Payment payment) {
		Map<String, Object> map = new HashMap<String, Object>();
		payment.setPaymentId(UUIDGenerator.getUUID());
		payment.setPayment(payment.getPayment().add(payment.getAmount()==null?new BigDecimal(0.00):payment.getAmount()));
		payment.setBalance(payment.getBalance().subtract(payment.getAmount()==null?new BigDecimal(0.00):payment.getAmount()));
		paymentService.save(payment);
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		String date = dateFormat.format(new Date());
		payment.setDateStr(date);
		map.put("ok", "ok");
		map.put("pay", payment);
		return map;
	}
	
	/**
	 * 生成PDF
	 */
	@RequestMapping(value="/exportInvoice",method = RequestMethod.GET)
	public String exportInvoice(Model model,String orderId) {
		String destPath = invoiceToPdfService.createInvoicePdfForVender(orderId);
		model.addAttribute("path", destPath);
		 return "/admin/peerUser/orders/exportInvoice";
	}
	
	/**
	 * 生成PDF
	 */
	@RequestMapping(value="/exportVoucher",method = RequestMethod.GET)
	public String exportVoucher(Model model,String id) {
		String destPath = orderToPdfService.createBPdf(id);
		Order order = orderService.findById(id);
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(id);
		Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
		String at = "";
		if(arriveTime!=null){
			at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
		}
		lineName=tourInfoForOrder.getLineName()+"("+at+")";
		model.addAttribute("destPath", destPath);
		model.addAttribute("lineName", lineName);
		model.addAttribute("orderId", id);
		model.addAttribute("order", order);
		return "/admin/peerUser/orders/exportVoucher";
	}
	
	/**
	 * 生成PDF
	 */
	@RequestMapping(value="/exportB2BVoucher",method = RequestMethod.GET)
	public String exportB2BVoucher(Model model,String groupLineId) {
		String destPath = orderToPdfService.createB2BPdf(groupLineId);
		model.addAttribute("destPath", destPath);
		return "/admin/peerUser/orders/exportVoucher";
	}
	
	/**
	 * 生成PDF
	 */
	@RequestMapping(value="/exportVoucherforOpconfirm",method = RequestMethod.GET)
	public String exportVoucherforOpconfirm(Model model,String id) {
		String destPath = orderToPdfService.createBPdfforOpConfirm(id);
		Order order = orderService.findById(id);
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(id);
		Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
		String at = "";
		if(arriveTime!=null){
			at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
		}
		lineName=tourInfoForOrder.getLineName()+"("+at+")";
		model.addAttribute("destPath", destPath);
		model.addAttribute("lineName", lineName);
		model.addAttribute("orderId", id);
		model.addAttribute("order", order);
		return "/admin/peerUser/orders/exportVoucher";
	}
	
	/**
	 * 导出订单
	 */
	@RequestMapping(value="/exportOrderExcle",method = RequestMethod.GET)
	public ModelAndView exportOrderExcle(Order order,HttpServletRequest request, HttpServletResponse response) {
		PeerUser peerUser=peerUserService.getCurrent();
		order.setPeerUserId(peerUser.getPeerUserId());
		List<TourOrderListVO> tourOrderListVOList = orderService.findTourOrderListVOForExport(order);
		ExportOrderExcle excle = new ExportOrderExcle();
		excle.setTourOrderListVOs(tourOrderListVOList);
		return new ModelAndView(excle);
	}
	@RequestMapping(value = "/getUserName" , method = RequestMethod.GET)
	 public @ResponseBody String getUserName(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        HttpSession session = request.getSession();
	        Principal principal = (Principal) session.getAttribute("peerUser");
	        String userName = "";
	        if(principal!=null){
	        	userName = principal.getUsername();
	        }
			return userName;
	 }
	/**
	 * 异步删除客人
	 * 
	 * @param customerOrderRelId
	 * @return
	 */
	@RequestMapping(value = "/delCustomer", method = RequestMethod.POST)
	public @ResponseBody String delCustomer(String customerOrderRelId){
		String result = orderService.delCustomer(customerOrderRelId);
		if("".equals(result)){
			return "success";
		}else if("all".equals(result)){
			return "all";
		}
		return "";
	}
	
	@RequestMapping(value="/groulineInfo",method = RequestMethod.GET)
	public String groulineInfo(Model model,String id) {
		List<GroupRoute> groupRouteList = groupLineService.findGroupRouteByGroupLineId(id);
		GroupLine groupLineWithHotel = groupLineService.findHotelByGroupLineId(id);
		List<GroupLineHotelRel> groupLineHotelRelList = groupLineWithHotel.getGroupLineHotelRel();
		GroupLine groupLine = groupLineService.findById(id);
		model.addAttribute("groupRouteList", groupRouteList);
		model.addAttribute("groupLine", groupLine);
		model.addAttribute("groupLineHotelRelList", groupLineHotelRelList);
		 return "/admin/peerUser/orders/toursLine";
	}
	
	/**
	 * 修改客人
	 * */
	@RequestMapping(value = "/updateCustomer", method = RequestMethod.POST)
	public @ResponseBody String updateCustomer(CustomerOrderRel customerOrderRel) {
		ordersTotalService.updateCustomerByPeerUser(customerOrderRel);
		return "";
	}
	@RequestMapping(value = "download")
	public ModelAndView download(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String downLoadPath =Constant.PEERUSER;
		String contentType = "application/octet-stream";
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	
	/**
	 * 同行修改跳转
	 */
	@RequestMapping(value = "/editPeerUser" , method = RequestMethod.GET)
	public String edit(ModelMap model,String id){
		PeerUser p=peerUserService.getCurrent();
		model.addAttribute("vender",venderService.findById(p.getPeerId()));
		model.addAttribute("peerUser",peerUserService.findById(p.getPeerUserId()));
		model.addAttribute("countryList", countryService.findAll());
		return "/admin/peerUser/orders/resetPassword";
	}
	
	/**
	 * 同行修改保存
	 */
	@RequestMapping(value = "/updatePeerUser" , method = RequestMethod.POST)
	public String update(ModelMap model,PeerUser peerUser,Vender vender){
		vender.setModifyDate(new Date());
		vender.setIsDel(vender.getIsDel());
		venderService.update(vender);
		peerUserService.update(peerUser);
		return "redirect:logout.jhtml";
	}
	@RequestMapping(value = "/addCustomerForSelection", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> addCustomerForSelection(RedirectAttributes redirectAttributes,String customerIds,String ordersTotalId) {
		Map<String, Object> map = new HashMap<String, Object>();
		String[] customerIdList = customerIds.split(",");
		List<Customer> customerList=new ArrayList<Customer>();
		for(int i=0;i<customerIdList.length;i++){
			Customer c=customerService.findById(customerIdList[i]);
			int maxCustomerOrderNo = customerOrderRelService.findMaxCustomerOrderNoByOrdersTotalId(ordersTotalId);
			CustomerOrderRel customerOrderRel = new CustomerOrderRel();
			customerOrderRel.setId(UUIDGenerator.getUUID());
			customerOrderRel.setCustomerId(customerIdList[i]);
			customerOrderRel.setOrdersTotalId(ordersTotalId);
			customerOrderRel.setContactFlag(0);//客人在总订单下的状态
			customerOrderRel.setCustomerOrderNo(maxCustomerOrderNo + 1);//客人在子订单下的编号
			ordersTotalService.addCustomerForSelect(customerOrderRel);
			c.setTicketType(customerOrderRel.getId());
			customerList.add(c);
		} 
		map.put("customerList", customerList);
		map.put("num", customerList.size());
		 return map;
	}
	/**
	 * 获取客人可组房的客人
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getRoommates", method = RequestMethod.POST)
	public @ResponseBody List<CustomerOrderRel> getRoommates(String ordersTotalId, String guestRoomType) {
		return ordersTotalService.getRoommates(ordersTotalId, guestRoomType);
	}
	/**
	 * 获取客人可组房的客人
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getNoRoom", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> getNoRoom(String ordersTotalId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CustomerOrderRel> corList=customerOrderRelService.getNoRoom(ordersTotalId);
		map.put("corList", corList);
		map.put("num", corList.size());
		return map;
	}
	/**
	 * 获取客人可加人的的房间及客人信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getKingRoom", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> getKingRoom(String ordersTotalId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CustomerOrderRel> corList=customerOrderRelService.getKingRoom(ordersTotalId);
		map.put("corList", corList);
		map.put("num", corList.size());
		return map;
	}
	/**
	 * 同行客人房型添加
	 * */
	@RequestMapping(value = "/roomType", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> roomType(String ordersTotalId,String cuso,String cusT,String roomtype,Integer paxType) {
		Map<String, Object> map = new HashMap<String, Object>();
			SimpleDateFormat format=new SimpleDateFormat("yyyy");
			//PeerUser peerUser=peerUserService.getCurrent();
			Customer customer=customerService.findById(cuso);
			CustomerOrderRel customerOrderRel=new CustomerOrderRel();
			customerOrderRel.setOrdersTotalId(ordersTotalId);
			customerOrderRel.setCustomerId(cuso);
			List<CustomerOrderRel> cerList=customerOrderRelService.find(customerOrderRel);
			for(int i=0;i<cerList.size();i++){
				CustomerOrderRel cor=cerList.get(i);//找出关系进行数据更改
				cor.setGuestRoomType(roomtype);
				cor.setRoomNumber(Integer.parseInt(cusT));
				cor.setRoomIsFull(0);
				customerOrderRelService.update(cor);
			}
			
			List<CustomerOrderRel> corList=customerOrderRelService.findRoomCustomer(ordersTotalId);
			int numbers=0;
			if(corList.size()>0){
				for(int i=0;i<corList.size();i++){
					if(corList.get(i).getGuestRoomType().equals("Single")){
						numbers=numbers+1;	
					}
				}
			}
			map.put("corList", corList);
			map.put("num", corList.size());
			map.put("numbers", numbers);
			map.put("paxType", paxType);
			map.put("birthday", format.format(customer.getDateOfBirth()));
		return map;
	}
	/**
	 * 酒店延住和提前入住
	 * 
	 * @return
	 */
	@RequestMapping(value = "/prePost", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> prePost(String guest,String roomType,Integer roomNo,Integer nights,Integer type,String ordersTotalId) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Order> order=orderService.findByOrdersTotalId(ordersTotalId);
		PrePostHotel pp=new PrePostHotel();
		pp.setPrePostHotelId(UUIDGenerator.getUUID());
		pp.setGuest(guest);
		pp.setRoomType(roomType);
		pp.setRoomNo(roomNo);
		pp.setNights(nights);
		pp.setType(type);
		pp.setOrderId(ordersTotalId);
		prePostHotelService.save(pp);
		int num=0;//半价数量
		int numPax=0;//房间的数量
		int nightH=0;
		int night=0;
		
		PrePostHotel p1=new PrePostHotel();
		p1.setOrderId(ordersTotalId);
		p1.setType(0);
		List<PrePostHotel> list1=prePostHotelService.findByOrderId(p1);
		if(list1.size()>0){
			for(int i=0;i<list1.size();i++){
				if(list1.get(i).getRoomType().equals("Extra Bed")){
					num=num+1;
					nightH=nightH+list1.get(i).getNights();
				}
				if(i==0){
					numPax=numPax+1;
					night=list1.get(i).getNights();
				}else{
					if(list1.get(i).getRoomNo()!=list1.get(i-1).getRoomNo()){
						numPax=numPax+1;
						night=night+list1.get(i).getNights();
					}
				}
			}
		}
		if(order.size()>0){
			p1.setOrderId(order.get(0).getId());
			List<PrePostHotel> listorder1=prePostHotelService.findByOrderId(p1);
			if(listorder1.size()>0){
				for(int i=0;i<listorder1.size();i++){
					if(listorder1.get(i).getRoomType().equals("Extra Bed")){
						num=num+1;
						nightH=nightH+listorder1.get(i).getNights();
					}
					if(i==0){
						numPax=numPax+1;
						night=listorder1.get(i).getNights();
					}else{
						if(listorder1.get(i).getRoomNo()!=listorder1.get(i-1).getRoomNo()){
							numPax=numPax+1;
							night=night+listorder1.get(i).getNights();
						}
					}
				}
				list1.addAll(listorder1);
			}
		}
		PrePostHotel p2=new PrePostHotel();
		p2.setOrderId(ordersTotalId);
		p2.setType(1);
		List<PrePostHotel> list2=prePostHotelService.findByOrderId(p2);
		if(list2.size()>0){
			for(int i=0;i<list2.size();i++){
				if(list2.get(i).getRoomType().equals("Extra Bed")){
					num=num+1;
					nightH=nightH+list2.get(i).getNights();
				}
				if(i==0){
					numPax=numPax+1;
					night=night+list2.get(i).getNights();
				}else{
					if(list2.get(i).getRoomNo()!=list2.get(i-1).getRoomNo()){
						numPax=numPax+1;
						num+=1;
						night=night+list2.get(i).getNights();
					}
				}
			}
		}
		if(order.size()>0){
			p2.setOrderId(order.get(0).getId());
			List<PrePostHotel> listorder2=prePostHotelService.findByOrderId(p2);
			if(listorder2.size()>0){
				for(int i=0;i<listorder2.size();i++){
					if(listorder2.get(i).getRoomType().equals("Extra Bed")){
						num=num+1;
						nightH=nightH+listorder2.get(i).getNights();
					}
					if(i==0){
						numPax=numPax+1;
						night=night+listorder2.get(i).getNights();
					}else{
						if(list2.get(i).getRoomNo()!=listorder2.get(i-1).getRoomNo()){
							numPax=numPax+1;
							num+=1;
							night=night+listorder2.get(i).getNights();
						}
					}
				}
				list2.addAll(listorder2);
			}
		}
		map.put("num1", list1.size());
		map.put("num2", list2.size());
		map.put("night",night);//几晚
		map.put("numPax",numPax);//房间数量
		map.put("nightH",nightH);//半价对应的几晚
		map.put("num",num);//半个数量
		map.put("list1", list1);
		map.put("list2", list2);
		return map;
	}
	/**
	 * 酒店延住和提前入住
	 * 
	 * @return
	 */
	@RequestMapping(value = "/delPrePost", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> delPrePost(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		PrePostHotel prePostHotel=prePostHotelService.findById(id);
		List<Order> order=orderService.findByOrdersTotalId(prePostHotel.getOrderId());
		prePostHotelService.delete(id);
		int num=0;//半价数量
		int numPax=0;//房间的数量
		int nightH=0;
		int night=0;
		
		PrePostHotel p1=new PrePostHotel();
		p1.setOrderId(prePostHotel.getOrderId());
		p1.setType(0);
		List<PrePostHotel> list1=prePostHotelService.findByOrderId(p1);
		if(list1.size()>0){
			for(int i=0;i<list1.size();i++){
				if(list1.get(i).getRoomType().equals("Extra Bed")){
					num=num+1;
					nightH=nightH+list1.get(i).getNights();
				}
				if(i==0){
					numPax=numPax+1;
					night=list1.get(i).getNights();
				}else{
					if(list1.get(i).getRoomNo()!=list1.get(i-1).getRoomNo()){
						numPax=numPax+1;
						night=night+list1.get(i).getNights();
					}
				}
			}
		}
		if(order.size()>0){
			p1.setOrderId(order.get(0).getId());
			List<PrePostHotel> listorder1=prePostHotelService.findByOrderId(p1);
			if(listorder1.size()>0){
				for(int i=0;i<listorder1.size();i++){
					if(listorder1.get(i).getRoomType().equals("Extra Bed")){
						num=num+1;
						nightH=nightH+listorder1.get(i).getNights();
					}
					if(i==0){
						numPax=numPax+1;
						night=listorder1.get(i).getNights();
					}else{
						if(listorder1.get(i).getRoomNo()!=listorder1.get(i-1).getRoomNo()){
							numPax=numPax+1;
							night=night+listorder1.get(i).getNights();
						}
					}
				}
				list1.addAll(listorder1);
			}
		}
		PrePostHotel p2=new PrePostHotel();
		p2.setOrderId(prePostHotel.getOrderId());
		p2.setType(1);
		List<PrePostHotel> list2=prePostHotelService.findByOrderId(p2);
		if(list2.size()>0){
			for(int i=0;i<list2.size();i++){
				if(list2.get(i).getRoomType().equals("Extra Bed")){
					num=num+1;
					nightH=nightH+list1.get(i).getNights();
				}
				if(i==0){
					numPax=numPax+1;
					night=night+list2.get(i).getNights();
				}else{
					if(list2.get(i).getRoomNo()!=list2.get(i-1).getRoomNo()){
						numPax=numPax+1;
						num+=1;
						night=night+list2.get(i).getNights();
					}
				}
			}
		}
		if(order.size()>0){
			p2.setOrderId(order.get(0).getId());
			List<PrePostHotel> listorder2=prePostHotelService.findByOrderId(p2);
			if(listorder2.size()>0){
				for(int i=0;i<listorder2.size();i++){
					if(listorder2.get(i).getRoomType().equals("Extra Bed")){
						num=num+1;
						nightH=nightH+listorder2.get(i).getNights();
					}
					if(i==0){
						numPax=numPax+1;
						night=night+listorder2.get(i).getNights();
					}else{
						if(list2.get(i).getRoomNo()!=listorder2.get(i-1).getRoomNo()){
							numPax=numPax+1;
							num+=1;
							night=night+listorder2.get(i).getNights();
						}
					}
				}
				list2.addAll(listorder2);
			}
		}
		map.put("num1", list1.size());
		map.put("num2", list2.size());
		map.put("night",night);//几晚
		map.put("numPax",numPax);//房间数量
		map.put("nightH",nightH);//半价对应的几晚
		map.put("num",num);//半个数量
		map.put("list1", list1);
		map.put("list2", list2);
		return map;
	}
	@RequestMapping(value = "/logout" , method = RequestMethod.GET)
	public String logout(String captchaId, String captcha,String username,String password, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		session.removeAttribute("peerUser");
		 return "redirect:add.jhtml";
    }
	/**
	 * 清楚废用的总单，客人，航班及相应的关系信息数据
	 * */
	@RequestMapping(value="/delTotalInfo",method=RequestMethod.GET)
	public @ResponseBody void delTotalInfo(){
		PeerUser peerUser=peerUserService.getCurrent();
		ordersTotalService.delTotalInfo(peerUser.getPeerUserId());
	}
	/**
	 * 产生invoice(pdf)-->OrderTotal
	 * @return
	 */
	@RequestMapping(value = "/createInvoiceToPdf", method = RequestMethod.GET)
	public String createInvoiceToPdf(Model model,String totalId,String menuId,String logo){
		OrdersTotal order = ordersTotalService.findById(totalId);
		String destPath = "";
		List<Order> orderList = orderService.findChildOrderList(totalId);
		destPath = invoiceToPdfService.createInvoicePdf(totalId,logo);
		String tourCode = "";
		for(Order orders:orderList){
			tourCode+=orders.getTourCode();
		}
		
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0;i<orderList.size();i++){
			TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(orderList.get(i).getId());
			Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
			String at = "";
			if(arriveTime!=null){
				at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
				tourCode = orderList.get(i).getTourCode();
			}
			if(orderList.size()==1){
				lineName+=tourInfoForOrder.getLineName()+"("+at+")";
				tourCode = orderList.get(i).getTourCode();
			}else{
				if(i==orderList.size()-1){
					lineName+=tourInfoForOrder.getLineName()+"("+at+")";
					tourCode = orderList.get(i).getTourCode();
				}else{
					lineName+=tourInfoForOrder.getLineName()+"("+at+",)";
					tourCode = orderList.get(i).getTourCode()+",";
				}
				
			}
			
		}
		model.addAttribute("destPath", destPath);
		model.addAttribute("menuId", menuId);
		model.addAttribute("iOrV", "1");
		model.addAttribute("order", order);
		model.addAttribute("ordersTotalId", totalId);
		model.addAttribute("lineName", lineName);
		model.addAttribute("tourCode", tourCode);
		model.addAttribute("logo", logo);
		return "/admin/order/invoiceToPdf";
	}
	/**
	 * 产生invoice(pdf)-->OrderTotal
	 * @return
	 */
	@RequestMapping(value = "/createInvoiceToBPdf", method = RequestMethod.GET)
	public String createInvoiceToBPdf(Model model,String totalId,String menuId,String logo){
		OrdersTotal order = ordersTotalService.findById(totalId);
		String destPath = "";
		List<Order> orderList = orderService.findChildOrderList(totalId);
		destPath = invoiceToPdfService.createInvoicePdfB(totalId,logo);
		String tourCode = "";
		for(Order orders:orderList){
			tourCode+=orders.getTourCode();
		}
		
		String lineName = "";
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0;i<orderList.size();i++){
			TourInfoForOrder tourInfoForOrder = tourInfoForOrderService.findByOrderId(orderList.get(i).getId());
			Date arriveTime = tourInfoForOrder.getScheduleOfArriveTime();
			String at = "";
			if(arriveTime!=null){
				at = dateFormat.format(tourInfoForOrder.getScheduleOfArriveTime());
				tourCode = orderList.get(i).getTourCode();
			}
			if(orderList.size()==1){
				lineName+=tourInfoForOrder.getLineName()+"("+at+")";
				tourCode = orderList.get(i).getTourCode();
			}else{
				if(i==orderList.size()-1){
					lineName+=tourInfoForOrder.getLineName()+"("+at+")";
					tourCode = orderList.get(i).getTourCode();
				}else{
					lineName+=tourInfoForOrder.getLineName()+"("+at+",)";
					tourCode = orderList.get(i).getTourCode()+",";
				}
				
			}
			
		}
		model.addAttribute("destPath", destPath);
		model.addAttribute("menuId", menuId);
		model.addAttribute("iOrV", "1");
		model.addAttribute("order", order);
		model.addAttribute("ordersTotalId", totalId);
		model.addAttribute("lineName", lineName);
		model.addAttribute("tourCode", tourCode);
		model.addAttribute("logo", logo);
		return "/admin/order/invoiceToPdf";
	}
	/**
	 * 确认查看审核信息
	 * */
	@RequestMapping(value = "/changeReview", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeReview(String id){
		Map<String, Object> map = new HashMap<String, Object>();
		Order order = orderService.findById(id);
		order.setReviewState(2);
		orderService.update(order);
		map.put("ok", "ok");
		return map;
	}
	/**
	 * 添加联系人信息
	 * */
	@RequestMapping(value="/addContacts", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addContacts(String contactsName,String peerUserId){
		Map<String, Object> map=new HashMap<String, Object>();
		Contacts contacts=new Contacts();
		contacts.setId(UUIDGenerator.getUUID());
		contacts.setContactsName(contactsName);
		contacts.setPeerUserId(peerUserId);
		contactsMapper.save(contacts);
		List<Contacts> cList=contactsMapper.findByPeerUserId(peerUserId);
		map.put("cList", cList);
		map.put("num", cList.size());
		return map;
	}
	/**
	 * 修改订单信息
	 * */
	@RequestMapping(value = "/updateOrderInfo", method = RequestMethod.POST)
	public @ResponseBody String updateOrderInfo(Order order) {
		orderService.update(order);
		return "";
	}
	/**
	 * 异步删除联系人信息
	 * */
	@RequestMapping(value="/delCon", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> delCon(String id){
		Map<String, Object> map=new HashMap<String, Object>();
		contactsMapper.removeById(id);
		map.put("success","success");
		return map;
	}
}
