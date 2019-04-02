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
import com.chinatour.entity.Brand;
import com.chinatour.service.BrandService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright Copyright: 2014
 * @author Cery
 * @create-time Aug 28, 2014 3:49:46 PM
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/brand")
public class BrandController extends BaseController {

	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/brand";

	/*
	 * Brand的业务层注入
	 */
	@Autowired
	private BrandService brandService;

	/**
	 * 去添加Brand页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", "998");
		return BaseTemplateURL + "/add";
	}

	/**
	 * 根据传来的Brand对象进行添加操作
	 * 
	 * @param brand
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Brand brand) {
		brand.setBrandId(UUIDGenerator.getUUID());
		brandService.save(brand);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据传来的id执行删除Brand的操作
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		brandService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 根据传来的id查询出Brand对象存入model中，转去修改Brand页面
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", "808");
		model.addAttribute("brand", brandService.findById(id));
		return BaseTemplateURL + "/edit";
	}

	/**
	 * 根据传来的Brand对象进行更新操作
	 * 
	 * @param brand
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Brand brand) {
		brandService.update(brand);
		return "redirect:list.jhtml";
	}

	/**
	 * 将menuId值设为808存入model，去Brand展示页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "998");
		return BaseTemplateURL + "/list";
	}

	/**
	 * 根据传来的Pageable对象和Brand对象查出brand数据并以map返回
	 * 
	 * @param pageable
	 * @param brand
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, Brand brand) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Brand> page =brandService.findPage(brand, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
}
