package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.BusinessFlow;
import com.chinatour.entity.StatisticalProfit;

public interface BusinessFlowService extends BaseService<BusinessFlow, String> {
	List<StatisticalProfit> sumPayCostOfMonth(List<StatisticalProfit> statisticalProfitList);
	//获取一个区域的报表收支信息
	List<StatisticalProfit> getStatisticalProfitList(List<String> deptIdList,String year);
	
	void insertBatch(List<BusinessFlow> businessFlowList);
	
	List<BusinessFlow> searchBusinessFlowOfDept(BusinessFlow businessFlow);
	
	List<StatisticalProfit> sumPayCostOfMonthByHO(StatisticalProfit statisticalProfit);
}
