package com.chinatour.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.chinatour.entity.FlightPriceInfo;
import com.chinatour.entity.HotelPriceInfo;
import com.chinatour.entity.InsurancePriceInfo;
import com.chinatour.entity.Order;
import com.chinatour.entity.PayCostRecords;
import com.chinatour.entity.SupPriceInfoRel;
import com.chinatour.entity.SupplierCheck;
import com.chinatour.entity.SupplierOfAgent;
import com.chinatour.entity.SupplierOfOrder;
import com.chinatour.entity.SupplierPrice;
import com.chinatour.entity.SupplierPriceInfo;
import com.chinatour.vo.CustomerOrderVO;

/**
 * Service 账单供应商
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午11:00:23
 * @revision 3.0
 */
public interface SupPriceInfoRelService extends
		BaseService<SupPriceInfoRel, String> {

	/**
	 * 账单保存
	 * 
	 * @param supplierPrice 团账单
	 * @param supPriceInfoRel	账单供应商
	 * @param supplierOfAgentList	Agent团账单供应商
	 * @param supplierCheckList		Agent账单审核
	 * @param supplierPriceInfoList	地接社
	 * @param hotelPriceInfoList	酒店
	 * @param flightPriceInfoList	机票
	 * @param insurancePriceInfoList	保险
	 * @param supplierOfOrderList	Agent团账单供应商订单
	 */
	public void save(SupplierPrice supplierPrice,
			SupPriceInfoRel supPriceInfoRel,
			List<SupplierOfAgent> supplierOfAgentList,
			List<SupplierCheck> supplierCheckList,
			List<SupplierPriceInfo> supplierPriceInfoList,
			List<HotelPriceInfo> hotelPriceInfoList,
			List<FlightPriceInfo> flightPriceInfoList,
			List<InsurancePriceInfo> insurancePriceInfoList,
			List<SupplierOfOrder> supplierOfOrderList);

	public List<SupPriceInfoRel> find(SupPriceInfoRel supPriceInfoRel);

	public List<CustomerOrderVO> findCustomerByTourId(String tourId);
	
	/**
	 * 账单保存
	 * @param supplierPrice 团账单
	 * @param supPriceInfoRel	账单供应商
	 * @param supplierOfAgentList	Agent团账单供应商
	 * @param supplierCheckList		Agent账单审核
	 * @param supplierPriceInfoList	地接社
	 * @param hotelPriceInfoList	酒店
	 * @param flightPriceInfoList	机票
	 * @param insurancePriceInfoList	保险
	 * @param supplierOfOrderList	Agent团账单供应商订单
	 * @param orderList	订单
	 */
	public void updateSupplier(SupplierPrice supplierPrice,
			SupPriceInfoRel supPriceInfoRel,
			List<SupplierOfAgent> supplierOfAgentList,
			List<SupplierCheck> supplierCheckList,
			List<SupplierPriceInfo> supplierPriceInfoList,
			List<HotelPriceInfo> hotelPriceInfoList,
			List<FlightPriceInfo> flightPriceInfoList,
			List<InsurancePriceInfo> insurancePriceInfoList,
			List<SupplierOfOrder> supplierOfOrderList, List<Order> orderList);

	/**
	 * 查询 团下的供应商
	 * @param tourId
	 * @return
	 */
	public List<SupPriceInfoRel> findSupplierByTourId(String tourId);
	
	/**
	 * 删除账单内容
	 * @param supPriceInfoRel
	 */
	
	public void deleteSupplier(SupPriceInfoRel supPriceInfoRel);

	public List<SupPriceInfoRel> findSupplierOfOrderOfTour(
			SupPriceInfoRel supPriceInfoRel);

	/**
	 * 修改账单
	 * agent 审核账单
	 * @param supplierPrice
	 * @param supplierCheckList
	 * @param payCostRecordsList
	 */
	public void updateSupplierCheck(SupplierPrice supplierPrice,
			List<SupplierCheck> supplierCheckList,
			List<PayCostRecords> payCostRecordsList);
}
