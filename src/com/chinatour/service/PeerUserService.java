package com.chinatour.service;

import java.util.List;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.PeerUser;
/**
 * Service - 同行用户
 * @copyright   Copyright: 2015
 * @author Aries
 * @create-time 2015-5-06 上午 11:52:20
 * @revision  3.0
 */

public interface PeerUserService extends BaseService<PeerUser, String> {
	public List<PeerUser> find(PeerUser peerUser);
	public PeerUser findByName(String peerUserName);
	public Page<PeerUser> findPage(PeerUser peerUser,Pageable pageable);
	/**
	 * 获得当前登录的用户
	 * */
	PeerUser getCurrent();
	int update(PeerUser peerUser);
	
	void save(PeerUser peerUser);
	public PeerUser findById(String peerUserId);
}