package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-9-19 上午11:37:13
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Language extends BaseUuidEntity {


	@JsonProperty
	private String languageId; // 语种编号

	@JsonProperty
	private String language; // 语种

	@JsonProperty
	private int Sort; // 排序
}
