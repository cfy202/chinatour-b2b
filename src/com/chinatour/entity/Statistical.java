/**
 * 
 */
package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import sun.awt.PeerEvent;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;


/**
 * 统计(非数据库表)
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-01-13 下午14:39:46
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Statistical extends BaseUuidEntity{
	@JsonProperty
	private String agent;					//用户名称
	@JsonProperty	
	private String userId;					//用户Id
	@JsonProperty
	private String deptId;					//公司Id
	@JsonProperty
	private String deptName;				//公司名称
	@JsonProperty
	private int jan;						//一月
	@JsonProperty
	private int feb;						//二月
	@JsonProperty
	private int mar;						//三月
	@JsonProperty
	private int apr;						//四月
	@JsonProperty
	private int may;						//五月
	@JsonProperty
	private int jun;						//六月
	@JsonProperty
	private int jul;						//七月
	@JsonProperty
	private int aug;						//八月
	@JsonProperty
	private int sep;						//九月
	@JsonProperty
	private int oct;						//十月
	@JsonProperty
	private int nov; 						//十一月
	@JsonProperty
	private int dec;						//十二月
	@JsonProperty
	private int total; 						//合计
	@JsonProperty
	private String time;					//时间
	@JsonProperty
	private int sum;						//总和
	@JsonProperty
	private String role;					//角色（用来统计判断）
	@JsonProperty
	private String regionId;			    //区域Id（用来统计判断）
	@JsonProperty
	private Integer orderTourType; 			//团队语言类型  1.中文团  2.英文团   3.西语团 5 单订业务 ； 统计中  空表示所有，0表示组团业务，5表示单订业务
	@JsonProperty
	private BigDecimal sumFee; 				// 金额（用来统计）
	@JsonProperty
	private String Brand; 					// 品牌
	@JsonProperty
	private int isSystem;					//产品来源   0.人为添加   1.系统维护
	@JsonProperty
	private String venderName;				//同行名称
	
	private List<Vender> venderList;			//同行集合显示
	private List<GroupLine> groupLineList;		//产品集合显示
	private List<Order> orderList;				//订单集合显示
	private List<SupplierPriceForOrder> flightList;	//机票集合显示
	private List<OptionalExcurition> optionalExcuritions;		//自选项集合显示
	
	@JsonProperty
	private Integer isSelfOrganize; //是否自组  1为自组，0为非自组
	@JsonProperty
	private Integer orderType; // 订单类型 1.团订单 2.同行团订单 5.非团订单   10.在统计中表示入境订单
	@JsonProperty
	private String groupId;//组Id
	@JsonProperty
	private double commonTourFee; // 总团款
	@JsonProperty
	private double profit;//总利润
	
	@JsonProperty
	private String Source;//客人来源
	
	@JsonProperty
	private String month;//月份
	
	@JsonProperty
	private String date;//日期
	
	private List<Statistical> SList;
	
	@JsonProperty
	private double totalPay;
	
	@JsonProperty
	private double totalCost;
	
	@JsonProperty
	private String bDate;
	@JsonProperty
	private String eDate;
}
