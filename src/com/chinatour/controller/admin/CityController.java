package com.chinatour.controller.admin;

import java.util.HashMap;
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
import com.chinatour.entity.City;
import com.chinatour.service.CityService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Aug 28, 2014 3:49:46 PM
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/city")
public class CityController extends BaseController {

	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/city";

	/*
	 * 城市的业务层注入
	 */
	@Autowired
	private CityService cityService;

	/**
	 * 去添加城市页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", "808");
		return BaseTemplateURL + "/add";
	}

	/**
	 * 根据传来的City对象进行添加操作
	 * 
	 * @param city
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(City city) {
		city.setId(UUIDGenerator.getUUID());
		cityService.save(city);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据传来的id执行删除城市的操作
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		cityService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据传来的id查询出City对象存入model中，转去修改城市页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", "808");
		model.addAttribute("city", cityService.findById(id));
		return BaseTemplateURL + "/edit";
	}

	/**
	 * 根据传来的City对象进行更新操作
	 * 
	 * @param city
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(City city) {
		cityService.update(city);
		return "redirect:list.jhtml";
	}

	/**
	 * 将menuId值设为808存入model，去城市展示页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "808");
		return BaseTemplateURL + "/list";
	}

	/**
	 * 根据传来的Pageable对象和City对象查出city数据并以map返回
	 * 
	 * @param pageable
	 * @param city
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, City city) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<City> page = cityService.findPage(city, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
}
