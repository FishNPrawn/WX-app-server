package com.example.fishnprawn.promocode;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
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

//    @GetMapping("/getAll")
//    public List getAll(){
//        List all = promocodeDao.findAll();
//        return all;
//    }

    @GetMapping(path="getAllPromoCode")
    public List getAllPromoCode(@RequestParam(required = false) Map<String, String> filter){

        Map<String, String> filterLowercaseKey = new HashMap<>();
        for (Map.Entry<String,String> entry : filter.entrySet()) {
            filterLowercaseKey.put(entry.getKey().toLowerCase(), entry.getValue().toLowerCase());
        }

        List result = promoCodeServices.getAll(filterLowercaseKey);
        return result;
    }

    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<PromoCode> saveGood(@Valid @RequestBody PromoCode promoCode){ //if any attribute in v is not valid type, it will return 400
        log.info("[Create one promo code]");
        return new ResponseEntity<>(promoCodeServices.save(promoCode), HttpStatus.CREATED);
    }


    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<PromoCode> deleteCategoryById(@PathVariable Integer id){
        System.out.println("[Delete one category] parameters: "+ id);
        return new ResponseEntity<>(promoCodeServices.deleteById(id), HttpStatus.OK);
    }

}
