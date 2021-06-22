package com.example.fishnprawn.wxorder;

import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderDetailDao extends JpaRepository<WxOrderDetail, Integer> {
}
