/**
 * 
 */
package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @copyright   Copyright: 2015 
 * @author Aries
 * @create-time 2015-5-29 下午1:59:32
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper=true)
public class News extends BaseEntity {
	
	@JsonProperty
	private String newsId;//新闻ID
	
	@JsonProperty
	private String title;//新闻标题
	
	@JsonProperty
	private String content;//新闻内容
	
	@JsonProperty
	private String image;//新闻图片
	
	@JsonProperty
	private String userId;//添加新闻的用户
	
	@JsonProperty
	private Integer isAvailable ;//是否可用  0.可用 默认值   1.已取消的新闻
	
	@JsonProperty
	private String createDateStr;//添加新闻时间
	@JsonProperty
	private Integer isSystem ;//  0.默认值   1.系统可以看见   2 同行可以看见   12 都可以看到
	@JsonProperty
	private String currency;//新闻针对的国家
	
	@JsonProperty
	private Integer startPage ;//用于查询
	
}
