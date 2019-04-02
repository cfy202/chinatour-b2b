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
 * @author Aries
 * @create-time 2015-11-9 下午2:44:52
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class Contacts extends BaseUuidEntity{
	@JsonProperty
	private String contactsId;
	
	@JsonProperty
	private String contactsName;//联系人姓名
	
	@JsonProperty
	private String peerUserId;//Agency UserId;
	
	@JsonProperty
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date createDate;//创建时间
	
	@JsonProperty
	private String isDel;//是否删除：0：使用，1：删除

}
