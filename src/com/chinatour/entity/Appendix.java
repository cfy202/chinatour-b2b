/**
 * 
 */
package com.chinatour.entity;

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
public class Appendix extends BaseUuidEntity {
	
	@JsonProperty
	private String appendixId;
	
	@JsonProperty
	private String appendixFile;	//文件路径
	
	@JsonProperty
	private String appendixName;	//文件名
	
	@JsonProperty
	private String noticeId;		//站内信
	
	@JsonProperty
	private String serverIp;		//服务器IP
}
