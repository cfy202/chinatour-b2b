package com.chinatour.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinatour.entity.Payment;
import com.chinatour.persistence.PaymentMapper;
import com.chinatour.service.PaymentService;

@Service("paymentServiceServiceImpl")
public class PaymentServiceServiceImpl extends BaseServiceImpl<Payment, String> implements PaymentService {
	
	@Autowired
	private PaymentMapper paymentMapper;

	@Autowired
	public void setBaseMapper(PaymentMapper paymentMapper) {
	    super.setBaseMapper(paymentMapper);
	}
	
	@Override
	public List<Payment> find(Payment payment) {
		return paymentMapper.find(payment);
	}

}
