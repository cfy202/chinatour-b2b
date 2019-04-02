package com.chinatour.service.impl;

import java.util.ArrayList;

import java.util.List;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.Principal;
import com.chinatour.entity.Admin;
import com.chinatour.entity.AdminGroup;
import com.chinatour.entity.PeerUser;
import com.chinatour.persistence.PeerUserMapper;
import com.chinatour.service.PeerUserService;
import com.chinatour.vo.TourOrderListVO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
/**
 * Service - 同行用户
 * @copyright   Copyright: 2015
 * @author Aries
 * @create-time 2015-5-06 上午 11:52:20
 * @revision  3.0
 */

@Service("peerUserServiceImpl")
public class PeerUserServiceImpl extends BaseServiceImpl<PeerUser, String> implements PeerUserService {
	
	@Autowired
	private PeerUserMapper peerUserMapper;
	
	@Override
	public List<PeerUser> find(PeerUser peerUser) {
		return peerUserMapper.find(peerUser);
	}

	@Override
	public PeerUser findByName(String peerUserName) {
		return peerUserMapper.findByName(peerUserName);
	}
	/**
	 * 获得当前的用户信息
	 * */
	 @Transactional(readOnly = true)
	public PeerUser getCurrent() {
		 /*Subject subject =SecurityUtils.getSubject();
			if(subject!=null){
				 Principal principal = (Principal) subject.getPrincipal();
		            if (principal != null) {
		            	PeerUser peerUser=peerUserMapper.findById(principal.getId());
		                return peerUser;
		            }
			}
			return null;*/
			org.springframework.web.context.request.RequestAttributes requestAttributes = RequestContextHolder.currentRequestAttributes();
			if (requestAttributes != null) {
				javax.servlet.http.HttpServletRequest request = ((org.springframework.web.context.request.ServletRequestAttributes) requestAttributes).getRequest();
				Principal principal = (Principal) request.getSession().getAttribute("peerUser");
				if (principal != null) {
					return peerUserMapper.findById(principal.getId());
				}
			}
			return null;
	}
	 
	 @Override
	 @Transactional
	 public Page<PeerUser> findPage(PeerUser peerUser,Pageable pageable){
		 List<PeerUser> peerUserList = new ArrayList<PeerUser>();
				if (pageable == null) {
					pageable = new Pageable();
				}
				int pageCount = peerUserMapper.findForPageCount(peerUser);
				
				peerUserList = peerUserMapper.findForPage(peerUser, pageable);
				return new Page<PeerUser>(peerUserList, pageCount, pageable);
	 }
	 
	 @Override
	 @Transactional
	 public void save(PeerUser peerUser){
		 peerUserMapper.save(peerUser);
	 }
	 @Override
	 @Transactional
	 public PeerUser findById(String peerUserId){
		 return peerUserMapper.findById(peerUserId);
	 }
	 
	 @Override
	 @Transactional
	 public int update(PeerUser peerUser){
		 return peerUserMapper.update(peerUser);
	 }

}