package com.example.fishnprawn.promocode;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(PromoCodeController.BASE_URL)
@RestController
@Slf4j
public class PromoCodeController {

    public static final String BASE_URL = "/promo_code";



    @Autowired
    private PromoCodeServices promoCodeServices;

    @Autowired
    private PromoCodeDao promoCodeDao;

    @GetMapping(path="/checkPromoCode", produces = "application/json")
    public Map<String, Object> checkPromoCode(@RequestParam("promocode") String promocode){
        Map<String, Object> map = new HashMap<>();

        PromoCode promoCode = promoCodeDao.findByPromoCode(promocode);

        if(promoCode == null){
            map.put("success", false);
        }else{
            map.put("success", true);
            map.put("promoCodeHeaderId", promoCode.getPromoCodeHeaderId());
            map.put("promo_code", promoCode.getPromoCode());
            map.put("discount_rate", promoCode.getDiscount_rate());
            log.info("[找到团长]");
        }

        return map;
    }

    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<PromoCode> savePromoCode(@Valid @RequestBody PromoCode promoCode){ //if any attribute in v is not valid type, it will return 400
        log.info("[Create one promo code]");
        return new ResponseEntity<>(promoCodeServices.save(promoCode), HttpStatus.CREATED);
    }


    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<PromoCode> deleteCategoryById(@PathVariable Integer id){
        System.out.println("[Delete one category] parameters: "+ id);
        return new ResponseEntity<>(promoCodeServices.deleteById(id), HttpStatus.OK);
    }

}
