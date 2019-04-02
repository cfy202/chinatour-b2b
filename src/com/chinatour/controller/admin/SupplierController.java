/**
 * 
 */
package com.chinatour.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Hotel;
import com.chinatour.entity.Supplier;
import com.chinatour.service.AdminService;
import com.chinatour.service.CityService;
import com.chinatour.service.SupplierService;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-8-29 上午10:10:10
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/supplier")
public class SupplierController  extends BaseController{
	
	@Resource(name = "supplierServiceImpl")
	private SupplierService supplierService;
	
	@Resource(name = "cityServiceImpl")
	private CityService cityService;
	
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list" , method = RequestMethod.GET)
	public String list(ModelMap model){
		model.addAttribute("menuId", "804");
		return "/admin/basic/supplier/list";
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, Supplier supplier) {
		Map<String, Object> map = new HashMap<String, Object>();
		supplier.setDeptId(adminService.getCurrent().getDeptId());
		Page<Supplier> page = supplierService.findPage(supplier,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 添加地接信息，并且加载城市信息
	 */
	@RequestMapping(value = "/add" , method=RequestMethod.GET)
	public String add(ModelMap model){
		model.addAttribute("menuId", "804");
		model.addAttribute("cityListt", cityService.findAll());
		return "/admin/basic/supplier/add";
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value = "/save" , method=RequestMethod.POST)
	public String save(Supplier supplier){
		supplier.setSupplierId(UUIDGenerator.getUUID());
		supplier.setDeptId(adminService.getCurrent().getDeptId());
		supplier.setCreateDate(new Date());
		supplier.setModifyDate(new Date());
		supplier.setIsDel(0);
		supplierService.save(supplier);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 按照id删除
	 */
	@RequestMapping(value = "/del" , method=RequestMethod.GET)
	public String delete(String id,RedirectAttributes redirectAttributes){
		Supplier supplier=supplierService.findById(id);
		supplier.setIsDel(1);//逻辑删除
		supplierService.update(supplier);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(Supplier supplier){
		supplier.setDeptId(adminService.getCurrent().getDeptId());
		supplier.setModifyDate(new Date());
		supplier.setIsDel(supplier.getIsDel());
		supplierService.update(supplier);
		return "redirect:list.jhtml"; 
	}
	
	/**
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id) {
		model.addAttribute("menuId", "804");
		model.addAttribute("supplier",supplierService.findById(id));
		model.addAttribute("cityListt", cityService.findAll());
		return "/admin/basic/supplier/edit";
	}
	
	/**
	 * 异步查询所有地接社
	 */
	@RequestMapping(value = "/listSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelect(Supplier supplier) {
		//按部门搜索supplier
		supplier.setDeptId(adminService.getCurrent().getDeptId());
		List<Supplier> supplierList = supplierService.findSelect(supplier);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("supplierList", supplierList);
		return map;
	}
}
