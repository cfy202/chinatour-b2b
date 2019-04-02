package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.chinatour.util.JsonDateSerializer;
import com.chinatour.vo.SingleOrdersVO;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * @copyright Copyright: 2014
 * @author Jared
 * @create-time Sep 3, 2014 11:32:19 AM
 * @revision 3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Order extends BaseUuidEntity {

	@JsonProperty
	private String orderNo; // 订单号
	@JsonProperty
	private String orderId; // 订单号

	@JsonProperty
	private String orderNoIn; // 订单号（拓展）(2016/01/20将字段更改类型，用来标识网站接口接入类型)

	@JsonProperty
	private Integer totalPeople; // 总人数

	@JsonProperty
	private BigDecimal commonTourFee; // 总团款

	@JsonProperty
	private Integer tax; // 结算状态  0 未结算, 2 已结算 未发0.05Invoice, 3 结算申请, 4 已结算

	@JsonProperty
	private Integer state; // 0 new, 2 已组团 , 3 update, 4 申请订单取消中, 5 已取消, 6.订单取消, 7.申请订单恢复中   

	@JsonProperty
	private String userId; // 用户ID

	@JsonProperty
	private String tourTypeId; // 团队类型ID

	@JsonProperty
	private String tourCode; // 团号

	@JsonProperty
	private String tourId; // 团ID

	@JsonProperty
	private String peerId; // 同行ID

	@JsonProperty
	private String contact; // 联系人

	@JsonProperty
	private Integer orderType; // 订单类型 1.团订单 2.同行团订单 5.非团订单
	
	@JsonProperty
	private String brand; // 品牌  

	@JsonProperty
	private String orderTourType; // 订单组团类型: brand_sys,brand_self,inbound_sys,inbound_self,hotel,flight,cruise

	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDate; // 非团机票航班出发日期

	@JsonProperty
	private String flightPnr; // 非团机票航班

	@JsonProperty
	private String nonGroupType; // 非团类型（签证、机票、保险、酒店等）

	@JsonProperty
	private String peerUserId; // 同行用户下单
	
	@JsonProperty
	private String peerUserName; // 同行用户名称

	@JsonProperty
	private BigDecimal peerUserFee; // 同行用户收款

	@JsonProperty
	private Integer noticeState; // 通知OP订单修改状态

	@JsonProperty
	private Integer payState; // 财务收/付款审核状态

	@JsonProperty
	private Integer warnState; // 会计订单修改通知状态		2表示通知  0不通知 1财务已查看状态

	@JsonProperty
	private Integer peerState; // 会计审核同行付款状态

	@JsonProperty
	private Integer reviewState; // 同行用户下单状态（0.默认值新下订单、1.同行下单申请通过，订单未支付   、2.审核通过，订单未支付 、3.审核不通过  ，订单未支付 、4.审核通过,同行订单已支付,5.修改订单，审核未通过,6.Agent之前审核通过，Agency User再次更改，Agent再次审核）

	@JsonProperty
	private Integer costState; // 同行订单支付状态(0:默认状态，在同行订单下才有意义，1：Agent申请支付状态，2.财务确认支付，3.财务拒绝申请)
	
	@JsonProperty
	private String peerUserRemark;//同行订单审核时的Agent审核备注
	
	@JsonProperty
	private String refNo;//同行自己的订单编号

	@JsonProperty
	private String ordersTotalId; // 订单总表ID
	
	@JsonProperty
	private String deptId; // 部门ID
	
	@JsonProperty
	private Integer isSelfOrganize; //是否自组  1为自组，0为非自组,2 other booking
	
	@JsonProperty
	private BigDecimal rate; //汇率 默认为1
	
	@JsonProperty
	private BigDecimal peerUserRate; //同行用户订单使用的汇率
	
	@JsonProperty
	private BigDecimal cusPrice;//存储订单的团款（只是客人的，不包含其他费用）
	
	@JsonProperty
	private String postInfo;//更改为同行下载提醒
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date checkOutDate; //出签日期
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date sendingDate; //送签日期
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date pinSigningDate; //销签日期

	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date  checkTime; // 结算时间 		agent申请结算则是 agent结算时间  财务结算 则是财务结算时间 

	@JsonProperty
	private Integer planticket; // 国内机票  	 0 两者兼有,1 自订, 2 代订  
	
	@JsonProperty
	private String otherInfo; // agent自订航班信息备注
	
	@JsonProperty
	private String reference; //非团对外的引用
	
	@JsonProperty
	private Customer customer; // 储存该订单联系人信息（非储存字段）

	@JsonProperty
	private String userName; // 用于查询 下单用户名或agent（非储存字段）

	@JsonProperty
	private String groupId; // 用于查询 小组下单

	@JsonProperty
	private List<PayCostRecords> payCostRecords; // 用于查询  收入支出
	
	@JsonProperty
	private BigDecimal profit; // 利润	用于查询 (借用：单房差传递字段)
	
	@JsonProperty
	private BigDecimal agentProfit; // agent利润	用于查询 （同行用户中借用自费）
	
	@JsonProperty
	private BigDecimal opProfit; // op利润	用于查询 （同行用户中借用小费）
	
	@JsonProperty
	private BigDecimal payTotalSum; // 总收入 	用于查询  （同行用户中借用续住）
	
	@JsonProperty
	private BigDecimal costTotalSum; // 总支出 	用于查询 （同行用户中借用接送机费用）
	
	@JsonProperty
	private BigDecimal singleProfit; // 非团利润（自组）	用于查询 （同行用户中借用单房差）
	
	@JsonProperty
	private Integer type; //成本类型：手动生成：0  ；  账单自动生成：（ 1.地接  2.酒店 3.机票  4.保险  5其他）变更单生成：9		用于查询 
	
	@JsonProperty
	private Integer sprCheck;// 审核状态:0 未审核 1 全部审核通过	 2  Agent审核未通过	3	会计审核通过 	4 会计审核未通过 5	已结算    用于查询 
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date arriveDateTime; // 抵达时间		用于查询 
	
	@JsonProperty
	private List<CustomerOrderRel> customerOrderRel;//订单中客人
	
	@JsonProperty
	private String deptName; // 用于查询  部门名称
	
	@JsonProperty
	private Integer flag;		//标示字段（0：系统下单；1：webservice下单）
	
	@JsonProperty
	private String lineName; // 用于查询  部门名称
	
	@JsonProperty
	private Integer customerTourNo; // 用于查询  团下客人编号
	
	@JsonProperty
	private Integer customerOrderNo; // 用于查询  订单下客人编号
	
	@JsonProperty
	private Integer isDel; // 用于查询   customerOrderRel  是否已被删除  0 未删除，1 已删除， 5 删除中 cancelling
	
	@JsonProperty
	private String customerOrderRelId; // 用于查询   id
	
	private List<CustomerFlight> customerFlightList; //对应的出入境航班信息（非储存字段)
	
	@JsonProperty
	private String guestRoomType; // 用于查询  
	
	@JsonProperty
	private String scheduleLineCode; // 用于查询   线路编号
	
	/**
	 * 列表时间查询时传输数据(非储存字段)
	 * 开始日期
	 */
	@JsonProperty
	private Date bookingBeginningDate; //(借用字段，在统计中用来存储time)
	
	/**
	 * 列表时间查询时传输数据(非储存字段)
	 * 结束日期
	 */
	@JsonProperty
	private Date bookingEndingDate;	   //(借用字段，在统计中用来存储Year)
	
	@JsonProperty
	private String contactName;//webservice  总订单联系人    (借用字段，在统计中用来存储RegionId)

	@JsonProperty
	private PayCostRecords payCost;//收入支出
	
	@JsonProperty
	private Date arrivalBeginningDate; //抵达日期时间查询
	
	@JsonProperty
	private Date arrivalEndingDate; //抵达日期时间查询
	
	@JsonProperty
	private Date settlementDateBeg; //结算时间查询
	
	@JsonProperty
	private Date settlementDateEnd; //结算时间查询
	
	@JsonProperty
	private Date beginningCheckOutDate;  //开始出签日期
	
	@JsonProperty
	private Date endingCheckOutDate;   //终止出签日期
	
	@JsonProperty
	private Date beginningSendingDate;  //开始送签日期
	
	@JsonProperty
	private Date endingSendingDate;   //终止送签日期
	
	@JsonProperty
	private Date beginningPinSigningDate;  //开始销签日期
	
	@JsonProperty
	private Date endingPinSigningDate;   //终止销签日期
	
	@JsonProperty
	private String ticketType; //用户传递客人的机票类型(借用字段，在统计明细中用来判断Booking还是Arrival)
	
	@JsonProperty
	private String time;	//统计使用字段(非数据库)
	@JsonProperty
	private String year;	//统计使用字段(非数据库)
	@JsonProperty
	private String role;	//统计使用字段(非数据库)
	@JsonProperty
	private BigDecimal pay; // 总团款(非数据库)
	@JsonProperty
	private BigDecimal cost; // 总团款(非数据库)(存储totalFeeOfOthers)
	@JsonProperty
	private String wr;//零售或批发(非数据库)(在团下查看客人时，存储voucherStr内容)
	@JsonProperty
	private String groupLineId;//零售或批发(非数据库)
	
	@JsonProperty
	private String tourTypeName;//团队类型名称
	
	@JsonProperty
	private BigDecimal priceExpression; //操作费结算方式(非数据库)(存储discounts)

	@JsonProperty
	private String source;	//产品供应商
	
	//WEB
	@JsonProperty
	private List<Customer> customerList;//客人
	@JsonProperty
	private String arrivaDate;
	
	@JsonProperty
	private String sourceName;
	
	@JsonProperty 
	private String lastName; //姓
	
	@JsonProperty
	private String firstName; //名
	
	@JsonProperty
	private String middleName; //中间名称
	
	@JsonProperty
	private String carId;      //非数据库字段，给客人拼车时使用
	
	@JsonProperty
	private String carName;      //非数据库字段，给客人拼车时使用
	@JsonProperty
	private Integer sorceId; //判断系统同行订单
	
	@JsonProperty
	private SingleOrdersVO singleOrdersVO;//非团的封装
	@JsonProperty
	private Integer isSuccess;//是否同步到qb
	@JsonProperty
	private Integer isEdit;//判断订单是否修改
	@JsonProperty
	private Integer ifUpdateSuc;
	@JsonProperty
	private String itInfo;//判断OP是否添加导游等信息
	@JsonProperty
	private String optionalId;//自选项Id(统计使用)
	@JsonProperty
	private List<ReceivableInfoOfOrder> receivableInfoOfOrders; //费用信息(导出excel使用)
	/**
	 * 返回订单状态的详细描述
	 * 
	 * @return
	 */
	public String getStateDetail() {
		if (state == null) {
			return "";
		}
		switch (state) {
		   case 0 : return "NEW";
		   case 2 : return "已组团";
		   case 3 : return "update";
		   case 4 : return "申请客人取消中";
		   case 5 : return "已取消";
		   case 6 : return "订单取消";
		   default : return "";
 		}
	}
	public static final String BRAND_SYS = "brand_sys";
	public static final String BRAND_SELF = "brand_self";
	public static final String INBOUND_SYS = "inbound_sys";
	public static final String INBOUND_SELF = "inbound_self";
}
