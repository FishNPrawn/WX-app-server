package com.example.fishnprawn.wxorderremark;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@RequestMapping(WxOrderDetailRemarkController.BASE_URL)
@RestController
@Slf4j
public class WxOrderDetailRemarkController {
    public static final String BASE_URL = "/order/remark";

    @Autowired
    private WxOrderDetailRemarkServices wxOrderDetailRemarkServices;


    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<WxOrderDetailRemark> saveRemark(@Valid @RequestBody WxOrderDetailRemark wxOrderDetailRemark){
        log.info("[Create one remark]");
        return new ResponseEntity<>(wxOrderDetailRemarkServices.save(wxOrderDetailRemark), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/good/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<WxOrderDetailRemark> updateRemarkById(@NotNull @PathVariable Integer id,
                                               @Valid @RequestBody WxOrderDetailRemark wxOrderDetailRemark){
        //id is not match
        if(!id.equals(wxOrderDetailRemark.getWx_order_detail_remark_id())){
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }

        log.info("[Update one remark] parameters: " + id);
        return new ResponseEntity<>(wxOrderDetailRemarkServices.updateById(id, wxOrderDetailRemark), HttpStatus.CREATED);
    }

}
