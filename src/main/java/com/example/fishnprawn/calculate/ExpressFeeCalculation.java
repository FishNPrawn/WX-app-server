package com.example.fishnprawn.calculate;

import com.lly835.bestpay.rest.type.Get;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping(ExpressFeeCalculation.BASE_URL)
@RestController
@Slf4j
public class ExpressFeeCalculation {
    public static final String BASE_URL = "/calculate";

    @GetMapping("/total_price_with_promo_code")
    public double total_price_with_promo_code(@RequestParam("order_total_price") double order_total_price,
                                              @RequestParam(value = "discount_rate",required = false, defaultValue = "1") double discount_rate){
        double order_total_price_with_promo_code = order_total_price*discount_rate;

        return order_total_price_with_promo_code;
    }

    // 计算运费根据重量和总价格
    @GetMapping("/express_fee_with_weight_and_total_price")
    public double express_fee_with_weight_total_price(@RequestParam("weight") double weight,
                                                      @RequestParam("order_total_price") double order_total_price){
        double express_fee = 20;
        if(weight>0 && weight<=1000){
            express_fee = 20;
        }else if(weight > 1000 && weight <= 2000){
            express_fee = 20;
        }else if(weight > 2000 && weight <= 3000){
            express_fee = 23;
        }else if(weight > 3000 && weight <= 4000){
            express_fee = 26;
        }else if(weight > 4000 && weight <= 5000){
            express_fee = 29;
        }else if(weight > 5000 && weight <= 6000){
            express_fee = 32;
        }else if(weight > 6000 && weight <= 7000){
            express_fee = 35;
        }else if(weight > 7000 && weight <= 8000){
            express_fee = 38;
        }else if(weight > 8000 && weight <= 9000){
            express_fee = 41;
        }else if(weight > 9000 && weight <= 10000){
            express_fee = 44;
        }else{
            express_fee = 47;
        }
        if(order_total_price>=99 && order_total_price<199){
            express_fee = express_fee - 5;
        }else if(order_total_price>=199 && order_total_price<298){
            express_fee = express_fee - 12;
        }else if(order_total_price>=298){
            express_fee = 0;
        }
        return express_fee;
    }

    // 计算运费根据重量
    @GetMapping("/express_fee_with_weight")
    public double express_fee_with_weight(@RequestParam("weight") double weight){
        double express_fee = 20;
        if(weight>0 && weight<=1000){
            express_fee = 20;
        }else if(weight > 1000 && weight <= 2000){
            express_fee = 20;
        }else if(weight > 2000 && weight <= 3000){
            express_fee = 23;
        }else if(weight > 3000 && weight <= 4000){
            express_fee = 26;
        }else if(weight > 4000 && weight <= 5000){
            express_fee = 29;
        }else if(weight > 5000 && weight <= 6000){
            express_fee = 32;
        }else if(weight > 6000 && weight <= 7000){
            express_fee = 35;
        }else if(weight > 7000 && weight <= 8000){
            express_fee = 38;
        }else if(weight > 8000 && weight <= 9000){
            express_fee = 41;
        }else if(weight > 9000 && weight <= 10000){
            express_fee = 44;
        }else{
            express_fee = 47;
        }
        return express_fee;
    }

}
