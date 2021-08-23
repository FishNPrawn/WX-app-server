package com.example.fishnprawn.orderRefund;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@RequestMapping(OrderRefundController.BASE_URL)
@RestController
@Slf4j
public class OrderRefundController {

    public static final String BASE_URL = "/orderRefund";

    @Autowired
    private OrderRefundServices orderRefundServices;

    //http://localhost:8080/orderRefund/add
    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<OrderRefund> saveOrderRefund(@Valid @RequestBody OrderRefund orderRefund){ //if any attribute in v is not valid type, it will return 400
        System.out.println("[Create one 退款]");
        return new ResponseEntity<>(orderRefundServices.save(orderRefund), HttpStatus.CREATED);
    }


    //http://localhost:8080/orderRefund/deletebyid/{id}
    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<OrderRefund> deleteOrderRefundById(@PathVariable Integer id){ //pathvariable here gaurantee id will mapping to variable in path
        System.out.println("[Delete one 退款] parameters: "+ id);
        return new ResponseEntity<>(orderRefundServices.deleteById(id), HttpStatus.OK);
    }

    //http://localhost:8080/orderRefund/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<OrderRefund> updateOrderRefundById(@NotNull @PathVariable Integer id,
                                                       @Valid @RequestBody OrderRefund orderRefund){
        //id is not match
        if(!id.equals(orderRefund.getOrder_refund_id()))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        System.out.println("[Update one 图款] parameters: " + id);
        return new ResponseEntity<>(orderRefundServices.updateById(id, orderRefund), HttpStatus.CREATED);
    }


}
