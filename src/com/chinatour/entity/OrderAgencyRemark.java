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
 *同行订单修改日志
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-11-2
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class OrderAgencyRemark extends BaseUuidEntity{
	/**
	 *  
	 */
	private static final long serialVersionUID = 730735218380015718L;
	
	@JsonProperty
	private String orderAgencyRemarksId; //Id
	
	@JsonProperty
	@JsonSerialize(using = JsonDateSerializer.class)
	private Date modifyDate;//修改时间
	
	@JsonProperty
	private String updateRemark; //修改备注
	
	@JsonProperty
	private String orderId; //订单Id

	@JsonProperty
	private String userId; //用户id
	
	@JsonProperty
	private String userName; //用户名称
}
