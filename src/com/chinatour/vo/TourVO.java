package com.chinatour.vo;

import java.util.Date;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Oct 8, 2014 9:00:12 PM
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TourVO {
	
	private String id;

	private int customerOrderNo;
	
	private int isDel;
	
	private int state;
	
	private String tourCode;
	
	private String orderNo;
	
	private int totalPeople;
	
	private String lastName;
	
	private String firstName;

	private String middleName;
	
	private String ticketType;
	
	private String agent;
	
	private String ordersTotalId;
	
	private String orderId;
	
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date dateOfBirth;
	
	private String nationalityOfPassport; //护照国籍
	
	private String passportNo; //护照号码
	
	private String customerOrderRelId; // 订单客人表Id
	
	private String voucherStr; 
}
