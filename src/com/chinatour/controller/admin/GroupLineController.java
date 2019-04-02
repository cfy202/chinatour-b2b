package com.chinatour.controller.admin;

import java.io.File;
import java.math.BigDecimal;
import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.FileInfo.FileType;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AgeOfPrice;
import com.chinatour.entity.CurrencyType;
import com.chinatour.entity.DateOfPrice;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.GroupLineHotelRel;
import com.chinatour.entity.GroupRoute;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.Tour;
import com.chinatour.entity.TourType;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.AgeOfPriceMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.AgeOfPriceService;
import com.chinatour.service.BrandService;
import com.chinatour.service.CityService;
import com.chinatour.service.CurrencyTypeService;
import com.chinatour.service.DateOfPriceService;
import com.chinatour.service.DeptService;
import com.chinatour.service.FileService;
import com.chinatour.service.GroupLineService;
import com.chinatour.service.HotelService;
import com.chinatour.service.PDFService;
import com.chinatour.service.ProductAreaService;
import com.chinatour.service.TourTypeService;
import com.chinatour.service.VenderService;
import com.chinatour.util.FreemarkerUtils;
import com.chinatour.util.UUIDGenerator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;
import com.ibm.icu.text.SimpleDateFormat;

/**
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Aug 25, 2014 3:28:51 PM
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/groupline")
public class GroupLineController extends BaseController {
	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/groupline";
	
	/*
	 * 线路的业务层注入
	 */
	@Autowired
	private GroupLineService groupLineService;
	
	@Autowired
	private TourTypeService tourTypeService;
	
	@Autowired
	private CityService cityService;
	
	@Autowired
	private HotelService hotelService;
	
	@Autowired
	private PDFService pdfService;
	
	@Resource(name = "fileServiceImpl")
	private FileService fileService;
	
	@Resource(name="productAreaServiceImpl")
	private ProductAreaService productAreaService;
	
	@Autowired
	private DateOfPriceService dateOfPriceService;
	@Autowired
	private CurrencyTypeService currencyTypeService;
	@Autowired
	private AgeOfPriceService ageOfPriceService;
	@Resource(name = "brandServiceImpl")
	private BrandService brandService;
	@Autowired
	private DeptService DeptService;
	@Autowired
	private VenderService venderService;
	@Resource(name = "adminServiceImpl") 
	private AdminService adminService;
	
	
	@Autowired
	private AgeOfPriceMapper ageOfPriceMapper;
	
	
	/**
	 * 去添加线路页面
	 * @return
	 */
	@RequestMapping(value="/add",method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", 801);
		model.addAttribute("tourTypeList", tourTypeService.findAll());
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("OPAccountList", DeptService.findAll());
		model.addAttribute("productAreaList",productAreaService.findAll());
		return BaseTemplateURL + "/add";
	}
	
	/**
	 * 根据传来的GroupLine对象进行添加操作
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value="/save",method = RequestMethod.POST)
	public String save(GroupLine groupLine) {
		groupLine.setId(UUIDGenerator.getUUID());
		groupLineService.save(groupLine);
		return "redirect:listforUser.jhtml";
	}
	
	/**
	 * 根据传来的GroupLine对象进行添加操作ForAdmin
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value="/saveforAdmin",method = RequestMethod.POST)
	public String saveforAdmin(GroupLine groupLine) {
		groupLine.setId(UUIDGenerator.getUUID());
		groupLineService.save(groupLine);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id执行删除线路的操作
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/del",method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		GroupLine groupLine=groupLineService.findById(id);
		groupLine.setIsAvailable(1);
		groupLineService.update(groupLine);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id查询出GroupLine对象存入model中，转去修改线路页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method = RequestMethod.GET)
	public String edit(String id, Model model,HttpServletRequest request) {
		GroupLine groupLine=groupLineService.findById(id);
		//区分级别
		String a = null,b = null,c=null;
		/*if(groupLine.getLevel()!=null&&!(groupLine.getLevel().equals(""))){
			String[] level=groupLine.getLevel().split(",");
			a=level[0];
			b=level[1];
			c=level[2];
		}*/
		model.addAttribute("menuId", 801);
		model.addAttribute("groupLine", groupLine);
		model.addAttribute("tourTypeList", tourTypeService.findAll());
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("OPAccountList", DeptService.findAll());
		model.addAttribute("opperator", DeptService.findById(groupLine.getOperater()));
		model.addAttribute("productAreaList",productAreaService.findAll());
		if("Admin".equals(adminService.getCurrent().getUsername())){
			model.addAttribute("venderList", venderService.findAll());
		}else{
			model.addAttribute("venderList", venderService.findByDept(adminService.getCurrent().getDeptId()));
		}
		/*model.addAttribute("a", a);
		model.addAttribute("b", b);
		model.addAttribute("c", c);*/
		return BaseTemplateURL + "/edit";
	}
	/**
	 * 去添加线路页面
	 * @return
	 */
	@RequestMapping(value="/addforAdmin",method = RequestMethod.GET)
	public String addForAdmin(Model model) {
		Gson gson=new Gson();
		model.addAttribute("menuId", 899);
		model.addAttribute("tourTypeList", gson.toJson(tourTypeService.findAll()));
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("productAreaList",productAreaService.findAll());
		return BaseTemplateURL + "/addforAdmin";
	}
	/**
	 * 根据传来的id查询出GroupLine对象存入model中，转去修改线路页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/editforAdmin",method = RequestMethod.GET)
	public String editForAdmin(String id, Model model,HttpServletRequest request) {
		GroupLine groupLine=groupLineService.findById(id);
		//区分级别
		String a = null,b = null,c=null;
		/*if(groupLine.getLevel()!=null&&!(groupLine.getLevel().equals(""))){
			String[] level=groupLine.getLevel().split(",");
			a=level[0];
			b=level[1];
			c=level[2];
		}*/
		Gson gson=new Gson();
		model.addAttribute("menuId", 899);
		model.addAttribute("groupLine", groupLine);
		model.addAttribute("tourTypeList",gson.toJson(tourTypeService.findAll()));
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("productAreaList",productAreaService.findAll());
		/*model.addAttribute("a", a);
		model.addAttribute("b", b);
		model.addAttribute("c", c);*/
		return BaseTemplateURL + "/editforAdmin";
	}
	/**
	 * 封团
	 * @param id
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/soldOutDate",method = RequestMethod.GET)
	public String soldOutDate(String id, Model model,HttpServletRequest request) {
		GroupLine groupLine=groupLineService.findById(id);
		model.addAttribute("menuId", 813);
		model.addAttribute("groupLine", groupLine);
		return BaseTemplateURL + "/soldOutDep";
	}
	//b2b封团
	@RequestMapping(value="/updateforB2B",method = RequestMethod.POST)
	public String updateforB2B(GroupLine groupLine) {
		groupLineService.update(groupLine);
		return "redirect:agencyList.jhtml";
	}
	
	/**
	 * 根据传来的GroupLine对象进行更新操作
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value="/update",method = RequestMethod.POST)
	public String update(GroupLine groupLine) {
		groupLineService.update(groupLine);
		return "redirect:listforUser.jhtml";
	}
	
	/**
	 * 根据传来的GroupLine对象进行更新操作
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value="/updateforAdmin",method = RequestMethod.POST)
	public String updateforAdmin(GroupLine groupLine) {
		groupLineService.update(groupLine);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 将menuId值设为801存入model，去线路展示页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public String list(Model model) {
		Admin admin=adminService.getCurrent();
		GroupLine groupLine =new GroupLine();
		groupLine.setBrand("New Product");
		groupLine.setIsSystem(5);
		List<GroupLine> list=groupLineService.findGroupLine(groupLine);
		model.addAttribute("size", list.size());
		model.addAttribute("menuId", "899");
//		if("Admin".equals(admin.getUsername())){
			return BaseTemplateURL + "/list";
//		}
//		return BaseTemplateURL + "/listForOp";
	}
	
	/**
     * 根据传来的Pageable对象和GroupLine对象查出数据并以map返回
     * @param pageable
     * @param groupLine
     * @return
     */
	@RequestMapping(value="/list",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, GroupLine groupLine) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<GroupLine> page = groupLineService.findPage(groupLine, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
     * 给OP编辑本部门产品的权限
     * @param pageable
     * @param groupLine
     * @return
     */
	@RequestMapping(value="/listForOp",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> listForOp(Pageable pageable, GroupLine groupLine) {
		Map<String, Object> map = new HashMap<String, Object>();
		groupLine.setDeptId(adminService.getCurrent().getDeptId());
		Page<GroupLine> page = groupLineService.findPageForOp(groupLine, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	@RequestMapping(value="/listforUser",method = RequestMethod.GET)
	public String listforUser(Model model) {
		GroupLine groupLine =new GroupLine();
		groupLine.setBrand("New Product");
		groupLine.setIsSystem(5);
		List<GroupLine> list=groupLineService.findGroupLine(groupLine);
		model.addAttribute("size", list.size());
		model.addAttribute("menuId", "801");
		return BaseTemplateURL + "/listUser";
	}
	
	/**
     * 根据传来的Pageable对象和GroupLine对象查出数据并以map返回
     * @param pageable
     * @param groupLine
     * @return
     */
	@RequestMapping(value="/listforUser",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> listforUser(Pageable pageable, GroupLine groupLine) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<GroupLine> page = groupLineService.findPage(groupLine, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 同行用户使用的产品线路
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/agencyList",method = RequestMethod.GET)
	public String agencyList(Model model) {
		model.addAttribute("menuId", "813");
		return BaseTemplateURL + "/peerGroupLineList";
	}
	@RequestMapping(value="/agencyList",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agencyList(Pageable pageable, GroupLine groupLine) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<GroupLine> page = groupLineService.findPage(groupLine, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 网站新添加进来的产品需要维护
	 * */
	@RequestMapping(value="/webList",method = RequestMethod.GET)
	public String webList(Model model) {
		model.addAttribute("menuId", "813");
		return BaseTemplateURL + "/webGroupLineList";
	}
	
	/**
	 * 线路出发日期
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/setDeparture",method = RequestMethod.GET)
	public String setDeparture(Model model,String groupLineId) {
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		List<String> list=new ArrayList<String>();
		List<String> monthList=new ArrayList<String>();
		List<AgeOfPrice> ageList=ageOfPriceService.findByGroupLineId(groupLineId);
		String currencyId=null;
		if(ageList.size()>0){
			for(int i=0;i<ageList.size();i++){
				if(i==0){
					monthList.add(format.format(ageList.get(i).getDepartureTime()).substring(0, 7));
					list.add(i,format.format(ageList.get(i).getDepartureTime()));
					currencyId=ageList.get(i).getCurrencyId();
				}else{
					String timeN=format.format(ageList.get(i).getDepartureTime()).substring(0, 7);
					String time=format.format(ageList.get(i-1).getDepartureTime()).substring(0, 7);
					if(!(timeN.equals(time))){
						monthList.add(timeN);
						list.add(i, format.format(ageList.get(i).getDepartureTime()));
					}else{
						list.add(i, format.format(ageList.get(i).getDepartureTime()));
					}
				}
			}
		}
		model.addAttribute("menuId", "813");
		model.addAttribute("list", list);
		model.addAttribute("monthList", monthList);
		model.addAttribute("groupLine", groupLineService.findById(groupLineId));
		model.addAttribute("currencyId",currencyId);
		return BaseTemplateURL + "/setDeparture";
	}
	
	/**
	 * 更改线路出发日期
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateDeparture",method = RequestMethod.GET)
	public String updateDeparture(Model model,String groupLineId,String delTime,String time,String currencyId) {
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		List<CurrencyType> currencyList=currencyTypeService.findAll();
		if(delTime!=null){
			String[] d=delTime.split(",");
			for(String t:d){
				for(int i=0;i<currencyList.size();i++){
					AgeOfPrice ageOfPrice=new AgeOfPrice();
					ageOfPrice.setCurrencyId(currencyList.get(i).getId());
					ageOfPrice.setGroupLineId(groupLineId);
					try {
						ageOfPrice.setDepartureTime(format.parse(t));
					} catch (ParseException e) {
					}
					
					AgeOfPrice p=ageOfPriceService.findByDepartureTime(ageOfPrice);
					if(p!=null){
						p.setIsAvailable(1);
						p.setUpdateTime(new Date());
						ageOfPriceService.update(p);
					}
				}
			}
		}
		GroupLine groupLine=groupLineService.findById(groupLineId);
		String depar[]=time.split(",");
		Arrays.sort(depar);
		String str=null;
		for(int i=0;i<depar.length;i++){
			if(i==0){
			     str=(String)depar[i];
			}else{
			     str+=","+(String)depar[i];
			}
		}	
		groupLine.setDepartureDate(str);
		groupLine.setModifyDate(new Date());
		groupLineService.update(groupLine);
		return "redirect:setDeparture.jhtml?groupLineId="+groupLineId;
	}
	/**
	 * 进入线路管理页面
	 * @param groupRoute
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/setGroupRoute", method = RequestMethod.GET)
	public String setGroupRoute(GroupRoute groupRoute,Model model) {
		model.addAttribute("groupRouteList", groupLineService.findGroupRouteByGroupLineId(groupRoute.getGroupLineId()));
		model.addAttribute("groupLine",groupLineService.findById(groupRoute.getGroupLineId()));
		model.addAttribute("menuId", "801");
		return BaseTemplateURL + "/setGroupRoute";
	}
	
	/**
     * 根据传来的Pageable对象和GroupLine对象查出数据并以map返回
     * @param pageable
     * @param groupLine
     * @return
     */
	/*@RequestMapping(value="/groupRoutelist",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> groupRoutelist(Pageable pageable, GroupRoute groupRoute) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<GroupLine> page = groupLineService.findPage(groupRoute, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}*/
	/**
	 * 去添加线路页面
	 * @return
	 */
	@RequestMapping(value="/addGroupRoute",method = RequestMethod.GET)
	public String addGroupRoute(String groupLineId,Model model) {
		model.addAttribute("groupLineId",groupLineId);
		model.addAttribute("menuId", 801);
		return BaseTemplateURL + "/addGroupRoute";
	}
	
	/**
	 * 保存线路
	 * @param groupRoute
	 * @return
	 */
	@RequestMapping(value = "/saveGroupRoute", method = RequestMethod.POST)
	public String saveGroupRoute(GroupRoute groupRoute) {
			groupRoute.setId(UUIDGenerator.getUUID());
			groupLineService.save(groupRoute);
		return "redirect:setGroupRoute.jhtml?groupLineId="+groupRoute.getGroupLineId();
	}
	
	/**
	 * 进入线路编辑页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editGroupRoute", method = RequestMethod.GET)
	public String editGroupRoute(String id,Model model) {
		GroupRoute groupRoute = groupLineService.findGroupRouteById(id);
		model.addAttribute("groupRoute", groupRoute);
		model.addAttribute("menuId", "801");
		return BaseTemplateURL + "/editGroupRoute";
	}
	
	/**
	 * 线路更新
	 * @param groupRoute
	 * @return
	 */
	@RequestMapping(value="/updateGroupRoute",method = RequestMethod.POST)
	public String updateGroupRoute(GroupRoute groupRoute) {
		groupLineService.updateRoute(groupRoute);
		return "redirect:setGroupRoute.jhtml?groupLineId="+groupRoute.getGroupLineId();
	}
	
	/**
	 * 酒店管理
	 * @param groupLineId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/setHotel", method = RequestMethod.GET)
	public String setHotel(String groupLineId,Model model) {
		GroupLine groupLine =  groupLineService.findHotelByGroupLineId(groupLineId);
		List<GroupLineHotelRel> groupLineHotelRels = groupLine.getGroupLineHotelRel();
		List<Hotel> hotels = new ArrayList<Hotel>();
		for(GroupLineHotelRel groupLineHotelRel:groupLineHotelRels){
			String hotelId = groupLineHotelRel.getHotelId();
			Hotel hotel = hotelService.findById(hotelId);
			hotel.setDayNum(groupLineHotelRel.getDayNum());
			hotel.setGroupLineHotelRelId(groupLineHotelRel.getId());
			hotels.add(hotel);
		}
		List<Integer> dayNums = new ArrayList<Integer>();
		for(int i=1;i<=20;i++){
			dayNums.add(i);
		}
		model.addAttribute("groupLine", groupLineService.findById(groupLineId));
		model.addAttribute("hotels", hotels);
		model.addAttribute("citys", cityService.findAll());
		//model.addAttribute("hotelList", hotelService.findAll());
		model.addAttribute("dayNums", dayNums);
		model.addAttribute("menuId", "801");
		return BaseTemplateURL + "/setHotel";
	}
	
	/**
	 * 保存酒店
	 * @param hotel
	 * @return
	 */
	@RequestMapping(value = "/saveHotel", method = RequestMethod.POST)
	public String saveHotel(Hotel hotel) {
		if(hotel.getId().equals("0")){
			hotel.setId(UUIDGenerator.getUUID());
			hotelService.save(hotel);
		}else{
			hotelService.update(hotel);
		}
		
		GroupLineHotelRel groupLineHotelRel = new GroupLineHotelRel();
		groupLineHotelRel.setId(UUIDGenerator.getUUID());
		groupLineHotelRel.setDayNum(hotel.getDayNum());
		groupLineHotelRel.setGroupLineId(hotel.getGroupLineId());
		groupLineHotelRel.setHotelId(hotel.getId());
		hotel.setGroupLineHotelRelId(groupLineHotelRel.getId());
		groupLineService.saveGroupLineHotelRel(groupLineHotelRel);
		return "redirect:setHotel.jhtml?groupLineId="+hotel.getGroupLineId();
	}
	
	/**
	 * 酒店编辑页
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/editHotel", method = RequestMethod.GET)
	public String editHotel( String groupLineHotelRelId,Model model) {
		GroupLineHotelRel groupLineHotelRel =groupLineService.findGroupLineHotelRelById(groupLineHotelRelId);
		Hotel hotel = hotelService.findById(groupLineHotelRel.getHotelId());
		hotel.setGroupLineId(groupLineHotelRel.getGroupLineId());
		hotel.setGroupLineHotelRelId(groupLineHotelRelId);
		hotel.setDayNum(groupLineHotelRel.getDayNum());
		List<Integer> dayNums = new ArrayList<Integer>();
		List<String> standards = new ArrayList<String>();
		for(int i=1;i<=20;i++){
			dayNums.add(i);
		}
		for(int i=6;i>=1;i--){
			if(i==6){
				standards.add(Constant.STAR);
			}else{
				standards.add(Integer.toString(i));
			}
		}
		model.addAttribute("citys", cityService.findAll());
		model.addAttribute("dayNums", dayNums);
		model.addAttribute("standards", standards);
		model.addAttribute("hotel", hotel);
		model.addAttribute("menuId", "801");
		return BaseTemplateURL + "/editHotel";
	}
	
	/**
	 * 更新酒店
	 * @param hotel
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/updateHotel",method = RequestMethod.POST)
	public String updateHotel(Hotel hotel) {
		String groupLineHotelRelId = hotel.getGroupLineHotelRelId();
		GroupLineHotelRel groupLineHotelRel = groupLineService.findGroupLineHotelRelById(groupLineHotelRelId);
		groupLineHotelRel.setDayNum(hotel.getDayNum());
		hotelService.update(hotel);
		groupLineService.updateGroupLineHotelRel(groupLineHotelRel);
		return "redirect:setHotel.jhtml?groupLineId="+hotel.getGroupLineId();
	}
	
	/**
	 * 生成PDF
	 */
	@RequestMapping(value="/toFdf",method = RequestMethod.GET)
	public String toPDF(Model model,String groupLineId) {
		String destPath = pdfService.createPdf(groupLineId);
		model.addAttribute("path", destPath);
		model.addAttribute("menuId", "801");
		 return BaseTemplateURL + "/toPdf";
	}
	
	/**
	 * 酒店下拉选项获得酒店信息
	 * 
	 * @param venderId
	 * @return
	 */
	@RequestMapping(value = "/getHotel", method = RequestMethod.POST)
	public @ResponseBody Hotel getHotel(String id){
		return hotelService.findById(id);
	}
	
	/**
	 * 酒店下拉选项获得酒店信息
	 * 
	 * @param venderId
	 * @return
	 */
	@RequestMapping(value = "/delHotel", method = RequestMethod.GET)
	public String delHotel(String id){
		GroupLineHotelRel groupLineHotleRel = groupLineService.findGroupLineHotelRelById(id);
		groupLineService.delGroupLineHotelRel(id);
		return "redirect:setHotel.jhtml?groupLineId="+groupLineHotleRel.getGroupLineId();
	}
	/**
	 * 上传
	 * @param file 上传文件
	 * @param id 
	 * @param redirectAttributes
	 * @return
	 */
	/*@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String upload(MultipartFile file, GroupLine groupLine,
			HttpServletRequest request, String menuId,
			RedirectAttributes redirectAttributes) {
		String fileString= fileService.uploadLocal(FileType.productImagePath,file);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:tourList";
	}*/
	@RequestMapping(value = "/upload" , method=RequestMethod.POST)
	public @ResponseBody String upload(MultipartFile file){
		return fileService.uploadLocal(FileType.productImagePath,file);
	}
	/**
	 * 设置不同时间段的价格
	 * */
	@RequestMapping(value="/setPrice",method=RequestMethod.GET)
	public String setPrice(Model model,String groupLineId){
		GroupLine groupLine=groupLineService.findById(groupLineId);
		//AgeOfPrice ageOfPrice=ageOfPriceService.findOnlyOneByGroupLineId(groupLineId);
		/*List<DateOfPrice> dateOfPriceList=dateOfPriceService.findByGroupLineId(groupLineId);*/
		List<CurrencyType> currencyList=currencyTypeService.findAll();
		model.addAttribute("groupLine", groupLine);
		model.addAttribute("currencyList", currencyList);
		//model.addAttribute("ageOfPrice", ageOfPrice);
		/*model.addAttribute("dateOfPriceList", dateOfPriceList);*/
		return BaseTemplateURL + "/addPrice";
		
	}
	
	/**
	 * 异步获取
	 * */
	@RequestMapping(value="/selectCurrency", method = RequestMethod.POST)
	public @ResponseBody Map<String,Object> selectTourType(AgeOfPrice ageofPrice){
		Map<String, Object> map=new HashMap<String, Object>();
		AgeOfPrice ageOfPrice=ageOfPriceService.findOnlyOne(ageofPrice);
		map.put("ageOfPrice", ageOfPrice);
		return map;
	}
	/**
	 * 保存时间段价格
	 * @throws ParseException 
	 * */
	@RequestMapping(value="/savePrice",method=RequestMethod.POST)
	public String savePrice(Model model,AgeOfPrice ageofPrice) throws ParseException{
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		String[] time=ageofPrice.getCurrencyChs().split(",");
		ageOfPriceService.deleteAgeOfPrice(ageofPrice);
		List<AgeOfPrice> ageOfPriceList=new ArrayList<AgeOfPrice>();
		AgeOfPrice a=null;
		for(int i=0;i<time.length;i++){
			a = new AgeOfPrice();
			a.setAgeOfPriceId(UUIDGenerator.getUUID());
			a.setDepartureTime(format.parse(time[i]));
			a.setCreateDate(new Date());
			a.setAdult(ageofPrice.getAdult());
			a.setCommission(ageofPrice.getCommission());
			a.setChildComm(ageofPrice.getChildComm());
			a.setBed(ageofPrice.getBed());
			a.setChildren(ageofPrice.getChildren());
			a.setBaby(ageofPrice.getBaby());
			a.setNotBed(ageofPrice.getNotBed());
			a.setCurrencyId(ageofPrice.getCurrencyId());
			a.setGroupLineId(ageofPrice.getGroupLineId());
			a.setHotelPrice(ageofPrice.getHotelPrice());
			a.setSupplement(ageofPrice.getSupplement());
			ageOfPriceList.add(a);
		}
		a=null;
		ageOfPriceService.batchSave(ageOfPriceList);
		return "redirect:setPrice.jhtml?groupLineId="+ageofPrice.getGroupLineId();
		
	}
	/**
	 * 去添加线路页面
	 * @return
	 */
	@RequestMapping(value="/addPeerProduct",method = RequestMethod.GET)
	public String addPeerProduct(Model model) {
		Gson gson=new Gson();
		model.addAttribute("menuId", 813);
		model.addAttribute("tourTypeList", gson.toJson(tourTypeService.findAll()));
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("productAreaList",productAreaService.findAll());
		model.addAttribute("currencyList",currencyTypeService.findAll());
		return BaseTemplateURL + "/addPeerProduct";
	}
	/**
	 * 保存同行产品
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value="/savePeerProduct",method = RequestMethod.POST)
	public String savePeerProduct(GroupLine groupLine) throws ParseException {
		SimpleDateFormat format =new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<String> list=new ArrayList<String>();
		String date=null;
		if(groupLine.getDepartureDate()==null&&groupLine.getSymbol()!=null){
			if(groupLine.getTime()==null){
				groupLine.setTime("");
			}
			list=getWeekDays(groupLine.getSymbol(), groupLine.getCurrencyEng(),groupLine.getTime());
			for(int a=0;a<list.size();a++){
				if(a==0){
					date=list.get(a);
				}else{
					date =date+","+list.get(a);
				}
			}
			groupLine.setDepartureDate(date);
		}
		if(groupLine.getDepartureDate()!=null&&groupLine.getSymbol()==null){
			String[] deputer=groupLine.getDepartureDate().split(",");
			for(int a=0;a<deputer.length;a++){
				list.add(deputer[a]);
			}
		}
		groupLine.setId(UUIDGenerator.getUUID());
//		String number=groupLine.getTourCode().substring(0, 4);
//		String num=groupLineService.lineNoMax(number);
//		groupLine.setLineNo(num);
		List<AgeOfPrice> ageOfPriceList=new ArrayList<AgeOfPrice>();
		AgeOfPrice ageOfPrice=null;
		if(list.size()>0){
			for(String dates : list){
				ageOfPrice=new AgeOfPrice();
				ageOfPrice.setAgeOfPriceId(UUIDGenerator.getUUID());
				ageOfPrice.setCurrencyId(groupLine.getCurrencyId());
				ageOfPrice.setAdult(groupLine.getAdult());
				ageOfPrice.setBed(groupLine.getBed());
				ageOfPrice.setNotBed(groupLine.getNotBed());
				ageOfPrice.setChildren(groupLine.getChildren());
				ageOfPrice.setBaby(groupLine.getBaby());
				ageOfPrice.setCommission(groupLine.getCommission());
				ageOfPrice.setChildComm(groupLine.getChildComm());
				ageOfPrice.setHotelPrice(groupLine.getHotelPrice());
				ageOfPrice.setDepartureTime(format.parse(dates));
				ageOfPrice.setCreateTime(new Date());
				ageOfPrice.setGroupLineId(groupLine.getId());
				ageOfPrice.setIsAvailable(0);
				ageOfPrice.setSupplement(groupLine.getPrice());
				
				ageOfPriceList.add(ageOfPrice);
				
			}
			ageOfPriceService.batchSave(ageOfPriceList);
		}
		groupLineService.save(groupLine);
		return "redirect:agencyList.jhtml";
	}
	/***
	 * 截取时间段中周几的时间日期
	 * */
	public static ArrayList<String> getWeekDays(String beginYear, String endYear,String week){
		 String[] b=beginYear.split("-");
		 String[] e=endYear.split("-");
		 String[] weekList=week.split(",");
		 Calendar c_begin = new GregorianCalendar();
	     Calendar c_end = new GregorianCalendar();
	     DateFormatSymbols dfs = new DateFormatSymbols();
	     String[] weeks = dfs.getWeekdays();
	     c_begin.set(Integer.parseInt(b[0]),Integer.parseInt(b[1])-1,Integer.parseInt(b[2])); //Calendar的月从0-11，所以4月是3.
	     c_end.set(Integer.parseInt(e[0]),Integer.parseInt(e[1])-1,Integer.parseInt(e[2])); //Calendar的月从0-11，所以5月是4.
	     c_end.add(Calendar.DAY_OF_YEAR, 1);  //结束日期下滚一天是为了包含最后一天
	     ArrayList<String> list=new ArrayList<String>();
	     while(c_begin.before(c_end)){
	    	 if(weekList[0].equals("e")){
	    		 list.add(new java.sql.Date(c_begin.getTime().getTime()).toString());
	    	 }else{
	    		 for(int i=0;i<weekList.length;i++){
		    		 if(weeks[c_begin.get(Calendar.DAY_OF_WEEK)].equals(weekList[i])){
			    		 list.add(new java.sql.Date(c_begin.getTime().getTime()).toString());
			    	 }
		    	 }
	    	 }
	      c_begin.add(Calendar.DAY_OF_YEAR, 1);
	     }
	     return list;
	}
	/**
	 * 修改同行系统产品
	 * */
	@RequestMapping(value="/editPeerProduct",method = RequestMethod.GET)
	public String editPeerProduct(String id, Model model,HttpServletRequest request) {
		GroupLine groupLine=groupLineService.findById(id);
		model.addAttribute("menuId", 813);
		Gson gson=new Gson();
		model.addAttribute("groupLine", groupLine);
		model.addAttribute("tourTypeList", gson.toJson(tourTypeService.findAll()));
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("productAreaList",productAreaService.findAll());
		return BaseTemplateURL + "/editPeerProduct";
	}
	/**
	 * 根据传来的GroupLine对象进行更新操作
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value="/updatePeerProduct",method = RequestMethod.POST)
	public String updatePeerProduct(GroupLine groupLine) {
		groupLineService.update(groupLine);
		return "redirect:agencyList.jhtml";
	}
	/**
	 * 产品添加日期，同时添加不同货币价格
	 * */
	@RequestMapping(value="/addTime",method=RequestMethod.GET)
	public String addTime(Model model,String groupLineId,HttpServletRequest request){
		//Session防止用户重复提交
		HttpSession session =request.getSession();
		session.setAttribute("ageOfPriceSession", "PriceSessionCheck");
		GroupLine groupLine=groupLineService.findById(groupLineId);
		String[] depar=groupLine.getDepartureDate().split(",");
		Arrays.sort(depar);
		String date=null;
		for(int a=0;a<depar.length;a++){
			if(a==0){
				date=depar[a];
			}else{
				date =date+","+depar[a];
			}
		}
		groupLine.setDepartureDate(date);
		AgeOfPrice ageOfPrice=new AgeOfPrice();
		ageOfPrice.setGroupLineId(groupLineId);
//		ageOfPrice.setDepartureTime(new Date());
		List<AgeOfPrice> list=ageOfPriceService.findOrderByCurrencyId(ageOfPrice);
		model.addAttribute("list",list);
		model.addAttribute("size",list.size());
		model.addAttribute("menuId", 813);
		model.addAttribute("groupLine", groupLine);
		return BaseTemplateURL + "/addTime";
	}
	/**
	 * 根据传来的GroupLine对象进行更新操作
	 * @param groupLine
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value="/saveTime",method = RequestMethod.GET)
	public String saveTime(String groupLineId,String beginningDate,String Endtime,String time,String dateStr,String price,HttpServletRequest request) throws ParseException {
		
		//验证用户是否重复提交
		String ageOfpriceSession=(String) request.getSession().getAttribute("ageOfPriceSession");
		if(ageOfpriceSession==""||ageOfpriceSession==null){
			return BaseTemplateURL + "/addTime";
		}
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<String> list=new ArrayList<String>();
		GroupLine groupLine=groupLineService.findById(groupLineId);
		String date=null;
		if(beginningDate!=null&&Endtime!=null){
			if(groupLine.getTime()==null){
				groupLine.setTime("");
			}
			list=getWeekDays(beginningDate, Endtime,time);
			if(list.size()>0){
				for(int a=0;a<list.size();a++){
					if(a==0){
						date=list.get(a);
					}else{
						date =date+","+list.get(a);
					}
				}
			}
			
		}
		String deparTime=null;
		if(date!=null&&dateStr.equals("1")){
			deparTime=date;
		}else if(date!=null){
			deparTime=dateStr+","+date;
		}
		String[] depar=deparTime.split(",");
		Arrays.sort(depar);
		List<String> listS = new ArrayList<String>();  
        for (int i=0; i<depar.length; i++) {  
            if(!listS.contains(depar[i])) {  
            	listS.add(depar[i]);  
            }  
        }
		String str=null;
		for(int i=0;i<listS.size();i++){
			if(i==0){
			     str=listS.get(i);
			}else{
			     str+=","+listS.get(i);
			}
		}
		groupLine.setDepartureDate(str);
		groupLineService.update(groupLine);
		String[] dTime=str.split(",");
		String p[]=price.split(",");
		int idx = 0;
		List<AgeOfPrice> ageOfPriceList=new ArrayList<AgeOfPrice>();
		AgeOfPrice ageOfPrice=null;
		for(String pr:p){
			String pre[]=pr.split(":");
			for(String t:dTime){
				ageOfPrice=new AgeOfPrice();
				ageOfPrice.setAgeOfPriceId(UUIDGenerator.getUUID());
				ageOfPrice.setCurrencyId(pre[0]);
				ageOfPrice.setAdult(new BigDecimal(pre[1]));
				ageOfPrice.setBed(new BigDecimal(pre[2]));
				ageOfPrice.setNotBed(new BigDecimal(pre[3]));
				ageOfPrice.setChildren(new BigDecimal(pre[4]));
				ageOfPrice.setBaby(new BigDecimal(pre[5]));
				ageOfPrice.setSupplement(new BigDecimal(pre[6]));
				ageOfPrice.setHotelPrice(new BigDecimal(pre[7]));
				ageOfPrice.setCommission(new BigDecimal(pre[8]));
				ageOfPrice.setChildComm(new BigDecimal(pre[9]));
				ageOfPrice.setDepartureTime(format.parse(t));
				ageOfPrice.setTypeNo(idx);
				ageOfPrice.setCreateTime(new Date());
				ageOfPrice.setGroupLineId(groupLineId);
				ageOfPrice.setIsAvailable(0);
				
				ageOfPriceList.add(ageOfPrice);
			}
			idx++;
			ageOfPrice=new AgeOfPrice();
			ageOfPrice.setGroupLineId(groupLineId);
			ageOfPrice.setCurrencyId(pre[0]);
			ageOfPriceService.deleteAgeOfPrice(ageOfPrice);
		}
		
		ageOfPriceService.batchSave(ageOfPriceList);
		//移除Session
		request.getSession().removeAttribute("ageOfPriceSession");
		if(adminService.getCurrent().getUsername()=="Admin"){
			return "redirect:addTime.jhtml?groupLineId="+groupLineId;
		}
		else{
			return "redirect:addTime.jhtml?groupLineId="+groupLineId;
		}
	}
	/**
	 * 更改不同时间的
	 * */
	@RequestMapping(value="/editPrice",method=RequestMethod.GET)
	public String editPrice(Model model,String groupLineId){
		GroupLine groupLine=groupLineService.findById(groupLineId);
		List<AgeOfPrice> list=ageOfPriceService.findMaxMin(groupLineId);
		model.addAttribute("groupLine", groupLine);
		model.addAttribute("currencyList", currencyTypeService.findAll());
		model.addAttribute("list", list);
		model.addAttribute("menuId", 813);
		return BaseTemplateURL + "/editPrice";
	}
	/**
	 * 根据传来的GroupLine对象进行更新操作
	 * @param groupLine
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value="/updatePrice",method = RequestMethod.GET)
	public String updatePrice(String groupLineId,String time,String price) throws ParseException {
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		String[] depar=time.split(",");
		String pre[]=price.split(":");
		AgeOfPrice age=new AgeOfPrice();
		age.setGroupLineId(groupLineId);
		age.setCurrencyId(pre[0]);
		age.setMaxTime(format.parse(depar[0]));
		age.setMinTime(format.parse(depar[1]));
		List<AgeOfPrice> list=ageOfPriceService.findByTime(age);
		for(AgeOfPrice ageOfPrice:list){
			ageOfPrice.setAdult(new BigDecimal(pre[1]));
			ageOfPrice.setBed(new BigDecimal(pre[2]));
			ageOfPrice.setNotBed(new BigDecimal(pre[3]));
			ageOfPrice.setChildren(new BigDecimal(pre[4]));
			ageOfPrice.setBaby(new BigDecimal(pre[5]));
			ageOfPrice.setSupplement(new BigDecimal(pre[6]));
			ageOfPrice.setHotelPrice(new BigDecimal(pre[7]));
			ageOfPrice.setCommission(new BigDecimal(pre[8]));
			ageOfPrice.setChildComm(new BigDecimal(pre[9]));
			ageOfPriceService.update(ageOfPrice);
		}
		return "redirect:agencyList.jhtml";
	}
	
	@RequestMapping(value="/venderlist",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> venderlist(String DeptId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("venderList", venderService.findByDept(DeptId));
		return map;
	}
	//同步产品工具类
	@RequestMapping(value="/batchInsertB2BPrice",method = RequestMethod.GET)
	public @ResponseBody String batchInsertB2BPrice(String grouplineId) throws ParseException{
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		GroupLine groupLine=groupLineService.findById(grouplineId);
		String deparTime=groupLine.getDepartureDate();
		String[] depar=deparTime.split(",");
		Arrays.sort(depar);
		String [] currencyList = {"42DC81C7-3FEE-4B15-9C08-CC575620FD4B","B8C53700-AD43-4CAA-8E9E-64DD7D3D958F"}; 
		for(int i=0;i<currencyList.length;i++){
			for(String t:depar){
				AgeOfPrice ageOfPrice=new AgeOfPrice();
				ageOfPrice.setAgeOfPriceId(UUIDGenerator.getUUID());
				ageOfPrice.setCurrencyId(currencyList[i]);
				ageOfPrice.setDepartureTime(format.parse(t));
				ageOfPrice.setCreateTime(new Date());
				ageOfPrice.setGroupLineId(grouplineId);
				ageOfPrice.setIsAvailable(0);
				ageOfPrice.setTypeNo(0);
				ageOfPriceService.save(ageOfPrice);
				}
		}
		return "yes";
	}
	
	@RequestMapping(value="/batchInsertB2BPriceTest",method = RequestMethod.GET)
	public @ResponseBody String batchInsertB2BPriceTest(String grouplineId) throws ParseException{
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		GroupLine groupLine=groupLineService.findById(grouplineId);
		String deparTime=groupLine.getDepartureDate();
		String[] depar=deparTime.split(",");
		Arrays.sort(depar);
		AgeOfPrice afeAgeOfPriceTest =new AgeOfPrice();
		afeAgeOfPriceTest.setGroupLineId(grouplineId);
		List<AgeOfPrice> ageodprices = ageOfPriceMapper.findOrderNoCurrencyId(afeAgeOfPriceTest);
		for(int i=0;i<=ageodprices.size();i++) {
		for(String t:depar){
			AgeOfPrice ageOfPrice=new AgeOfPrice();
			ageOfPrice.setAgeOfPriceId(UUIDGenerator.getUUID());
			ageOfPrice.setCurrencyId("42DC81C7-3FEE-4B15-9C08-CC575620FD4B");
			ageOfPrice.setDepartureTime(format.parse(t));
			ageOfPrice.setCreateTime(new Date());
			ageOfPrice.setGroupLineId(grouplineId);
			ageOfPrice.setIsAvailable(0);
			ageOfPrice.setTypeNo(i);
			ageOfPriceService.save(ageOfPrice);
			}
		}
		return "yes";
	}
}
