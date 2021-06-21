package com.example.fishnprawn.wxorder;

import com.example.fishnprawn.good.Good;
import com.example.fishnprawn.good.GoodDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
@Slf4j
public class WxOrderUtils {

    @Autowired
    private GoodDao goodDao;

    @Autowired
    private OrderDetailDao orderDetailDao;

    @Autowired
    private OrderRootDao orderRootDao;


    public WxOrderResponse createOrder(WxOrderResponse orderBean){

//        log.error("小程序提交上来的订单={}", orderBean);


        WxOrderRoot orderMaster = new WxOrderRoot();
        BeanUtils.copyProperties(orderBean, orderMaster);

        WxOrderRoot orderRoot = orderRootDao.save(orderMaster);

        for (WxOrderDetail orderDetail : orderBean.getOrderDetailList()) {
            Good foodInfo = goodDao.findById(orderDetail.getGood_id()).orElse(null);
            //订单详情入库
            orderDetail.setGood_id(orderRoot.getOrder_id());
            BeanUtils.copyProperties(foodInfo, orderDetail);
            orderDetailDao.save(orderDetail);
        }

        log.info("[添加订单成功={}]", orderBean);

        return orderBean;
    }
}
