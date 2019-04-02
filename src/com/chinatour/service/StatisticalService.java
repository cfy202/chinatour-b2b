package com.chinatour.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.AccountRecord;
import com.chinatour.entity.AccountRow;
import com.chinatour.entity.CustomerSource;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.MonthAccountRecord;
import com.chinatour.entity.OptionalExcurition;
import com.chinatour.entity.Order;
import com.chinatour.entity.StasticAccount;
import com.chinatour.entity.State;
import com.chinatour.entity.Statistical;
import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.entity.Vender;


/**
 * 统计
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time Jan 13, 2015 14:34:33 PM
 * @revision  3.0
 */
public interface StatisticalService extends BaseService<Statistical, String> {
	/**
	 * 收客人数统计(按月统计)
	 * */
	List<Statistical> queryBookingStatistical(Statistical statistical);
	/**
	 * 发客人数统计(按月统计)
	 * */
	List<Statistical> queryArrivalStatistical(Statistical statistical);
	/**
	 * 收客人数统计OP(按月统计)
	 * */
	List<Statistical> queryBookingStatisticalOP(Statistical statistical);
	/**
	 * 发客人数统计OP(按月统计)
	 * */
	List<Statistical> queryArrivalStatisticalOP(Statistical statistical);
	
	/**
	 * 收客人数统计(按月统计)
	 * */
	Statistical queryBookingStatisticalL(Statistical statistical);
	/**
	 * 发客人数统计(按月统计)
	 * */
	Statistical queryArrivalStatisticalL(Statistical statistical);
	
	/**
	 * 收客人数统计OP(按月统计)
	 * */
	Statistical queryBookingStatisticalOPL(Statistical statistical);
	/**
	 * 发客人数统计OP(按月统计)
	 * */
	Statistical queryArrivalStatisticalOPL(Statistical statistical);
	/**
	 * 品牌发客统计
	 * */
	Statistical queryBookingBrand(Statistical statistical);
	/**
	 * 公司发客统计
	 * */
	Statistical queryBookingDept(Statistical statistical);
	/**
	 * 同行发客统计
	 * */
	List<Vender> queryBookingPeer(Vender vender);
	/**
	 * 产品发客统计
	 * */
	List<GroupLine> queryBookingProduct(GroupLine groupLine);
	/**
	 * 品牌收客统计
	 * */
	Statistical queryArrivalBrand(Statistical statistical);
	/**
	 * 公司收客统计
	 * */
	Statistical queryArrivalDept(Statistical statistical);
	/**
	 * 同行收客统计
	 * */
	List<Vender> queryArrivalPeer(Vender vender);
	/**
	 * 产品收客统计
	 * */
	List<GroupLine> queryArrivalProduct(GroupLine groupLine);
	/**
	 * 团订单统计(发客)
	 * */
	List<Order> queryTourBooking(Order order);
	/**
	 * 团订单统计(收客)
	 * */
	List<Order> queryTourBookingB(Order order);
	/**
	 * 非 团订单统计
	 * */
	List<Order> queryOtherTourBooking(Order order);
	/**
	 * 订单详情(同行,团队--发客)
	 * */
	Page<Order> orderDetails(Order order,Pageable pageable);
	/**
	 * 订单详情(Product Brand--发客)
	 * */
	Page<Order> orderDetailsT(Order order,Pageable pageable);
	
	/**
	 * 订单详情(同行,团队--发客Booking)
	 * */
	Page<Order> orderDetailsB(Order order,Pageable pageable);
	/**
	 * 订单详情(Product Brand--发客Booking)
	 * */
	Page<Order> orderDetailsBT(Order order,Pageable pageable);
	/**
	 * 合计总数
	 * */
	Order detailsCount(Order order);
	Order detailsCountT(Order order);
	Order detailsCountB(Order order);
	Order detailsCountBT(Order order);
	/********************************/
	/**
	 * 打印统计详情
	 * */
	List<Order> detailsPrint(Order order);
	List<Order> detailsTPrint(Order order);
	List<Order> detailsBPrint(Order order);
	List<Order> detailsBTPrint(Order order);
	Statistical findBookingSource(Statistical statistical);
	List<Statistical> findSourceName(Statistical statistical);
	Statistical findArrivalSource(Statistical statistical);
	Page<Order> sourceDetailsS(Order order, Pageable pageable);
	Order detailsCountS(Order order);
	List<Order> detailsSPrint(Order order);
	List<SupplierPriceForOrder> queryFlight(SupplierPriceForOrder so);
	List<SupplierPriceForOrder> queryFlightAirline(SupplierPriceForOrder so);
	SupplierPriceForOrder ticketCount(SupplierPriceForOrder so);
	Page<SupplierPriceForOrder> ticketPage(SupplierPriceForOrder so,
			Pageable pageable);
	List<SupplierPriceForOrder> findForStatisticalPrint(SupplierPriceForOrder so);
	/**
	 * 机票按照供应商统计
	 */
	List<SupplierPriceForOrder> queryFlightbyVender(SupplierPriceForOrder so);
	/**
	 * optional Tour下单时间统计
	 */
	List<OptionalExcurition> queryBookingOptional(OptionalExcurition excurition);
	/**
	 * 按下单日期 统计optional Tour订单数量
	 */
	Order detailsCountOptional(Order order);
	
	Page<Order> orderDetailsByOptional(Order order,Pageable pageable);
	List<Order> detailsOptionalPrint(Order order);
	/**
	 * optional Tour抵达日期统计
	 */
	List<OptionalExcurition> queryArrivalOptional(OptionalExcurition excurition);
	/**
	 * optional Tour统计订单
	 */
	Order detailsCountOptionalForArrival(Order order);
	
	Page<Order> ArrivalDetailsByOptional(Order order,Pageable pageable);
	
	List<Order> detailsOptionalPrintForArrival(Order order);
	
	/**
	 * 统计报表导出
	 * */
	List<Dept> queryStatisticalReportDept(Statistical statistical);
	List<Statistical> getStatisticalReport(Statistical statistical,ArrayList<String>  year);
}
