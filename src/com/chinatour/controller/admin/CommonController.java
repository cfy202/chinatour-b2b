/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.controller.admin;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.ServletContextAware;

import com.chinatour.entity.News;
import com.chinatour.entity.RoomSharing;
import com.chinatour.service.NewsService;
import com.chinatour.service.RoomSharingService;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Controller - 共用
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Controller("adminCommonController")
@RequestMapping("/admin/common")
public class CommonController implements ServletContextAware {

    @Value("${system.name}")
    private String systemName;
    @Value("${system.version}")
    private String systemVersion;
    @Value("${system.description}")
    private String systemDescription;
    @Value("${system.show_powered}")
    private Boolean systemShowPowered;
    @Resource(name = "newsServiceImpl")
	private NewsService newsService;
	@Resource(name = "roomSharingServiceImpl")
	private RoomSharingService roomSharingService;
    /**
     * servletContext
     */
    private ServletContext servletContext;

    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /**
     * 主页
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(Model model) {
        model.addAttribute("menuId", "1");
        News n=new News();
        n.setIsSystem(1);
        List<News> newsList=newsService.findNewsList(n);
        SimpleDateFormat dateFormat=new SimpleDateFormat("MM-dd");
        if(newsList!=null&&newsList.size()>0){
			for(News news:newsList){
				String createDateStr = dateFormat.format(news.getCreateDate());
				news.setCreateDateStr(createDateStr);
			}
        }
        //弹出紧急拼房信息
        List<RoomSharing> roomlist=roomSharingService.findRoomList();
        model.addAttribute("roomlist", roomlist);
        model.addAttribute("newsList", newsList);
        return "/admin/common/mainPage";
    }

    /**
     * 首页
     */
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(ModelMap model) {
        model.addAttribute("systemName", systemName);
        model.addAttribute("systemVersion", systemVersion);
        model.addAttribute("systemDescription", systemDescription);
        model.addAttribute("systemShowPowered", systemShowPowered);
        model.addAttribute("javaVersion", System.getProperty("java.version"));
        model.addAttribute("javaHome", System.getProperty("java.home"));
        model.addAttribute("osName", System.getProperty("os.name"));
        model.addAttribute("osArch", System.getProperty("os.arch"));
        model.addAttribute("serverInfo", servletContext.getServerInfo());
        model.addAttribute("servletVersion", servletContext.getMajorVersion() + "." + servletContext.getMinorVersion());
        return "/admin/common/index";
    }

    /**
     * 错误提示
     */
    @RequestMapping("/error")
    public String error() {
        return "/admin/common/error";
    }

    /**
     * 权限错误
     */
    @RequestMapping("/unauthorized")
    public String unauthorized(HttpServletRequest request, HttpServletResponse response) {
        String requestType = request.getHeader("X-Requested-With");
        if (requestType != null && requestType.equalsIgnoreCase("XMLHttpRequest")) {
            response.addHeader("loginStatus", "unauthorized");
            try {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
        return "/admin/common/unauthorized";
    }

}