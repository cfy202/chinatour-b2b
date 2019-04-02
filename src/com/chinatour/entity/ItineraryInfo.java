package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @copyright   Copyright: 2014 
 * @author Pis
 * @create-time 2014/8/26 上午10:47:24
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class ItineraryInfo extends BaseUuidEntity{

    /**
	 * 
	 */
	private static final long serialVersionUID = -4672510501552350959L;
	
	@JsonProperty
	private String itineraryInfoId; //确认单id
	
	@JsonProperty
	private String tourName; //线路名称
	
	@JsonProperty
	private String tourCode; //线路编号
	
	@JsonProperty
	private String itineraryInfo; //行程描述
	
	@JsonProperty
	private String hotelInfo; //酒店信息
	
	@JsonProperty
	private String contact; //联系方式
	
	@JsonProperty
	private String tourId; //
	
	@JsonProperty
	private Integer isDel; //是否删除 0:不删除; 1:删除; default 0
	
	
}
