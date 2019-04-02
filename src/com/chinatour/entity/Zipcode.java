package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;
/**
 * 邮政编码
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2015-10-30 上午9:56:19
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Zipcode extends BaseUuidEntity {
	@JsonProperty
    private String id;//
	@JsonProperty
    private String areacode;//地区编号
	@JsonProperty
    private String country;//国家
	@JsonProperty
    private String state;//省
	@JsonProperty
    private String city;//城市
	@JsonProperty
    private String code;//编号

}