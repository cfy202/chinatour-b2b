/**
 * 
 */
package com.chinatour.controller.admin;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.chinatour.Constant;
import com.chinatour.FileInfo.FileType;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Country;
import com.chinatour.entity.Enquirys;
import com.chinatour.entity.Humanrace;
import com.chinatour.entity.Language;
import com.chinatour.entity.State;
import com.chinatour.entity.TourType;
import com.chinatour.service.AdminService;
import com.chinatour.service.CountryService;
import com.chinatour.service.EnquirysService;
import com.chinatour.service.FileService;
import com.chinatour.service.HumanraceService;
import com.chinatour.service.LanguageService;
import com.chinatour.service.StateService;
import com.chinatour.service.TourTypeService;
import com.chinatour.util.EnquiryItemsExcel;
import com.chinatour.util.UUIDGenerator;
import com.google.gson.Gson;

import freemarker.ext.beans.BeansWrapper;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;

/**
 * Coontroller 询价
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-9-29 上午9:43:11
 * @revision 3.0
 */

@Controller
@RequestMapping("/admin/enquirys")
public class EnquirysController extends BaseController {

	public static final TemplateHashModel CONSTANT;

	static {
		TemplateHashModel constant = null;
		try {
			constant = BeansWrapper.getDefaultInstance().getStaticModels();
			constant = (TemplateHashModel) constant
					.get("com.chinatour.Constant");
		} catch (TemplateModelException e) {
			e.printStackTrace();
		}
		CONSTANT = constant;
	}

	@Resource(name = "enquirysServiceImpl")
	private EnquirysService enquirysService;

	/*
	 * 用户的业务层注入
	 */
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;

	/*
	 * 国家的业务层注入
	 */
	@Resource(name = "countryServiceImpl")
	private CountryService countryService;

	/*
	 * 州的业务层注入
	 */
	@Resource(name = "stateServiceImpl")
	private StateService stateService;

	/*
	 * 语种的业务层注入
	 */
	@Resource(name = "languageServiceImpl")
	private LanguageService languageService;

	/*
	 * 种族的业务层注入
	 */
	@Resource(name = "humanraceServiceImpl")
	private HumanraceService humanraceService;

	@Resource(name = "fileServiceImpl")
	private FileService fileService;

	@Resource(name = "tourTypeServiceImpl")
	private TourTypeService tourTypeService;
	
	/**
	 * OP 查询所有
	 */
	@RequestMapping(value = "/opList", method = RequestMethod.GET)
	public String opList(ModelMap model) {
		model.addAttribute("menuId", "203");
		return "/admin/enquirys/opList";
	}

	/**
	 * OP 查看所有 异步查询所有
	 */
	@RequestMapping(value = "/opList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> opList(Pageable pageable, Enquirys enquirys) {
		Map<String, Object> map = new HashMap<String, Object>();
		enquirys.setType(0);// 非草稿
		Page<Enquirys> page = enquirysService.findPageByDeptId(enquirys, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * Agent 查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(ModelMap model) {
		model.addAttribute("menuId", "201");
		return "/admin/enquirys/list";
	}

	/**
	 * Agent 查看所有 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, Enquirys enquirys) {
		Map<String, Object> map = new HashMap<String, Object>();
		enquirys.setType(0);// 非草稿
		enquirys.setUserId(adminService.getCurrent().getId());// 当前用户
		Page<Enquirys> page = enquirysService.findPage(enquirys, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * Agent 查询所有
	 */
	@RequestMapping(value = "/draftList", method = RequestMethod.GET)
	public String draftList(ModelMap model) {
		model.addAttribute("menuId", "202");
		return "/admin/enquirys/draftList";
	}

	/**
	 * Agent 查看所有 异步查询所有
	 */
	@RequestMapping(value = "/draftList", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> draftList(Pageable pageable, Enquirys enquirys) {
		Map<String, Object> map = new HashMap<String, Object>();
		enquirys.setType(1);// 草稿
		enquirys.setUserId(adminService.getCurrent().getId());// 当前用户
		Page<Enquirys> page = enquirysService.findPage(enquirys, pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}

	/**
	 * 添加enquirys信息，并且加载国家信息
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		Gson gson=new Gson();
		model.addAttribute("menuId", "201");
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		model.addAttribute("tourTypeList", gson.toJson(tourTypeService.findAll()));
		model.addAttribute("humanraceList", humanraceService.findAll());
		return "/admin/enquirys/add";
	}

	/**
	 * 保存
	 * 
	 * @param enquirys
	 *            询价实体
	 * @return
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Enquirys enquirys,RedirectAttributes redirectAttributes) {
		enquirys.setEnquiryId(UUIDGenerator.getUUID());
		Admin admin = adminService.getCurrent();
		enquirys.setUserId(admin.getId());
		enquirys.setDeptId(admin.getDeptId());
		enquirysService.save(enquirys);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 按照id删除
	 */
	@RequestMapping(value = "/del", method = RequestMethod.GET)
	public String delete(String id, RedirectAttributes redirectAttributes) {
		enquirysService.delete(id);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 按id加载并且加载城市信息
	 * 
	 * @param model
	 * @param id
	 *            询价id
	 * @param temp
	 *            判断从那个页面传过来 0 询价管理 1 草稿箱
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String load(ModelMap model, String id, String temp) {
		if (temp.equals("0")) {
			model.addAttribute("menuId", "201");
		} else {
			model.addAttribute("menuId", "202");
		}
		Gson gson=new Gson();
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("tourTypeList", gson.toJson(tourTypeService.findAll()));
		model.addAttribute("enquirys", enquirysService.findById(id));
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		model.addAttribute("humanraceList", humanraceService.findAll());
		return "/admin/enquirys/edit";
	}

	/**
	 * 更新
	 * 
	 * @param enquirys
	 * @param temp
	 *            判断跳转到那个页面 0 询价管理 1 询价草稿箱
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Enquirys enquirys, String temp,RedirectAttributes redirectAttributes) {
		enquirysService.update(enquirys);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		if (temp.equals("0")) {
			return "redirect:list.jhtml";
		}
		return "redirect:draftList.jhtml";
	}

	/**
	 * 按id加载并且加载城市信息
	 * 
	 * @param model
	 * @param id
	 *            询价id
	 * @param temp
	 *            判断从那个页面传过来 0 询价管理 1 询价信息
	 * @return
	 */
	@RequestMapping(value = "/searchDetail", method = RequestMethod.GET)
	public String searchDetail(ModelMap model, String id, String temp) {
		if (temp.equals("0")) {
			model.addAttribute("menuId", "201");
		} else {
			model.addAttribute("menuId", "203");
		}
		model.addAttribute("constant", CONSTANT);
		model.addAttribute("enquirys", enquirysService.findById(id));
		model.addAttribute("countryList", countryService.findAll());
		model.addAttribute("tourTypeList", tourTypeService.findAll());
		model.addAttribute("stateList", stateService.findAll());
		model.addAttribute("languageList", languageService.findAll());
		model.addAttribute("humanraceList", humanraceService.findAll());
		return "/admin/enquirys/searchDetail";
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
			HttpServletResponse response,String id) throws Exception {
		
		Enquirys enquirys=enquirysService.findById(id);
		String downLoadPath =enquirys.getEnquiryDocs();
		String contentType = "application/octet-stream";
		/*if(downLoadPath.isEmpty()){
			return null;
		}*/
		fileService.download(request, response, downLoadPath, contentType);
		return null;
	}
	/**
	 * 上传
	 * @param file 上传文件
	 * @param id 
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "/upload" , method=RequestMethod.POST)
	public String upload(MultipartFile file,String id,RedirectAttributes redirectAttributes ){
		
		String fileString= fileService.uploadLocal(FileType.enquiryPath,file);
		if(fileString!=null){
			Enquirys enquirys=new Enquirys();
			enquirys.setEnquiryId(id);
			enquirys.setEnState(1);// 是否上传文件 0否 1是
			enquirys.setEnquiryDocs(fileString);
			enquirys.setServerIp(Constant.SERVERIP);
			enquirysService.update(enquirys);
		}
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:opList.jhtml";
	}
	
	/**
	 * 导出询价信息
	 * @return
	 */
	@RequestMapping(value = "/exportEnquiry", method = RequestMethod.GET)
	public ModelAndView exportEnquiry(HttpServletRequest request,
			HttpServletResponse response,String id) {
			OutputStream os = null;
			String filename = "";
			Enquirys enquirys = enquirysService.findById(id);
			if(enquirys!=null){
				filename = enquirys.getEnquiryNo();
				Language language=languageService.findById(enquirys.getLanguageId());
				enquirys.setLanguageId(language==null?"":language.getLanguage());
				Humanrace humanrace =humanraceService.findById(enquirys.getHumanRaceId());
				enquirys.setHumanRaceId(humanrace==null?"":humanrace.getHumanRace());
				Country country=countryService.findById(enquirys.getCountryId());
				enquirys.setCountryId(country==null?"":country.getCountryName());
				State state=stateService.findById(enquirys.getStateId());
				enquirys.setStateId(state==null?"":state.getStateName());
				TourType tourType=tourTypeService.findById(enquirys.getTourTypeId());
				enquirys.setTourTypeId(tourType==null?"":tourType.getTypeName());
				try {
					os = response.getOutputStream();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			response.reset();
			response.setHeader("Content-disposition","attachment;filename=" + filename + ".doc");
			response.setContentType("application/msword");
			if(enquirys!=null){
				EnquiryItemsExcel.createEnquiryItemsPlan(enquirys,os);
			}
			return null;
	}
}
