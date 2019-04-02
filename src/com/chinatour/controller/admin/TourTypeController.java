/**
 * 
 */
package com.chinatour.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.TourType;
import com.chinatour.entity.TourTypeOfDept;
import com.chinatour.service.AdminService;
import com.chinatour.service.BrandService;
import com.chinatour.service.DeptService;
import com.chinatour.service.TourTypeOfDeptService;
import com.chinatour.service.TourTypeService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 上午10:10:10
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/tourType")
public class TourTypeController  extends BaseController{
	
	@Resource(name = "tourTypeServiceImpl")
	private TourTypeService tourTypeService;
	@Resource(name = "brandServiceImpl")
	private BrandService brandService;
	@Autowired
	private DeptService DeptService;
	@Resource(name = "tourTypeOfDeptServiceImpl")
	private TourTypeOfDeptService tourTypeOfDeptService;
	@Resource(name = "adminServiceImpl") 
	private AdminService adminService;
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list" , method = RequestMethod.GET)
	public String list(ModelMap model){
		model.addAttribute("menuId", "803");
		return "/admin/basic/tourType/list";
	}
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, TourType tourType) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<TourType> page = tourTypeService.findPage(tourType,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/listforAdmin" , method = RequestMethod.GET)
	public String listforAdmin(ModelMap model){
		model.addAttribute("menuId", "898");
		return "/admin/basic/tourType/listforAdmin";
	}
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/listforAdmin", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listforAdmin(Pageable pageable, TourType tourType) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<TourType> page = tourTypeService.findPage(tourType,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 添加Vender信息，并且加载国家信息
	 */
	@RequestMapping(value = "/add" , method=RequestMethod.GET)
	public String add(ModelMap model){
		model.addAttribute("menuId", "803");
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("OPAccountList", DeptService.findAll());
		return "/admin/basic/tourType/add";
	}
	/**
	 * 添加Vender信息，并且加载国家信息forAdmin
	 */
	@RequestMapping(value = "/addforAdmin" , method=RequestMethod.GET)
	public String addforAdmin(ModelMap model){
		model.addAttribute("menuId", "898");
		model.addAttribute("brandList", brandService.findAll());
		return "/admin/basic/tourType/addforAdmin";
	}
	/**
	 * 保存
	 */
	@RequestMapping(value = "/save" , method=RequestMethod.POST)
	public String save(TourType tourType){
		tourType.setTourTypeId(UUIDGenerator.getUUID());
		TourTypeOfDept tourTypeOfDept=new TourTypeOfDept();
			tourTypeOfDept.setTourTypeOfDeptId(UUIDGenerator.getUUID());
			tourTypeOfDept.setDeptId(tourType.getOperater());
			tourTypeOfDept.setTourTypeId(tourType.getTourTypeId());
			tourTypeOfDept.setCode(tourType.getCode());
			tourTypeService.save(tourType);
		tourTypeOfDeptService.save(tourTypeOfDept);
		
		return "redirect:list.jhtml";
	}
	
	/**
	 * 保存 forAdmin
	 */
	@RequestMapping(value = "/saveforAdmin" , method=RequestMethod.POST)
	public String saveforAdmin(TourType tourType){
		tourType.setTourTypeId(UUIDGenerator.getUUID());
		tourTypeService.save(tourType);
		return "redirect:listforAdmin.jhtml";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(TourType tourTypeVo){
		String[] tourTypeOfDeptIds =new String[tourTypeVo.getTourTypeOfDeptList().size()];
		List<TourTypeOfDept> tourTypeOfDeptList=new ArrayList<TourTypeOfDept>();
		//循环团队类型集合 保存
				for (int i=0;i<tourTypeVo.getTourTypeOfDeptList().size();i++) {
					TourTypeOfDept tourTypeOfDept=tourTypeVo.getTourTypeOfDeptList().get(i);
					if(tourTypeOfDept.getTourTypeOfDeptId()!=null){
						tourTypeOfDeptIds[i]=tourTypeOfDept.getTourTypeOfDeptId();
					}
					if(tourTypeVo.getTourTypeId()!=null){
						tourTypeOfDept.setTourTypeOfDeptId(UUIDGenerator.getUUID());
						tourTypeOfDept.setDeptId(tourTypeOfDept.getDeptId());
						tourTypeOfDept.setTourTypeId(tourTypeVo.getTourTypeId());
						tourTypeOfDept.setCode(tourTypeVo.getCode());
						//保存list集合
						tourTypeOfDeptList.add(tourTypeOfDept);
					}
				}
				//删除原有的关系
				if(tourTypeOfDeptIds.length>0){
					tourTypeOfDeptService.delete(tourTypeOfDeptIds);
				}
				//保存
				if(tourTypeOfDeptList.size()>0){
					tourTypeOfDeptService.batchSave(tourTypeOfDeptList);
				}
				tourTypeService.update(tourTypeVo);
			return "redirect:list.jhtml"; 
	}
	/**
	 * 更新forAdmin
	 */
	@RequestMapping(value = "/updateforAdmin" , method=RequestMethod.POST)
	public String updateforAdmin(TourType tourType){
		tourTypeService.update(tourType);
		return "redirect:listforAdmin.jhtml"; 
	}
	/**
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id) {
		model.addAttribute("menuId", "803");
		model.addAttribute("tourType",tourTypeService.findById(id));
		model.addAttribute("brandList", brandService.findAll());
		model.addAttribute("OPAccountList", DeptService.findAll());
		model.addAttribute("TourTypeList", tourTypeOfDeptService.queryByTourType(id));
		return "/admin/basic/tourType/edit";
	}
	
	/**
	 * 按id加载并且加载城市信息 forAdmin
	 */
	@RequestMapping(value = "/editforAdmin", method = RequestMethod.GET)
	public String loadforAdmin(ModelMap model, String id) {
		model.addAttribute("menuId", "898");
		model.addAttribute("tourType",tourTypeService.findById(id));
		model.addAttribute("brandList", brandService.findAll());
		return "/admin/basic/tourType/editforAdmin";
	}
	
	@RequestMapping(value = "/opaccount", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> findTourType(String deptName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tourType", tourTypeOfDeptService.findTourTypeOfDeptByDept(deptName));
		return map;
	}
}
