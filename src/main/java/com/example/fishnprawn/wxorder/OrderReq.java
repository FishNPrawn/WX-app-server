package com.example.fishnprawn.wxorder;

import lombok.Data;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Data
public class OrderReq {
    @NotNull
    private String open_id;

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

    private int order_status;

    private String items;   //购物车

}
