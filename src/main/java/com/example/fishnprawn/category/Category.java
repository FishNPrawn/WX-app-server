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
    @Column(unique=true)
    @Size(min = 1, max = 20)
    private String cat_name;

    @Column(columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP",insertable = false, updatable = false)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime cat_create_time;

    @Column(columnDefinition="TIMESTAMP default current_timestamp on update current_timestamp", insertable = false, updatable = true)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime cat_update_time;

    public int getCat_id() {
        return cat_id;
    }

    public void setCat_id(int cat_id) {
        this.cat_id = cat_id;
    }

    public String getCat_name() {
        return cat_name;
    }

    public void setCat_name(String cat_name) {
        this.cat_name = cat_name;
    }

    public LocalDateTime getCat_create_time() {
        return cat_create_time;
    }

    public void setCat_create_time(LocalDateTime cat_create_time) {
        this.cat_create_time = cat_create_time;
    }

    public LocalDateTime getCat_update_time() {
        return cat_update_time;
    }

    public void setCat_update_time(LocalDateTime cat_update_time) {
        this.cat_update_time = cat_update_time;
    }
}


