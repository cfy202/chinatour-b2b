package com.chinatour.entity;

import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.fasterxml.jackson.annotation.JsonProperty;

@Data
@EqualsAndHashCode(callSuper = false)
public class CustomerConsult extends BaseUuidEntity {
	@JsonProperty
	private String customerConsultId;
	@JsonProperty
	private String customerId;
	@JsonProperty
	private String userId;
	@JsonProperty
	private String consultMethod;
	@JsonProperty
	private String consultContent;
	@JsonProperty
	private String userName;
	@JsonProperty
	private String createDateStr;
	@JsonProperty
	private String deptId;
	@JsonProperty
	private String customerSource;
	@JsonProperty
	private String deptName;
	@JsonProperty
	private Date endDate;
	@JsonProperty
	private Integer endDateForString;
	@JsonProperty
	private String tel;
	@JsonProperty
	private String firstName;
	@JsonProperty
	private String middleName;
	@JsonProperty
	private String lastName;
}
