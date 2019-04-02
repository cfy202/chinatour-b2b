package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.Customer;
import com.chinatour.entity.Vender;

/**
 * @copyright   Copyright: 2014 
 * @author Jared
 * @create-time Sep 25, 2014 8:16:10 PM
 * @revision  3.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TourOrdersVO {
	
	private List<Customer> customerList;
	
	private Customer shareCustomer;
	
	private Vender vender;
    
	private List<EachGroupLineOrder> eachGroupLineOrderList; 
	
}
