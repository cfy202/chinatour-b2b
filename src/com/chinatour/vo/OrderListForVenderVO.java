package com.chinatour.vo;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

import com.chinatour.entity.Order;

@Data
@EqualsAndHashCode(callSuper = false)
public class OrderListForVenderVO {
	private List<Order> orderList;
	private String venderId; 
}
