package com.chinatour.controller.shop;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinatour.Principal;
import com.chinatour.Setting.CaptchaType;
import com.chinatour.entity.News;
import com.chinatour.entity.PeerUser;
import com.chinatour.service.AdminService;
import com.chinatour.service.CaptchaService;
import com.chinatour.service.FileService;
import com.chinatour.service.NewsService;
import com.chinatour.service.PeerUserService;

/**
 * Created by XuXuebin on 2014/7/17.
 */
@Controller
@RequestMapping("/index")
public class IndexController extends BaseController {
	
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
	
	@RequestMapping(value = "/login" , method = RequestMethod.POST)
	public @ResponseBody String login(String captchaId, String captcha,String username,String password, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		String message = "success";
		/*if (!captchaService.isValid(CaptchaType.memberLogin, captchaId, captcha)) {
			
			message = "1";
			return message;
		}*/
		PeerUser peerUser = new PeerUser();
		peerUser.setPeerUserName(username);
		peerUser.setPassword(password);
		peerUser.setIsAvailable(0);
		List<PeerUser> peerUsers = peerUserService.find(peerUser);
		if(peerUsers.size()==0){
			message =  "2";
			return message;
		}
		if(peerUsers.size()>0){
			session = request.getSession();
			session.setAttribute("peerUser", new Principal(peerUsers.get(0).getPeerUserId(),peerUsers.get(0).getPeerUserName()));
		}
		 return message;
    }
	
	@RequestMapping(value = "/logout" , method = RequestMethod.GET)
	public @ResponseBody String logout(String captchaId, String captcha,String username,String password, HttpServletRequest request, HttpServletResponse response, HttpSession session){
		session.removeAttribute("peerUser");
		 return "success";
    }
	
	@RequestMapping(value = "/getUserName" , method = RequestMethod.GET)
	 public @ResponseBody String getUserName(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        HttpSession session = request.getSession();
	        Principal principal = (Principal) session.getAttribute("peerUser");
	        String userName = "";
	        if(principal!=null){
	        	userName = principal.getUsername();
	        }
			return userName;
	 }
	
	@RequestMapping(value = "/imageForPage", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> imageForPage(int startPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		startPage =(startPage-1)*4;
		PeerUser peerUser=peerUserService.getCurrent();
		News n=new News();
		n.setStartPage(startPage);
		n.setCurrency(peerUser.getCurrencyTypeId());
		List<News> newsList = newsService.findNewsForPage(n);
		SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
		for(News news:newsList){
			String createDateStr = dateFormat.format(news.getCreateDate());
			news.setCreateDateStr(createDateStr);
		}
		map.put("newsList", newsList);
		return map;
	}
	
	@RequestMapping(value = "/getPageCount", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> getPageCount() {
		Map<String, Object> map = new HashMap<String, Object>();
		PeerUser peerUser=peerUserService.getCurrent();
		int pageCount = newsService.findNewsForPageCount(peerUser.getCurrencyTypeId());
		map.put("pageCount", pageCount);
		return map;
	}
	
}
