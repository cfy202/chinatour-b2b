/**
 * 
 */
package com.chinatour.entity;

import java.util.ArrayList;
import java.util.List;

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
public class Notice extends BaseUuidEntity {
	
	@JsonProperty
	private String noticeId;
	
	@JsonProperty
	private String title;	//标题
	
	@JsonProperty
	private String content;		//站内信内容
	
	@JsonProperty
	private int isDel; //是否删除 0 未删除；1 删除
	
	private List <Appendix> appendixList = new ArrayList<Appendix>();
}
