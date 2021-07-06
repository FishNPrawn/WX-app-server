package com.example.fishnprawn.userinfo;

import lombok.Data;

import javax.persistence.Id;

@Data
public class UserInfoForm {


    private String openid;
    private String username;
    private String city;
    private String phone;
    private String user_create_time;
}
