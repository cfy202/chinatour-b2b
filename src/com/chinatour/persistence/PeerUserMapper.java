package com.chinatour.persistence;


import java.util.List;
import org.springframework.stereotype.Repository;
import com.chinatour.entity.PeerUser;

/**
 * Dao - 同行用户
 * @copyright   Copyright: 2015
 * @author Aries
 * @create-time 2015-5-06 上午 11:52:20
 * @revision  3.0
 */

@Repository
public interface PeerUserMapper extends BaseMapper<PeerUser, String> {
	PeerUser findByName(String peerUserName);
}