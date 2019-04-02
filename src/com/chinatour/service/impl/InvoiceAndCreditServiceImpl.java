/**
 * 
 */
package com.chinatour.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinatour.Constant;
import com.chinatour.entity.AccData;
import com.chinatour.entity.AccountRecord;
import com.chinatour.entity.AccountRow;
import com.chinatour.entity.Admin;
import com.chinatour.entity.City;
import com.chinatour.entity.Company;
import com.chinatour.entity.Country;
import com.chinatour.entity.Dept;
import com.chinatour.entity.InvoiceAndCredit;
import com.chinatour.entity.InvoiceAndCreditItems;
import com.chinatour.entity.MonthAccountRecord;
import com.chinatour.entity.RateOfCurrency;
import com.chinatour.entity.StasticAccount;
import com.chinatour.persistence.AccountRecordMapper;
import com.chinatour.persistence.CityMapper;
import com.chinatour.persistence.CompanyMapper;
import com.chinatour.persistence.CountryMapper;
import com.chinatour.persistence.DeptMapper;
import com.chinatour.persistence.InvoiceAndCreditItemsMapper;
import com.chinatour.persistence.InvoiceAndCreditMapper;
import com.chinatour.persistence.RateOfCurrencyMapper;
import com.chinatour.persistence.VenderMapper;
import com.chinatour.service.AdminService;
//import com.chinatour.service.DataFactoryService;
import com.chinatour.service.InvoiceAndCreditService;
import com.chinatour.util.FormatUtil;
import com.chinatour.util.UUIDGenerator;
import com.chinatour.webService.client.GetAccData;
import com.intuit.ipp.data.Account;
import com.intuit.ipp.data.AccountBasedExpenseLineDetail;
import com.intuit.ipp.data.Bill;
import com.intuit.ipp.data.Line;
import com.intuit.ipp.data.LineDetailTypeEnum;
import com.intuit.ipp.data.PhysicalAddress;
import com.intuit.ipp.data.ReferenceType;
import com.intuit.ipp.data.TelephoneNumber;
import com.intuit.ipp.data.Vendor;
import com.intuit.ipp.data.VendorCredit;
import com.intuit.ipp.services.DataService;
import com.intuit.ipp.services.QueryResult;
import com.intuit.ipp.util.Config;


/**
 * 对账
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2014-10-9 下午4:40:02
 * @revision  3.0
 */
@Service("invoiceAndCreditServiceImpl")
public class InvoiceAndCreditServiceImpl extends BaseServiceImpl<InvoiceAndCredit, String> implements InvoiceAndCreditService {

	@Autowired
	private InvoiceAndCreditMapper invoiceAndCreditMapper;
	@Autowired
	private InvoiceAndCreditItemsMapper invoiceAndCreditItemsMapper;
	@Autowired
	private RateOfCurrencyMapper rateOfCurrencyMapper;
	@Autowired
	private AccountRecordMapper accountRecordMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private AdminService adminService;
	@Autowired
	private VenderMapper venderMapper;
	@Autowired
	private CompanyMapper companyMapper;
	@Autowired
	private CityMapper cityMapper;
	@Autowired
	private CountryMapper countryMapper;
	/*@Autowired
	private DataFactoryService dataFactoryService;*/
	@Autowired
	public void setInvoiceAndCreditMapper(InvoiceAndCreditMapper invoiceAndCreditMapper){
		this.setBaseMapper(invoiceAndCreditMapper);
	}
	
	@Resource(name = "getAccData")
	private GetAccData getAccData;
	/**
	 * 找出最大的业务编码
	 * */
	@Override
	@Transactional
	public synchronized int getBusinessNo(String deptId) {
		int businessNo =invoiceAndCreditMapper.getBusinessNo(deptId);
		return businessNo;
		 
	}
	
	@Transactional
	public void save(InvoiceAndCredit invoiceAndCredit) {
		if(invoiceAndCredit.getListInvoiceAndCreditItems()!=null){
			invoiceAndCredit.setBusinessNo(getBusinessNo(invoiceAndCredit.getDeptId()));
			//获取InvoiceAndCreditItems集合，保存数据
			List<InvoiceAndCreditItems> itemsList=invoiceAndCredit.getListInvoiceAndCreditItems();
			for(int i=0;i<itemsList.size();i++){
				InvoiceAndCreditItems items=new InvoiceAndCreditItems();
				items=itemsList.get(i);
				items.setItemsId(UUIDGenerator.getUUID());
				items.setInvoiceAndCreditId(invoiceAndCredit.getInvoiceAndCreditId());
				items.setBusinessNo(invoiceAndCredit.getBusinessNo());
				items.setBillToDeptId(invoiceAndCredit.getBillToDeptId());
				items.setDeptId(invoiceAndCredit.getDeptId());
				items.setIfBeginningValue(invoiceAndCredit.getIfBeginningValue());
				invoiceAndCreditItemsMapper.save(items);
			}
			invoiceAndCreditMapper.save(invoiceAndCredit);
		}
	}
	
	@Transactional
	public int update(InvoiceAndCredit invoiceAndCredit) {
		if(invoiceAndCredit.getListInvoiceAndCreditItems()!=null){
			//获取InvoiceAndCreditItems集合，保存数据
			List<InvoiceAndCreditItems> itemsList=invoiceAndCredit.getListInvoiceAndCreditItems();
			for(int i=0;i<itemsList.size();i++){
				InvoiceAndCreditItems items=new InvoiceAndCreditItems();
				items=itemsList.get(i);
				if(items.getItemsId()==null){
					items.setItemsId(UUIDGenerator.getUUID());
					items.setIfBeginningValue(1);
					invoiceAndCreditItemsMapper.save(items);
				}else{
					items.setIfBeginningValue(1);
					invoiceAndCreditItemsMapper.update(items);
				}
			}
			return invoiceAndCreditMapper.update(invoiceAndCredit);
		}else{//为空，用来删除Item更改invoiceAndCredit数据，不更改InvoiceAndCreditItems
			return invoiceAndCreditMapper.update(invoiceAndCredit);
		}
	}
	
	/**
	 * 批量审核
	 * */
	@Transactional
	public void verifyMulty(List<InvoiceAndCredit> listInvoiceAndCredit){
		for(InvoiceAndCredit invoiceAndCredit:listInvoiceAndCredit){
			verifyConfirm(invoiceAndCredit);	
		}
	}
	/**
	 * 审核过程
	 * */
	@Transactional
	public void verifyConfirm(InvoiceAndCredit invoiceAndCredit){
		InvoiceAndCredit invoice=invoiceAndCreditMapper.findById(invoiceAndCredit.getInvoiceAndCreditId());
		Boolean bIfVerified=new Boolean(false);
		if(invoice.getConfirmStatus().equalsIgnoreCase("CONFIRM")||invoice.getConfirmStatus().equalsIgnoreCase("CONFIRMSEND")){
			bIfVerified=true;
		}
		if(!bIfVerified){
			invoice.setConfirmRemarks(invoiceAndCredit.getConfirmRemarks());
			invoice.setConfirmStatus(invoiceAndCredit.getConfirmStatus());
			invoiceAndCreditMapper.update(invoice);
			
			for(InvoiceAndCreditItems ici:invoiceAndCredit.getListInvoiceAndCreditItems()){
				InvoiceAndCreditItems items=invoiceAndCreditItemsMapper.findById(ici.getItemsId());
				items.setVerifyRemarks(ici.getVerifyRemarks());
				items.setIfVerified(2);
				invoiceAndCreditItemsMapper.update(items);
			}
			
			if(invoice.getConfirmStatus().equalsIgnoreCase("CONFIRM")||invoice.getConfirmStatus().equalsIgnoreCase("CONFIRMSEND")){
				
				AccountRecord account1=new AccountRecord();			//本部门账
				AccountRecord account2=new AccountRecord();			//对方部门账
				//本部门 部门 记录
				account1.setAccountRecordId(UUIDGenerator.getUUID());
				account1.setInvoiceAndCreditId(invoice.getInvoiceAndCreditId());
				account1.setBusinessNo(invoice.getBusinessNo());
				account1.setDeptId(invoice.getDeptId());
				account1.setBillToDeptId(invoice.getBillToDeptId());
				account1.setBillToReceiver(invoice.getBillToReceiver());
				account1.setCreateDate(new Date());
				SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
				String month=simpleDateFormat.format(invoice.getMonth());
				account1.setMonth(month);
				account1.setRemarks(invoice.getRemarks());
				account1.setTourCode(invoice.getTourCode());
				account1.setIfBeginningValue(invoice.getIfBeginningValue());
				//对方部门 记录
				account2.setAccountRecordId(UUIDGenerator.getUUID());
				account2.setInvoiceAndCreditId(invoice.getInvoiceAndCreditId());
				account2.setBusinessNo(invoice.getBusinessNo());
				account2.setDeptId(invoice.getBillToDeptId());
				//account2.setDeptId(invoice.getDeptName());
				String deptName = deptMapper.findById(invoice.getDeptId()).getDeptName();
				account2.setBillToReceiver(deptName);
				account2.setCreateDate(new Date());
				account2.setMonth(month);
				account2.setRemarks(invoice.getRemarks());
				account2.setTourCode(invoice.getTourCode());
				account2.setIfBeginningValue(invoice.getIfBeginningValue());
				account2.setBillToDeptId(invoice.getDeptId());
				
				RateOfCurrency rateOfCurrency=rateOfCurrencyMapper.findById(invoice.getRateOfCurrencyId());
				BigDecimal exDollar = invoice.getEnterCurrency().multiply(rateOfCurrency.getRateUp()).divide(rateOfCurrency.getRateDown(), 2,BigDecimal.ROUND_HALF_UP);
				
				if(invoice.getRecordType().equals("INVOICE")){
					account1.setReceivableCurrency(invoice.getEnterCurrency());
					account1.setReceivableAmount(invoice.getDollar());		//应收
					account1.setReceivedAmount(exDollar);
					/*account1.setBalanceDue(invoice.getDollar().subtract(account1.getReceivedAmount()));	//应收款余额*/					
					account2.setReceivableCurrency(new BigDecimal(0).subtract(exDollar));
					account2.setReceivableAmount(new BigDecimal(0).subtract(invoice.getDollar()));
					account2.setReceivedAmount(new BigDecimal(0).subtract(invoice.getEnterCurrency()));
				}
				if(invoice.getRecordType().equals("CREDIT MEMO")){
					account1.setReceivableCurrency(new BigDecimal(0).subtract(invoice.getEnterCurrency()));
					account1.setReceivableAmount(new BigDecimal(0).subtract(invoice.getDollar()));
					account1.setReceivedAmount(new BigDecimal(0).subtract(exDollar));
					
					account2.setReceivableCurrency(exDollar);
					account2.setReceivableAmount(invoice.getDollar());		//应收
					account2.setReceivedAmount(invoice.getEnterCurrency());
				}
				
				accountRecordMapper.save(account1);
				accountRecordMapper.save(account2);
			}
		}
	}
	@Override
	public List<AccountRow> getAccountRow(AccountRecord accountRecord) {
		return accountRecordMapper.getAccountRow(accountRecord);
	}
	@Override
	public List<AccountRow> getBeginningVal(AccountRecord accountRecord) {
		return accountRecordMapper.getBeginningVal(accountRecord);
	}
	@Override
	public List<StasticAccount> getStasticAccountList(AccountRecord accountRecord) {
		List<StasticAccount> list=new ArrayList<StasticAccount>();
		list.add(getStasticAccount(accountRecord));
		return list;
	}
	
	/**
	 * 获取分公司所有的汇总往来账统计信息
	 * @param accountRecord
	 * @return
	 */
	@Transactional
	private StasticAccount getStasticAccount(AccountRecord accountRecord){
		List<Dept>		listBillDept=new ArrayList<Dept>();
		listBillDept=deptMapper.listBillDept(accountRecord.getDeptId());//除本部门的其他部门
		Dept dept=new Dept();
		StasticAccount	stasticAccount=new StasticAccount();
		stasticAccount.setDeptId(accountRecord.getDeptId());
		stasticAccount.setDeptName(deptMapper.findById(accountRecord.getDeptId()).getDeptName());
		List<AccountRow>	listAccountRow=accountRecordMapper.getAccountRow(accountRecord);
		List<AccountRow>    listBeginningVal=accountRecordMapper.getBeginningVal(accountRecord);
		String[] arrMonth = new String[12];
		for(int i=1;i<=12;i++){
			String month=i<10?accountRecord.getYear()+"-0"+i:accountRecord.getYear()+"-"+i;
			arrMonth[i-1]=month;
		}
		
		for(Dept d:listBillDept){
			MonthAccountRecord mar=new MonthAccountRecord();
			mar.setBillToDeptId(d.getDeptId());
			mar.setBillToReceiver(d.getDeptName());
			mar.setYear(accountRecord.getYear());
				for(AccountRow row:listAccountRow){
					if(row.getBillToDeptId().equals(d.getDeptId())){
						mar.setDeptId(row.getDeptId());
						if(row.getMonth().equals(arrMonth[0])){
							mar.setJan(row.getBalance());
							stasticAccount.setJanSub(stasticAccount.getJanSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[1])){
							mar.setFeb(row.getBalance());
							stasticAccount.setFebSub(stasticAccount.getFebSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[2])){
							mar.setMar(row.getBalance());
							stasticAccount.setMarSub(stasticAccount.getMarSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[3])){
							mar.setApr(row.getBalance());
							stasticAccount.setAprSub(stasticAccount.getAprSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[4])){
							mar.setMay(row.getBalance());
							stasticAccount.setMaySub(stasticAccount.getMaySub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[5])){
							mar.setJune(row.getBalance());
							stasticAccount.setJuneSub(stasticAccount.getJuneSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[6])){
							mar.setJuly(row.getBalance());
							stasticAccount.setJulySub(stasticAccount.getJulySub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[7])){
							mar.setAug(row.getBalance());
							stasticAccount.setAugSub(stasticAccount.getAugSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[8])){
							mar.setSept(row.getBalance());
							stasticAccount.setSeptSub(stasticAccount.getSeptSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[9])){
							mar.setOct(row.getBalance());
							stasticAccount.setOctSub(stasticAccount.getOctSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[10])){
							mar.setNov(row.getBalance());
							stasticAccount.setNovSub(stasticAccount.getNovSub().add(row.getBalance()));
						}
						if(row.getMonth().equals(arrMonth[11])){
							mar.setDec(row.getBalance());
							stasticAccount.setDecSub(stasticAccount.getDecSub().add(row.getBalance()));
						}
						mar.setSubtotal(mar.getSubtotal().add(row.getBalance()));	
					}
				}
				
				for(AccountRow ar:listBeginningVal){
					if(ar.getBillToDeptId().equals(d.getDeptId())){
						mar.setBeginningValue(ar.getBalance());
						mar.setSubtotal(mar.getSubtotal().add(ar.getBalance()));
						stasticAccount.setBeginningValueSub(stasticAccount.getBeginningValueSub().add(ar.getBalance()));
					}
				}
			stasticAccount.getListMonth().add(mar);
			stasticAccount.setGrandTotal(stasticAccount.getGrandTotal().add(mar.getSubtotal()));
		}
		return stasticAccount;
	}
	
	/**
	 * 获取全公司所有的汇总往来账统计信息
	 * @param accountRecord
	 * @return
	 */
	@Transactional
	public List<StasticAccount> getAllStasticAccountList(AccountRecord accountRecord){
		List<StasticAccount> list=new ArrayList<StasticAccount>();
		List<Dept> listDept=deptMapper.findAll();
		AccountRecord acc = null;
		for(Dept d:listDept){
			acc=new AccountRecord();
			acc.setYear(accountRecord.getYear());
			acc.setDeptId(d.getDeptId());
			list.add(getStasticAccount(acc));
		}
		return list;
	}
	
	/**
	 * 查询出明细往来账
	 * @param accountRecord
	 * @return
	 */
	public List<AccountRecord> searchAccount(AccountRecord accountRecord){
		//打了一个小布丁
		accountRecord.setStartMonth(null);
		accountRecord.setEndMonth(null);
		BigDecimal	yearReceivableSubtotal=new BigDecimal(0);
		BigDecimal	yearReceivedSubtotal=new BigDecimal(0);
		//BigDecimal	yearBalanceDueSubtotal=new BigDecimal(0);
		BigDecimal	yearReceivableCurrency=new BigDecimal(0);
		
		List<AccountRecord> list=new ArrayList<AccountRecord>();
		AccountRecord arBeginValue=accountRecordMapper.getBeginningValueOfYear(accountRecord);
		if(arBeginValue!=null){
			yearReceivableCurrency=yearReceivableCurrency.add(arBeginValue.getReceivableCurrency());
			yearReceivableSubtotal=yearReceivableSubtotal.add(arBeginValue.getReceivableAmount());
			yearReceivedSubtotal=yearReceivedSubtotal.add(arBeginValue.getReceivedAmount()==null?new BigDecimal(0.00):arBeginValue.getReceivedAmount());
			//yearBalanceDueSubtotal=yearBalanceDueSubtotal.add(arBeginValue.getBalanceDue());
			arBeginValue.setIsData(new Boolean(false));
			arBeginValue.setLabel("Beginning:");
			list.add(arBeginValue);
		}
		
		List<AccountRecord> listOther=new ArrayList<AccountRecord>();//存储全部符合条件的accountRecord
		listOther=accountRecordMapper.find(accountRecord);
		String[] arrMonth=FormatUtil.getMonthArr(accountRecord.getYear());
		if(accountRecord.getStartMonth()!=null&&accountRecord.getEndMonth()!=null){
			//截取月份转为整数
			int stratMonth = Integer.parseInt(accountRecord.getStartMonth().substring(5,7));
			int endMonth = Integer.parseInt(accountRecord.getEndMonth().substring(5,7));
			String[]  arrMonthArray = new String[endMonth-stratMonth+1];
			List<String> arrMonthList = new ArrayList<String>();
			for(int i=stratMonth;i<=endMonth;i++){
				if(i>=10){
					arrMonthList.add(accountRecord.getYear()+i);
				}else if(i<10){
					arrMonthList.add(accountRecord.getYear()+"0"+i);
				}
			}
			
			for(int i=0;i<endMonth-stratMonth+1;i++){
				arrMonthArray[i] = arrMonthList.get(i);
			}
			arrMonth = arrMonthArray;
		}
		String monthNow=FormatUtil.getMonth(new Date());
		
		for(String m:arrMonth){
			if(m.compareTo(monthNow)<=0){
				BigDecimal	receivableSubtotal=new BigDecimal(0);
				BigDecimal	receivedSubtotal=new BigDecimal(0);
				//BigDecimal	balanceDueSubtotal=new BigDecimal(0);
				BigDecimal	receivableCurrencySubtotal=new BigDecimal(0);
				
				for(AccountRecord ar:listOther){
					String month = ar.getMonth().replace("-", "").trim();
					if(m.equals(month) && ar.getIfBeginningValue()!=2){
						receivableCurrencySubtotal=receivableCurrencySubtotal.add(ar.getReceivableCurrency());
						receivableSubtotal=receivableSubtotal.add(ar.getReceivableAmount());
						receivedSubtotal=receivedSubtotal.add(ar.getReceivedAmount());
						//balanceDueSubtotal=balanceDueSubtotal.add(ar.getBalanceDue());
						ar.setIsData(new Boolean(true));
						ar.setMonth(m.substring(0, 4)+"-"+m.substring(4, 6));
						list.add(ar);
					}
				}
				AccountRecord arMonth=new AccountRecord();
				arMonth.setReceivableCurrency(receivableCurrencySubtotal);
				arMonth.setReceivableAmount(receivableSubtotal);
				arMonth.setReceivedAmount(receivedSubtotal);
				//arMonth.setBalanceDue(balanceDueSubtotal);
				arMonth.setIsData(new Boolean(false));
				arMonth.setLabel(m+Constant.TOTAL_STRING);
				arMonth.setMonth(m.substring(0, 4)+"-"+m.substring(4, 6));
				list.add(arMonth);
				
				yearReceivableCurrency=yearReceivableCurrency.add(arMonth.getReceivableCurrency());
				yearReceivableSubtotal=yearReceivableSubtotal.add(arMonth.getReceivableAmount());
				yearReceivedSubtotal=yearReceivedSubtotal.add(arMonth.getReceivedAmount());
				//yearBalanceDueSubtotal=yearBalanceDueSubtotal.add(arMonth.getBalanceDue());
				AccountRecord arYear=new AccountRecord();
				arYear.setReceivableCurrency(yearReceivableCurrency);
				arYear.setReceivableAmount(yearReceivableSubtotal);
				arYear.setReceivedAmount(yearReceivedSubtotal);
				//arYear.setBalanceDue(yearBalanceDueSubtotal);
				arYear.setIsData(new Boolean(false));
				arYear.setMonth(m.substring(0, 4)+"-"+m.substring(4, 6));
				arYear.setLabel(Constant.YEARTOTAL_STRING);
				list.add(arYear);
			}
		}
		return list;
	}
	
	@Override
	public List<InvoiceAndCredit> find(InvoiceAndCredit invoiceAndCredit) {
		return invoiceAndCreditMapper.find(invoiceAndCredit);
	}
	@Override
	public int findCount(InvoiceAndCredit invoiceAndCredit){
		return invoiceAndCreditMapper.findCount(invoiceAndCredit);
	}
	
	@Override
	public List<Dept> queryDeptForBegVal(String deptId) {
		return invoiceAndCreditMapper.queryDeptForBegVal(deptId);
	}
	@Override
	public AccountRecord querySumYearly(AccountRecord accountRecord) {
		return accountRecordMapper.querySumYearly(accountRecord);
	}
	@Override
	public InvoiceAndCredit querySum(InvoiceAndCredit invoiceAndCredit) {
		return invoiceAndCreditMapper.querySum(invoiceAndCredit);
	}
}