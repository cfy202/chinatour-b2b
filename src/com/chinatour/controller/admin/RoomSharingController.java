package com.chinatour.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.RoomSharing;
import com.chinatour.entity.Vender;
import com.chinatour.service.AdminService;
import com.chinatour.service.RoomSharingService;
import com.chinatour.service.TourTypeService;
import com.chinatour.util.UUIDGenerator;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

/**
 * 
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2015-4-17 下午2:01:02
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/roomSharing")
public class RoomSharingController  extends BaseController{
	
	@Resource(name = "roomSharingServiceImpl")
	private RoomSharingService roomSharingService;
	
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	
	@Resource(name = "tourTypeServiceImpl")
	private TourTypeService tourTypeService;

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
	
	/**room
	 * 查询所有
	 */
	@RequestMapping(value = "/roomList" , method = RequestMethod.GET)
	public String roomList(ModelMap model){
		model.addAttribute("menuId", "411");
		return "/admin/roomSharing/roomList";
	}
	
	/**
	 * room
	 * 异步查询所有
	*/
	@RequestMapping(value = "/roomList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> roomList(Pageable pageable, RoomSharing roomSharing) {
		Map<String, Object> map = new HashMap<String, Object>();
		//1拼房
		roomSharing.setRoomOrTour(1);
		Page<RoomSharing> page = roomSharingService.findPage(roomSharing,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	} 
	
	/**
	 * tour
	 * 查询所有
	 */
	@RequestMapping(value = "/tourList" , method = RequestMethod.GET)
	public String tourList(ModelMap model){
		model.addAttribute("menuId", "412");
		return "/admin/roomSharing/tourList";
	}
	
	/**
	 * tour
	 * 异步查询所有
	*/
	@RequestMapping(value = "/tourList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> tourList(Pageable pageable, RoomSharing roomSharing) {
		//2拼团
		roomSharing.setRoomOrTour(2);
		Map<String, Object> map = new HashMap<String, Object>();
		Page<RoomSharing> page = roomSharingService.findPage(roomSharing,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	} 
	
	/**
	 * 添加Vender信息，并且加载国家信息
	 */
	@RequestMapping(value = "/add" , method=RequestMethod.GET)
	public String add(ModelMap model,RoomSharing roomSharing){
		if(roomSharing.getRoomOrTour()==1){
			model.addAttribute("menuId", "411");
		}else{
			model.addAttribute("menuId", "412");
		}
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("roomOrTour", roomSharing.getRoomOrTour());
		model.addAttribute("tourTypeList", tourTypeService.findAll());
		return "/admin/roomSharing/add";
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value = "/save" , method=RequestMethod.POST)
	public String save(RoomSharing roomSharing,RedirectAttributes redirectAttributes){
		Admin admin = adminService.getCurrent();
		roomSharing.setRoomSharingId(UUIDGenerator.getUUID());
		roomSharing.setUserName(admin.getUsername());
		roomSharing.setUserId(admin.getId());
		roomSharing.setCreateDate(new Date());
		roomSharing.setModifyDate(new Date());
		roomSharingService.save(roomSharing);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		if(roomSharing.getRoomOrTour()==1){
			return "redirect:roomList.jhtml";
		}
		return "redirect:tourList.jhtml";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(RoomSharing roomSharing,RedirectAttributes redirectAttributes){
		roomSharing.setModifyDate(new Date());
		roomSharingService.update(roomSharing);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		if(roomSharing.getRoomOrTour()==1){
			return "redirect:roomList.jhtml";
		}
		return "redirect:tourList.jhtml";
	}
	
	/**
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, RoomSharing roomSharing) {
		if(roomSharing.getRoomOrTour()==1){
			model.addAttribute("menuId", "411");
		}else{
			model.addAttribute("menuId", "412");
		}
		model.addAttribute("roomSharing",roomSharingService.findById(roomSharing.getRoomSharingId()));
		model.addAttribute("roomOrTour", roomSharing.getRoomOrTour());
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("tourTypeList", tourTypeService.findAll());
		return "/admin/roomSharing/edit";
	}
	/**
	 * 拼房
	 */
	@RequestMapping(value = "/addRoom" , method=RequestMethod.POST)
	public String addRoom(RoomSharing roomSharing,RedirectAttributes redirectAttributes){
		roomSharing.setModifyDate(new Date());
		RoomSharing room = roomSharingService.findById(roomSharing.getRoomSharingId());
		Map<String,Object> map = new HashMap<String,Object>(); 
		map.put("userName", adminService.getCurrent().getUsername()); 
		map.put("description", roomSharing.getDescription());
		if(room==null){
			return "redirect:roomList.jhtml"; 
		}
		String sub = roomSharing.getDescription().replace("\r\n","");
		if(room.getDescription()!=null&&room.getDescription()!=""){
			String str="{\"userName\":\""+adminService.getCurrent().getUsername()+"\","+"\"description\":\""+sub+"\"}";
			JSONArray json = JSONArray.fromObject(room.getDescription()); 
			json.add(str);
			roomSharing.setDescription(json.toString());
		}else{
			String str="[{\"userName\":\""+adminService.getCurrent().getUsername()+"\","+"\"description\":\""+sub+"\"}]";
			roomSharing.setDescription(str);
		}
		roomSharingService.update(roomSharing);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:view.jhtml?roomSharingId="+roomSharing.getRoomSharingId()+"&roomOrTour="+room.getRoomOrTour(); 
	}
	
	/**查看拼房
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(ModelMap model,RoomSharing roomSharing) {
		if(roomSharing.getRoomOrTour()==1){
			model.addAttribute("menuId", "411");
		}else{
			model.addAttribute("menuId", "412");
		}
		model.addAttribute("roomSharing",roomSharingService.findById(roomSharing.getRoomSharingId()));
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("tourTypeList", tourTypeService.findAll());
		return "/admin/roomSharing/view";
	}
}
