package com.chinatour.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.FileInfo.FileType;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Dept;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.PeerUser;
import com.chinatour.entity.State;
import com.chinatour.entity.Vender;
import com.chinatour.entity.ExcelForVendor;
import com.chinatour.service.AdminService;
import com.chinatour.service.CityService;
import com.chinatour.service.CountryService;
import com.chinatour.service.DeptService;
import com.chinatour.service.FileService;
import com.chinatour.service.PeerUserService;
import com.chinatour.service.StateService;
import com.chinatour.service.VenderService;
import com.chinatour.util.MD5Util;
import com.chinatour.util.UUIDGenerator;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-15 上午10:10:10
 * @revision  3.0
 */
@Controller
@RequestMapping("/admin/vender")
public class VenderController  extends BaseController{
	
	@Resource(name = "venderServiceImpl")
	private VenderService venderService;
	
	@Resource(name = "countryServiceImpl")
	private CountryService countryService;
	
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	
	@Resource(name="peerUserServiceImpl")
	private PeerUserService peerUserService;
	
	@Resource(name="deptServiceImpl")
	private DeptService deptService;
	
	@Resource(name="fileServiceImpl")
	private FileService fileService;
	
	@Resource(name="cityServiceImpl")
	private CityService cityService;
	
	@Resource(name="stateServiceImpl")
	private StateService stateService;
	
	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list" , method = RequestMethod.GET)
	public String list(ModelMap model,Vender vender){
		model.addAttribute("menuId", "809");
		model.addAttribute("vender",vender);
		return "/admin/basic/vender/list";
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, Vender vender) {
		Admin admin = adminService.getCurrent();
		vender.setDeptId(admin.getDeptId());
		vender.setIsDel(0);
		Page<Vender> page = venderService.findPage(vender,pageable);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/listSelect", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> listSelect(Vender vender,String type,String role) {
		Admin admin = adminService.getCurrent();
		if(type!=null){
		Integer types=Integer.parseInt(type);
		vender.setType(types);
		}
		if(role==null){
			vender.setDeptId(admin.getDeptId());
		}else if(role.equals("Office")){
			vender.setDeptId(admin.getDeptId());
		}
		vender.setIsDel(0);
		List<Vender> venderList = venderService.findSelect(vender);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("venderList", venderList);
		return map;
	}
	
	/**
	 * 添加Vender信息，并且加载国家信息
	 */
	@RequestMapping(value = "/add" , method=RequestMethod.GET)
	public String add(ModelMap model){
		model.addAttribute("menuId", "809");
		model.addAttribute("countryList", countryService.findAll());
		return "/admin/basic/vender/add";
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value = "/save" , method=RequestMethod.POST)
	public String save(Vender vender,RedirectAttributes redirectAttributes){
		Admin admin = adminService.getCurrent();
		vender.setVenderId(UUIDGenerator.getUUID());
		vender.setUserId(admin.getId());
		vender.setDeptId(admin.getDeptId());
		vender.setCreateDate(new Date());
		vender.setModifyDate(new Date());
		vender.setIsDel(0);
		vender.setStatus(0);
		venderService.save(vender);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 按照id删除
	 */
	@RequestMapping(value = "/del" , method=RequestMethod.GET)
	public String delete(String id,RedirectAttributes redirectAttributes){
		Vender vender =venderService.findById(id);
		vender.setIsDel(1);//逻辑删除
		venderService.update(vender);
		//查看同行下是否有同行用户，有同行用户的也一并不可以
		PeerUser peerUser=new PeerUser();
		peerUser.setPeerId(id);
		List<PeerUser> peerUserList=peerUserService.find(peerUser);
		if(peerUserList.size()>0){
			for(PeerUser p:peerUserList){
				p.setIsAvailable(1);
				peerUserService.update(p);
			}
		}
		
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 更新
	 */
	@RequestMapping(value = "/update" , method=RequestMethod.POST)
	public String update(Vender vender,String codeS,String nameS,String telS,String contactorS,String cityIdS,String stateIdS,
			String countryNameS,String zipcodeS,RedirectAttributes redirectAttributes){
		if(codeS.equals("0")){
			codeS="";
		}
		if(nameS.equals("0")){
			nameS="";
		}
		if(telS.equals("0")){
			telS="";
		}
		if(contactorS.equals("0")){
			contactorS="";
		}
		if(cityIdS.equals("0")){
			cityIdS="";
		}
		if(stateIdS.equals("0")){
			stateIdS="";
		}
		if(countryNameS.equals("0")){
			countryNameS="";
		}
		if(zipcodeS.equals("0")){
			zipcodeS="";
		}
		vender.setModifyDate(new Date());
		vender.setIsDel(vender.getIsDel());
		venderService.update(vender);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml?code="+codeS+"&name="+nameS+"&tel="+telS+"&contactor="+contactorS+"&cityId="+cityIdS+"&stateId="+stateIdS+"&countryName="+countryNameS+"&zipcode="+zipcodeS; 
	}
	
	/**
	 * 按id加载并且加载城市信息
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST)
	public String load(ModelMap model, String id,Vender vender) {
		model.addAttribute("menuId", "809");
		model.addAttribute("vender",venderService.findById(id));
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("venderPage", vender);
		return "/admin/basic/vender/edit";
	}
	/**
	 * 按id审核同行或供应商是否生效
	 */
	@RequestMapping(value = "/verify", method = RequestMethod.GET)
	public String verify(String id,String status,RedirectAttributes redirectAttributes) {
		Vender vender = venderService.findById(id);
		/*if(status!=null){
			vender.setStatus(1);
			venderService.update(vender);
		}*/
		vender.setStatus(1);
		venderService.update(vender);
		return "redirect:list.jhtml";
	}
	/**
	 * 添加同行用户页面跳转
	 * */
	@RequestMapping(value="/addPeerUser",method= RequestMethod.GET)
	public String addPeerUser(PeerUser peerUser,Model model){
		/*model.addAttribute("uploadLocal", Constant.UPLOADLOCAL);*/
		model.addAttribute("peerUser", peerUser);
		return "/admin/basic/vender/addPeerUser";
	}
	
	@RequestMapping(value="/savePeerUser", method=RequestMethod.POST)
	public String savePeerUser(PeerUser peerUser,Model model){
		Admin admin =adminService.getCurrent();
		Dept dept=deptService.findById(admin.getDeptId());
		peerUser.setPeerUserId(UUIDGenerator.getUUID()); 
		peerUser.setUserId(admin.getId());
		peerUser.setCurrencyTypeId(dept.getCurrencyTypeId());
		peerUser.setIsAvailable(0);
		peerUserService.save(peerUser);
		return "redirect:peerUserList.jhtml?peerId="+peerUser.getPeerId();
	}
	
	/**
	 * 同行用户查询所有
	 */
	@RequestMapping(value = "/peerUserList" , method = RequestMethod.GET)
	public String peerUserList(ModelMap model,String peerId){
		model.addAttribute("peer",venderService.findById(peerId));
		model.addAttribute("menuId", "809");
		return "/admin/basic/vender/peerUserList";
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/peerUserList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> peerUserList(Pageable pageable, PeerUser peerUser) {
		peerUser.setIsAvailable(0);
		Page<PeerUser> page = peerUserService.findPage(peerUser, pageable);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		map.put("peer", venderService.findById(peerUser.getPeerId()));
		return map;
	}
	/**
	 * 同行修改跳转
	 */
	@RequestMapping(value = "/editPeerUser" , method = RequestMethod.GET)
	public String edit(ModelMap model,String id){
		PeerUser peeruser=peerUserService.findById(id);
		String[] brand=peeruser.getBrandMange().split(",");
		String a1=null,a2=null,a3=null,a4=null;
		for(String b:brand){
			if(b.equals("文景假期")){
				a1=b;
			}else if(b.equals("InterTrips")){
				a2=b;
			}else if(b.equals("chinatour")){
				a3=b;
			}else{
				a4=b;
			}
		}
		
		model.addAttribute("peerUser",peeruser);
		model.addAttribute("menuId", "809");
		model.addAttribute("a1", a1);
		model.addAttribute("a2", a2);
		model.addAttribute("a3", a3);
		model.addAttribute("a4", a4);
		return "/admin/basic/vender/editPeerUser";
	}
	/*
	 * 同行修改保存
	 */
	@RequestMapping(value = "/updatePeerUser" , method = RequestMethod.POST)
	public String update(ModelMap model,PeerUser peerUser){
		peerUserService.update(peerUser);
		return "redirect:peerUserList.jhtml?peerId="+peerUser.getPeerId();
	}
	/**
	 * 取消
	 */
	@RequestMapping(value = "/delPeerUser" , method = RequestMethod.GET)
	public String delPeerUser(ModelMap model,String peerUserId){
		PeerUser peerUser=peerUserService.findById(peerUserId);
		peerUser.setIsAvailable(1);
		peerUserService.update(peerUser);
		return "redirect:peerUserList.jhtml?peerId="+peerUser.getPeerId();
	}
	/**
	 * 上传同行用户的Logo
	 * @param file 上传文件
	 * @param id 
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/upload" , method=RequestMethod.POST)
	public @ResponseBody String upload(MultipartFile file){
		return fileService.uploadLocal(FileType.peerUserLogoPath,file);
	}
	/**
	 * Vender导出
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST)
	public ModelAndView excalForpersons(HttpServletRequest requset,
			HttpServletResponse reponse,Vender vender) {
		Admin admin =adminService.getCurrent();
		vender.setDeptId(admin.getDeptId());
		List<Vender> VenderList = venderService.findVenderUserName(vender);
		ExcelForVendor vc = new ExcelForVendor();
		vc.setVenderList(VenderList);
		return new ModelAndView(vc);
	}
} 
