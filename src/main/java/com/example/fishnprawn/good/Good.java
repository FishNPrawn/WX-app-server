package com.example.fishnprawn.good;


import lombok.Data;
import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.sql.Date;
import java.time.LocalDateTime;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Data
public class Good{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private int good_id;

    @NotNull
    @Column(unique = true)
    private String good_name;

    @NotNull
    private double good_price;

    @NotNull
    private int good_stock;

    @NotNull
    private double good_weight;

    @NotNull
    private int good_status;

    @NotNull
    private String good_image;

    @NotNull
    private String good_supplier;

    @NotNull
    private String good_description;

    @NotNull
    private String good_production;

    @NotNull
    private String good_size;

    @NotNull
    private String good_expiration;

    @NotNull
    private String good_optimal_period;

    @NotNull
    private String good_image_description;

    @NotNull
    private Date good_publish_date;

    @NotNull
    private String good_image_1;

    @NotNull
    private String cat_name;

    @NotNull
    private double good_origin_price;

    @NotNull
    private String good_cat_image;

    @Column(columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", insertable = false, updatable = false)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime good_create_time;

    @Column(columnDefinition = "TIMESTAMP default current_timestamp on update current_timestamp", insertable = false, updatable = true)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime good_update_time;
}