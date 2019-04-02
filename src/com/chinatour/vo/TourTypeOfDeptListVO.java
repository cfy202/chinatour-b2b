package com.chinatour.vo;

import java.util.Date;
import java.util.List;

import com.chinatour.entity.TourTypeOfDept;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;

/** 
 * 团队类型   集合
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-12-3 上午9:21:35
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TourTypeOfDeptListVO {
	
	private List<TourTypeOfDept> tourTypeOfDeptList;//团队类型

}
