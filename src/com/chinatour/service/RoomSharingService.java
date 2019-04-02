package com.chinatour.service;



import java.util.List;

import com.chinatour.entity.RoomSharing;



/**
 * 
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2015-4-17 下午2:03:02
 * @revision  3.0
 */

public interface RoomSharingService extends BaseService<RoomSharing, String> {

	List<RoomSharing> findRoomList();


}