package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;


/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time Jan 30, 2015 9:48:04 AM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class OrderFinanceInvoice extends BaseUuidEntity {
	private Date 		createTime;		
	private Date      	statisticalTime;		//结算日期
	private String 		orderId;				//訂單ID
	private String 		userName;				//用戶姓名
	private	Integer		status;					//狀態
	private BigDecimal	receivedMoney;			//收入金額
	private BigDecimal	receivableMoney;		//應收團款
	private BigDecimal	costMoney;				//成本金額
	private	String		deptId;          		//部門Id
	private Date 		startTime;				//開始時間
	private Date 		endTime;				//結束時間
	private String		tourId;					//用于查询
	private BigDecimal	sumDebit;				
	private BigDecimal	sumCredit;
	private String		orderNo;				//訂單號
	private String 		tourCode;				//團號
    private Integer 	tax;		      		//是否结算 
    private int 		state;
    private String 		userId;					//用戶ID
    private Integer 	orderTourType;			//訂單類型
    private String 		tourType;				//團類型
    private String 		ReceivableInfoOfOrderId;//費用明細
    private Date 		balanceDate;			//結算日期
}
