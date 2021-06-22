package com.example.fishnprawn.wxorder;

import com.example.fishnprawn.good.Good;
import com.example.fishnprawn.good.GoodDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;


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


        WxOrderRoot wxOrderRoot = new WxOrderRoot();
        BeanUtils.copyProperties(orderBean, wxOrderRoot);

        WxOrderRoot orderRoot = orderRootDao.save(wxOrderRoot);

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

    //查询单个订单
    public WxOrderResponse findOne(Integer order_id) {

        WxOrderRoot wxOrderRoot = orderRootDao.findById(order_id).orElse(null);

        List<WxOrderDetail> orderDetailList = orderDetailDao.findByOrderId(order_id);

        WxOrderResponse orderDTO = new WxOrderResponse();
        BeanUtils.copyProperties(wxOrderRoot, orderDTO);
        orderDTO.setOrderDetailList(orderDetailList);

        return orderDTO;
    }


}
