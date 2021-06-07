package com.example.fishnprawn.admin;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Generated;
import org.hibernate.annotations.GenerationTime;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Data
public class Admin{
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO,generator="native")
    @GenericGenerator(name = "native",strategy = "native")
    private int adminid;

    @NotNull
    @NotBlank
    @Size(min = 3, max = 20)
    private String username;

    @NotNull
    @NotBlank
    @Size(min = 3, max = 100)
    private String password;

    @NotNull
    @NotBlank
    @Size(min = 3, max = 40)
    private String phone;

    @NotNull
    private Integer admintype;

    @Column(columnDefinition="TIMESTAMP DEFAULT CURRENT_TIMESTAMP",insertable = false, updatable = false)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime admin_create_time;

    @Column(columnDefinition="TIMESTAMP default current_timestamp on update current_timestamp", insertable = false, updatable = true)
    @Generated(GenerationTime.INSERT)
    private LocalDateTime admin_update_time;

    public int getAdminid() {
        return adminid;
    }

    public void setAdminid(int adminid) {
        this.adminid = adminid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public LocalDateTime getAdmin_create_time() {
        return admin_create_time;
    }

    public void setAdmin_create_time(LocalDateTime admin_create_time) {
        this.admin_create_time = admin_create_time;
    }

    public LocalDateTime getAdmin_update_time() {
        return admin_update_time;
    }

    public void setAdmin_update_time(LocalDateTime admin_update_time) {
        this.admin_update_time = admin_update_time;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getAdmintype() {
        return admintype;
    }

    public void setAdmintype(Integer admintype) {
        this.admintype = admintype;
    }

}
