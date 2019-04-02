package com.chinatour.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Page;
import com.chinatour.Pageable;
import com.chinatour.entity.CustomerSource;
import com.chinatour.entity.Dept;
import com.chinatour.entity.GroupLine;
import com.chinatour.entity.OptionalExcurition;
import com.chinatour.entity.Order;
import com.chinatour.entity.StasticAccount;
import com.chinatour.entity.State;
import com.chinatour.entity.Statistical;
import com.chinatour.entity.SupplierPriceForOrder;
import com.chinatour.entity.Tour;
import com.chinatour.entity.Vender;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.StateMapper;
import com.chinatour.persistence.StatisticalMapper;
import com.chinatour.persistence.SupplierPriceForOrderMapper;
import com.chinatour.service.StateService;
import com.chinatour.service.StatisticalService;

/**
 * @copyright Copyright: 2015
 * @author Aries
 * @create-time Jan 13, 2015 14:39:22 PM
 * @revision 3.0
 */

@Service("statisticalServiceImpl")
public class StatisticalServiceImpl extends BaseServiceImpl<Statistical, String> implements StatisticalService {
	
	@Autowired
	private StatisticalMapper statisticalMapper;
	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private DeptMapper deptMapper;
	
	@Autowired
	private SupplierPriceForOrderMapper supplierPriceForOrderMapper;
	
	/**
	 *根据返回List写入相应的月份
	 * */
	private Statistical getMonthStatic(List<Statistical> statisticalList){
		Statistical statistical=new Statistical();
		int total=0;
		for(int i=0;i<statisticalList.size();i++){
			if(statisticalList.get(i).getTime().equals("01")){
				statistical.setJan(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("02")){
				statistical.setFeb(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("03")){
				statistical.setMar(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("04")){
				statistical.setApr(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("05")){
				statistical.setMay(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("06")){
				statistical.setJun(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("07")){
				statistical.setJul(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("08")){
				statistical.setAug(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("09")){
				statistical.setSep(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("10")){
				statistical.setOct(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("11")){
				statistical.setNov(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}else{
				statistical.setDec(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
		}
		statistical.setDeptId(statisticalList.get(0).getDeptId());
		statistical.setDeptName(statisticalList.get(0).getDeptName());
		statistical.setBrand(statisticalList.get(0).getBrand());
		statistical.setDate(statisticalList.get(0).getDate());
		statistical.setTotal(total);
		return statistical;
	}
	/**
	 * 收客人数统计（按月统计）
	 * */
	@Override
	public List<Statistical> queryBookingStatistical(Statistical statistical) {
		return statisticalMapper.queryBookingStatistical(statistical);
	}
	/**
	 * 发客人数统计（按月统计）
	 * */
	@Override
	public List<Statistical> queryArrivalStatistical(Statistical statistical) {
		return statisticalMapper.queryArrivalStatistical(statistical);
	}
	/**
	 * 收客人数统计OP（按月统计）
	 * */
	@Override
	public List<Statistical> queryBookingStatisticalOP(Statistical statistical) {
		return statisticalMapper.queryBookingStatisticalOP(statistical);
	}
	/**
	 * 发客人数统计OP（按月统计）
	 * */
	@Override
	public List<Statistical> queryArrivalStatisticalOP(Statistical statistical) {
		return statisticalMapper.queryArrivalStatisticalOP(statistical);
	}
	@Override
	public Statistical queryBookingStatisticalL(Statistical statistical) {
		List<Statistical> list=statisticalMapper.queryBookingStatistical(statistical);
		statistical=new Statistical();
		int total=0;
		for(int i=0;i<list.size();i++){
			if(list.get(i).getTime().equals("01")){
				statistical.setJan(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("02")){
				statistical.setFeb(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("03")){
				statistical.setMar(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("04")){
				statistical.setApr(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("05")){
				statistical.setMay(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("06")){
				statistical.setJun(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("07")){
				statistical.setJul(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("08")){
				statistical.setAug(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("09")){
				statistical.setSep(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("10")){
				statistical.setOct(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("11")){
				statistical.setNov(list.get(i).getSum());
				total+=list.get(i).getSum();
			}else{
				statistical.setDec(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
		}
		statistical.setTotal(total);
		return statistical;
	}
	@Override
	public Statistical queryArrivalStatisticalL(Statistical statistical) {
		List<Statistical> list=statisticalMapper.queryArrivalStatistical(statistical);
		statistical=new Statistical();
		int total=0;
		for(int i=0;i<list.size();i++){
			if(list.get(i).getTime().equals("01")){
				statistical.setJan(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("02")){
				statistical.setFeb(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("03")){
				statistical.setMar(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("04")){
				statistical.setApr(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("05")){
				statistical.setMay(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("06")){
				statistical.setJun(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("07")){
				statistical.setJul(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("08")){
				statistical.setAug(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("09")){
				statistical.setSep(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("10")){
				statistical.setOct(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("11")){
				statistical.setNov(list.get(i).getSum());
				total+=list.get(i).getSum();
			}else{
				statistical.setDec(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
		}
		statistical.setTotal(total);
		return statistical;
	}
	@Override
	public Statistical queryBookingStatisticalOPL(Statistical statistical) {
		List<Statistical> list=statisticalMapper.queryBookingStatisticalOP(statistical);
		statistical=new Statistical();
		int total=0;
		for(int i=0;i<list.size();i++){
			if(list.get(i).getTime().equals("01")){
				statistical.setJan(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("02")){
				statistical.setFeb(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("03")){
				statistical.setMar(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("04")){
				statistical.setApr(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("05")){
				statistical.setMay(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("06")){
				statistical.setJun(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("07")){
				statistical.setJul(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("08")){
				statistical.setAug(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("09")){
				statistical.setSep(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("10")){
				statistical.setOct(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("11")){
				statistical.setNov(list.get(i).getSum());
				total+=list.get(i).getSum();
			}else{
				statistical.setDec(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
		}
		statistical.setTotal(total);
		return statistical;
	}
	@Override
	public Statistical queryArrivalStatisticalOPL(Statistical statistical) {
		List<Statistical> list=statisticalMapper.queryArrivalStatisticalOP(statistical);
		statistical=new Statistical();
		int total=0;
		for(int i=0;i<list.size();i++){
			if(list.get(i).getTime().equals("01")){
				statistical.setJan(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("02")){
				statistical.setFeb(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("03")){
				statistical.setMar(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("04")){
				statistical.setApr(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("05")){
				statistical.setMay(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("06")){
				statistical.setJun(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("07")){
				statistical.setJul(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("08")){
				statistical.setAug(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("09")){
				statistical.setSep(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("10")){
				statistical.setOct(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
			else if(list.get(i).getTime().equals("11")){
				statistical.setNov(list.get(i).getSum());
				total+=list.get(i).getSum();
			}else{
				statistical.setDec(list.get(i).getSum());
				total+=list.get(i).getSum();
			}
		}
		statistical.setTotal(total);
		return statistical;
	}
	/**
	 * 根据品牌
	 * */
	@Override
	public Statistical queryBookingBrand(Statistical statistical) {
		List<Statistical> statisticalList = statisticalMapper.queryBookingBrand(statistical);
		if(statisticalList.size()==0){
			statisticalList.add(statistical);
		}
		return getMonthStatic(statisticalList);
	}
	/**
	 * 根据部门统计
	 * */
	@Override
	public Statistical queryBookingDept(Statistical statistical) {
		List<Statistical> statisticalList = statisticalMapper.queryBookingDept(statistical);
		if(statisticalList.size()==0){
			statisticalList.add(statistical);
		}
		return getMonthStatic(statisticalList);
	}
	@Override
	public List<Vender> queryBookingPeer(Vender vender) {
		List<Vender> venderList=statisticalMapper.queryBookingPeer(vender);
		return venderList;
	}
	@Override
	public List<GroupLine> queryBookingProduct(GroupLine groupLine) {
		return statisticalMapper.queryBookingProduct(groupLine);
	}
	/**品牌发客统计*/
	@Override
	public Statistical queryArrivalBrand(Statistical statistical) {
		List<Statistical> statisticalList = statisticalMapper.queryArrivalBrand(statistical);
		if(statisticalList.size()==0){
			statisticalList.add(statistical);
		}
		return getMonthStatic(statisticalList);
	}
	/**公司发客统计*/
	@Override
	public Statistical queryArrivalDept(Statistical statistical) {
		List<Statistical> statisticalList = statisticalMapper.queryArrivalDept(statistical);
		if(statisticalList.size()==0){
			statisticalList.add(statistical);
		}
		return getMonthStatic(statisticalList);
	}
	/**同行发客统计*/
	@Override
	public List<Vender> queryArrivalPeer(Vender vender) {
		return statisticalMapper.queryArrivalPeer(vender);
	}
	/**产品发客统计*/
	@Override
	public List<GroupLine> queryArrivalProduct(GroupLine groupLine) {
		return statisticalMapper.queryArrivalProduct(groupLine);
	}
	/**团订单统计*/
	@Override
	public List<Order> queryTourBooking(Order order) {
		return statisticalMapper.queryTourBooking(order);
	}
	@Override
	public List<Order> queryOtherTourBooking(Order order) {
		return statisticalMapper.queryOtherTourBooking(order);
	}
	/**
	 * 订单详情(同行,团队--发客)
	 * */
	@Override
	public Page<Order> orderDetails(Order order, Pageable pageable) {
		List<Order> orderList=orderMapper.orderDetailsPage(order, pageable);
		if (pageable == null) {
			pageable = new Pageable();
		}
		int pageCount = orderMapper.orderDetailsPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}
	@Override
	public Page<Order> orderDetailsT(Order order, Pageable pageable) {
		List<Order> orderList=orderMapper.orderDetailsTPage(order, pageable);
		if (pageable == null) {
			pageable = new Pageable();
		}
		int pageCount = orderMapper.orderDetailsTPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}
	@Override
	public Page<Order> orderDetailsB(Order order, Pageable pageable) {
		List<Order> orderList=orderMapper.orderDetailsBPage(order, pageable);
		if (pageable == null) {
			pageable = new Pageable();
		}
		int pageCount = orderMapper.orderDetailsBPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}
	@Override
	public Page<Order> orderDetailsBT(Order order, Pageable pageable) {
		List<Order> orderList=orderMapper.orderDetailsBTPage(order, pageable);
		if (pageable == null) {
			pageable = new Pageable();
		}
		int pageCount = orderMapper.orderDetailsBTPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}
	@Override
	public Order detailsCount(Order order) {
		return orderMapper.detailsCount(order);
	}
	@Override
	public Order detailsCountT(Order order) {
		return orderMapper.detailsCountT(order);
	}
	@Override
	public Order detailsCountB(Order order) {
		return orderMapper.detailsCountB(order);
	}
	@Override
	public Order detailsCountBT(Order order) {
		return orderMapper.detailsCountBT(order);
	}
	/**
	 * 同行，团订单（收客统计）
	 * */
	@Override
	public List<Order> queryTourBookingB(Order order) {
		return statisticalMapper.queryTourBookingB(order);
	}
	@Override
	public List<Order> detailsPrint(Order order) {
		return orderMapper.detailsPrint(order);
	}
	@Override
	public List<Order> detailsTPrint(Order order) {
		return orderMapper.detailsTPrint(order);
	}
	@Override
	public List<Order> detailsBPrint(Order order) {
		return orderMapper.detailsBPrint(order);
	}
	@Override
	public List<Order> detailsBTPrint(Order order) {
		return orderMapper.detailsBTPrint(order);
	}
	@Override
	public List<Order> detailsOptionalPrint(Order order) {
		return orderMapper.detailsOptionalPrint(order);
	}
	@Override
	public List<Order> detailsOptionalPrintForArrival(Order order) {
		return orderMapper.detailsOptionalPrintForArrival(order);
	}
	@Override
	public Statistical findBookingSource(Statistical statistical) {
		List<Statistical> statisticalList = statisticalMapper.findBookingSource(statistical);
		if(statisticalList.size()==0){
			statisticalList.add(statistical);
		}
		return getMonth(statisticalList);
	}
	@Override
	public List<Statistical> findSourceName(Statistical statistical) {
		return statisticalMapper.findSourceName(statistical);
	}
	@Override
	public Statistical findArrivalSource(Statistical statistical) {
		List<Statistical> statisticalList = statisticalMapper.findArrivalSource(statistical);
		if(statisticalList.size()==0){
			statisticalList.add(statistical);
		}
		return getMonth(statisticalList);
	}
	@Override
	public Page<Order> sourceDetailsS(Order order, Pageable pageable) {
		List<Order> orderList=orderMapper.sourceDetailsSPage(order, pageable);
		if (pageable == null) {
			pageable = new Pageable();
		}
		int pageCount = orderMapper.sourceDetailsSPageCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}
	@Override
	public Order detailsCountS(Order order) {
		return orderMapper.detailsCountS(order);
	}
	/**
	 *根据返回List写入相应的月份
	 * */
	private Statistical getMonth(List<Statistical> statisticalList){
		Statistical statistical=new Statistical();
		int total=0;
		for(int i=0;i<statisticalList.size();i++){
			if(statisticalList.get(i).getTime().equals("01")){
				statistical.setJan(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("02")){
				statistical.setFeb(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("03")){
				statistical.setMar(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("04")){
				statistical.setApr(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("05")){
				statistical.setMay(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("06")){
				statistical.setJun(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("07")){
				statistical.setJul(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("08")){
				statistical.setAug(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("09")){
				statistical.setSep(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("10")){
				statistical.setOct(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
			else if(statisticalList.get(i).getTime().equals("11")){
				statistical.setNov(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}else{
				statistical.setDec(statisticalList.get(i).getSum());
				total+=statisticalList.get(i).getSum();
			}
		}
		statistical.setDeptId(statisticalList.get(0).getDeptId());
		statistical.setDeptName(statisticalList.get(0).getDeptName());
		statistical.setSource(statisticalList.get(0).getSource());
		statistical.setTotal(total);
		return statistical;
	}
	@Override
	public List<Order> detailsSPrint(Order order) {
		return orderMapper.detailsSPrint(order);
	}
	@Override
	public List<SupplierPriceForOrder> queryFlight(SupplierPriceForOrder so) {
		return statisticalMapper.queryFlight(so);
	}
	@Override
	public List<SupplierPriceForOrder> queryFlightAirline(SupplierPriceForOrder so) {
		return statisticalMapper.queryFlightAirline(so);
	}
	@Override
	public List<SupplierPriceForOrder> queryFlightbyVender(SupplierPriceForOrder so) {
		return statisticalMapper.queryFlightbyVender(so);
	}
	@Override
	public SupplierPriceForOrder ticketCount(SupplierPriceForOrder so) {
		return supplierPriceForOrderMapper.findAirPepoleStatistical(so);
	}
	@Override
	public Page<SupplierPriceForOrder> ticketPage(SupplierPriceForOrder so,
			Pageable pageable) {
		if (pageable == null) {
		    pageable = new Pageable();
		}
		List<SupplierPriceForOrder> page = supplierPriceForOrderMapper.findForStatisticalPage(so, pageable);
		int pageCount = supplierPriceForOrderMapper.findForStatisticalCount(so,pageable);
		return new Page<SupplierPriceForOrder>(page, pageCount, pageable);
	}
	@Override
	public List<SupplierPriceForOrder> findForStatisticalPrint(
			SupplierPriceForOrder so) {
		return supplierPriceForOrderMapper.findForStatisticalPrint(so);
	}
	@Override
	public List<OptionalExcurition> queryBookingOptional(OptionalExcurition excurition) {
		return statisticalMapper.queryBookingOptional(excurition);
	}
	@Override
	public Order detailsCountOptional(Order order) {
		return orderMapper.detailsCountOptional(order);
	}
	@Override
	public Page<Order> orderDetailsByOptional(Order order, Pageable pageable) {
		List<Order> orderList=orderMapper.orderDetailsOptional(order, pageable);
		if (pageable == null) {
			pageable = new Pageable();
		}
		int pageCount = orderMapper.orderDetailsOptioanlCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}
	@Override
	public List<OptionalExcurition> queryArrivalOptional(OptionalExcurition excurition) {
		return statisticalMapper.queryArrivalOptional(excurition);
	}
	@Override
	public Order detailsCountOptionalForArrival(Order order) {
		return orderMapper.detailsCountOptionalForArrival(order);
	}
	@Override
	public Page<Order> ArrivalDetailsByOptional(Order order, Pageable pageable) {
		List<Order> orderList=orderMapper.ArrivalDetailsByOptional(order, pageable);
		if (pageable == null) {
			pageable = new Pageable();
		}
		int pageCount = orderMapper.ArrivalDetailsOptioanlCount(order, pageable);
		return new Page<Order>(orderList, pageCount, pageable);
	}

	@Override
	public List<Dept> queryStatisticalReportDept(Statistical statistical) {
		return statisticalMapper.queryStatisticalReportDept(statistical);
	}
	
	
	/**
	 * @param accountRecord
	 * @return
	 */
	@Transactional
	public List<Statistical> getStatisticalReport(Statistical statistical,ArrayList<String>  year){
		List<Statistical> listStatistical= null;
		if(statistical.getIsSelfOrganize()==0){
			listStatistical=statisticalMapper.queryStatisticalReport(statistical);
		}else{
			listStatistical=statisticalMapper.queryStatisticalReportArrival(statistical);
		}
		List<Dept> listDept=statisticalMapper.queryStatisticalReportDept(statistical);
		List<Statistical> list=new ArrayList<Statistical>();
		for(int n=0;n<year.size();n++){
			for(Dept d:listDept){
				Statistical sMonth=new Statistical();
				sMonth.setDeptName(d.getDeptName());
				sMonth.setDate(year.get(n));
				sMonth.setAgent(statistical.getAgent());
				sMonth.setBrand(statistical.getBrand());
				for(Statistical row:listStatistical){
					if(row.getDeptId().equals(d.getDeptId())&&year.get(n).equals(row.getDate())){
						if(row.getTime().equals("01")){
							sMonth.setJan(row.getSum());
						}
						if(row.getTime().equals("02")){
							sMonth.setFeb(row.getSum());
						}
						if(row.getTime().equals("03")){
							sMonth.setMar(row.getSum());
						}
						if(row.getTime().equals("04")){
							sMonth.setApr(row.getSum());
						}
						if(row.getTime().equals("05")){
							sMonth.setMay(row.getSum());
						}
						if(row.getTime().equals("06")){
							sMonth.setJun(row.getSum());
						}
						if(row.getTime().equals("07")){
							sMonth.setJul(row.getSum());
						}
						if(row.getTime().equals("08")){
							sMonth.setAug(row.getSum());
						}
						if(row.getTime().equals("09")){
							sMonth.setSep(row.getSum());
						}
						if(row.getTime().equals("10")){
							sMonth.setOct(row.getSum());
						}
						if(row.getTime().equals("11")){
							sMonth.setNov(row.getSum());
						}
						if(row.getTime().equals("12")){
							sMonth.setDec(row.getSum());
						}
						sMonth.setTotal(sMonth.getTotal()+row.getSum());	
						sMonth.setVenderName(row.getVenderName());
					}
				}
				list.add(sMonth);
			}
		}
		return list;
	}
}
