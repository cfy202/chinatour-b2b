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
import com.chinatour.entity.Country;
import com.chinatour.service.CountryService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 28, 2014 3:49:46 PM
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/country")
public class CountryController extends BaseController {
	
	/*
     * template所属包的路径
     */
	private String BaseTemplateURL = "/admin/basic/country";
	
	/*
	 * 国家的业务层注入
	 */
	@Autowired
	private CountryService countryService;
	
	/**
	 * 去添加国家页面
	 * @return
	 */
	@RequestMapping(value="/add",method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", 806);
		return BaseTemplateURL + "/add";
	}
	
	/**
	 * 根据传来的Country对象进行添加操作
	 * @param country
	 * @return
	 */
	@RequestMapping(value="/save",method = RequestMethod.POST)
	public String save(Country country) {
		country.setId(UUIDGenerator.getUUID());
		countryService.save(country);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id执行删除国家的操作
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/del",method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		countryService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id查询出Country对象存入model中，转去修改国家页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", 806);
		model.addAttribute("country", countryService.findById(id));
		return BaseTemplateURL + "/edit";
	}
	
	/**
	 * 根据传来的Country对象进行更新操作
	 * @param country
	 * @return
	 */
	@RequestMapping(value="/update",method = RequestMethod.POST)
	public String update(Country country) {
		countryService.update(country);
		return "redirect:list.jhtml";
	}
    
	/**
	 * 将menuId值设为806存入model，去国家展示页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "806");
		return BaseTemplateURL + "/list";
	}
	
	/**
	 * 根据传来的Pageable对象和Country对象查出数据并以map返回
	 * @param pageable
	 * @param country
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, Country country) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Country> page = countryService.findPage(country, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
}
