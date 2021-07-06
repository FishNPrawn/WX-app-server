package com.example.fishnprawn.userinfo;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserInfoDao extends JpaRepository<UserInfo, String> {
}
