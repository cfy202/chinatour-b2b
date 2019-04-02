package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.chinatour.Pageable;
import com.chinatour.entity.Order;
import com.chinatour.entity.Tour;

@Repository
public interface TourMapper extends BaseMapper<Tour, String> {
	
	Tour findByTourCode(String tourCode);

	void changeTotalPeople(@Param("change")int change,@Param("tourId")String tourId);
	
	List<Tour> findForGroupPage(@Param("record") Tour tour, @Param("page") Pageable pageable);
	
	int findForGroupPageCount(@Param("record") Tour tour, @Param("page") Pageable pageable);

	Tour findAllCheckByTourId(String tourId);

	List<Tour> findTourOfRegionPage(@Param("record")Tour tour,@Param("page") Pageable pageable);

	int findTourOfRegionPageCount(@Param("record")Tour tour,@Param("page") Pageable pageable);

	int findTourOfOrderPageCount(@Param("record")Tour tour,@Param("page") Pageable pageable);

	List<Tour> findTourOfOrderPage(@Param("record")Tour tour,@Param("page") Pageable pageable);

	List<Tour> findTourOfGroupPage(@Param("record")Tour tour,@Param("page")Pageable pageable);

	int findTourOfGroupPageCount(@Param("record")Tour tour,@Param("page") Pageable pageable);

	List<Tour> findTourOfUserForPage(@Param("record")Tour tour, @Param("page")Pageable pageable);

	int findTourOfUserForPageCount(@Param("record")Tour tour,@Param("page") Pageable pageable);

	Tour findTourOfOrderSumPepole(Tour tour);

	Tour findTourOfGroupSumPepole(Tour tour);

	Tour findTourOfRegionSumPepole(Tour tour);
	
	List<Tour> findList(Tour tour);
	
	List<Tour> findListForSingle(Tour tour);
	
	List<Tour> findListForTour(Tour tour);

	Tour findTourOfUserSumPepole(Tour tour);
}
