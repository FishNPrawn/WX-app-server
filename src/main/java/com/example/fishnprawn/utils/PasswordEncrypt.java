package com.example.fishnprawn.utils;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


public class PasswordEncrypt {
    public static void main(String[] args){
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String rawPassword="123456";
        String encodedPassword = encoder.encode(rawPassword);
        System.out.println(encodedPassword);
    }

    public static String encrypt(String aPassword){
        BCryptPasswordEncoder theEncoder = new BCryptPasswordEncoder();
        return theEncoder.encode(aPassword);
    }
}
