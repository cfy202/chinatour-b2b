package com.chinatour.webService.client;

import java.net.MalformedURLException;

import org.codehaus.xfire.XFireFactory;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;
import org.springframework.stereotype.Service;

import com.chinatour.entity.AccData;
import com.chinatour.webService.toAccount.GetAccDataInterface;
import com.google.gson.Gson;

@Service("getAccData")
public class GetAccData {
	public String saveAccData(AccData accData){
		org.codehaus.xfire.service.Service srvcModel = new ObjectServiceFactory().create(GetAccDataInterface.class);
		XFireProxyFactory factory = new XFireProxyFactory(XFireFactory.newInstance().getXFire()); 
		String visitUrl = "http://192.168.1.104:8080/account/service/serviceInterface";
		GetAccDataInterface getAccDataInterface = null;
		try {
			getAccDataInterface = (GetAccDataInterface)factory.create(srvcModel,visitUrl);
			Gson gson = new Gson();
			String accDataString=gson.toJson(accData);
			String customerString=gson.toJson(accData.getCustomer());
			String customersDataString=gson.toJson(accData.getCustomersData());
			getAccDataInterface.getCustomer(customerString);
			getAccDataInterface.getAccData(accDataString);
			getAccDataInterface.getCustomersData(customersDataString);
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return null;
		}
		return visitUrl;
}
	
	public String saveAccDataForVendor(AccData accData){
		org.codehaus.xfire.service.Service srvcModel = new ObjectServiceFactory().create(GetAccDataInterface.class);
		XFireProxyFactory factory = new XFireProxyFactory(XFireFactory.newInstance().getXFire()); 
		String visitUrl = "http://47.88.0.72:8080/account/service/serviceInterface";
		GetAccDataInterface getAccDataInterface = null;
		try {
			getAccDataInterface = (GetAccDataInterface)factory.create(srvcModel,visitUrl);
			Gson gson = new Gson();
			String accDataString=gson.toJson(accData);
			String vendorString=gson.toJson(accData.getVender());
			String vendorsDataString=gson.toJson(accData.getVendorsData());
			getAccDataInterface.getVendor(vendorString);
			getAccDataInterface.getAccData(accDataString);
			getAccDataInterface.getVendorsData(vendorsDataString);
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return null;
		}
		return visitUrl;
}
}
