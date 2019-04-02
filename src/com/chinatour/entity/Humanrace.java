package com.chinatour.entity;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Entity 种族
 * 
 * @copyright   Copyright: 2014 
 * @author jacky
 * @create-time 2014-9-30 下午5:03:51
 * @revision  3.0
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class Humanrace extends BaseUuidEntity {

	private static final long serialVersionUID = 7065110973203482161L;
	
	@JsonProperty
	private String humanRaceId;//种族id

	@JsonProperty
	private String humanRace;//种族

}
