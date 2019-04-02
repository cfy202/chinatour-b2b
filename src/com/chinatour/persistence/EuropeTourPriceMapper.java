package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.EuropeTourPrice;
import com.chinatour.entity.Order;

@Repository
public interface EuropeTourPriceMapper extends BaseMapper<EuropeTourPrice, String> {
	List<EuropeTourPrice> findByTourId(String tourId);
	List<EuropeTourPrice> findDeptsByTourId(String tourId);
	List<EuropeTourPrice> findForAgentPage(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	int findForAgentPageCount(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	List<EuropeTourPrice> findForAccOPPage(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	int findForAccOPPageCount(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	List<EuropeTourPrice> findForOPAccPage(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	int findForOPAccPageCount(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	int findSumForAgent(String userIdForOrder);
	int findCount(EuropeTourPrice europeTourPrice);
	List<EuropeTourPrice> findForGroupPage(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	int findForGroupPageCount(@Param("record")EuropeTourPrice europeTourPrice, @Param("page")Pageable pageable);
	
}
