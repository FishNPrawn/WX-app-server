package com.example.fishnprawn.wxorder;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

//数据库： wx_order_root
@Entity
@Data
@EntityListeners(AuditingEntityListener.class)
@Table(name = "wx_order_root")
public class WxOrderRoot {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private Integer order_id;

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
}
