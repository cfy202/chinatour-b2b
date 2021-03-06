/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.filter;

import sun.misc.BASE64Decoder;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Filter - 限制访问
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class AccessDeniedFilter implements Filter {

    /**
     * 错误消息
     */
    private static final String ERROR_MESSAGE = "Access denied!";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        response.addHeader(
                new String(new BASE64Decoder().decodeBuffer("UG93ZXJlZEJ5"),
                        "utf-8"),
                new String(
                        new BASE64Decoder().decodeBuffer("WHVYdWViaW4="),
                        "utf-8"));
        response.sendError(HttpServletResponse.SC_FORBIDDEN, ERROR_MESSAGE);
    }

}