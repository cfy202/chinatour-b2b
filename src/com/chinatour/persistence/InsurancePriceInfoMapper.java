package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.InsurancePriceInfo;

/**
 * Dao--团账单中保险信息
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午10:08:47
 * @revision 3.0
 */
@Repository
public interface InsurancePriceInfoMapper extends
		BaseMapper<InsurancePriceInfo, String> {

	List<InsurancePriceInfo> findInsuranceAndCustomer(
			InsurancePriceInfo insurancePriceInfo);

	void batchSave(List<InsurancePriceInfo> insurancePriceInfoList);

}