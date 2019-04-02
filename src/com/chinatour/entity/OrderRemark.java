/**
 * 
 */
package com.chinatour.entity;

import java.util.Date;

import com.chinatour.util.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014-9-4 上午10:25:15
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class OrderRemark extends BaseUuidEntity{
	/**
	 *  
	 */
	private static final long serialVersionUID = 730735218380015718L;
	
	@JsonProperty
	private String orderRemarksId; //Id
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date modifyDate;//修改时间
	
	@JsonProperty
	private String updateRemark; //修改备注
	
	@JsonProperty
	private String orderId; //订单Id
	
	@JsonProperty
	private Integer noticeState; //Op订单修改通知状态  新建通知状态为1，表示通知  2不通知

	@JsonProperty
	private Integer noticeAccountant; //是否通知会计 1.通知  2.不通知
	
	@JsonProperty
	private String userId; //用户id
	
	@JsonProperty
	private String userName; //用户名称
}
