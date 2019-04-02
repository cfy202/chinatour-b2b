package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 用户区域关系
 * 
 * @copyright Copyright: 2014
 * @author jacky
 * @create-time 2014-11-24 下午3:45:23
 * @revision 3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class AdminRegion implements Serializable {
	/**
	 * 用户编号
	 */
	private String adminId;

	/**
	 * 区域编号
	 */
	private String regionId;
	
	/**
	 * 地区实体
	 */
	private Region region;
}
