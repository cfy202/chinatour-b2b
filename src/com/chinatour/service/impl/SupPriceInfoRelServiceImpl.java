package com.chinatour.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
import com.chinatour.persistence.FlightPriceInfoMapper;
import com.chinatour.persistence.HotelPriceInfoMapper;
import com.chinatour.persistence.InsurancePriceInfoMapper;
import com.chinatour.persistence.OrderMapper;
import com.chinatour.persistence.PayCostRecordsMapper;
import com.chinatour.persistence.SupPriceInfoRelMapper;
import com.chinatour.persistence.SupplierCheckMapper;
import com.chinatour.persistence.SupplierOfAgentMapper;
import com.chinatour.persistence.SupplierOfOrderMapper;
import com.chinatour.persistence.SupplierPriceInfoMapper;
import com.chinatour.persistence.SupplierPriceMapper;
import com.chinatour.service.SupPriceInfoRelService;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.vo.CustomerOrderVO;

/**
 * Service 账单供应商
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-10-22 上午11:06:19
 * @revision 3.0
 */

@Service("supPriceInfoRelServiceImpl")
public class SupPriceInfoRelServiceImpl extends
		BaseServiceImpl<SupPriceInfoRel, String> implements
		SupPriceInfoRelService {

	@Autowired
	private SupPriceInfoRelMapper supPriceInfoRelMapper;

	@Autowired
	private SupplierPriceMapper supplierPriceMapper;

	@Autowired
	private SupplierOfAgentMapper supplierOfAgentMapper;

	@Autowired
	private HotelPriceInfoMapper hotelPriceInfoMapper;

	@Autowired
	private SupplierPriceInfoMapper supplierPriceInfoMapper;

	@Autowired
	private FlightPriceInfoMapper flightPriceInfoMapper;

	@Autowired
	private InsurancePriceInfoMapper insurancePriceInfoMapper;

	@Autowired
	private SupplierOfOrderMapper supplierOfOrderMapper;

	@Autowired
	private SupplierCheckMapper supplierCheckMapper;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private PayCostRecordsMapper payCostRecordsMapper;
	
	@Autowired
	public void setBaseMapper(SupPriceInfoRelMapper suppriceinforelMapper) {
		super.setBaseMapper(suppriceinforelMapper);
	}

	public void save(SupplierPrice supplierPrice,
			SupPriceInfoRel supPriceInfoRel,
			List<SupplierOfAgent> supplierOfAgentList,
			List<SupplierCheck> supplierCheckList,
			List<SupplierPriceInfo> supplierPriceInfoList,
			List<HotelPriceInfo> hotelPriceInfoList,
			List<FlightPriceInfo> flightPriceInfoList,
			List<InsurancePriceInfo> insurancePriceInfoList,
			List<SupplierOfOrder> supplierOfOrderList) {

		if (supplierPrice.getSupplierPriceId() == null) {
			supplierPrice.setSupplierPriceId(UUIDGenerator.getUUID());
			supplierPriceMapper.save(supplierPrice);
		} else {
			// 只要按审核一次，更改为修更改状态
			if (supplierPrice.getAccCheck() != null
					&& supplierPrice.getAccCheck() != 0) {
				supplierPrice.setAllCheck(0);
				supplierPrice.setAccCheck(0);
			}
			supplierPriceMapper.update(supplierPrice);
		}

		supPriceInfoRelMapper.save(supPriceInfoRel);

		supplierOfAgentMapper.batchSave(supplierOfAgentList);
		
		if (hotelPriceInfoList != null) {
			hotelPriceInfoMapper.batchSave(hotelPriceInfoList);
		}

		if (supplierPriceInfoList != null) {
			supplierPriceInfoMapper.batchSave(supplierPriceInfoList);
		}

		if (flightPriceInfoList != null) {
			flightPriceInfoMapper.batchSave(flightPriceInfoList);
		}

		if (insurancePriceInfoList != null) {
			insurancePriceInfoMapper.batchSave(insurancePriceInfoList);
		}
		
		supplierOfOrderMapper.batchSave(supplierOfOrderList);
		
		//没有审核过添加新记录
		List<SupplierCheck> supplierCheckListS=new ArrayList<SupplierCheck>();
		
		for (int i = 0; i < supplierCheckList.size(); i++) {
			if (supplierCheckList.get(i).getSupplierCheckId() == null) {
				supplierCheckList.get(i).setSupplierCheckId(
						UUIDGenerator.getUUID());
				supplierCheckList.get(i).setSupplierPriceId(
						supplierPrice.getSupplierPriceId());
				supplierCheckListS.add(supplierCheckList.get(i));
			} else {

				// 只要按审核一次，更改为修更改状态
				supplierCheckList.get(i).setCheckOfAgent(0);
				supplierCheckMapper.update(supplierCheckList.get(i));
			}
		}
		if(supplierCheckListS.size()!=0){
			supplierCheckMapper.batchSave(supplierCheckListS);
		}
	}
	
	public void updateSupplier(SupplierPrice supplierPrice,
			SupPriceInfoRel supPriceInfoRel,
			List<SupplierOfAgent> supplierOfAgentList,
			List<SupplierCheck> supplierCheckList,
			List<SupplierPriceInfo> supplierPriceInfoList,
			List<HotelPriceInfo> hotelPriceInfoList,
			List<FlightPriceInfo> flightPriceInfoList,
			List<InsurancePriceInfo> insurancePriceInfoList,
			List<SupplierOfOrder> supplierOfOrderList, List<Order> orderList) {
		
		if(supplierPrice!=null){
			supplierPriceMapper.update(supplierPrice);
		}
		
		if(supPriceInfoRel!=null){
			supPriceInfoRelMapper.update(supPriceInfoRel);
		}
		
		if(supplierOfAgentList!=null){
			for(int i=0;i<supplierOfAgentList.size();i++){
				supplierOfAgentMapper.update(supplierOfAgentList.get(i));
			}
		}
		if(hotelPriceInfoList!=null){
			for(int i=0;i<hotelPriceInfoList.size();i++){
				hotelPriceInfoMapper.update(hotelPriceInfoList.get(i));
			}
		}
		
		if(supplierPriceInfoList!=null){
			for(int i=0;i<supplierPriceInfoList.size();i++){
				supplierPriceInfoMapper.update(supplierPriceInfoList.get(i));
			}
		}
		
		
		if(flightPriceInfoList!=null){
			for(int i=0;i<flightPriceInfoList.size();i++){
				flightPriceInfoMapper.update(flightPriceInfoList.get(i));
			}
		}
		
		if(insurancePriceInfoList!=null){
			for(int i=0;i<insurancePriceInfoList.size();i++){
				insurancePriceInfoMapper.update(insurancePriceInfoList.get(i));
			}
		}
		
		if(supplierOfOrderList!=null){
			for(SupplierOfOrder supplierOfOrder:supplierOfOrderList){
				supplierOfOrderMapper.update(supplierOfOrder);
			}
		}
		
		if(orderList!=null){
			for(Order order:orderList){
				orderMapper.update(order);
			}
		}
		
		if(supplierCheckList!=null){
			for(int i=0;i<supplierCheckList.size();i++){
				supplierCheckMapper.update(supplierCheckList.get(i));
			}
		}
	}
	
	/**
	 * 删除账单内容
	 * @param supPriceInfoRel
	 */
	
	@Transactional
	public void deleteSupplier(SupPriceInfoRel supPriceInfoRel){
		supPriceInfoRelMapper.removeById(supPriceInfoRel.getSupPriceInfoRelId());
		
		
		SupplierOfAgent supplierOfAgent = new SupplierOfAgent();
		supplierOfAgent.setSupPriceInfoRelId(supPriceInfoRel.getSupPriceInfoRelId());
		
		List<SupplierOfAgent> supplierOfAgentList = supplierOfAgentMapper.find(supplierOfAgent);
		for(int j=0;j<supplierOfAgentList.size();j++){
			if(supPriceInfoRel.getType()==1){
				SupplierPriceInfo supplierPriceInfo = new SupplierPriceInfo();
				supplierPriceInfo.setSupplierOfAgentId(supplierOfAgentList.get(j).getSupplierOfAgentId());
				List<SupplierPriceInfo> supplierPriceInfoList = supplierPriceInfoMapper.find(supplierPriceInfo);
				if(supplierPriceInfoList!=null&&supplierPriceInfoList.size()>0){
					String[] supplierPriceInfoIdS=new String[supplierPriceInfoList.size()];
					for(int i=0;i<supplierPriceInfoList.size();i++){
						supplierPriceInfoIdS[i]=supplierPriceInfoList.get(i).getSupplierPriceInfoId();
					}
					supplierPriceInfoMapper.removeByIds(supplierPriceInfoIdS);
				}
				
			}else if(supPriceInfoRel.getType()==2){
				HotelPriceInfo hotelPriceInfo = new HotelPriceInfo();
				hotelPriceInfo.setSupplierOfAgentId(supplierOfAgentList.get(j).getSupplierOfAgentId());
				List<HotelPriceInfo> hotelPriceInfoList = hotelPriceInfoMapper.find(hotelPriceInfo);
				if(hotelPriceInfoList!=null&&hotelPriceInfoList.size()>0){
					String[] hotelPriceInfoIdS=new String[hotelPriceInfoList.size()];
					for(int i=0;i<hotelPriceInfoList.size();i++){
						hotelPriceInfoIdS[i]=hotelPriceInfoList.get(i).getHotelPriceInfoId();
					}
					hotelPriceInfoMapper.removeByIds(hotelPriceInfoIdS);
				}
			}else if(supPriceInfoRel.getType()==3){
				FlightPriceInfo flightPriceInfo = new FlightPriceInfo();
				flightPriceInfo.setSupplierOfAgentId(supplierOfAgentList.get(j).getSupplierOfAgentId());
				List<FlightPriceInfo> flightPriceInfoList = flightPriceInfoMapper.find(flightPriceInfo);
				if(flightPriceInfoList!=null&&flightPriceInfoList.size()>0){
					String[] flightPriceInfoIdS=new String[flightPriceInfoList.size()];
					for(int i=0;i<flightPriceInfoList.size();i++){
						flightPriceInfoIdS[i]=flightPriceInfoList.get(i).getFlightPriceInfoId();
					}
					flightPriceInfoMapper.removeByIds(flightPriceInfoIdS);
				}
			}else if(supPriceInfoRel.getType()==4){
				InsurancePriceInfo insurancePriceInfo = new InsurancePriceInfo();
				insurancePriceInfo.setSupplierOfAgentId(supplierOfAgentList.get(j).getSupplierOfAgentId());
				List<InsurancePriceInfo> insurancePriceInfoList = insurancePriceInfoMapper.find(insurancePriceInfo);
				if(insurancePriceInfoList!=null&&insurancePriceInfoList.size()>0){
					String[] insurancePriceInfoIdS=new String[insurancePriceInfoList.size()];
					for(int i=0;i<insurancePriceInfoList.size();i++){
						insurancePriceInfoIdS[i]=insurancePriceInfoList.get(i).getInsurancePriceInfoId();
					}
					insurancePriceInfoMapper.removeByIds(insurancePriceInfoIdS);
				}
			}
			supplierOfAgentMapper.removeById(supplierOfAgentList.get(j).getSupplierOfAgentId());
		}
	}
	@Override
	public List<SupPriceInfoRel> find(SupPriceInfoRel supPriceInfoRel) {
		return supPriceInfoRelMapper.find(supPriceInfoRel);
	}

	@Override
	public List<CustomerOrderVO> findCustomerByTourId(String tourId) {
		return supPriceInfoRelMapper.findCustomerByTourId(tourId);
	}

	
	@Override
	public List<SupPriceInfoRel> findSupplierByTourId(String tourId) {
		return supPriceInfoRelMapper.findSupplierByTourId(tourId);
	}

	@Override
	public List<SupPriceInfoRel> findSupplierOfOrderOfTour(
			SupPriceInfoRel supPriceInfoRel) {
		return supPriceInfoRelMapper.findSupplierOfOrderOfTour(supPriceInfoRel);
	}
	
	@Transactional
	public void updateSupplierCheck(SupplierPrice supplierPrice,
			List<SupplierCheck> supplierCheckList,
			List<PayCostRecords> payCostRecordsList) {
		if(supplierPrice!=null){
			supplierPriceMapper.update(supplierPrice);
		}
		
		if(supplierCheckList!=null){
			for(int i=0;i<supplierCheckList.size();i++){
				supplierCheckMapper.update(supplierCheckList.get(i));
			}
		}
		
		if(payCostRecordsList!=null){
			for(int i=0;i<payCostRecordsList.size();i++){
				payCostRecordsMapper.save(payCostRecordsList.get(i));
			}
		}
	}

}