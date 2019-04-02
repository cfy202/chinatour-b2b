package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.RoomSharing;

@Repository
public interface RoomSharingMapper  extends BaseMapper<RoomSharing, String> {

	List<RoomSharing> findRoomList();

}