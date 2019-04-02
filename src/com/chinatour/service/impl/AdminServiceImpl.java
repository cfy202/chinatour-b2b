package com.chinatour.service.impl;

/**
 * Created by XuXuebin on 2014/7/9.
 */

import com.chinatour.Principal;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AdminGroup;
import com.chinatour.entity.AdminRole;
import com.chinatour.entity.Role;
import com.chinatour.persistence.AdminGroupMapper;
import com.chinatour.persistence.AdminMapper;
import com.chinatour.service.AdminService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Service - 管理员
 *
 * @author SHOP++ Team
 * @version 3.0
 */
@Service("adminServiceImpl")
public class AdminServiceImpl extends BaseServiceImpl<Admin, String> implements AdminService {

    @Autowired
    private AdminMapper adminMapper;
    
    @Autowired
    private AdminGroupMapper adminGroupMapper;

    @Autowired
    public void setBaseMapper(AdminMapper adminMapper) {
        super.setBaseMapper(adminMapper);
    }

    @Transactional(readOnly = true)
    public boolean usernameExists(String username) {
        return adminMapper.usernameExists(username) > 0;
    }

    @Transactional(readOnly = true)
    public Admin findByUsername(String username) {
        return adminMapper.findByUsername(username);
    }

    @Transactional(readOnly = true)
    public List<String> findAuthorities(String id) {
        List<String> authorities = new ArrayList<String>();
        Admin admin = adminMapper.findByIdForRole(id);
        if (admin != null) {
        	Set roleSet=admin.getAdminRoles();
        	Iterator iterator=roleSet.iterator();
    		while (iterator.hasNext()) {
    			AdminRole adminRole = (AdminRole) iterator.next();
    			//判断是否分配权限
    			if(adminRole.getRole()!=null&&adminRole.getRole().getAuthorities()!=null){
    				authorities.addAll(adminRole.getRole().getAuthorities());
    			}
    			
    		}
        }
        return authorities;
    }

    @Transactional(readOnly = true)
    public boolean isAuthenticated() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null) {
            return subject.isAuthenticated();
        }
        return false;
    }

    @Transactional(readOnly = true)
    public Admin getCurrent() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null) {
            Principal principal = (Principal) subject.getPrincipal();
            if (principal != null) {
            	AdminGroup adminGroup=adminGroupMapper.findByAdminId(principal.getId());
            	Admin admin=adminMapper.findById(principal.getId());
            	if(adminGroup!=null){
            		admin.setGroupId(adminGroup.getGroupId());
            	}
                return admin;
            }
        }
        return null;
    }

    @Transactional(readOnly = true)
    public String getCurrentUsername() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null) {
            Principal principal = (Principal) subject.getPrincipal();
            if (principal != null) {
                return principal.getUsername();
            }
        }
        return null;
    }

    @Override
    @Transactional(readOnly = true)
    public Admin findByIdAndRole(String id) {
        return adminMapper.findByIdAndRole(id);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void save(Admin admin) {
        super.save(admin);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public int update(Admin admin) {
        return super.update(admin);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(String id) {
        super.delete(id);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(String... ids) {
        super.delete(ids);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(Admin admin) {
        super.delete(admin);
    }

	@Override
	public List<Admin> find(Admin admin) {
		return adminMapper.find(admin);
	}

	@Override
	public List<Admin> findAllOfDeptName() {
		return adminMapper.findAllOfDeptName();
	}

}