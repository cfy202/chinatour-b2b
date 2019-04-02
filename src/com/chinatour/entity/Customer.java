package com.chinatour.entity;

import java.util.Date;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 3, 2014 3:00:00 PM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Customer extends BaseUuidEntity {
	
	private static final long serialVersionUID = 7065110973203482161L;

	@JsonProperty
	private String customerId; //顾客id编号
	
	@JsonProperty
	private String customerCode; //顾客编码
	
	@JsonProperty 
	private String lastName; //姓
	
	@JsonProperty
	private String firstName; //名
	
	@JsonProperty
	private String middleName; //中间名称
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date dateOfBirth; //出生日期
	
	@JsonProperty
	private Integer sex; //性别   1 女 F；2 男 M
	
	@JsonProperty
	private String memoOfCustomer; //客人备注：新客人、老客人、老人、小孩等
	
	@JsonProperty
	private String nationalityOfPassport; //护照国籍
	
	@JsonProperty 
	private String passportNo; //护照号码
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date expireDateOfPassport; //护照有效期
	
	@JsonProperty
	private String streetAddress; //联系地址
	
	@JsonProperty
	private String cityId; //城市
	
	@JsonProperty
	private String tel; //联系电话
	
	@JsonProperty
	private String mobile; //移动电话
	
	@JsonProperty
	private String email; //邮箱
	
	@JsonProperty
	private String zip; //邮编
	
	@JsonProperty
	private String otherInfo; //订单中其他备注信息
	
	@JsonProperty
	private String languageId; //语种ID
	
	@JsonProperty
	private String stateId; //州ID
	
	@JsonProperty
	private String countryId; //国家ID
	
	@JsonProperty
	private String customerSource; //客人来源：参团、 单订酒店、机票等
	
	@JsonProperty
	private String residency;//居住地
	
	@JsonProperty
	private Integer isDel; //是否删除  0:可用；	1：不可用
	
	@JsonProperty
	private Integer advertised; //修改信息通知状态：是，否
	
	@JsonProperty
	private Integer type;//客人年龄阶段：0：默认，1：婴儿，2：儿童，3：小孩，4：成人
	
	@JsonProperty
	private String planticket; //定机票类别：1:自订; 2:代订; 3:两者兼有 
	
	@JsonProperty
	private String payHistoryInfo; //客人备注
	
	@JsonProperty
	private String peerId;

	@JsonProperty
	private City city; //城市实体
	
	@JsonProperty
	private Country country; //国家实体
	
	@JsonProperty
	private State state; //州实体
	
	@JsonProperty
	private Language language;//语种实体
	
    private String guestRoomType; //传输数据用于存储房型
    
    @JsonProperty
    private Integer customerTourNo; //客人在团内的编号  非数据库内容
    
    @JsonProperty
    private Integer customerOrderNo;  //客人在子单中的编号
    
    private List<CustomerFlight> customerFlight;  //客人对应的航班；
    
    private List<CustomerFlight> customerFlightList; //关于航班信息临时存储(webService)
    @JsonProperty
    private String birthday; //传输数据用于存储房型(webService)
    @JsonProperty
    private String passportDate; //传输数据用于存储房型(webService)
    @JsonProperty
    private Integer roomNumber;//传输数据用于存储房型(webService)
    @JsonProperty
    private String message;//导入客人时产生的操作信息

    @JsonProperty
    private Integer roomIsFull;//导入客人时产生的操作信息
    
    @JsonProperty
    private String ticketType; //用于传输客人的机票类型(非储存字段)(同行系统中临时存储customerOrderRel)
    
    @JsonProperty
    private String brand; //订单品牌(非储存字段)
    
    @JsonProperty
    @JsonSerialize(using = JsonDateSerializer.class)
    private Date bookDate; //下单日期(非储存字段)
    
    @JsonProperty
    @JsonSerialize(using = JsonDateSerializer.class)
    private Date beginDateForBook; //下单日期(非储存字段)
    
    @JsonProperty
    @JsonSerialize(using = JsonDateSerializer.class)
    private Date endDateForBook; //下单日期(非储存字段)
    @JsonProperty
    private String customerInfo;   //非数据库字段，用于模糊查询客人
    @JsonProperty
    private List<String> customerInfos; //非数据库字段，用于模糊查询客人带有空格
    @JsonProperty
    private Integer start;            //和num都是在查询客人时传入后台的值
    @JsonProperty
    private Integer num;
    @JsonProperty
    private List<CustomerConsult> customerConsultList;  //非数据库字段(客人咨询内容)
    @JsonProperty
    private Integer wr;//区分同行与直客
    @JsonProperty
    private Integer isNew;  //判断该客人是第几次咨询
    @JsonProperty
    private String carName;  //非数据库字段
    @JsonProperty
    private String voucherStr;  //非数据库字段
    @JsonProperty
    private String companyId;  //非数据库字段(用于财务系统接口)
    @JsonProperty
    private String companyName;  //非数据库字段(用于财务系统接口)
    @JsonProperty
    private String displayName;  //非数据库字段(用于财务系统接口)
    @JsonProperty
    private String orderNo; //关联客人查询使用
    @JsonProperty
    private String orderId;
}
