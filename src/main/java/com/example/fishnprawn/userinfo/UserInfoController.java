package com.example.fishnprawn.userinfo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RequestMapping(UserInfoController.BASE_URL)
@RestController
@Slf4j
public class UserInfoController {

    public static final String BASE_URL = "/userinfo";

    @Autowired
    private UserInfoDao userInfoDao;

    @PostMapping("/create")
    public String create(@Valid UserInfoForm userInfoForm){

        if(userInfoDao.existsById(userInfoForm.getOpenid())){
            log.info("[User Exist]");
        }else{
            UserInfo user = new UserInfo();
            user.setOpenid(userInfoForm.getOpenid());
            user.setSession_key(userInfoForm.getSession_key());
            user.setUsername(userInfoForm.getUsername());
            user.setCity(userInfoForm.getCity());
            user.setPhone(userInfoForm.getPhone());
            user.setUser_create_time(userInfoForm.getUser_create_time());
            userInfoDao.save(user);
        }

        return "create Success";
    }


}
