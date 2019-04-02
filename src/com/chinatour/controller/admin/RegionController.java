package com.chinatour.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
import com.chinatour.entity.Dept;
import com.chinatour.entity.Region;
import com.chinatour.entity.RegionDeptRel;
import com.chinatour.service.DeptService;
import com.chinatour.service.RegionService;
import com.chinatour.util.UUIDGenerator;
//import com.chinatour.service.RegionDeptRelService;

/**
 * 
 * @author Andy
 *
 * @date
 */

@Controller
@RequestMapping("/admin/region")
public class RegionController extends BaseController{
	
	/*
     * template所属包的路径
     */
	private String BaseTemplateURL = "/admin/basic/region";
	
	/*
	 * 区域的业务层注入
	 */
	@Autowired
	private RegionService regionService;
	
	@Resource(name = "deptServiceImpl")
	private DeptService deptService;
	
	/*@Resource(name = "regionDeptRelServiceImpl")
	private RegionDeptRelService regionDeptRelService;*/
	
	/**
	 * 去添加区域页面
	 * @return
	 */
	@RequestMapping(value="/add",method = RequestMethod.GET)
	public String add(Model model) {
		model.addAttribute("menuId", 906);
		model.addAttribute("dept", deptService.findAll());
		return BaseTemplateURL + "/add";
	}
	
	/**
	 * 根据传来的region对象进行添加操作
	 * @param region
	 * @return
	 */
	@RequestMapping(value="/save",method = RequestMethod.POST)
	public String save(Region region) {
		region.setId(UUIDGenerator.getUUID());
		regionService.saveRegionWithDept(region);
		
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id执行删除区域的操作
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/del",method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		regionService.deleteRegionWithDept(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 根据传来的id查询出region对象存入model中，转去修改区域页面
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit",method = RequestMethod.GET)
	public String edit(String id, Model model) {
		model.addAttribute("menuId", 906);
		Region region = regionService.findRegionForDept(id);
		List<String> depts = new ArrayList<String>();
		for(RegionDeptRel regionDeptRel:region.getRegionDeptRel()){
			depts.add(regionDeptRel.getDeptId());
		}
		model.addAttribute("region", regionService.findById(id));
		model.addAttribute("allDepts", deptService.findAll());//所有部门信息
		model.addAttribute("depts", depts);//已包含的部门
		return BaseTemplateURL + "/edit";
	}
	
	/**
	 * 根据传来的region(包含部门信息)对象进行更新操作
	 * @param region
	 * @return
	 */
	@RequestMapping(value="/update",method = RequestMethod.POST)
	public String update(Region region,Model model) {
		regionService.updateRegionWithDept(region);
		model.addAttribute("menuId", "906");
		return "redirect:list.jhtml";
	}
	/**
	 * 将menuId值设为906存入model，去区域展示页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "906");
		return BaseTemplateURL + "/list";
	}
	
	/**
	 * 根据传来的Pageable对象和Region对象查出数据并以map返回
	 * @param pageable
	 * @param region
	 * @return
	 */
	@RequestMapping(value="/list",method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> list(Pageable pageable, Region region) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Region> page = regionService.findPage(region, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
}
