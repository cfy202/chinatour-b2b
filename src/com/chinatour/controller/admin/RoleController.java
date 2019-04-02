/**
 * 
 */
package com.chinatour.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Role;
import com.chinatour.entity.RoleAuthority;
import com.chinatour.entity.Vender;
import com.chinatour.service.AdminService;
import com.chinatour.service.RoleAuthorityService;
import com.chinatour.service.RoleService;
import com.chinatour.util.UUIDGenerator;
/**
 * 角色
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-10-8 上午9:29:50
 * @revision  3.0
 */

@Controller
@RequestMapping("/admin/roles")
public class RoleController  extends BaseController{
	
	@Resource(name = "roleServiceImpl")
	private RoleService roleService;
	
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	
	@Resource(name = "roleAuthorityServiceImpl")
	private RoleAuthorityService roleAuthorityService;
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list" , method = RequestMethod.GET)
	public String list(ModelMap model){
		model.addAttribute("menuId", "902");
		return "/admin/authorities/list";
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, Role role) {
		Map<String, Object> map = new HashMap<String, Object>();
		//查询可用权限 1
		role.setIsSystem(false);
		Page<Role> page = roleService.findPage(role,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 添加角色信息
	 */
	@RequestMapping(value = "/add" , method=RequestMethod.GET)
	public String add(ModelMap model){
		return "/admin/authorities/add";
	}
	
	/**
	 * 保存
	 * @param role 角色实体
	 * @param authority 权限数组
	 * @return
	 */
	@RequestMapping(value = "/save" , method=RequestMethod.POST)
	public String save(Role role,String[] authority){
		role.setModifyDate(new Date());
		role.setId(UUIDGenerator.getUUID());
		roleService.save(role);
    	RoleAuthority roleAuthority=new RoleAuthority(); 
    	if(authority!=null&&authority.length>0){
    		for (String austr : authority) {
    			roleAuthority.setRole(role.getId());
    			roleAuthority.setAuthorities(austr);
    			roleAuthorityService.save(roleAuthority);
    		}
    	}
		return "redirect:list.jhtml";
	}
	
	/**
	 * 按id加载
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id) {
		model.addAttribute("menuId", "902");
		model.addAttribute("role",roleService.findById(id));
		return "/admin/authorities/edit";
	}
	
	/**
	 * 更新
	 * @param role 角色实体
	 * @param authority 权限数组
	 * @return
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(Role role,String[] authority){
		role.setModifyDate(new Date());
		roleAuthorityService.delete(role.getId());
    	RoleAuthority roleAuthority=new RoleAuthority(); 
    	if(authority!=null&&authority.length>0){
	    	for (String austr : authority) {
				roleAuthority.setRole(role.getId());
				roleAuthority.setAuthorities(austr);
				roleAuthorityService.save(roleAuthority);
			}
    	}
		roleService.update(role);
		return "redirect:list.jhtml"; 
	}
}
