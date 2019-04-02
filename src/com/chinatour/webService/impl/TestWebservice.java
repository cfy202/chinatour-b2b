/**
 * 
 */
package com.chinatour.webService.impl;

import java.math.BigDecimal;
import java.net.MalformedURLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.xfire.XFireFactory;
import org.codehaus.xfire.client.XFireProxyFactory;
import org.codehaus.xfire.service.binding.ObjectServiceFactory;

import com.chinatour.entity.Customer;
import com.chinatour.entity.CustomerFlight;
import com.chinatour.entity.Order;
import com.chinatour.entity.OrderReceiveItem;
import com.chinatour.entity.ReceivableInfoOfOrder;
import com.chinatour.entity.TourInfoForOrder;
import com.chinatour.vo.SingleOrdersVO;
import com.chinatour.webService.GroupLineInterface;
import com.google.gson.Gson;


/**
 * @copyright   Copyright: 2014 
 * @author Aries
 * @create-time 2015-1-16 下午2:10:02
 * @revision  3.0
 */

public class TestWebservice {

	/**
	 * @param args
	 * @throws ParseException 
	 */
	public static void main(String[] args) throws ParseException {
		Gson gson = new Gson();
		org.codehaus.xfire.service.Service srvcModel = new ObjectServiceFactory().create(GroupLineInterface.class);
		XFireProxyFactory factory = new XFireProxyFactory(XFireFactory.newInstance().getXFire()); 
		String helloWorldURL = "http://localhost:8080/chinatour-3.0/service/serviceInterface";
		GroupLineInterface impl=null;
		try {
			impl= (GroupLineInterface) factory.create(srvcModel, helloWorldURL);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		
		Order order = new Order();
		order.setUserId("9a75b3c0-334e-11e4-b177-00163e002f1d");  //必填
		order.setTotalPeople(2);
		order.setTourCode("SGJN0901");
		order.setContactName("NXH");
		order.setTax(0);
		order.setOrderNoIn("wenjing");
		order.setRefNo("七七七七七");
		
		List<Customer> cList = new ArrayList<Customer>();
		
		Customer c = new Customer();
		c.setFirstName("TestOne");
		c.setLastName("Test");
		c.setBirthday("2015-02-12") ;    //必填  没有值也要以空字符””传值
		c.setNationalityOfPassport("CHINA");
		c.setPassportNo("GX1111");
		c.setPassportDate("");   //必填  没有值也要以空字符””传值
		c.setSex(2);        //2.男    1.女
		c.setTel("13709595556");
		c.setLanguageId("e4a1251b-8229-11e2-8c18-94de800a7ba1");
		c.setMemoOfCustomer("New Clients");
		c.setGuestRoomType("Twin Bed");  //房型  必填
		c.setRoomNumber(1);
		c.setRoomIsFull(2);
		
		List<CustomerFlight> cfList1=new ArrayList<CustomerFlight>();
		CustomerFlight cf1 =new CustomerFlight();
		cf1.setFlightNumber("1200");
		cf1.setFlightCode("CZ");
		cf1.setArriveTime("12:00");
		cf1.setArriveDateStr("2015-02-03");     //必填  没有值也要以空字符””传值
		cf1.setOutOrEnter(1);//		入境出境必填---2：出境 ， 1：入境
		cf1.setIfPickUp(1);
		cfList1.add(cf1);
		CustomerFlight cf2 =new CustomerFlight();
		cf2.setFlightNumber("8955");
		cf2.setFlightCode("MM");
		cf2.setArriveTime("15:00");
		cf2.setArriveDateStr("2015-02-01");     //必填  没有值也要以空字符””传值
		cf2.setOutOrEnter(2);//		入境出境必填---2：出境 ， 1：入境
		cf2.setIfSendUp(1);
		cfList1.add(cf2);
		c.setCustomerFlightList(cfList1);
		cList.add(c);

		Customer c1 = new Customer();
		c1.setFirstName("TestTwo");
		c1.setLastName("Two");
		c1.setBirthday("1991-03-02") ;    //必填  没有值也要以空字符””传值
		c1.setNationalityOfPassport("CHINA");
		c1.setPassportDate("2018-11-11");   //必填  没有值也要以空字符””传值
		c1.setPassportNo("G32748597");
		c1.setSex(2);      //2.男    1.女
		c1.setTel("13709595556");
		c1.setLanguageId("b42bd96c-3cf9-11e2-9ada-fcde614b56cb");
		c1.setMemoOfCustomer("新客人");
		c1.setGuestRoomType("Twin Bed");  //房型  必填
		c1.setRoomNumber(1);
		c1.setRoomIsFull(2);
		
		List<CustomerFlight> cfList2=new ArrayList<CustomerFlight>();
		CustomerFlight cf3 =new CustomerFlight();
		cf3.setFlightCode("MU5716");
		cf3.setArriveDateStr("2015-03-11");     //必填  没有值也要以空字符””传值
		cf3.setOutOrEnter(1);//        入境出境必填---2：出境 ， 1：入境
		cfList2.add(cf3);
		CustomerFlight cf4 =new CustomerFlight();
		cf4.setFlightCode("MU5716");
		cf4.setArriveDateStr("2015-03-18");     //必填  没有值也要以空字符””传值]
		cf4.setOutOrEnter(2);//      入境出境必填---2：出境 ， 1：入境
		cfList2.add(cf4);
		c1.setCustomerFlightList(cfList2);
		cList.add(c1);
		
		Customer c3 = new Customer();
		c3.setFirstName("Child");
		c3.setLastName("DC");
		c3.setBirthday("1991-03-02") ;    //必填  没有值也要以空字符””传值
		c3.setNationalityOfPassport("CHINA");
		c3.setPassportDate("2018-11-11");   //必填  没有值也要以空字符””传值
		c3.setPassportNo("G32748597");
		c3.setSex(2);      //2.男    1.女
		c3.setTel("13709595556");
		c3.setLanguageId("b42bd96c-3cf9-11e2-9ada-fcde614b56cb");
		c3.setMemoOfCustomer("新客人");
		c3.setGuestRoomType("Suite");  //房型  必填
		c3.setRoomNumber(1);
		c3.setRoomIsFull(0);
		
		List<CustomerFlight> cfList3=new ArrayList<CustomerFlight>();
		CustomerFlight cf5 =new CustomerFlight();
		cf5.setFlightCode("MU5716");
		cf5.setArriveDateStr("2015-03-11");     //必填  没有值也要以空字符””传值
		cf5.setOutOrEnter(1);//        入境出境必填---2：出境 ， 1：入境
		cfList3.add(cf5);
		CustomerFlight cf6 =new CustomerFlight();
		cf6.setFlightCode("MU5716");
		cf6.setArriveDateStr("2015-03-18");     //必填  没有值也要以空字符””传值]
		cf6.setOutOrEnter(2);//      入境出境必填---2：出境 ， 1：入境
		cfList3.add(cf6);
		c3.setCustomerFlightList(cfList3);
		cList.add(c3);
		
		TourInfoForOrder t = new TourInfoForOrder();
		t.setScheduleLineCode("SGJN0901");
		t.setGroupLineId("03857a0a-5021-11e4-9711-00163e002f1d");
		t.setLineName("青青草原");
		t.setArriveTime("2015-02-20");    //必填
		t.setSpecialRequirements("PLEASE Cancel this, API test only!!");
		t.setTourInfo("TESTING ONLY, Please DELETE this booking!");
		//费用
		List<OrderReceiveItem> itemList=new ArrayList<OrderReceiveItem>(); 
		OrderReceiveItem item1=new OrderReceiveItem();
		item1.setType(1);
		item1.setItemFee(new BigDecimal(100));
		item1.setItemFeeNum(1);
		item1.setNum(101);
		OrderReceiveItem item2=new OrderReceiveItem();
		item2.setType(2);
		item2.setItemFee(new BigDecimal(100));
		item2.setRemark("11111");
		item2.setNum(201);
		itemList.add(item1);
		itemList.add(item2);
		ReceivableInfoOfOrder re=new ReceivableInfoOfOrder();
		re.setSumFee(new BigDecimal(100));
		re.setTotalCommonTourFee(new BigDecimal(100));
		re.setTotalFeeOfOthers(new BigDecimal(100));
		re.setOrderReceiveItemList(itemList);
		
		//visa
		SingleOrdersVO sv=new SingleOrdersVO();
		List<OrderReceiveItem> visaFeeList=new ArrayList<OrderReceiveItem>();
		OrderReceiveItem item3=new OrderReceiveItem();
		item1.setType(1);
		item1.setItemFee(new BigDecimal(100));
		item1.setItemFeeNum(1);
		item1.setNum(100);
		OrderReceiveItem item4=new OrderReceiveItem();
		item2.setType(1);
		item2.setItemFee(new BigDecimal(100));
		item2.setRemark("11111");
		item2.setNum(101);
		visaFeeList.add(item1);
		visaFeeList.add(item2);
		sv.setVisaFeeList(visaFeeList);
		
		ReceivableInfoOfOrder re1=new ReceivableInfoOfOrder();
		re1.setSumFee(new BigDecimal(100));
		re1.setTotalCommonTourFee(new BigDecimal(100));
		re1.setTotalFeeOfOthers(new BigDecimal(100));
		sv.setReceivableInfoOfOrder(re1);
		order.setSingleOrdersVO(sv);
		
		String orders = gson.toJson(order);
		String customerList = gson.toJson(cList);
		String tourInfoForOrder = gson.toJson(t);
		String receivableInfoOfOrder=gson.toJson(re);
		
		GroupLineInterface oit=null;
		try {
			oit = (GroupLineInterface) factory.create(srvcModel,helloWorldURL);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		
		String q=oit.saveOrderWeb(orders, customerList, tourInfoForOrder,receivableInfoOfOrder);
		
	}

}
