package com.chinatour.controller.admin;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.chinatour.FileInfo.FileType;
import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.Admin;
import com.chinatour.entity.News;
import com.chinatour.service.AdminService;
import com.chinatour.service.CaptchaService;
import com.chinatour.service.CurrencyTypeService;
import com.chinatour.service.FileService;
import com.chinatour.service.NewsService;
import com.chinatour.service.PeerUserService;
import com.chinatour.util.UUIDGenerator;

@Controller
@RequestMapping("/admin/news")
public class NewsController extends BaseController {
	/*
	 * template所属包的路径
	 */
	private String BaseTemplateURL = "/admin/basic/news";
	
	@Resource(name = "newsServiceImpl")
	private NewsService newsService;
	@Resource(name = "fileServiceImpl")
	private FileService fileService;
	@Resource(name = "adminServiceImpl")
	private AdminService adminService;
	@Resource(name = "captchaServiceImpl")
	private CaptchaService captchaService;
	@Resource(name = "peerUserServiceImpl")
	private PeerUserService peerUserService;
	@Autowired
	private CurrencyTypeService  currencyTypeService;
	

	/**
	 * 查询所有
	 */
	@RequestMapping(value = "/list" , method = RequestMethod.GET)
	public String list(ModelMap model){
		model.addAttribute("menuId", "812");
		return BaseTemplateURL+"/list";
	}
	
	/**
	 * 异步查询所有
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> list(Pageable pageable, News news) {
		Map<String, Object> map = new HashMap<String, Object>();
		Page<News> page = newsService.findPage(news,pageable);
		map.put("recordsTotal", page.getTotal());
		map.put("recordsFiltered", page.getTotal());
		map.put("data", page.getContent());
		return map;
	}
	
	/**
	 * 跳转至添加页面
	 */
	@RequestMapping(value = "/add" , method = RequestMethod.GET)
	public String add(ModelMap model){
		model.addAttribute("menuId", "812");
		model.addAttribute("currencyTypeList", currencyTypeService.findAll());
		return BaseTemplateURL+"/add";
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String add(MultipartFile file,News news,
			HttpServletRequest request, String menuId,
			RedirectAttributes redirectAttributes) {
		Admin admin = adminService.getCurrent();
		if(file.getSize()!=0){
			String fileString= fileService.uploadLocal(FileType.imagePath,file);
			news.setImage(fileString);
		}
		news.setNewsId(UUIDGenerator.getUUID());
		news.setUserId(admin.getId());
		newsService.save(news);
		return "redirect:list";
	}
	
	/**
	 * 跳转至添加页面
	 */
	@RequestMapping(value = "/Preview" , method = RequestMethod.GET)
	public String Preview(ModelMap model){
		model.addAttribute("menuId", "812");
		return BaseTemplateURL+"/index";
	}
	
	@RequestMapping(value = "/edit" , method = RequestMethod.GET)
	public String edit(ModelMap model,String id){
		model.addAttribute("menuId", "812");
		News news = newsService.findById(id);
		model.addAttribute("news", news);
		model.addAttribute("currencyTypeList", currencyTypeService.findAll());
		return BaseTemplateURL+"/edit";
	}
	
	@RequestMapping(value = "/update" , method = RequestMethod.POST)
	public String update(ModelMap model,News news,MultipartFile file){
		if(file.getSize()!=0){
			String fileString= fileService.uploadLocal(FileType.imagePath,file);
			news.setImage(fileString);
		}
		newsService.update(news);
		model.addAttribute("menuId", "812");
		return "redirect:list";
	}
	
	@RequestMapping(value = "/del" , method = RequestMethod.GET)
	public String del(ModelMap model,String id){
		model.addAttribute("menuId", "812");
		News news=newsService.findById(id);
		news.setIsAvailable(1);
		newsService.update(news);
		return "redirect:list";
	}
	
	
}
