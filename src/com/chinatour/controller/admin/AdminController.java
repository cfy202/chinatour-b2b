package com.chinatour.controller.admin;

import com.chinatour.Constant;
import com.chinatour.Message;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AdminRegion;
import com.chinatour.entity.AdminRole;
import com.chinatour.entity.Enquirys;
import com.chinatour.entity.Role;
import com.chinatour.service.AdminRegionService;
import com.chinatour.service.AdminRoleService;
import com.chinatour.service.AdminService;
import com.chinatour.service.DeptService;
import com.chinatour.service.FileService;
import com.chinatour.service.RegionService;
import com.chinatour.service.RoleService;
import com.chinatour.util.UUIDGenerator;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * Created by XuXuebin on 2014/7/17.
 */
@Controller
@RequestMapping("/admin/admin")
public class AdminController extends BaseController {
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	@Resource(name = "roleServiceImpl")
	private RoleService roleService;

	@Resource(name = "deptServiceImpl")
	private DeptService deptService;
	
	@Resource(name = "adminRoleServiceImpl")
	private AdminRoleService adminRoleService;
	
	@Resource(name = "regionServiceImpl")
	private RegionService regionService;
	
	@Resource(name = "adminRegionServiceImpl")
	private AdminRegionService adminRegionService;
	
	@Resource(name = "fileServiceImpl")
	private FileService fileService;
	
	/**
	 * 检查用户名是否存在
	 */
	@RequestMapping(value = "/check_username", method = RequestMethod.POST)
	public @ResponseBody
	boolean checkUsername(String username) {
		if (StringUtils.isEmpty(username)) {
			return false;
		}
		if (adminService.usernameExists(username)) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 添加
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		Admin a=adminService.getCurrent();
		model.addAttribute("menuId", "903");
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("deptList", deptService.findAll());
		return "/admin/admin/add";
	}

	/**
	 * 保存
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Admin admin, String[] roleIds,
			RedirectAttributes redirectAttributes) {
	//	admin.setAdminRoles(new HashSet<AdminRole>(adminRoleService.findList(roleIds)));
		if (adminService.usernameExists(admin.getUsername())) {
			return ERROR_VIEW;
		}
		admin.setPassword(DigestUtils.md5Hex(admin.getPassword()));
		admin.setId(UUIDGenerator.getUUID());
		List<AdminRole> adminRoleList=new ArrayList<AdminRole>();
		for(int i=0;i<roleIds.length;i++){
			AdminRole adminRole=new AdminRole();
			String roleId=roleIds[i];
			adminRole.setAdmins(admin.getId());
			adminRole.setRoles(roleId);
			adminRoleList.add(adminRole);
		}
		adminRoleService.batchSave(adminRoleList);
		admin.setCreateDate(new Date());
		admin.setModifyDate(new Date());
		adminService.save(admin);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 编辑
	 */
	@RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
	public String edit(@PathVariable String id, ModelMap model) {
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("regions",regionService.findAll());
		model.addAttribute("admin", adminService.findByIdAndRole(id));
		model.addAttribute("deptList", deptService.findAll());
		return "/admin/admin/edit";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Admin admin,RedirectAttributes redirectAttributes) {
		//admin.setRoles(new HashSet<Role>(roleService.findList(roleIds)));
		Admin pAdmin = adminService.findById(admin.getId());
		if (pAdmin == null) {
			return ERROR_VIEW;
		}
		if (StringUtils.isNotEmpty(admin.getPassword())) {
			admin.setPassword(DigestUtils.md5Hex(admin.getPassword()));
		} else {
			admin.setPassword(pAdmin.getPassword());
		}
		adminService.update(admin);

		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "903");
		return "/admin/admin/list";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, Admin admin) {
//		admin.setIsEnabled(true);
		Map<String, Object> map = new HashMap<String, Object>();
		Page<Admin> page = adminService.findPage(admin, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	Message delete(String[] ids) {
		if (ids.length >= adminService.count()) {
			return Message.error("admin.common.deleteAllNotAllowed");
		}
		for(int i=0;i<ids.length;i++){
			Admin admin=adminService.findById(ids[i]);
			admin.setIsEnabled(false);
			adminService.update(admin);
		}
		return SUCCESS_MESSAGE;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable String id,
			RedirectAttributes redirectAttributes) {
		Admin admin=adminService.findById(id);
		admin.setIsEnabled(false);
		adminService.update(admin);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:/admin/admin/list.jhtml";
	}
	
	/**
	 * 异步添加修改角色
	 * @param pageable
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/editRole", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> editRole(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin=adminService.findByIdAndRole(id);
		map.put("admin", admin);
		map.put("roles",roleService.findAll());
		return map;
	}
	
	/**
	 * 角色更新
	 */
	@RequestMapping(value = "/updateRole", method = RequestMethod.POST)
	public String updateRole(Admin admin, String[] roleIds,
			RedirectAttributes redirectAttributes) {
		adminRoleService.delete(admin.getId());
		List<AdminRole> adminRoleList=new ArrayList<AdminRole>();
		for(int i=0;i<roleIds.length;i++){
			AdminRole adminRole=new AdminRole();
			String roleId=roleIds[i];
			adminRole.setAdmins(admin.getId());
			adminRole.setRoles(roleId);
			adminRoleList.add(adminRole);
		}
		adminRoleService.batchSave(adminRoleList);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 异步添加修改角色
	 * @param pageable
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/editRegion", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> editRegion(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		Admin admin=adminService.findByIdAndRole(id);
		map.put("admin", admin);
		map.put("regions",regionService.findAll());
		return map;
	}
	
	/**
	 * 区域经理更新
	 */
	@RequestMapping(value = "/updateRegion", method = RequestMethod.POST)
	public String updateRegion(Admin admin, String[] regions,
			RedirectAttributes redirectAttributes) {
		adminRegionService.delete(admin.getId());
		List<AdminRegion> adminRegionList=new ArrayList<AdminRegion>();
		for(int i=0;i<regions.length;i++){
			AdminRegion adminRegion=new AdminRegion();
			String regionId=regions[i];
			adminRegion.setAdminId(admin.getId());
			adminRegion.setRegionId(regionId);
			adminRegionList.add(adminRegion);
		}
		adminRegionService.batchSave(adminRegionList);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * my Account
	 * 编辑
	 */
	@RequestMapping(value = "/editUser", method = RequestMethod.GET)
	public String editUser(ModelMap model) {
		model.addAttribute("admin", adminService.findById(adminService.getCurrent().getId()));
		return "/admin/admin/myAccount";
	}

	/**
	 * 更新
	*/
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	public String updateUser(Admin admin,RedirectAttributes redirectAttributes) {
		Admin pAdmin = adminService.findById(admin.getId());
		if (pAdmin == null) {
			return ERROR_VIEW;
		}
		adminService.update(admin);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "/admin/common/main";
	} 
	
	/**
	 * password
	 * 编辑
	 */
	@RequestMapping(value = "/editPassword", method = RequestMethod.GET)
	public String editPassword(ModelMap model) {
		model.addAttribute("admin", adminService.findById(adminService.getCurrent().getId()));
		return "/admin/admin/updatePassword";
	}
	
	/**
	 *  password
	 * 更新
	*/
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public String updatePassword (Admin admin,RedirectAttributes redirectAttributes) {
		Admin pAdmin = adminService.findById(admin.getId());
		if (pAdmin == null) {
			return ERROR_VIEW;
		}
		if(!admin.getPassword().equals(admin.getRePassword())){
			return ERROR_VIEW;
		}
		admin.setPassword(DigestUtils.md5Hex(admin.getPassword()));
		adminService.update(admin);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:/admin/common/main.jhtml";
	} 
	
	/**
	 * 下载
	 * 
	 * @author
	 * @date
	 * @param attachment
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "download")
	public ModelAndView download(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String downLoadPath =Constant.README;
		String contentType = "application/octet-stream";
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	
	@RequestMapping(value = "/findByDepId", method = RequestMethod.POST)
	public @ResponseBody
	List<Admin> findByDepId(Admin admin) {
		admin.setIsEnabled(true);
		List<Admin> adminList = adminService.find(admin);
		return adminList;
	}
}
