package com.example.fishnprawn.swiper;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Data
@EntityListeners(AuditingEntityListener.class)
@Table(name = "swiper_img")
public class SwiperImg {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "native")
    @GenericGenerator(name = "native", strategy = "native")
    private int swiper_img_id;

    @NotNull
    private String image_src;

}
