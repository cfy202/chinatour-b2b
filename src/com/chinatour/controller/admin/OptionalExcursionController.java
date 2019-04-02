package com.chinatour.controller.admin;

import java.math.BigDecimal;
import java.util.Date;
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
import com.chinatour.entity.OptionalExcurition;
import com.chinatour.service.OptionalExcursionService;
import com.chinatour.util.UUIDGenerator;


@Controller
@RequestMapping("/admin/optional")
public class OptionalExcursionController extends BaseController {
	
	
	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/optional";
	
	
	@Autowired
	private OptionalExcursionService optionalExcursionService;
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", "1000");
		return BaseTemplateURL + "/add";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(OptionalExcurition optionalExcurition) {
		optionalExcurition.setId(UUIDGenerator.getUUID());
		optionalExcurition.setCreateDate(new Date());
		optionalExcurition.setModifyDate(new Date());
		optionalExcursionService.save(optionalExcurition);
		return "redirect:list.jhtml";
	}


	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		optionalExcursionService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}


	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", "1000");
		model.addAttribute("OptionalExcursion", optionalExcursionService.findById(id));
		return BaseTemplateURL + "/edit";
	}


	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(OptionalExcurition optionalExcurition) {
		optionalExcurition.setModifyDate(new Date());
		optionalExcursionService.update(optionalExcurition);
		return "redirect:list.jhtml";
	}


	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "1000");
		return BaseTemplateURL + "/list";
	}


	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, OptionalExcurition optionalExcurition) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<OptionalExcurition> page = optionalExcursionService.findPage(optionalExcurition, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
}
