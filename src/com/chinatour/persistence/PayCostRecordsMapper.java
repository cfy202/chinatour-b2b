package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.PayCostRecords;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 12, 2014 5:25:25 PM
 * @revision  3.0
 */

@Repository
public interface PayCostRecordsMapper extends BaseMapper<PayCostRecords, String> {
	
	/**
	 * 根据订单ID查找出PayCostRecoreds
	 * @return
	 */
	public List<PayCostRecords> findByOrderId(String orderId);

	public List<PayCostRecords> findForGroupPage(@Param("record")PayCostRecords payCostRecords,
			@Param("page")Pageable pageable);

	public int findForGroupPageCount(@Param("record")PayCostRecords payCostRecords,
			@Param("page")Pageable pageable);
	
	public List<PayCostRecords> findCostForPage(@Param("record")PayCostRecords payCostRecords,
			@Param("page")Pageable pageable);
	
	public int findCostForPageCount(@Param("record")PayCostRecords payCostRecords,
			@Param("page")Pageable pageable);
	
	public List<PayCostRecords> findPayOrCostByOrders(PayCostRecords payCostRecords);
}
