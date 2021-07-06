package com.example.fishnprawn.userinfo;

import lombok.Data;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;

@Entity
@Data
@EntityListeners(AuditingEntityListener.class)
@Table(name = "userinfo")
public class UserInfo {

    @Id
    private String openid;

    private String username;
    private String city;
    private String phone;
    private String user_create_time;


}
