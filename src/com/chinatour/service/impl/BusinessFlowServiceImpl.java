package com.chinatour.service.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.BusinessFlow;
import com.chinatour.entity.Dept;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.SmallGroup;
import com.chinatour.entity.StatisticalProfit;
import com.chinatour.entity.TabRecord;
import com.chinatour.persistence.BusinessFlowMapper;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.RateOfCurrencyMapper;
import com.chinatour.persistence.RegionDeptRelMapper;
import com.chinatour.persistence.SmallGroupMapper;
import com.chinatour.service.AdminService;
import com.chinatour.service.BusinessFlowService;
@Service("businessFlowServiceImpl")
public class BusinessFlowServiceImpl extends BaseServiceImpl<BusinessFlow, String> implements BusinessFlowService {
	@Autowired
	public void setBusinessFlowMapper(BusinessFlowMapper businessFlowMapper){
		this.setBaseMapper(businessFlowMapper);
	}
	@Autowired
	private BusinessFlowMapper businessFlowMapper;
	@Autowired
	private RegionDeptRelMapper regionDeptRelMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private RateOfCurrencyMapper  rateOfCurrencyMapper;
	@Autowired
	private SmallGroupMapper  smallGroupMapper;
	@Autowired
	private AdminService  adminService;
	
	
	
	@Override
	public List<StatisticalProfit> sumPayCostOfMonth(List<StatisticalProfit> statisticalProfitList) {
		
		List<StatisticalProfit> list=new ArrayList<StatisticalProfit>();
		List<Dept> listDept = new ArrayList<Dept>();
		for(StatisticalProfit statisticalProfit:statisticalProfitList){
			Dept dept = deptMapper.findById(statisticalProfit.getDeptId());
			listDept.add(dept);
		}
		StatisticalProfit sp = null;
		StatisticalProfit total = new StatisticalProfit();
		total.setDeptName("GrandTotal($):");
		for(Dept d:listDept){
			sp=new StatisticalProfit();
			sp.setTime(statisticalProfitList.get(0).getTime());
			sp.setDeptId(d.getDeptId());
			sp.setDeptName(d.getDeptName());
			list.add(getPayCostOfMonth(sp,total));
		}
		
		list.add(total);
		return list;
	}


	@Override
	public List<StatisticalProfit> getStatisticalProfitList(
			List<String> deptIdList,String year) {
		if(year==null||year.equals("")){
			Date date = new Date();
			SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd");
			year = simpleDateFormat.format(date).substring(0,4);
		}
		List<TabRecord> tabRecordList = new ArrayList<TabRecord>();
		List<StatisticalProfit> statisticalProfitist = new ArrayList<StatisticalProfit>();
		
		for(String deptId:deptIdList){
			BigDecimal totalIncome = new BigDecimal(0);
			BigDecimal totalCost = new BigDecimal(0);
			BigDecimal totalProfit = new BigDecimal(0);
			StatisticalProfit statisticalProfit = new StatisticalProfit();
			statisticalProfit.setDeptId(deptId);
			Dept dept = deptMapper.findById(statisticalProfit.getDeptId());
			statisticalProfit.setDeptName(dept.getDeptName());
			statisticalProfit.setTime(year);
			RateOfCurrency rateOfCurrency= new RateOfCurrency();
			rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
			List<RateOfCurrency> rateOfCurrencyList = rateOfCurrencyMapper.find(rateOfCurrency);
			rateOfCurrency = rateOfCurrencyList.get(0);
			tabRecordList = businessFlowMapper.sumPayCostOfMonth(statisticalProfit);
			for(TabRecord tabRecord:tabRecordList){
				tabRecord.setIncome(tabRecord.getIncome().divide(rateOfCurrency.getUsRate(),2,BigDecimal.ROUND_HALF_UP));
				tabRecord.setCost(tabRecord.getCost().divide(rateOfCurrency.getUsRate(),2,BigDecimal.ROUND_HALF_UP));
				tabRecord.setProfit(tabRecord.getIncome().subtract(tabRecord.getCost()));
				totalIncome = totalIncome.add(tabRecord.getIncome());
				totalCost = totalCost.add(tabRecord.getCost());
				totalProfit = totalProfit.add(tabRecord.getProfit());
				int time = tabRecord.getTime().intValue();
				switch (time){ 
				case 1 : statisticalProfit.setJan(tabRecord);
				break; 

				case 2 : statisticalProfit.setFeb(tabRecord);
				break;
				
				case 3 : statisticalProfit.setMar(tabRecord);
				break; 

				case 4 : statisticalProfit.setApr(tabRecord);
				break;
				
				case 5 : statisticalProfit.setMay(tabRecord);
				break; 

				case 6 : statisticalProfit.setJun(tabRecord);
				break;
				
				case 7 : statisticalProfit.setJul(tabRecord);
				break; 

				case 8 : statisticalProfit.setAug(tabRecord);
				break;
				
				case 9 : statisticalProfit.setSep(tabRecord);
				break; 

				case 10 : statisticalProfit.setOct(tabRecord);
				break;
				
				case 11 : statisticalProfit.setNov(tabRecord);
				break;
				
				case 12 : statisticalProfit.setDec(tabRecord);
				break;
				} 
				statisticalProfit.setTotalIncome(totalIncome);
				statisticalProfit.setTotalCost(totalCost);
				statisticalProfit.setTotalProfit(totalProfit);
			}
			statisticalProfitist.add(statisticalProfit);
		}
		return statisticalProfitist;
	}


	@Override
	public void insertBatch(List<BusinessFlow> businessFlowList) {
		businessFlowMapper.insertBatch(businessFlowList);
	}


	@Override
	public List<BusinessFlow> searchBusinessFlowOfDept(BusinessFlow businessFlow) {
		return businessFlowMapper.queryBusinessFlowOfDept(businessFlow);
	}


	@Override
	public List<StatisticalProfit> sumPayCostOfMonthByHO(
			StatisticalProfit statisticalProfit) {
		List<StatisticalProfit> list=new ArrayList<StatisticalProfit>();
		StatisticalProfit sp = null;
		StatisticalProfit total = new StatisticalProfit();
		total.setChildAccDept("100");
		List<SmallGroup> groupList = smallGroupMapper.findByDeptId(statisticalProfit.getDeptId());
		for(SmallGroup smallGroup:groupList){
			sp=new StatisticalProfit();
			sp.setTime(statisticalProfit.getTime());
			sp.setDeptId(statisticalProfit.getDeptId());
			sp.setDeptName(statisticalProfit.getDeptName());
			sp.setChildAccDept(smallGroup.getGroupId());
			sp.setChildAccDeptName(smallGroup.getName());
			list.add(getPayCostOfMonth(sp,total));
		}
		list.add(total);
		return list;
	}
	
	private StatisticalProfit getPayCostOfMonth(StatisticalProfit statisticalProfit,StatisticalProfit total){
		RateOfCurrency rateOfCurrency= new RateOfCurrency();
		Dept dept = deptMapper.findById(statisticalProfit.getDeptId());
		rateOfCurrency.setCurrencyId(dept.getCurrencyTypeId());
		List<RateOfCurrency> rateOfCurrencyList = rateOfCurrencyMapper.find(rateOfCurrency);
		rateOfCurrency = rateOfCurrencyList.get(0);
		List<TabRecord>	listTabRecord=businessFlowMapper.sumPayCostOfMonth(statisticalProfit);
		TabRecord totalTabRecord =new TabRecord();
		DecimalFormat df1 = new DecimalFormat("0.00");
		BigDecimal salesincomeDollar =null;
		BigDecimal tourcostDollar =null;
		BigDecimal incomeDollar =null;
		BigDecimal costDollar =null;
		BigDecimal profitDollar =null;
		BigDecimal zero = new BigDecimal(0.00);
		BigDecimal totalSalesIncome = new BigDecimal(0);
		BigDecimal totalTourCost = new BigDecimal(0);
		BigDecimal totalIncome = new BigDecimal(0);
		BigDecimal totalCost = new BigDecimal(0);
		BigDecimal totalProfit = new BigDecimal(0);
		BigDecimal grandTotalSalesIncome = new BigDecimal(0);
		BigDecimal grandTotalTourCost = new BigDecimal(0);
		BigDecimal grandTotalIncome = new BigDecimal(0);
		BigDecimal grandTotalCost = new BigDecimal(0);
		BigDecimal grandTotalProfit = new BigDecimal(0);
		for(TabRecord t:listTabRecord){
			if(t!=null){
				totalSalesIncome = totalSalesIncome.add(t.getSalesIncome().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP));
				totalTourCost = totalTourCost.add(t.getTourCost().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP));
				totalIncome = totalIncome.add(t.getIncome().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP));
				totalCost = totalCost.add(t.getCost().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP));
				totalProfit = totalIncome.subtract(totalCost);
				grandTotalSalesIncome = grandTotalSalesIncome.add(totalSalesIncome);
				grandTotalTourCost = grandTotalTourCost.add(totalTourCost);
				grandTotalIncome = grandTotalIncome.add(totalIncome);
				grandTotalCost = grandTotalCost.add(totalCost);
				grandTotalProfit = grandTotalIncome.subtract(grandTotalCost);
				salesincomeDollar=t.getSalesIncome().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP);
				tourcostDollar=t.getTourCost().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP);
				t.setSalesIncome(salesincomeDollar);
				t.setTourCost(tourcostDollar);
				incomeDollar=t.getIncome().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP);
				costDollar=t.getCost().divide(rateOfCurrency.getUsRate(),2 ,BigDecimal.ROUND_HALF_UP);
				t.setIncome(incomeDollar);
				t.setCost(costDollar);
				profitDollar=incomeDollar.subtract(costDollar);
				t.setProfit(profitDollar);
				
				int time = Integer.parseInt(t.getTime().toString());
				switch(time){
				case 1:
					statisticalProfit.setJan(t);
					total.getJan().setSalesIncome(total.getJan().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getJan().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getJan().setTourCost(total.getJan().getTourCost() == null ? zero : t.getTourCost().add(total.getJan().getTourCost()));
					total.getJan().setIncome(total.getJan().getIncome() == null ? zero : t.getIncome().add(total.getJan().getIncome()));
					total.getJan().setCost(total.getJan().getCost() == null ? zero : t.getCost().add(total.getJan().getCost()));
					total.getJan().setProfit(total.getJan().getProfit() == null ? zero : t.getProfit().add(total.getJan().getProfit()));
					break;
				case 2:
					statisticalProfit.setFeb(t);
					total.getFeb().setSalesIncome(total.getFeb().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getFeb().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getFeb().setTourCost(total.getFeb().getTourCost() == null ? zero : t.getTourCost().add(total.getFeb().getTourCost()));
					total.getFeb().setIncome(total.getFeb().getIncome() == null ? zero : t.getIncome().add(total.getFeb().getIncome()));
					total.getFeb().setCost(total.getFeb().getCost() == null ? zero : t.getCost().add(total.getFeb().getCost()));
					total.getFeb().setProfit(total.getFeb().getProfit() == null ? zero : t.getProfit().add(total.getFeb().getProfit()));
					break;
				case 3:
					statisticalProfit.setMar(t);
					total.getMar().setSalesIncome(total.getMar().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getMar().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getMar().setTourCost(total.getMar().getTourCost() == null ? zero : t.getTourCost().add(total.getMar().getTourCost()));
					total.getMar().setIncome(total.getMar().getIncome() == null ? zero : t.getIncome().add(total.getMar().getIncome()));
					total.getMar().setCost(total.getMar().getCost() == null ? zero : t.getCost().add(total.getMar().getCost()));
					total.getMar().setProfit(total.getMar().getProfit() == null ? zero : t.getProfit().add(total.getMar().getProfit()));
					break;
				case 4:
					statisticalProfit.setApr(t);
					total.getApr().setSalesIncome(total.getApr().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getApr().getSalesIncome().setScale(2, BigDecimal.ROUND_HALF_UP)));
					total.getApr().setTourCost(total.getApr().getTourCost() == null ? zero : t.getTourCost().add(total.getApr().getTourCost()));
					total.getApr().setIncome(total.getApr().getIncome() == null ? zero : t.getIncome().add(total.getApr().getIncome()));
					total.getApr().setCost(total.getApr().getCost() == null ? zero : t.getCost().add(total.getApr().getCost()));
					total.getApr().setProfit(total.getApr().getProfit() == null ? zero : t.getProfit().add(total.getApr().getProfit()));
					break;
				case 5:
					statisticalProfit.setMay(t);
					total.getMay().setSalesIncome(total.getMay().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getMay().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getMay().setTourCost(total.getMay().getTourCost() == null ? zero : t.getTourCost().add(total.getMay().getTourCost()));
					total.getMay().setIncome(total.getMay().getIncome() == null ? zero : t.getIncome().add(total.getMay().getIncome()));
					total.getMay().setCost(total.getMay().getCost() == null ? zero : t.getCost().add(total.getMay().getCost()));
					total.getMay().setProfit(total.getMay().getProfit() == null ? zero : t.getProfit().add(total.getMay().getProfit()));
					break;
				case 6:
					statisticalProfit.setJun(t);
					total.getJun().setSalesIncome(total.getJun().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getJun().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getJun().setTourCost(total.getJun().getTourCost() == null ? zero : t.getTourCost().add(total.getJun().getTourCost()));
					total.getJun().setIncome(total.getJun().getIncome() == null ? zero : t.getIncome().add(total.getJun().getIncome()));
					total.getJun().setCost(total.getJun().getCost() == null ? zero : t.getCost().add(total.getJun().getCost()));
					total.getJun().setProfit(total.getJun().getProfit() == null ? zero : t.getProfit().add(total.getJun().getProfit()));
					break;
				case 7:
					statisticalProfit.setJul(t);
					total.getJul().setSalesIncome(total.getJul().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getJul().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getJul().setTourCost(total.getJul().getTourCost() == null ? zero : t.getTourCost().add(total.getJul().getTourCost()));
					total.getJul().setIncome(total.getJul().getIncome() == null ? zero : t.getIncome().add(total.getJul().getIncome()));
					total.getJul().setCost(total.getJul().getCost() == null ? zero : t.getCost().add(total.getJul().getCost()));
					total.getJul().setProfit(total.getJul().getProfit() == null ? zero : t.getProfit().add(total.getJul().getProfit()));
					break;
				case 8:
					statisticalProfit.setAug(t);
					total.getAug().setSalesIncome(total.getAug().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getAug().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getAug().setTourCost(total.getAug().getTourCost() == null ? zero : t.getTourCost().add(total.getAug().getTourCost()));
					total.getAug().setIncome(total.getAug().getIncome() == null ? zero : t.getIncome().add(total.getAug().getIncome()));
					total.getAug().setCost(total.getAug().getCost() == null ? zero : t.getCost().add(total.getAug().getCost()));
					total.getAug().setProfit(total.getAug().getProfit() == null ? zero : t.getProfit().add(total.getAug().getProfit()));
					break;
				case 9:
					statisticalProfit.setSep(t);
					total.getSep().setSalesIncome(total.getSep().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getSep().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getSep().setTourCost(total.getSep().getTourCost() == null ? zero : t.getTourCost().add(total.getSep().getTourCost()));
					total.getSep().setIncome(total.getSep().getIncome() == null ? zero : t.getIncome().add(total.getSep().getIncome()));
					total.getSep().setCost(total.getSep().getCost() == null ? zero : t.getCost().add(total.getSep().getCost()));
					total.getSep().setProfit(total.getSep().getProfit() == null ? zero : t.getProfit().add(total.getSep().getProfit()));
					break;
				case 10:
					statisticalProfit.setOct(t);
					total.getOct().setSalesIncome(total.getOct().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getOct().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getOct().setTourCost(total.getOct().getTourCost() == null ? zero : t.getTourCost().add(total.getOct().getTourCost()));
					total.getOct().setIncome(total.getOct().getIncome() == null ? zero : t.getIncome().add(total.getOct().getIncome()));
					total.getOct().setCost(total.getOct().getCost() == null ? zero : t.getCost().add(total.getOct().getCost()));
					total.getOct().setProfit(total.getOct().getProfit() == null ? zero : t.getProfit().add(total.getOct().getProfit()));
					break;
				case 11:
					statisticalProfit.setNov(t);
					total.getNov().setSalesIncome(total.getNov().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getNov().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getNov().setTourCost(total.getNov().getTourCost() == null ? zero : t.getTourCost().add(total.getNov().getTourCost()));
					total.getNov().setIncome(total.getNov().getIncome() == null ? zero : t.getIncome().add(total.getNov().getIncome()));
					total.getNov().setCost(total.getNov().getCost() == null ? zero : t.getCost().add(total.getNov().getCost()));
					total.getNov().setProfit(total.getNov().getProfit() == null ? zero : t.getProfit().add(total.getNov().getProfit()));
					break;
				case 12:
					statisticalProfit.setDec(t);
					total.getDec().setSalesIncome(total.getDec().getSalesIncome() == null ? zero : t.getSalesIncome().add(total.getDec().getSalesIncome()).setScale(2, BigDecimal.ROUND_HALF_UP));
					total.getDec().setTourCost(total.getDec().getTourCost() == null ? zero : t.getTourCost().add(total.getDec().getTourCost()));
					total.getDec().setIncome(total.getDec().getIncome() == null ? zero : t.getIncome().add(total.getDec().getIncome()));
					total.getDec().setCost(total.getDec().getCost() == null ? zero : t.getCost().add(total.getDec().getCost()));
					total.getDec().setProfit(total.getDec().getProfit() == null ? zero : t.getProfit().add(total.getDec().getProfit()));
					break;
				default:
					break;
				}
				totalTabRecord.setTime(t.getTime());
				totalTabRecord.setTourCost(totalTabRecord.getTourCost().add(t.getTourCost()));
				totalTabRecord.setSalesIncome(totalTabRecord.getSalesIncome().add(t.getSalesIncome()));
				totalTabRecord.setCost(totalTabRecord.getCost().add(t.getCost()));
				totalTabRecord.setIncome(totalTabRecord.getIncome().add(t.getIncome()));
			}
		}
		totalTabRecord.setProfit(totalTabRecord.getIncome().subtract(totalTabRecord.getCost()));
		statisticalProfit.setTotal(totalTabRecord);
		total.getTotal().setSalesIncome(total.getTotal().getSalesIncome() == null ? zero : totalTabRecord.getSalesIncome().add(total.getTotal().getSalesIncome()));
		total.getTotal().setTourCost(total.getTotal().getTourCost() == null ? zero : totalTabRecord.getTourCost().add(total.getTotal().getTourCost()));
		total.getTotal().setIncome(total.getTotal().getIncome() == null ? zero : totalTabRecord.getIncome().add(total.getTotal().getIncome()));
		total.getTotal().setCost(total.getTotal().getCost() == null ? zero : totalTabRecord.getCost().add(total.getTotal().getCost()));
		total.getTotal().setProfit(total.getTotal().getProfit() == null ? zero : totalTabRecord.getProfit().add(total.getTotal().getProfit()));
		total.setTotalSalesIncome(grandTotalSalesIncome);
		total.setTotalTourCost(grandTotalTourCost);
		total.setTotalIncome(grandTotalIncome);
		total.setTotalCost(grandTotalCost);
		total.setTotalProfit(grandTotalProfit);
		statisticalProfit.setTotalSalesIncome(totalSalesIncome.setScale(2, BigDecimal.ROUND_HALF_UP));
		statisticalProfit.setTotalTourCost(totalTourCost.setScale(2, BigDecimal.ROUND_HALF_UP));
		statisticalProfit.setTotalIncome(totalIncome.setScale(2, BigDecimal.ROUND_HALF_UP));
		statisticalProfit.setTotalCost(totalCost.setScale(2, BigDecimal.ROUND_HALF_UP));
		statisticalProfit.setTotalProfit(totalProfit.setScale(2, BigDecimal.ROUND_HALF_UP));
		return statisticalProfit;
	}
}
