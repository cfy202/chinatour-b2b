package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Aug 25, 2014 3:36:35 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class GroupLine extends BaseUuidEntity{

	public GroupLine() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GroupLine(String id, String tourCode, String tourName,
			String tripDesc,int isAvailable) {
		super();
		this.setId(id); 
		this.tourCode = tourCode;
		this.tourName = tourName;
		this.tripDesc = tripDesc;
		this.isAvailable = isAvailable;
	}
    
	@JsonProperty
	private String tourCode;  //线路编码（B2B必有）
    
	@JsonProperty
	private String tourName;  //线路名称 ----B2B中名稱必有年份（B2B必有）
	
	@JsonProperty
	private String tourNameEn;  //线路名称（英文）（B2B必有）
    
	@JsonProperty
	private String tripDesc;  //线路描述(统计中的借用字段：Retail 1 or WholeSale 2)
	
	@JsonProperty
	private String brand;  //品牌：中国美,chinatour,文景假期,Nexus Holiday,inbound（B2B必有）
	
	@JsonProperty
	private String tourTypeId;  //团队类别（B2B必有）
	
	@JsonProperty
	private String image;//图片路径
	
	@JsonProperty
	private String departureDate;	//出发日期 (同时在统计中用来存放年份，统计借用字段  格式：YYYY)(借用字段，在同行系统头部使用接收字段)（B2B必有）
	
	@JsonProperty
	private Integer isAvailable;   //是否可用(0:可用  1：不可用)
	
	@JsonProperty
	private String specificItems;  //特殊条款
	
	@JsonProperty
	private Integer type;//佣金类型 0：固定佣金值   1：百分比
	
	@JsonProperty
	private String level;//级别及对应的参数  如一级：值（1:5%）( 現在是产品对人的年龄段划分备注 ex:adult:12岁以上...)
	
	@JsonProperty
	private BigDecimal supplement;//单房差
	
	@JsonProperty
	private BigDecimal selfExpense;//自费  美金（B2B必有）

	@JsonProperty
	private BigDecimal tip;//小费 美金（B2B必有）
	
	@JsonProperty
	private BigDecimal pickSendPrice;//接送机费用
	
	@JsonProperty
	private Integer least;//最少人数
	
	@JsonProperty
	private String destination;//目的地（B2B必有）
	
	@JsonProperty
	private String placeStart;//出发地（B2B必有）
	
	@JsonProperty
	private String attractions;//景点
	
	@JsonProperty
	private Integer ticket;//  是否包含机票 0：不包含，1：包含
	
	@JsonProperty
	private String degree;//Key Words（B2B必有）
	
	@JsonProperty
	private String remark;// 产品摘要（更改为产品天数）（B2B必有）
	
	@JsonProperty
	private String area;// 产品所属区域（B2B必有）
	
	@JsonProperty
	private String Operater;//产品操作中心（B2B必有）
	
	@JsonProperty
	private String source;// 产品的来源，例如某个同行提供的产品，同行名称等（B2B必有）
	
	@JsonProperty
	private String destinationlist;//每个产品目的地列表（B2B必有）
	
	@JsonProperty
	private String lineNo;//產品排序（接口默認源文件編號）
	@JsonProperty
	private String tourNo;//源文件編號（接口默認源文件編號）
	
	@JsonProperty
	private String otherCol;//备用字段（1.标识该产品对自费小费的管理）
	@JsonProperty
	private String isOceania;//用于标记澳洲第三人第四人价产品的B2B下单 为1下单计算流程改变
	@JsonProperty
	private List<GroupRoute> groupRoute;  //行程
	
	@JsonProperty
	private List<Hotel> hotel;  //酒店
	
	@JsonProperty
	private List<GroupLineHotelRel> groupLineHotelRel;  //酒店 	用于查询
	
	@JsonProperty
	private String contactor;  //联系人 	用于查询(统计借用字段，在统计中传递Role)
	
	@JsonProperty
	private Integer isSystem;//系统数据识别     0：agent添加数据     1：系统维护数据 2 同行数据 3 系统非团有线路
	
	@JsonProperty
	private Integer sum;//用于统计 
	
	@JsonProperty
	private String time;//用于统计  格式YYYY-MM

	@JsonProperty
	private String deptId;//用于统计 

	@JsonProperty
	private String role;//用于统计
	
	@JsonProperty
	private String groupId;//组Id(非数据库字段)
	
	@JsonProperty
	private String userId;//非数据库字段
	/*WEB*/
	@JsonProperty
	private List<Order> orderList;
	@JsonProperty
	private BigDecimal pay;//(非数据库字段)
	@JsonProperty
	private BigDecimal cost;//(非数据库字段)
	@JsonProperty
	private BigDecimal commonTourFee; // (非数据库字段)
	/***非数据库字段*****/
	
	@JsonProperty
	private String currencyId;//货币Id
	@JsonProperty
	private BigDecimal adult;//成人价格
	@JsonProperty
	private BigDecimal bed;//5-12岁小孩占床价格
	@JsonProperty
	private BigDecimal notBed;//5-12岁小孩不占床价格
	@JsonProperty
	private BigDecimal children;//2-5岁的小孩的价格
	@JsonProperty
	private BigDecimal baby;//0-2岁婴儿的价格
	@JsonProperty
	private Date departureTime;//时间段
	@JsonProperty
	private BigDecimal price;//该产品的价格
	@JsonProperty
	private BigDecimal settlePrice;//结算价
	@JsonProperty
	private BigDecimal commission;//佣金
	@JsonProperty
	private BigDecimal hotelPrice;//佣金
	@JsonProperty
	private BigDecimal childComm;//佣金
	@JsonProperty
	private String symbol;// 货币币种代表符(添加同行产品时，传递开始时间)
	@JsonProperty
	private String currencyEng;// 货币币种代表符(添加同行产品时，传递结束时间)
	@JsonProperty
	private Integer days;// 货币币种代表符
	@JsonProperty
	private Date dateTime;//用于统计  格式YYYY-MM
	@JsonProperty
	private Dept dept;//借用字段
	@JsonProperty
	private TourTypeOfDept tourTypeOfDept;//借用字段
	@JsonProperty
	private String vender;// 产品的来源，例如某个同行提供的产品，同行名称等
	@JsonProperty
	private String tourType; //tourType作为产品选填属性   原来的TourTypeName
	@JsonProperty
	private String opCenter; //tourType名字
	@JsonProperty
	private Integer addDate;//  是否包含机票 0：不包含，1：包含
}
