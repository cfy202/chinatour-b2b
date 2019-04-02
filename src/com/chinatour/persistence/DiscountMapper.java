package com.chinatour.persistence;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Discount;

/**
 * @copyright   Copyright: 2014 
 * @revision  3.0
 */
@Repository
public interface DiscountMapper extends BaseMapper<Discount, String> {
	Discount findByOrderId(String orderId);
}
