package com.chinatour.webService.toAccount;

import java.text.ParseException;
import javax.jws.WebService;

import com.chinatour.entity.AccData;

/**
 * @copyright   Copyright: 2014 
 * @create-time Aug 29, 2014 4:48:04 PM
 * @revision  3.0
 */
@WebService
public interface GetAccDataInterface {

/**
 * 获取invoice数据
 */
	public String getAccData(String accDataString);

/**
 * 获取customer数据
 * @param customerString
 * @return
 */
	public String getCustomer(String customerString);
	
	
	public String getCustomersData(String customersDataString);
	
	public String getVendor(String vendorString);
	
	
	public String getVendorsData(String vendorsDataString);
	
}
