package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.BusinessFlow;
import com.chinatour.entity.StatisticalProfit;
import com.chinatour.entity.TabRecord;
@Repository
public interface BusinessFlowMapper extends BaseMapper<BusinessFlow, String> {
	
	List<TabRecord> sumPayCostOfMonth(StatisticalProfit statisticalProfit);
	
	void insertBatch(List<BusinessFlow> businessFlowList);
	
	List<BusinessFlow> queryBusinessFlowOfDept(BusinessFlow businessFlow);
}
