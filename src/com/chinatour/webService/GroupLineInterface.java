package com.chinatour.webService;

import java.text.ParseException;
import javax.jws.WebService;

import com.chinatour.entity.Order;
/**
 * @copyright   Copyright: 2014 
 * @create-time Aug 29, 2014 4:48:04 PM
 * @revision  3.0
 */
@WebService
public interface GroupLineInterface {
	/**线路接口*/
	public String getGroupLine();
	/**
	 * 订单接口
	 * @throws ParseException 
	 * */
	public String saveOrder(String order, String customerList, String tourInfoOfOrder) throws ParseException;
	/**
	 * 订单成本统计
	 * 
	 * */
	public String getStatisticsRevenueCost(String userId,String orderFinance);
	/**
	 *根据订单号返回订单详情 
	 * */
	public String[] getByOrderNo(String userId,String orderNo);
	/**
	 * 形成确认
	 * */
	/*public String getItineraryinfo();*/
	/**
	 * 語種
	 * */
	public String getLanguage();
	/**
	 * 修改订单内容
	 * */
	public String updateOrder(String orderNo,String productVO) throws ParseException;
	
	/**
	 * 内部使用
	 * */
	public String getList();
	/**
	 * 网站提交订单，带费用详情（已付款）
	 * */
	public String saveOrderWeb(String order, String customerList, String tourInfoOfOrder,String  receivableInfoOfOrder)throws ParseException;
	/**
	 * 根据产品
	 * */
	public String getGroupLineByCode(String tourCode,String source);
	/**
	 * 添加产品（来自网站的Product）
	 * */
	public String addGroupLine(String groupline);
	
	/**
	 * 添加自选项（来自网站）
	 */
	public String addOptionalExcurition(String OptionalExcurition);
}
