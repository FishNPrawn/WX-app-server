package com.example.fishnprawn.wxorder;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderRootDao extends JpaRepository<WxOrderRoot, Integer> {

    List<WxOrderRoot> findByOpenIdAndOrderStatus(String openId, Integer orderStatus);

}
