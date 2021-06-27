package com.example.fishnprawn.wxorder;

import lombok.Data;

import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Data
public class OrderReq {
    @NotNull
    @Column(name = "open_id")
    private String openId;

    @NotNull
    private String order_number;

    @NotNull
    private String access_token;

    @NotNull
    private String user_name;

    @NotNull
    private String user_address;

    @NotNull
    private String user_phone;

    @NotNull
    private BigDecimal order_total_price;

    private String order_comment;

    @Column(name = "order_status")
    private int orderStatus;

    private String items;   //购物车

    public OrderReq(){}

    public void setAttributes(WxOrderRoot wxOrderRoot)
    {
        this.setOpenId(wxOrderRoot.getOpenId());
        this.setOrder_number(wxOrderRoot.getOrder_number());
        this.setAccess_token(wxOrderRoot.getAccess_token());
        this.setUser_name(wxOrderRoot.getUser_name());
        this.setUser_address(wxOrderRoot.getUser_address());
        this.setUser_phone(wxOrderRoot.getUser_phone());
        this.setOrder_total_price(wxOrderRoot.getOrder_total_price());
        this.setOrder_comment(wxOrderRoot.getOrder_comment());
        this.setOrderStatus(wxOrderRoot.getOrderStatus());
    }

}
