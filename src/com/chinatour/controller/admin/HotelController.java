package com.chinatour.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.HotelPriceInfo;
import com.chinatour.entity.Vender;
import com.chinatour.service.CityService;
import com.chinatour.service.HotelService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Aug 28, 2014 3:49:29 PM
 * @revision 3.0
 */
@Controller
@RequestMapping("/admin/hotel")
public class HotelController extends BaseController {
	
	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/hotel";
	
	/*
	 * 酒店的业务层注入
	 */
	@Autowired
	private HotelService hotelService;
	
	/*
	 * 城市的业务层注入
	 */
	@Autowired
	private CityService cityService;
	
	/**
	 * 将查出的city数据存入model，去添加酒店页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/add",method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", "805");
		model.addAttribute("citys", cityService.findAll());
		return BaseTemplateURL + "/add";
	}
	
	/**
	 * 根据传来的Hotel对象进行添加操作
	 * @param hotel
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save",method = RequestMethod.POST)
	public String save(Hotel hotel) throws Exception {
		hotel.setId(UUIDGenerator.getUUID());
		hotelService.save(hotel);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id执行删除酒店的操作
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/del",method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		Hotel hotel=hotelService.findById(id);
		hotel.setIsDel(1);//逻辑删除
		hotelService.update(hotel);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id查询出Hotel对象存入model中，并查出city数据存入model
	 * 转去修改酒店页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method = RequestMethod.GET)
	public String edit(String id, Model model) {
		List<String> standards = new ArrayList<String>();
		for(int i=5;i>=1;i--){
			standards.add(Integer.toString(i));
		}
		model.addAttribute("menuId", "805");
		model.addAttribute("citys", cityService.findAll());
		model.addAttribute("hotel", hotelService.findById(id));
		model.addAttribute("standards", standards);
		return BaseTemplateURL + "/edit";
	}
	
	/**
	 * 根据传来的Hotel对象进行更新操作
	 * @param hotel
	 * @return
	 */
	@RequestMapping(value="/update",method = RequestMethod.POST)
	public String update(Hotel hotel) {
		hotelService.update(hotel);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 将menuId值设为805存入model，去酒店展示页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "805");
		return BaseTemplateURL + "/list";
	}
    
	/**
	 * 根据传来的Pageable对象和Hotel对象查出hotel数据并以map返回
	 * @param pageable
	 * @param hotel
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, Hotel hotel) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Hotel> page = hotelService.findPage(hotel, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	/**
	 * 异步查询酒店
	 * @param pageable
	 * @param order
	 * @return
	 */
	@RequestMapping(value = "/findHotelByName", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> findHotelByName(Hotel hotel) {
		Map<String, Object> map = new HashMap<String, Object>();
        map.put("hotelList", hotelService.find(hotel));
        return map;
	}
	
	/**
	 * 异步查询所有酒店
	 */
	@RequestMapping(value = "/listSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelect(Hotel hotel) {
		List<Hotel> hotelList = hotelService.findSelect(hotel);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("hotelList", hotelList);
		return map;
	}
}
