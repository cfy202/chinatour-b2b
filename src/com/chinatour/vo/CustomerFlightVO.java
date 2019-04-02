package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.CustomerFlight;

@Data
@EqualsAndHashCode(callSuper = false)
public class CustomerFlightVO {
	private List<CustomerFlight> customerFlightList;
	private String customerOrderRelIds;
	private String tourId;
	private String tourCode;
	private String ticketType;
	
}
