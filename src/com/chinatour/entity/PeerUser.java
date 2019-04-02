package com.chinatour.entity;

import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.vo.ProductVO;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time Sep 15, 2014 11:00:00 AM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class PeerUser extends BaseUuidEntity {
	
	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String peerUserId;	//Id

	@JsonProperty
	private String peerUserName; //同行用户名称
	
	@JsonProperty 
	private String password; //密码
	
	@JsonProperty
	private String peerId; //同行ID
	
	@JsonProperty
	private String userId; //AgentID   记录添加同行用户的Agent
	
	@JsonProperty
	private Integer isAvailable; //是否可用  0 可用     1，不可用
	
	@JsonProperty
	private String currencyTypeId;//同行用户使用的货币类型
	
	@JsonProperty
	private Integer level; //同行级别 0：默认值，级别分：1、2、3
	
	@JsonProperty
	private String brandMange;//同行可选的品牌管理
	
	@JsonProperty
	private String logoAddress;//LOGO存放地址
	
	@JsonProperty
	private String authority; //同行权限  0 默认销售权限  1经理权限
	
	@JsonProperty
	private TourInfoForOrder tourInfoForOrder;
	
	@JsonProperty
	private List<Customer> customer;
	
	@JsonProperty
	private ProductVO productVO;
	
	@JsonProperty
	private String cusId;
	
	@JsonProperty
	private String memoOfCustomer;
	
	@JsonProperty
	private Integer totalPeople;
	
	@JsonProperty
	private String area;//同行用户所在区域
	
	@JsonProperty
	private String delOrl;//非数据字段，应删除的customerOderRelID
	
}
