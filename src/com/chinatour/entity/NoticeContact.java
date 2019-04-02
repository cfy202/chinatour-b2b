/**
 * 
 */
package com.chinatour.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time 2014-9-16 下午1:10:48
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class NoticeContact extends BaseUuidEntity {
	
	@JsonProperty
	private String noticeContactId;
	
	@JsonProperty
	private String sendUser;		//发件人Id
	
	@JsonProperty
	private String receiveUser;		//收件人Id
	
	@JsonProperty
	private Integer type;				//1 发送; 2 抄送
	
	@JsonProperty
	private Integer state; 				//  0 未读; 1已读	;  2草稿 ; 3非草稿
	
	@JsonProperty
	private String noticeId;		//站内信
	
	@JsonProperty
	private Notice notice;			//查询站内信
	
	@JsonProperty
	private Admin admin;		//查询发件人
	
	private String receiveUserName;	 //查询收件人姓名
	
	private Map<String, String> appendixFile; //上传文件路径和名称
	
	@JsonProperty
	private String title;	//标题 (非储存字段)
}
