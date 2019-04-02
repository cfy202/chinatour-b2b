package com.chinatour.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import sun.awt.PeerEvent;

import com.chinatour.entity.CustomerSource;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.OptionalExcurition;
import com.chinatour.entity.Order;
import com.chinatour.entity.Statistical;
import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.entity.Vender;


/**
 * 统计mapper
 * @copyright   Copyright: 2015
 * @author Aries
 * @create-time Jan 13, 2015 14:28:51 PM
 * @revision  3.0
 */

@Repository
public interface StatisticalMapper extends BaseMapper<Statistical, String> {
	List<Statistical> queryBookingStatistical(@Param("record") Statistical statistical);
	List<Statistical> queryArrivalStatistical(@Param("record") Statistical statistical);
	List<Statistical> queryBookingStatisticalOP(@Param("record") Statistical statistical);
	List<Statistical> queryArrivalStatisticalOP(@Param("record") Statistical statistical);
	/**收客统计*/
	List<Statistical> queryBookingBrand(@Param("record") Statistical statistical);
	List<Statistical> queryBookingDept(@Param("record") Statistical statistical);
	List<Vender> queryBookingPeer(@Param("record") Vender vender);
	List<GroupLine> queryBookingProduct(@Param("record") GroupLine groupLine);
	List<Order> queryTourBookingB(@Param("record") Order order);
	List<Order> queryOtherTourBooking(@Param("record") Order order);
	
	/**收客报表导出统计*/
	List<Statistical> queryStatisticalReport(@Param("record") Statistical statistical);
	List<Statistical> queryStatisticalReportArrival(@Param("record") Statistical statistical);
	List<Dept> queryStatisticalReportDept(@Param("record") Statistical statistical);
	
	/**发客统计*/
	List<Statistical> queryArrivalBrand(@Param("record") Statistical statistical);
	List<Statistical> queryArrivalDept(@Param("record") Statistical statistical);
	List<Vender> queryArrivalPeer(@Param("record") Vender vender);
	List<GroupLine> queryArrivalProduct(@Param("record") GroupLine groupLine);
	List<Order> queryTourBooking(@Param("record") Order order);
	List<Statistical> findBookingSource(Statistical statistical);
	List<Statistical> findArrivalSource(Statistical statistical);
	List<Statistical> findSourceName(Statistical statistical);
	List<SupplierPriceForOrder> queryFlight(SupplierPriceForOrder so);
	List<SupplierPriceForOrder> queryFlightAirline(SupplierPriceForOrder so);
	
	/**
	 * 机票按供应商统计
	 */
	List<SupplierPriceForOrder> queryFlightbyVender(SupplierPriceForOrder so);
	
	/**
	 * optional Tour下单时间统计
	 */
	List<OptionalExcurition> queryBookingOptional(@Param("record") OptionalExcurition optionalExcurition);
	/**
	 * optional Tour抵达日期统计
	 */
	List<OptionalExcurition> queryArrivalOptional(@Param("record") OptionalExcurition optionalExcurition);
}
