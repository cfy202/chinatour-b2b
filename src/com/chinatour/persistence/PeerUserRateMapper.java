package com.chinatour.persistence;

import java.util.List;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.entity.PeerUserRate;


/**
 * @copyright   Copyright: 2015
 * @author Aries
 * @create-time 2015-06-25 上午09：52：00
 * @revision  3.0
 */

@Repository
public interface PeerUserRateMapper extends BaseMapper<PeerUserRate, String> {
	PeerUserRate getRate(@Param("record")PeerUserRate peerUserRate);
}