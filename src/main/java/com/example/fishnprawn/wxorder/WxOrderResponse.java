package com.example.fishnprawn.wxorder;


import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;


@Data
public class WxOrderResponse {
    @Id
    @Column(name = "order_id")
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private Integer orderId;

    @Column(name = "open_id")
    private String openId;
    private String order_number;
    private String access_token;
    private String user_name;
    private String user_address;
    private String user_phone;
    private BigDecimal order_total_price;
    private LocalDateTime order_create_time;
    private String order_comment;

    @Column(name = "order_status")
    private int orderStatus;

    @Column(name = "order_total_weight")
    private double order_total_weight;

    @Column(name = "order_express_fee")
    private double order_express_fee;

    List<WxOrderDetail> orderDetailList;

}
