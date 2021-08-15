package com.example.fishnprawn.promocode;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PromoCodeDao extends JpaRepository<PromoCode, Integer> {
    PromoCode findByPromoCode(String promoCode);
    PromoCode findByOpenId(String openId);
}
