package com.example.fishnprawn.wxorder;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

//数据库： wx_order_detail
@Entity
@Data
@Table(name = "wx_order_detail")
public class WxOrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private Integer order_detail_id;

    private Integer orderId; //菜品id

    @NotNull
    private String order_number; //订单变好

    @NotNull
    private int good_id; //菜品id

    @NotNull
    private String good_name;

    @NotNull
    private BigDecimal good_price;

    @NotNull
    private int good_quantity; //下单食物数量

    @NotNull
    private String good_image; //商品图
}
