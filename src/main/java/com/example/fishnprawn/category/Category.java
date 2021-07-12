package com.example.fishnprawn.category;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Data
public class Category {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO,generator="native")
    @GenericGenerator(name = "native",strategy = "native")
    private int cat_id;

    @NotNull
    @Column(unique=true, name="cat_name")
    @Size(min = 1, max = 20)
    private String catname;

    @Column(name="cat_image")
    private String cat_image;

    @Column(columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP",insertable = false, updatable = false)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime cat_create_time;

    @Column(columnDefinition="TIMESTAMP default current_timestamp on update current_timestamp", insertable = false, updatable = true)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime cat_update_time;

}


