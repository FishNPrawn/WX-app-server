package com.example.fishnprawn.paySupplier;


import com.example.fishnprawn.orderRefund.OrderRefund;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;

@RequestMapping(PaySupplierController.BASE_URL)
@RestController
@Slf4j
public class PaySupplierController {
    public static final String BASE_URL = "/paySupplier";

    @Autowired
    private PaySupplierServices paySupplierServices;

    @Autowired
    private PaySupplierDao paySupplierDao;

    //http://localhost:8080/paySupplier/add
    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<PaySupplier> savePaySupplier(@Valid @RequestBody PaySupplier paySupplier){ //if any attribute in v is not valid type, it will return 400
        System.out.println("[Create one 供应商结算]");
        return new ResponseEntity<>(paySupplierServices.save(paySupplier), HttpStatus.CREATED);
    }

    //http://localhost:8080/paySupplier/deletebyid/{id}
    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<PaySupplier> deletePaySupplierById(@PathVariable Integer id){ //pathvariable here gaurantee id will mapping to variable in path
        System.out.println("[Delete one 供应商结算退款] parameters: "+ id);
        return new ResponseEntity<>(paySupplierServices.deleteById(id), HttpStatus.OK);
    }

    //http://localhost:8080/paySupplier/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<PaySupplier> updateOrderRefundById(@NotNull @PathVariable Integer id,
                                                             @Valid @RequestBody PaySupplier paySupplier){
        //id is not match
        if(!id.equals(paySupplier.getPay_supplier_id()))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        System.out.println("[Update one 供应商结算] parameters: " + id);
        return new ResponseEntity<>(paySupplierServices.updateById(id, paySupplier), HttpStatus.CREATED);
    }

    @PostMapping("/PaySupplierSelected")
    public ModelAndView PaySupplierSelected(@RequestParam("idChecked") List<String> pay_supplier_id, ModelMap map){
        ModelAndView modelAndView = new ModelAndView();

        if(pay_supplier_id != null){
            for(String paySupplier_idStr : pay_supplier_id){
                int pay_supplier_id_idx = Integer.parseInt(paySupplier_idStr);
                PaySupplier pay_supplier_id_find = paySupplierDao.findById(pay_supplier_id_idx).orElse(null);
                pay_supplier_id_find.setPay_supplier_id(pay_supplier_id_find.getPay_supplier_id());
                pay_supplier_id_find.setPay_supplier_or_not(1);
                paySupplierDao.save(pay_supplier_id_find);
            }
        }
        modelAndView.setViewName("/operation/success");
        map.put("url", "/paySupplier");
        return modelAndView;
    }

}
