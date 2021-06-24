package com.example.fishnprawn.swiper;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;

@RequestMapping(SwiperImgController.BASE_URL)
@RestController
@Slf4j
public class SwiperImgController {

    public static final String BASE_URL = "/allswiper";

    @Autowired
    private SwiperImgServices swiperImgServices;

    //http://localhost:8080/allswiper/getAllSwiper
    @GetMapping(path = "/getAllSwiper", produces= MediaType.APPLICATION_JSON_VALUE)
    public List<SwiperImg> getAllSwiper(@RequestParam(required = false) Map<String, String> filter) {
        System.out.println("[Get all Swiper| parameters: " + filter);

        List<SwiperImg> list = swiperImgServices.getAll(filter);

        return list;
    }


    //http://localhost:8080/allswiper/add
    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<SwiperImg> saveCategory(@Valid @RequestBody SwiperImg swiperImg){
        System.out.println("[Create one category]");
        return new ResponseEntity<>(swiperImgServices.save(swiperImg), HttpStatus.CREATED);
    }

    //http://localhost:8080/allswiper/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<SwiperImg> updateSwiperById(@NotNull @PathVariable Integer id,
                                                       @Valid @RequestBody SwiperImg swiperImg){
        //id is not match
        if(!id.equals(swiperImg.getSwiper_img_id())) {
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
        System.out.println("[Update one swiper] parameters: " + id);
        return new ResponseEntity<>(swiperImgServices.updateById(id, swiperImg), HttpStatus.CREATED);
    }

    //http://localhost:8080/allswiper/deletebyid/{id}
    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<SwiperImg> deleteCategoryById(@PathVariable Integer id){
        System.out.println("[Delete one swiper] parameters: "+ id);
        return new ResponseEntity<>(swiperImgServices.deleteById(id), HttpStatus.OK);
    }


}
