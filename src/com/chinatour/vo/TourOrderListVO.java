package com.chinatour.vo;

import java.math.BigDecimal;
import java.util.Date;

import com.chinatour.entity.PayCostRecords;
import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class TourOrderListVO {
	
	private String id;
	
	private String orderNo;
	
	private String orderNoIn;
	
	private String tourId;
	
	private String tourCode;
	
	private String lineName;
	
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date scheduleOfArriveTime;
	
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date createDate;
	
	private Integer totalPeople;
	
	private String state;
	
	private BigDecimal sumFee;
	
	private BigDecimal peerUserFee;
	
	private String peerUserRemark;
	
	private Integer tax;
	
	private Integer payState;
	
	private Integer warnState;

	private Integer ReviewState;
	
	private String userId;
	
	private String userName;
	
	private String deptName;
	
	private Integer orderType; // 订单类型 1.团订单 2.同行团订单 5.非团订单
	
	private Integer isSelfOrganize; //是否自组  1为自组，0为非自组
	
	private String ordersTotalId;
	
	private String peerName;//同行名称
	
	private String brand;//同行名称
	
	private String scheduleLineCode;//线路编号
	
	private String tourTypeName;//团队类型名称
	
	private String flightPnr;//非团机票
	
	private String contact;//联系人
	
	private String refNo;//同行自己输入的内容
	
	private PayCostRecords payCost;//收入支出
	
	private BigDecimal payTotalSum; // 总收入 	用于查询  
	
	private BigDecimal costTotalSum; // 总支出 	用于查询
	
	private Integer costState;//同行支付状态
	
	private String peerUserName;//同行名称
	private String postInfo;//同行名称
	private String source;//产品供应商
	private String itInfo;//此订单对应的团是否被Op修改
	
}
