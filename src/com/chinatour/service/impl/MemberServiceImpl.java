/*
 * Copyright 2005-2013 shopxx.net. All rights reserved.
 * Support: http://www.shopxx.net
 * License: http://www.shopxx.net/license
 */
package com.chinatour.service.impl;

import com.chinatour.Principal;
import com.chinatour.Setting;
import com.chinatour.entity.Admin;
import com.chinatour.entity.Member;
import com.chinatour.persistence.MemberMapper;
import com.chinatour.service.MemberService;
import com.chinatour.util.SettingUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Service - 会员
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("memberServiceImpl")
public class MemberServiceImpl extends BaseServiceImpl<Member, String> implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    public void setBaseMapper(MemberMapper memberMapper) {
        super.setBaseMapper(memberMapper);
    }

    @Transactional(readOnly = true)
    public boolean usernameExists(String username) {
        return memberMapper.usernameExists(username);
    }

    @Transactional(readOnly = true)
    public boolean usernameDisabled(String username) {
        Assert.hasText(username);
        Setting setting = SettingUtils.get();
        if (setting.getDisabledUsernames() != null) {
            for (String disabledUsername : setting.getDisabledUsernames()) {
                if (StringUtils.containsIgnoreCase(username, disabledUsername)) {
                    return true;
                }
            }
        }
        return false;
    }

    @Transactional(readOnly = true)
    public boolean emailExists(String email) {
        return memberMapper.emailExists(email);
    }

    @Transactional(readOnly = true)
    public boolean emailUnique(String previousEmail, String currentEmail) {
        if (StringUtils.equalsIgnoreCase(previousEmail, currentEmail)) {
            return true;
        } else {
            if (memberMapper.emailExists(currentEmail)) {
                return false;
            } else {
                return true;
            }
        }
    }

    public void save(Member member, Admin operator) {
        Assert.notNull(member);
        memberMapper.save(member);
    }

    public void update(Member member, Integer modifyPoint, BigDecimal modifyBalance, String depositMemo, Admin operator) {
        Assert.notNull(member);

        memberMapper.update(member);
    }

    @Transactional(readOnly = true)
    public Member findByUsername(String username) {
        return memberMapper.findByUsername(username);
    }

    @Transactional(readOnly = true)
    public List<Member> findListByEmail(String email) {
        return memberMapper.findListByEmail(email);
    }

    @Transactional(readOnly = true)
    public List<Object[]> findPurchaseList(Date beginDate, Date endDate, Integer count) {
        return memberMapper.findPurchaseList(beginDate, endDate, count);
    }

    @Transactional(readOnly = true)
    public boolean isAuthenticated() {
        RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
            Principal principal = (Principal) request.getSession().getAttribute(Member.PRINCIPAL_ATTRIBUTE_NAME);
            if (principal != null) {
                return true;
            }
        }
        return false;
    }

    @Transactional(readOnly = true)
    public Member getCurrent() {
        RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
            Principal principal = (Principal) request.getSession().getAttribute(Member.PRINCIPAL_ATTRIBUTE_NAME);
            if (principal != null) {
                return memberMapper.findById(principal.getId());
            }
        }
        return null;
    }

    @Transactional(readOnly = true)
    public String getCurrentUsername() {
        RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
        if (requestAttributes != null) {
            HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();
            Principal principal = (Principal) request.getSession().getAttribute(Member.PRINCIPAL_ATTRIBUTE_NAME);
            if (principal != null) {
                return principal.getUsername();
            }
        }
        return null;
    }

}