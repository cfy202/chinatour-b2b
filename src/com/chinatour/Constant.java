package com.chinatour;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * 页面上下拉列表的选项
 * 
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Sep 19, 2014 2:38:18 PM
 * @revision 3.0
 */
public class Constant {
	
	/**
	 * 品牌类型
	 */
	/*public static final String[] BRAND_ITEMS = new String[] { "中国美","chinatour", "文景假期", "InterTrips","wenjing"};*/
	
	public static final String[] BRAND_ITEMS = new String[] { "中国美","chinatour", "文景假期", "InterTrips"};
	
	/**
	 *
	 *年份
	 */
	public static final String[] BRAND_YEAR = new String[] { "2011","2012", "2013", "2014","2015","2016","2017","2018","2019"};
	
	/**
	 *
	 *月份
	 */
	public static final String[] BRAND_MONTH = new String[] { "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	
	/**
	 * 对应品牌logo的路径
	 */
	public  static final String[] LOGO_PATH = new String[] { "resources/images/echinatours-logo.png",
															 "resources/images/chinatour-logo.png", 
															 "resources/images/wenjing-logo.png", 
															 "resources/images/nexus-logo.png",
															 "resources/images/wenjing-logo-old.png",
															 "resources/images/logo_vancouver.jpg"
															 };
	
	/**
	 * 收入款项
	 */
	/*public static final String[] PAYMENT_ITEMS = new String[] { "邮寄费",
			"机票退票收入", "保险佣金", "押金", "机票", "余款", "签证费用", "保险", "BUS团费", "门票",
			"酒店", "自费", "购物", "团费", "其他" };
*/
	/*public static final String[] PAYMENT_ITEMS = new String[] { "Postage Fee",
		"Revenue of Flight Cancellation", "Insurance Commission", "Deposit", 
		"Flight", "Balance", "Visa Fee", "Insurance", "Bus Tour Charge", "Addmission Fee",
		"Hotel", "Option Tour", "Shopping", "Tour Charge", "Others" };*/
	
	public static final String[] PAYMENT_ITEMS = new String[] { "Tour Deposit", "Tour Fee", "Air Ticket", 
		"Tour Balance"," Hotel", "Visa", "Postage", "Insurance", "Optional", "Admission", "Shopping","LS", "Other" };

	/**
	 * 付款方式
	 */
	/*public static final String[] PAYMENT_WAYS = new String[] { "西安代收", "电汇",
			"内部转账", "现金", "支票", "柜台存入", "信用卡", "出票公司", "其他" };*/
	/*public static final String[] PAYMENT_WAYS = new String[] { "Collected by Xian", "Cable Transfer",
		"Internal transfer", "Cash", "Check", "Counter deposit", "Credit Card", "Flight Agency", "Others" };*/

	public static final String[] PAYMENT_WAYS = new String[] { "Check", "Cash", "AMERICAN EXPRESS", "VISA", "MASTER CARD", "DISCOVER", 
		"DEBIT CARD", "MC PCARD","MONEY ORDER","PAYPAL","REFUND","WIRE","Living Social","GIFT CARD","authorize.net","Groupon"};
	public static final String[] COST_WAYS = new String[] { "Check", "Credit Card"};


	/**
	 * 支付款项
	 */
	/*public static final String[] COST_ITEMS = new String[] { "酒店", "租车",
			"导游费用", "门票", "客人退款", "其他供应商", "机票", "签证", "信用卡手续费", "保险成本",
			"单订酒店", "游船", "中国账单", "Paypal手续费", "同行佣金返还", "导游垫付餐费(现金)",
			"导游费用(支票)", "往来抵账", "其他" };*/
	/*public static final String[] COST_ITEMS = new String[] { "Hotel", "Car Rental",
		"Guide Service Fee", "Addmission Fee", "Refund", "Other Supplier", "Flight", "Visa", "Credit Card Fee", "Insurance Cost",
		"Hotel Booking", "Cruise", "Bill of China", "Paypal Fee", "Agency Commission Payment", "Meal Paid by Guide(Cash)",
		"Guide Service Fee(Check)", "Accounts Balance", "Others" };*/
	public static final String[] COST_ITEMS = new String[] {"Tour Cost", "Tour Refund", "Air Ticket", "Hotel, Cruise", "Visa", "Postage", 
		"Insurance", "Tour Guide", "Bank Fee", "Credit Card Fee", "Paypal Fee", "Commission", "Advance  payment","LS"," Other" };

	/**
	 * 客人备注
	 */
	/*public static final String[] CUSTOMER_MEMOS = new String[] { "新客人", "老客人",
			"VIP", "普通", "领队", "老人需照顾", "旅行商", "残疾人士", "小孩" };*/
	public static final String[] CUSTOMER_MEMOS = new String[] { "New Clients", "Former Clients",
		"VIP", "Standard", "Group Leader", "Aged", "MICE", "Disabled", "Child" };


	/**
	 * 房型
	 */
	public static final String[] GUEST_ROOM_TYPES = new String[] {"Twin Bed","King Bed","Single",
		"Extra Bed","Suite","Sharing Existing Bed","Room Matching"};
	
	/**
	 * 
	 */
	public static final String[] TICKET_TYPES = new String[]{"","GIT Ticket","FIT Ticket","Land only","Deviation","Ticketed/Diviation"};

	/**
	 * 团队类型
	 */
	public static final Map<String, String> TOUR_TYPES = new HashMap<String, String>();
    
	/*
	 * 以key为option的value，value为option的文本
	 */
	static {
		/*TOUR_TYPES.put("0", "﻿独立团");
		TOUR_TYPES.put("1", "系列团");
		TOUR_TYPES.put("2", "国内特价团");
		TOUR_TYPES.put("3", "英文团购");
		TOUR_TYPES.put("4", "团购机票");
		TOUR_TYPES.put("5", "零售机票");
		TOUR_TYPES.put("6", "国外特价团");
		TOUR_TYPES.put("8", "独立特价团");*/
		TOUR_TYPES.put("0", "Independent Tour");
		TOUR_TYPES.put("1", "Seires Group");
		TOUR_TYPES.put("2", "CHN Travel Deals");
		TOUR_TYPES.put("3", "ENG Travel Deals");
		TOUR_TYPES.put("4", "Group Flight");
		TOUR_TYPES.put("5", "Retail Flight");
		TOUR_TYPES.put("6", "Outbound Travel Deals");
		TOUR_TYPES.put("8", "Independent Travel Deals");
	}
	
	/**
	 * 询价人数
	 */
	public static final String[] TEAM_POPULATION_STRINGS = new String[] { "1-3 person",
			"4-5 person", "6-10 person", "11-20 person", "21-30 person", "31-50 person", "51-100 person", "101-500 person", "501-1000 person" };
	
	/**
	 * 不可实例化
	 */
	private Constant() {
	}
	
	/**
	 * 确认的状态 NEW:手动录入未审核状态,NEWAUTO:账单发送未审核状态,CONFIRM:手动录入确认,CONFIRMAUTO:系统自动审核,CONFIRMSEND:账单审核确认,REJECT (初始状态、自动发送、确认、拒绝）
	 */
	public static final String[] CONFIRMSTATUS = new String[]{" NEW","CONFIRMAUTO","NEWAUTO","CONFIRM","CONFIRMSEND","REJECT"};
	
	/**
	 * 系统自动确认时输入的备注摘要信息
	 */
	public static final String AUTOCONFIRMREMARKS = "System Automatic Confirmation"; //系统自动确认
	
	public static final String HOTELPRICE = "Hotel Bill:";	//酒店账单
	
	public static final String SUPPLIERPRICE = "Operator Bill :"; //地接社账单
	
	public static final String FLIGHTPRICE = "Flight Bill :"; //机票账单
	
	public static final String INSURANCEPRICE = "Insurance Bill:"; //保险账单
	
	public static final String SYSTEMPINPUT = "(entering)";//(系统录入)
	
	public static final String CHINAPRICE = "Bill of China";//中国账单
	
	public static final String BILLREMARKS = "Automatic Bill Confirmation";//账单自动确认
	
	public static final String HOTEL = "Hotel";//酒店
	
	public static final String FLIGHT = "Flight";//机票
	
	public static final String INSURANCE = "Insurance"; //保险
	
	public static final String TOURCOST = "Tour Cost"; //团花费
	
	public static final String CHECKBILLCHANGE = "Cost of Revised Bill "; //变更单成本
	
	public static final String AUTOCHECKBILL = "Revised Bill Automatic Confirmation"; //变更单自动确认
	
	public static final String CHECKBILLINFO = "Cost of Revised Bill Entering"; //变更单成本录入
	
	public static final String HEADOFFICE="261d670d-7fca-11e2-b80b-94de800a7ba1"; //INVOICE显示总公司个性化
	/**
	 * 订单结算时agent所获利润的百分比
	 */
	public static BigDecimal AGENT_PROFIT = new BigDecimal(0.95);// agent利润
	
	/**
	 * 订单结算时op获得的利润百分比
	 */
	public static BigDecimal OP_PROFIT = new BigDecimal(0.05);// op利润
	
	/**
	 * //系统自动录入账单将西安视为别的部门的vender
	 */
	public static final String XIAN_OFFICENAME = "XIAN OFFICE";
	
	/**
	 * 发送账单的状态  INVOICE\CREDIT
	 */
	public static String INVOICE = "INVOICE";
	public static String CREDIT= "CREDIT MEMO";
	
	/**
	 * invoiceAndCreditItems中SetRemarks所加硬编码内容
	 */
	public static String ORDERPROFIT = "Booking Profit";//订单利润
	public static String PROFITFORMONTH = "Monthly Profit";//月团利润
	public static String EXCHANGEDPROFITFORMONTH = " Revised Monthly Profit";//月团变更利润
	public static String EXCHANGEDPROFIT = "Revised Profit";//变更利润
	public static String TOURFEEFORMONTH = "Monthly Tour Bill";//月 账单团款
	public static String AIRTICKETMONTH = " Air Ticket Bill";//月 账单团款
	public static String TOURFEE = "Tour Charge";//团款
	public static String EXCHANGEOFBILL = "Revised Bill";//账单变更单 
	public static String EXCHANGEITEMSOFREMARKS = "Revised Bill"; //变更单
	public static String EXCHANGEITEMSOFDESCREPTION = "Revised Settlement Price";//结算价格变更
	
	/**
	 * 服务器IP
	 */
	/*public static final String SERVERIP = "http://192.168.1.40:8080";*/
	public static final String SERVERIP = "http://erp.intertrips.com";
	
	public static final String SERVER = "A";
	
	public static final String README = "/upload/read/ERP-V3-Readme.pdf";
	
	public static final String PEERUSER = "/upload/read/ERP-V3-User-Manual.pdf";
	
	/**
	 * 系统自动发送站内信
	 */
	public static final String SYSNOTICE = "(系统通知)";//系统通知
	
	public static final String ORDERS = "订单：";//订单
	
	public static final String CANCELOF_ORDER = "订单取消：";//订单取消
	
	public static final String IN_STRING = "中";//中
	
	public static final String CUSTOMERCODE = "号客人";//号客人
	
	public static final String ADD_STRING = "添加";//添加
	
	public static final String RECOVER_STRING = "恢复";//恢复
	
	public static final String TOTAL_STRING = "Monthly Subtotal：";//账单详情中的“合计”
	
	public static final String YEARTOTAL_STRING = "Yearly Total：";//账单详情中的“本年累计”
	
	public static final String STAR = "准5";//星级中的准5星
	
	/**
	 * 紧急联系人
	 */
	public static final String[] CONTACT = new String[]{
		//苏州联系方式：
		"24 小時紧急联系人:\n"+
			" 1.江南、黄山千岛湖、西安、少林寺： Roberta Chang 張小姐  / Infi Zhang 張先生 18862688102\n"+
			" 2.北京，九寨沟，张家界，云南， 贵州，长江三峡，山東，厦门，珠江，桂林，海南，东北Sandy Zhou 周小姐手機： 18862688103/18862688105\n"+
			" 3.台湾，日本，韩国，泰国，新马泰，越南柬埔寨，新加坡江南，墨西哥，迪拜，印度: Yannie Zhang 张小姐手機:18862688106\n"+
			" 4.中国线路总负责人: Tony Zheng 郑先生手機： 18862688101\n"+
			" 5.参团期间请客人携戴有效证件：比如美国/加拿大护照或绿卡（原件）；如参团期间无法出示有效证件则不能享有当地优惠政策，本公司导游会向客人收取原价参团费用。\n",
			
			
		//北京联系方式：	
			"China Emergency Contact (24/7)\n"+
			"1.Susie:13581680003 \n"+
			"2.Jocelyn:18611577400\n"+
			"3.Yillia:13811457427\n"+
			"4.Beijing Office(Only 9:00AM-5:30PM Beijing Time) 86-10-84605505  OR 86-10-65206752",
			//文景假期欧洲团联系方式：
			"Europe Emergency Contact\n"+
			"Contact：Helen Quach\n"+
			"Tel：626-328-6574\n"+
			"Toll free: 1-844-551-9909",
			//苏州红色字体标注部分
			" 6.自行入住的客人，請在出發前24小時與我們的同事再次聯繫，第一晚入住酒店的地址。\n",
			
	};
	
	/**
	 * orderReceiveItems的type(非团)
	 */
	
	public static String[] SORDERRECEIVEITEMSOFTYPE = new String[]{
		"visa","flight ticket","hotel","ticket","insurance","busTour","cruise","other"
	};
	
	/**
	 * orderReceiveItems的type(团)
	 */
	
	public static String[] TORDERRECEIVEITEMSOFTYPE = new String[]{
		"tour cost","other","discount"
	};
	/**
	 * 财务审核导出 xls
	 */
	public static final String DEPTNAME = "Xian";//部门名
	
	public static final String[] accountType = new String[]{
		"资产类","负债类","所有者权益类","成本类","收入-损益类","费用-损益类"
	};
	
	/**
	 * invoice中给Cynthia Su写死的地址
	 */
	public static String ADDRESSFORINVOICE = "ChinaTour.com International\n"+
											 "680 Brea Canyon Road, Suite 268\nDiamond Bar, CA 91789";
	
	/**
	 * invoice中给Cynthia Su写死的tel
	 */
	
	public static String TELFORINVOICE = "(626)478-3519";
	
	/**
	 * invoice中给Cynthia Su写死的fax
	 */
	
	public static String FAXFORINVOICE = "(909)598-8188";
	
	/**
	 * invoice中给Cynthia Su写死的email
	 */
	
	public static String EMAILFORINVOICE = "inbound@wenjing.com";
	
	/**
	 * invoice中给Cynthia Su写死的英文acc
	 */
	public static String[] ENACCFORINVOICE = { "Bank Name: Chase Bank",
										    "Bank Address: P.O.Box 659754,", 
											"San Antonio, TX 78265-9754",
											"Swift Code: CHASUS33",
											"Rounting Number: 322271627",
											"Account Number: 265655517",
											"Account Name: Chinatour.com",
											"Bank Name: East West Bank华美银行",
											"Bank Address: 668 S. LANE St.#101,",
											"Seattle, WA 98104", 
											"Swift Code: EWBKUS66XXX",
											"Routing Number (ABA): 322070381",
											"Account Number: 8639009839",
											"Account Name : CHINA TRAVEL CA INC.", 
											"(DBA) CHINATOUR.COM INTERNATIONAL"};
	
	/**
	 * invoice中给Cynthia Su写死的中文acc
	 */
	
	public static String[] CHACCFORINVOICE =  {"苏州账户：苏州和平国际旅行社有限公司",
											"公司账户：10550301040011948",
											"开户行地址：农行苏州干将路支行",
											"私人招商银行账户：6225883713219918", 
											"开户名：陈治",
											"开户行地址：郑州市招商银行未来支行纬五路66号"};
	/**
	 * 北京淘宝订单 签证类型
	 */
	public static final String[] VISA_TYPE = new String[] { "日本单次", "日本3年多次", "日本5年多次", 
		"申根","英国", "土耳其", "新加坡", "马来西亚", "加拿大", "美国", "澳大利亚" };
	
	/**
	 * 上传文件路径
	 * 
	 * */
	public static String UPLOADLOCAL = "/mnt/tomcat7/";
	
	
	public static String[] PAYTYPES = {"现金","信用卡","银行卡"};
	
	/**
	 * CRM新修改客人客人默认customerSource
	 */
	public static String CUSTOMERSOURCE=" Returned Customers";
	
	/**
	 * 财务系统接口
	 */
	//public static final String ACCOUNTFORINVOICE = "105Amounts Receivable";
	
	/**
	 * 限定使用财务接口人员id
	 */
	
	public static String[] USERFORACC = {"8fa49720-6c40-11e3-be5b-00163e002f1d","5e9882d0-48e7-11e3-a8e8-0018518addfd","0D72DAC2-2BCA-4175-B47F-5AEB96C0E834"};
	
	/**
	 * AR科目名称
	 */
	public static String SUBFORAR = "10500 · Accounts Receviable";
	
	/**
	 * AP科目名称
	 */
	public static String SUBFORAP = "20100 · Accounts Payable";
	
	public static final String SUBFORUNDEPOSIT = "12000.108 Undeposited Funds";
	
	/**
	 * qb接口数据
	 */
	
	public static final String APPTOKEN = "2602733cbb826b425dbba8fb687c3559ed88";
	public static final String OAUTHCONSUMERKEY = "qyprdDvskX2wUmukGIGmvxZEcLTmKf";
	public static final String OAUTHCONSUMERSECRET = "HbCpOl9txAYkOJOQCrZsFvMWzO7DrGuxFvyf0HiN";
	public static final String APPID = "b7rpewnqnt";
	public static final String COMPANYID = "123145810214857"; //123145774690182
	public static final String REQUEST_TOKEN_URL = "https://oauth.intuit.com/oauth/v1/get_request_token";
	public static final String ACCESS_TOKEN_URL = "https://oauth.intuit.com/oauth/v1/get_access_token";
	public static final String AUTHORIZE_URL = "https://appcenter.intuit.com/connect/begin";
	public static final String ADMIN = "c60f6023-83ce-11e2-bafb-94de800a7ba1";
	
	public static final String VANCOUVER = "B0BEA8CF-3F5C-4BD2-B315-38FEC8F0FEF0";
	public static final String VANCOUVER_LICENSE = "BC Mixed Travel Agent / Wholesaler License #73186";
	public static final String[] VANCOUVER_TERMS = {"Remarks:Please read and check this invoice carefully,our company will not be responsible for any errors after 2 business days.All travel documents will only be sent after your full balance has been made",
													"Refound and Cancellation Policy:For Intertrips's products,items can be 100% cancelled and refunded 30 days prior to the departure.For Other Vender's products,refund policy will be based on their policy which listed on their flyer/brochure/website.For Air,Train,Cruise tickets,please refer to the transportation company's policy."
													};
}
