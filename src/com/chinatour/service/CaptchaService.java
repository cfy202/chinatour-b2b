package com.chinatour.service;

/**
 * Created by XuXuebin on 2014/7/9.
 */

import com.chinatour.Setting;

import java.awt.image.BufferedImage;

/**
 * Service - 验证码
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public interface CaptchaService {

    /**
     * 生成验证码图片
     *
     * @param captchaId 验证ID
     * @return 验证码图片
     */
    BufferedImage buildImage(String captchaId);

    /**
     * 验证码验证
     *
     * @param captchaType 验证码类型
     * @param captchaId   验证ID
     * @param captcha     验证码(忽略大小写)
     * @return 验证码验证是否通过
     */
    boolean isValid(Setting.CaptchaType captchaType, String captchaId, String captcha);

}