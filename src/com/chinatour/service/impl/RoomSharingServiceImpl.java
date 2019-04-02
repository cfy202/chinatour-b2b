package com.chinatour.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.RoomSharing;
import com.chinatour.persistence.RoomSharingMapper;
import com.chinatour.service.RoomSharingService;

@Service("roomSharingServiceImpl")
public class RoomSharingServiceImpl extends
		BaseServiceImpl<RoomSharing, String> implements RoomSharingService {

	@Autowired
	private RoomSharingMapper roomSharingMapper;

	@Autowired
	public void setBaseMapper(RoomSharingMapper roomSharingMapper) {
		super.setBaseMapper(roomSharingMapper);
	}

	@Override
	public List<RoomSharing> findRoomList() {
		return roomSharingMapper.findRoomList();
	}

}