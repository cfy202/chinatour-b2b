package com.chinatour.interceptor;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by XuXuebin on 2014-08-27.
 */
public class DataTablesInterceptor extends HandlerInterceptorAdapter {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object columns = request.getParameter("columns");
        return super.preHandle(request, response, handler);
    }
}
