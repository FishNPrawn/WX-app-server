package com.example.fishnprawn.promocode;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Data
@Table(name = "promo_code")
public class PromoCode {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    @Column(name = "promo_code_header_id")
    private int promoCodeHeaderId;

    @NotNull
    private String username;

    @NotNull
    private String phone;

    @NotNull
    private String address;

    @NotNull
    private String city;

    @NotNull
    private String remark;

    @NotNull
    @Column(name = "promo_code")
    private String promoCode;

    @NotNull
    private double commission_rate;

    @NotNull
    private double discount_rate;

    @NotNull
    private int promo_code_verify;

    @NotNull
    @Column(name = "open_id")
    private String openId;

}
