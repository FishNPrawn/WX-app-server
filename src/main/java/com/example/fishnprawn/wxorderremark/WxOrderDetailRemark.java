package com.example.fishnprawn.wxorderremark;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Data
public class WxOrderDetailRemark {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private int wx_order_detail_remark_id;

    @NotNull
    private int order_id;

    @NotNull
    private String remark;
}
