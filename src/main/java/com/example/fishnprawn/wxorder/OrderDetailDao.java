package com.example.fishnprawn.wxorder;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderDetailDao extends JpaRepository<WxOrderDetail, Integer> {

    List<WxOrderDetail> findByOrderId(Integer orderId);

}
