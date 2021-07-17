package com.example.fishnprawn.shipment;

import com.example.fishnprawn.wxorder.WxOrderResponse;
import com.example.fishnprawn.wxorder.WxOrderRoot;
import com.example.fishnprawn.wxorder.WxOrderUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RequestMapping(ShipmentController.BASE_URL)
@RestController
@Slf4j
public class ShipmentController {

    public static final String BASE_URL = "/order/shipment";

    @Autowired
    private WxOrderUtils wxOrder;

    @Autowired
    private ShipmentServices shipmentServices;

    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<Shipment> saveRemark(@Valid @RequestBody Shipment shipment, @RequestParam("orderId") int orderId){


        WxOrderResponse orderDTO = wxOrder.findOne(orderId);
        if (orderDTO == null) {
            log.error("【取消订单】查不到改订单, orderId={}", orderId);
        }

        wxOrder.changeShipmentStatus(orderDTO);

        log.info("[Create shipment]");
        return new ResponseEntity<>(shipmentServices.save(shipment), HttpStatus.CREATED);
    }



}
