package com.example.fishnprawn.calculate;

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

    // 计算运费根据重量和总价格
    @GetMapping("/express_fee_with_weight_and_total_price")
    public double express_fee_with_weight_total_price(@RequestParam("weight") double weight, @RequestParam("order_total_price") double order_total_price){
        double express_fee = 18;
        if(weight>0 && weight<=1000){
            express_fee = 18;
        }else if(weight > 1000 && weight <= 2000){
            express_fee = 18;
        }else if(weight > 2000 && weight <= 3000){
            express_fee = 21;
        }else if(weight > 3000 && weight <= 4000){
            express_fee = 24;
        }else if(weight > 4000 && weight <= 5000){
            express_fee = 27;
        }else if(weight > 5000 && weight <= 6000){
            express_fee = 30;
        }else if(weight > 6000 && weight <= 7000){
            express_fee = 33;
        }else if(weight > 7000 && weight <= 8000){
            express_fee = 36;
        }else if(weight > 8000 && weight <= 9000){
            express_fee = 39;
        }else if(weight > 9000 && weight <= 10000){
            express_fee = 42;
        }else{
            express_fee = 45;
        }
        if(order_total_price>=88 && order_total_price<188){
            express_fee = express_fee - 5;
        }else if(order_total_price>=188 && order_total_price<268){
            express_fee = express_fee - 12;
        }else if(order_total_price>=268){
            express_fee = 0;
        }
        return express_fee;
    }

    // 计算运费根据重量
    @GetMapping("/express_fee_with_weight")
    public double express_fee_with_weight(@RequestParam("weight") double weight){
        double express_fee = 18;
        if(weight>0 && weight<=1000){
            express_fee = 18;
        }else if(weight > 1000 && weight <= 2000){
            express_fee = 18;
        }else if(weight > 2000 && weight <= 3000){
            express_fee = 21;
        }else if(weight > 3000 && weight <= 4000){
            express_fee = 24;
        }else if(weight > 4000 && weight <= 5000){
            express_fee = 27;
        }else if(weight > 5000 && weight <= 6000){
            express_fee = 30;
        }else if(weight > 6000 && weight <= 7000){
            express_fee = 33;
        }else if(weight > 7000 && weight <= 8000){
            express_fee = 36;
        }else if(weight > 8000 && weight <= 9000){
            express_fee = 39;
        }else if(weight > 9000 && weight <= 10000){
            express_fee = 42;
        }else{
            express_fee = 45;
        }
        return express_fee;
    }

}
