/**
 * 
 */
package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.PeerUserRate;
import com.chinatour.persistence.NewsMapper;
import com.chinatour.persistence.PeerUserRateMapper;
import com.chinatour.service.PeerUserRateService;


/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-06-25 上午09：50：00
 * @revision  3.0
 */
@Service("peerUserRateServiceImpl")
public class PeerUserRateServiceImpl extends BaseServiceImpl<PeerUserRate,String> implements PeerUserRateService {
	
	@Autowired
	private PeerUserRateMapper peerUserRateMapper;
	
	@Autowired
	public void setBaseMapper(PeerUserRateMapper peerUserRateMapper) {
	    	super.setBaseMapper(peerUserRateMapper);
	}

	@Override
	public PeerUserRate getRate(PeerUserRate peerUserRate) {
		return peerUserRateMapper.getRate(peerUserRate);
	}

}
