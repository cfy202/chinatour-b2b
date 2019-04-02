package com.chinatour.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinatour.entity.Payment;
@Repository
public interface PaymentMapper extends BaseMapper<Payment, String>  {
   List<Payment> findByOrderId(String orderId);
}