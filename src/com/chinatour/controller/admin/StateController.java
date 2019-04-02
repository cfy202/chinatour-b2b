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
import com.chinatour.entity.State;
import com.chinatour.service.CountryService;
import com.chinatour.service.StateService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Aug 28, 2014 3:49:29 PM
 * @revision 3.0
 */
@Controller
@RequestMapping("/admin/state")
public class StateController extends BaseController {
    
	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/state";
	
	/*
	 * 州的业务层注入
	 */
	@Autowired
	private StateService stateService;
	
    /*
     * 国家的业务层注入
     */
	@Autowired
	private CountryService countryService;
	
	/**
	 * 将查出的country数据存入model，去添加州页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/add",method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", "807");
		model.addAttribute("countrys", countryService.findAll());
		return BaseTemplateURL + "/add";
	}
	
	/**
	 * 根据传来的State对象进行添加操作
	 * @param state
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/save",method = RequestMethod.POST)
	public String save(State state) throws Exception {
		state.setId(UUIDGenerator.getUUID());
		stateService.save(state);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id执行删除州的操作
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/del",method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		stateService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id查询出State对象存入model中，并查出country数据存入model
	 * 转去修改州页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", "807");
		model.addAttribute("countrys", countryService.findAll());
		model.addAttribute("state", stateService.findById(id));
		return BaseTemplateURL + "/edit";
	}
	
	/**
	 *  根据传来的State对象进行更新操作
	 * @param state
	 * @return
	 */
	@RequestMapping(value="/update",method = RequestMethod.POST)
	public String update(State state) {
		stateService.update(state);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 将menuId值设为807存入model，去州展示页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "807");
		return BaseTemplateURL + "/list";
	}
    
	/**
	 * 根据传来的Pageable对象和State对象查出state数据并以map返回
	 * @param pageable
	 * @param state
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, State state) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<State> page = stateService.findPage(state, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
}
