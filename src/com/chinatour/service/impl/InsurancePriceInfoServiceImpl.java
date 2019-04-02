package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.InsurancePriceInfo;
import com.chinatour.service.InsurancePriceInfoService;
import com.chinatour.persistence.InsurancePriceInfoMapper;

/**
 * Service 团账单 保险
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision 3.0
 */

@Service("insurancePriceInfoServiceImpl")
public class InsurancePriceInfoServiceImpl extends
		BaseServiceImpl<InsurancePriceInfo, String> implements
		InsurancePriceInfoService {

	@Autowired
	private InsurancePriceInfoMapper insurancePriceInfoMapper;

	@Autowired
	public void setBaseMapper(InsurancePriceInfoMapper insurancePriceInfoMapper) {
		super.setBaseMapper(insurancePriceInfoMapper);
	}

	@Override
	public List<InsurancePriceInfo> findInsuranceAndCustomer(
			InsurancePriceInfo insurancePriceInfo) {
		return insurancePriceInfoMapper.findInsuranceAndCustomer(insurancePriceInfo);
	}


}