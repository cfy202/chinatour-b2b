/**
 * 
 */
package com.chinatour.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.RatePeer;
import com.chinatour.persistence.RatePeerMapper;
import com.chinatour.service.RatePeerService;


/**
 * @copyright   Copyright: 2016 
 * @author Aries
 * @create-time 2016-3-29 下午2:26:01
 * @revision  3.0
 */
@Service("ratePeerServiceImpl")
public class RatePeerServiceImpl extends BaseServiceImpl<RatePeer,String> implements RatePeerService {
	@Autowired
	private RatePeerMapper ratePeerMapper;

	@Autowired
	public void setBaseMapper(RatePeerMapper ratePeerMapper){
		super.setBaseMapper(ratePeerMapper);
	}

	@Override
	public RatePeer findByCurrency(RatePeer patePeer) {
		return ratePeerMapper.findByCurrency(patePeer);
	}

}
