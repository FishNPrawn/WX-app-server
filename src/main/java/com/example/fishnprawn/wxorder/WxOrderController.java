package com.example.fishnprawn.wxorder;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RequestMapping(WxOrderController.BASE_URL)
@RestController
@Slf4j
public class WxOrderController {

    public static final String BASE_URL = "/order";

    @Autowired
    private WxOrderUtils wxOrder;

    @PostMapping("/create")
    @Transactional
    public String create(@Valid OrderReq orderReq){
        //数据转换
        WxOrderResponse orderBean = new WxOrderResponse();
        orderBean.setOrder_number(orderReq.getOrder_number());
        orderBean.setOpen_id(orderReq.getOpen_id());
        orderBean.setAccess_token(orderReq.getAccess_token());
        orderBean.setUser_name(orderReq.getUser_name());
        orderBean.setUser_address(orderReq.getUser_address());
        orderBean.setUser_phone(orderReq.getUser_phone());
        orderBean.setOrder_total_price(orderReq.getOrder_total_price());
        orderBean.setOrder_create_time(LocalDateTime.now());
        orderBean.setOrder_comment(orderReq.getOrder_comment());
        List<WxOrderDetail> orderDetailList = new ArrayList<>();

        try{
            orderDetailList = new Gson().fromJson(orderReq.getItems(), new TypeToken<List<WxOrderDetail>>(){}.getType());
            System.out.println("order_Detail: " +orderDetailList);

        }catch (Exception e){
            log.error("【对象转换】错误, string={}", orderReq.getItems());
        }

        orderBean.setOrderDetailList(orderDetailList);

        wxOrder.createOrder(orderBean);

        return "success";
    }

    //订单详情
    @GetMapping("/detail")
    public String detail(@RequestParam("orderId") int orderId) {

        wxOrder.findOne(orderId);

        return "success";
    }



}
