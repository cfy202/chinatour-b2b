/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.controller.admin;

import com.chinatour.DateEditor;
import com.chinatour.Message;
import com.chinatour.Setting;
import com.chinatour.entity.Log;
import com.chinatour.template.directive.FlashMessageDirective;
import com.chinatour.util.SettingUtils;
import com.chinatour.util.SpringUtils;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Controller - 基类
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class BaseController {

    /**
     * 错误视图
     */
    protected static final String ERROR_VIEW = "/admin/common/error";

    /**
     * 错误消息
     */
    protected static final Message ERROR_MESSAGE = Message.error("admin.message.error");

    /**
     * 成功消息
     */
    protected static final Message SUCCESS_MESSAGE = Message.success("admin.message.success");

    /**
     * 结算消息
     */
    protected static final Message SETTLEMENT_MESSAGE = Message.error("admin.message.settlement");
    
    /**
     * 同步财务系统数据失败信息
     */
    protected static final Message TRANSFERERROR_MESSAGE = Message.error("admin.message.transferError");
    
    /**
     * 同步财务系统成功消息
     */
    protected static final Message TRANSFERSUCCESS_MESSAGE = Message.success("admin.message.transferSuccess");
    
    /**
     * "验证结果"参数名称
     */
    private static final String CONSTRAINT_VIOLATIONS_ATTRIBUTE_NAME = "constraintViolations";

    /**
     * 数据绑定
     *
     * @param binder WebDataBinder
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
        binder.registerCustomEditor(Date.class, new DateEditor(true));
    }


    /**
     * 货币格式化
     *
     * @param amount   金额
     * @param showSign 显示标志
     * @param showUnit 显示单位
     * @return 货币格式化
     */
    protected String currency(BigDecimal amount, boolean showSign, boolean showUnit) {
        Setting setting = SettingUtils.get();
        String price = setting.setScale(amount).toString();
        if (showSign) {
            price = setting.getCurrencySign() + price;
        }
        if (showUnit) {
            price += setting.getCurrencyUnit();
        }
        return price;
    }

    /**
     * 获取国际化消息
     *
     * @param code 代码
     * @param args 参数
     * @return 国际化消息
     */
    protected String message(String code, Object... args) {
        return SpringUtils.getMessage(code, args);
    }

    /**
     * 添加瞬时消息
     *
     * @param redirectAttributes RedirectAttributes
     * @param message            消息
     */
    protected void addFlashMessage(RedirectAttributes redirectAttributes, Message message) {
        if (redirectAttributes != null && message != null) {
            redirectAttributes.addFlashAttribute(FlashMessageDirective.FLASH_MESSAGE_ATTRIBUTE_NAME, message);
        }
    }

    /**
     * 添加日志
     *
     * @param content 内容
     */
    protected void addLog(String content) {
        if (content != null) {
            RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
            requestAttributes.setAttribute(Log.LOG_CONTENT_ATTRIBUTE_NAME, content, RequestAttributes.SCOPE_REQUEST);
        }
    }
}