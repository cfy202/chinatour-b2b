package com.chinatour.service;

import java.util.List;

import com.chinatour.entity.Payment;

public interface PaymentService extends BaseService<Payment, String> {
	List<Payment> find(Payment payment);
}
