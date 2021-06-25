package com.example.fishnprawn.wxorder;


import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

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
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private Integer order_id;
    private String open_id;
    private String order_number;
    private String access_token;
    private String user_name;
    private String user_address;
    private String user_phone;
    private BigDecimal order_total_price;
    private LocalDateTime order_create_time;
    private String order_comment;
    private int order_status;

    List<WxOrderDetail> orderDetailList;

}
