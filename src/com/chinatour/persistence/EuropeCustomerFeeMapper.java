package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.EuropeCustomerFee;

@Repository
public interface EuropeCustomerFeeMapper extends BaseMapper<EuropeCustomerFee, String> {
	List<EuropeCustomerFee> findCustomerWithFee(String orderId);
}
