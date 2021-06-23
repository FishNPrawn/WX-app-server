package com.example.fishnprawn.wxorder;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Data
public class WxOrderDetailView {

    private Integer order_detail_id;
    private Integer orderId; //菜品id
    private String order_number; //订单变好
    private int good_id; //菜品id
    private String good_name;
    private BigDecimal good_price;
    private int good_quantity; //下单食物数量

    public void setAttributes(WxOrderDetail wxOrderDetail){
        this.setOrder_detail_id(wxOrderDetail.getOrder_detail_id());
        this.setOrderId(wxOrderDetail.getOrderId());
        this.setOrder_number(wxOrderDetail.getOrder_number());
        this.setGood_id(wxOrderDetail.getGood_id());
        this.setGood_name(wxOrderDetail.getGood_name());
        this.setGood_price(wxOrderDetail.getGood_price());
        this.setGood_quantity(wxOrderDetail.getGood_quantity());
    }
}
