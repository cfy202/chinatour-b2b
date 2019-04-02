package com.chinatour.entity;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * @copyright   Copyright: 2014 
 * @author Nina
 * @create-time Sep 15, 2014 11:00:00 AM
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class TourType extends BaseUuidEntity {
	
	/**
	 *  
	 */
	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String tourTypeId;	//Id

	@JsonProperty
	private String code; //团队类型编号
	
	@JsonProperty
	private String typeName; //团队类型名称
	
	@JsonProperty
	private String brand; //品牌
	
	@JsonProperty
	private Integer type; //团队类型:0 品牌自录入团; 1 品牌系列团; 3 入境系统录入团; 4 入境自录入团
	
	@JsonProperty
	private Integer isDel; //是否删除  0 未删除；1 删除
	
	@JsonProperty
	private BigDecimal priceExpression; //操作费结算方式
	
	@JsonProperty
	private String operater;//操作中心
	
	private List<TourTypeOfDept> tourTypeOfDeptList;
}
