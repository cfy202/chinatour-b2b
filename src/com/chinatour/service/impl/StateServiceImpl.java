package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.State;
import com.chinatour.persistence.StateMapper;
import com.chinatour.service.StateService;

/**
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Aug 28, 2014 3:39:22 PM
 * @revision 3.0
 */

@Service("stateServiceImpl")
public class StateServiceImpl extends BaseServiceImpl<State, String> implements
		StateService {
	
	@Autowired
	private StateMapper stateMapper;
   
	/**
	 * StateMapper注入
	 * @param stateMapper
	 */
	@Autowired
	public void setStateMapper(StateMapper stateMapper) {
        super.setBaseMapper(stateMapper);
	}

	/* (non-Javadoc)
	 * @see com.chinatour.service.StateService#findByCountryId(java.lang.String)
	 */
	@Override
	public List<State> findByCountryId(String countryId) {
		return stateMapper.findByCountryId(countryId);
	}
}
