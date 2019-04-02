package com.chinatour.entity;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
@Data
@EqualsAndHashCode(callSuper = false)
public class FlightWithCustomers {
	private CustomerFlight customerFlight;
	private List<Customer> customerList;
	private int customerSize;
}
