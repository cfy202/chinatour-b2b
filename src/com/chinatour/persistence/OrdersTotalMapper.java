
package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.OrdersTotal;

/**
 * Dao  订单总表
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-25 下午4:26:24
 * @revision  3.0
 */
@Repository
public interface OrdersTotalMapper extends BaseMapper<OrdersTotal, String> {
	
	void changeTotalPeople(@Param("change")int change,@Param("id")String id);
	
	List<OrdersTotal> findForGroupPage(@Param("record") OrdersTotal ordersTotal, @Param("page") Pageable pageable);
	
	int findForGroupPageCount(@Param("record") OrdersTotal ordersTotal, @Param("page") Pageable pageable);

	List<OrdersTotal> findOrderTotalTaxPage(@Param("record")OrdersTotal ordersTotal,
			@Param("page")Pageable pageable);

	int findOrderTotalTaxPageCount(@Param("record")OrdersTotal ordersTotal, @Param("page")Pageable pageable);

	List<OrdersTotal> findOrderOfRegionPage(@Param("record")OrdersTotal ordersTotal,
			@Param("page")Pageable pageable);

	int findOrderOfRegionPageCount(@Param("record")OrdersTotal ordersTotal, @Param("page")Pageable pageable);

	OrdersTotal findOrderTotalSumPepole(OrdersTotal ordersTotal);

	OrdersTotal findGroupOrderTotalSumPepole(OrdersTotal ordersTotal);

	OrdersTotal findRegionOrderTotalSumPepole(OrdersTotal ordersTotal);

	List<OrdersTotal> findOrderTotalTaxGroupPage(@Param("record")OrdersTotal ordersTotal,
			@Param("page")Pageable pageable);

	int findOrderTotalTaxGroupPageCount(@Param("record")OrdersTotal ordersTotal,
			@Param("page")Pageable pageable);
	
	List<OrdersTotal> find(@Param("record") OrdersTotal ordersTotal);

	OrdersTotal findSumPepoleAndPayOrCost(OrdersTotal ordersTotal);

	List<OrdersTotal> findOrderTotalTaxPrint(OrdersTotal ordersTotal);
	
	void setTotalPeopleByOrdersTotalId(@Param("totalPeople")int totalPeople,@Param("ordersTotalId")String ordersTotalId);

	OrdersTotal findGroupSumPepoleAndPayOrCost(OrdersTotal ordersTotal);

	List<OrdersTotal> findGroupOrderTotalTaxPrint(OrdersTotal ordersTotal);
	/**
	 * 根据同行用户Id删除总订单信息
	 * */
	void deleteByOrdersTotalId(String ordersTotalId);
	List<OrdersTotal> findNoOrderId(String peerUserId);
	
	OrdersTotal findByOrderId(String orderNo);//根据orderNO进行查找ordersTotal
}
