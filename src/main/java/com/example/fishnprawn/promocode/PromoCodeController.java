package com.example.fishnprawn.promocode;

import com.example.fishnprawn.wxorder.OrderRootDao;
import com.example.fishnprawn.wxorder.WxOrderRoot;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
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

    @Autowired
    private OrderRootDao orderRootDao;

    // 查询是否存在团长码
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

    // 查询是否存在团长码通过openId
    @GetMapping(path="/checkPromoCodeByOpenId", produces = "application/json")
    public Map<String, Object> checkPromoCodeByOpenId(@RequestParam("openId") String openId){
        Map<String, Object> map = new HashMap<>();

        PromoCode promoCode = promoCodeDao.findByOpenId(openId);

        if(promoCode == null){
            map.put("success", false);
        }else{
            map.put("success", true);
            map.put("promoCodeHeaderId", promoCode.getPromoCodeHeaderId());
            map.put("promo_code", promoCode.getPromoCode());
            map.put("discount_rate", promoCode.getDiscount_rate());
            map.put("commission_rate", promoCode.getCommission_rate());
            log.info("[找到团长]");
        }
        return map;
    }

    @GetMapping(path="/order_filter_by_promocode_header_id", produces = "application/json")
    public ResponseEntity<Map<String, List<WxOrderRoot>>> filterOrderRootByPromoCodeHeaderId(@RequestParam("promoCodeHeaderId") int promoCodeHeaderId){
        log.info("[Get order_filter_by_promocode_header_id]");
        Map<String, List<WxOrderRoot>> result = new HashMap<>();
        result.put("data", new ArrayList<>());
        List<WxOrderRoot> wxOrderRoot = orderRootDao.findByPromoCodeHeaderId(promoCodeHeaderId);

        try {
            for(WxOrderRoot item : wxOrderRoot){
                result.get("data").add(item);
            }
        }catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }


        return new ResponseEntity<>(result, HttpStatus.OK);
    }



    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<PromoCode> savePromoCode(@Valid @RequestBody PromoCode promoCode){ //if any attribute in v is not valid type, it will return 400
        log.info("[Create one promo code]");
        return new ResponseEntity<>(promoCodeServices.save(promoCode), HttpStatus.CREATED);
    }

    @PostMapping(path="/createByUser", produces = "application/json")
    public ResponseEntity<PromoCode> createByUser(@RequestBody PromoCode promoCode){ //if any attribute in v is not valid type, it will return 400
        log.info("[Create one promo code by user]");
        return new ResponseEntity<>(promoCodeServices.save(promoCode), HttpStatus.CREATED);
    }


    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<PromoCode> deleteCategoryById(@PathVariable Integer id){
        System.out.println("[Delete one category] parameters: "+ id);
        return new ResponseEntity<>(promoCodeServices.deleteById(id), HttpStatus.OK);
    }

    //http://localhost:8080/promo_code/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<PromoCode> updatePromoCodeById(@NotNull @PathVariable Integer id,
                                               @Valid @RequestBody PromoCode promoCode){
        //id is not match
        if(!id.equals(promoCode.getPromoCodeHeaderId())){
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }

        log.info("[Update one promocode] parameters: " + id);
        return new ResponseEntity<>(promoCodeServices.updateById(id, promoCode), HttpStatus.CREATED);
    }

}
