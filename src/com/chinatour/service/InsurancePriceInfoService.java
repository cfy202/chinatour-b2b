package com.chinatour.service;


import java.util.List;

import com.chinatour.entity.InsurancePriceInfo;


/**
 * Service 团账单保险
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-23 下午3:53:26
 * @revision 3.0
 */
public interface InsurancePriceInfoService extends
		BaseService<InsurancePriceInfo, String> {

	List<InsurancePriceInfo> findInsuranceAndCustomer(InsurancePriceInfo insurancePriceInfo);

}
