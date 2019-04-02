package com.chinatour.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AdminGroup;
import com.chinatour.entity.Dept;
import com.chinatour.entity.SmallGroup;
import com.chinatour.service.AdminGroupService;
import com.chinatour.service.AdminService;
import com.chinatour.service.DeptService;
import com.chinatour.service.SmallGroupService;
import com.chinatour.util.UUIDGenerator;

/**
 * 小组
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-16 下午12:53:40
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/smallGroup")
public class SmallGroupController extends BaseController {

	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/smallGroup";

	@Resource(name = "smallGroupServiceImpl")
	private SmallGroupService groupService;
	
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	
	@Resource(name = "adminGroupServiceImpl")
	private AdminGroupService adminGroupService;
	
	@Resource(name = "deptServiceImpl")
	private DeptService deptService;
	
	/**
	 * 将menuId值设为905存入model，去线路展示页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model) {
		model.addAttribute("menuId", "905");
		return BaseTemplateURL + "/list";
	}

	/**
	 * 根据传来的Pageable对象和Group对象查出数据并以map返回
	 * 
	 * @param pageable
	 * @param groupLine
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, SmallGroup smallGroup) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<SmallGroup> page = groupService.findPage(smallGroup, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value = "/save" , method=RequestMethod.POST)
	public String save(SmallGroup smallGroup,String[] adminId){
			smallGroup.setGroupId(UUIDGenerator.getUUID());
			groupService.save(smallGroup);
			if(adminId!=null){
				AdminGroup adminGroup=new AdminGroup();
				for (String adminIdString : adminId) {
					adminGroup.setGroupId(smallGroup.getGroupId());
					adminGroup.setAdminId(adminIdString);
					adminGroupService.save(adminGroup);
				}
			}
			
		return "redirect:list.jhtml";
	}
	/**
	 * 异步查询
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public @ResponseBody Map<String, String> add(String deptId) {
		Map<String,String> adminMap = new HashMap<String,String>();
		//查出当前用户的部门
		//String detpIdString=adminService.getCurrent().getDeptId();
		Admin admin=new Admin();
		admin.setDeptId(deptId);
		admin.setIsEnabled(true);
		//查出部门的所有用户
		List<Admin> list=adminService.find(admin);
		if(list!=null){
			for(Admin admins : list){
				adminMap.put(admins.getId(), admins.getUsername());
			}
		}
		return adminMap;
	}
	/**
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(Model model,String id) {
		SmallGroup smallGroup=groupService.findById(id);
		Admin admin=new Admin();
		admin.setDeptId(smallGroup.getDeptId());
		admin.setIsEnabled(true);
		model.addAttribute("menuId", "905");
		model.addAttribute("smallGroup",smallGroup);
		model.addAttribute("adminList", adminService.find(admin));
		return BaseTemplateURL + "/edit";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(SmallGroup smallGroup,String[] adminId,RedirectAttributes redirectAttributes){
		groupService.update(smallGroup);
		adminGroupService.delete(smallGroup.getGroupId());
		AdminGroup adminGroup=new AdminGroup();
		for (String adminIdString : adminId) {
			adminGroup.setGroupId(smallGroup.getGroupId());
			adminGroup.setAdminId(adminIdString);
			adminGroupService.save(adminGroup);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml"; 
	}
	/**
	 * 按照id删除
	 */
	@RequestMapping(value = "/del" , method=RequestMethod.GET)
	public String delete(String id,RedirectAttributes redirectAttributes){
		adminGroupService.delete(id);
		groupService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 添加
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String addGroup(Model model) {
		model.addAttribute("menuId", "905");
		List<Dept> deptList= deptService.findAll();
		model.addAttribute("deptList", deptList);
		return BaseTemplateURL + "/add";
	}
}
