/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour;

import com.chinatour.Setting.CaptchaType;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Dept;
import com.chinatour.entity.PeerUser;
import com.chinatour.entity.TourType;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.PeerUserMapper;
import com.chinatour.persistence.TourTypeMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.CaptchaService;
import com.chinatour.service.PeerUserService;
import com.chinatour.service.VenderService;
import com.chinatour.util.MD5Util;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.pam.UnsupportedTokenException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;
import java.util.List;

/**
 * 权限认证
 *
 * @author SHOP++ Team
 * @version 3.0
 */
public class AuthenticationRealm extends AuthorizingRealm {

    @Resource(name = "captchaServiceImpl")
    private CaptchaService captchaService;
    @Resource(name = "adminServiceImpl")
    private AdminService adminService;
    @Resource(name="peerUserServiceImpl")
    private PeerUserService peerUserService;
    @Resource(name="venderServiceImpl")
    private VenderService venderService;

	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private PeerUserMapper peerUserMapper;
	@Autowired
	private TourTypeMapper tourTypeMapper;
    /**
     * 获取认证信息
     *
     * @param token 令牌
     * @return 认证信息
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(org.apache.shiro.authc.AuthenticationToken token) {
        AuthenticationToken authenticationToken = (AuthenticationToken) token;
        String username = authenticationToken.getUsername();
        String password = new String(authenticationToken.getPassword());
        String captchaId = authenticationToken.getCaptchaId();
        String captcha = authenticationToken.getCaptcha();
        if (!captchaService.isValid(CaptchaType.adminLogin, captchaId, captcha)) {
            throw new UnsupportedTokenException();
        }
        /* if (!captchaService.isValid(CaptchaType.peerUserLogin, captchaId, captcha)) {
            throw new UnsupportedTokenException();
        }
        if (username != null && password != null) {
            Admin admin = adminService.findByUsername(username);
            if (admin == null) {
                throw new UnknownAccountException();
            }
            if (!admin.getIsEnabled()) {
                throw new DisabledAccountException();
            }
            if (!MD5Util.MD5(password).equals(admin.getPassword().toUpperCase())) {
                throw new IncorrectCredentialsException();
            }
            Dept dept=deptMapper.findCountryNameById(admin.getDeptId());
            String userImage=dept.getCountryId();
            return new SimpleAuthenticationInfo(new Principal(admin.getId(), username,userImage), password, getName());
        }*/
        if (username != null && password != null) {
            //Admin admin = adminService.findByUsername(username);
            PeerUser peeruser=peerUserService.findByName(username);
            /*if(admin!=null){
	            if (!admin.getIsEnabled()) {
	                throw new DisabledAccountException();
	            }
	            if (!MD5Util.MD5(password).equals(admin.getPassword().toUpperCase())) {
	                throw new IncorrectCredentialsException();
	            }
	            String type="Admin";
	            Dept dept=deptMapper.findCountryNameByIdForLogin(admin.getDeptId());
	            String userImage=dept.getCountryId();
	            return new SimpleAuthenticationInfo(new Principal(admin.getId(), username,userImage,type), password, getName());
	        }else{*/
            if (peeruser == null) {
                    throw new UnknownAccountException();
                }
                if (peeruser.getIsAvailable()!=0) {
                    throw new DisabledAccountException();
                }
                if (!MD5Util.MD5(password).equals(peeruser.getPassword().toUpperCase())) {
                    throw new IncorrectCredentialsException();
                }
                String type="PeerUser";
                Vender vender=venderService.findById(peeruser.getPeerId());
                Dept dept=deptMapper.findCountryNameById(vender.getDeptId());
                String userImage=dept.getCountryId();
                return new SimpleAuthenticationInfo(new Principal(peeruser.getPeerUserId(), username,userImage,type), password, getName());
	        }
        //}
        throw new UnknownAccountException();
    }

    /**
     * 获取授权信息
     *
     * @param principals principals
     * @return 授权信息
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        Principal principal = (Principal) principals.fromRealm(getName()).iterator().next();
        if (principal != null) {
            List<String> authorities = adminService.findAuthorities(principal.getId());
            if (authorities != null) {
                SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
                authorizationInfo.addStringPermissions(authorities);
                return authorizationInfo;
            }
        }
        return null;
    }

}