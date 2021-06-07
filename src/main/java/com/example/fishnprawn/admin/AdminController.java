package com.example.fishnprawn.admin;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(AdminController.BASE_URL)
@RestController
@Slf4j
public class AdminController {
    public static final String BASE_URL = "/admin";

    @Autowired
    private AdminServices adminServices;

    //http://localhost:8080/fishnprawn/admin/getall
    @GetMapping(path="/getall", produces = "application/json")
    public ResponseEntity<List<Admin>> getAllAdmin(@RequestParam(required = false) Map<String, String> filter){
        System.out.println("[Get all admins] | parameters: " + filter);

        //1. Turn keys into lowercase
        //2. Check Nullity, if null return Bad Request
        //3. Treat every valid parameter as String
        //4. Guarantee no duplicate key (Since RequestParam will only pick the first one)
        Map<String, String> filterLowercaseKey = new HashMap<>();
        for (Map.Entry<String,String> entry : filter.entrySet()) {
            if (entry.getValue().equals("")) //check if null
                return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);

            filterLowercaseKey.put(entry.getKey().toLowerCase(), entry.getValue().toLowerCase());
        }

        return new ResponseEntity<>(adminServices.getAll(filterLowercaseKey), HttpStatus.OK);
    }

    //http://localhost:8080/fishnprawn/admin/getbyid/{id}
    @GetMapping(path="/getbyid/{id}", produces = "application/json")
    public ResponseEntity<Admin> getByAdminId(@NotNull @PathVariable Integer id){//if id is not integer type, it will return 400
        System.out.println("[Get one admin] | parameters: " + id);
        return new ResponseEntity<>(adminServices.getById(id), HttpStatus.OK);
    }

    //http://localhost:8080/fishnprawn/admin/add
    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<Admin> saveAdmin(@Valid @RequestBody Admin admin){ //if any attribute in v is not valid type, it will return 400
        System.out.println("[Create one admin]");
        return new ResponseEntity<>(adminServices.addOne(admin), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/admin/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<Admin> updateAdminById(@NotNull @PathVariable Integer id,
                                                 @Valid @RequestBody Admin admin){
        System.out.println("[Update one admin] parameters: " + id);

        //id is not match
        if(!id.equals(admin.getAdminid()))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);

        return new ResponseEntity<>(adminServices.updateById(id, admin), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/admin/updateattrbyid/{id}
    @PutMapping(path="/updateattrbyid/{id}", produces = "application/json")
    public ResponseEntity<Admin> updateAdminAttrById(@NotNull @PathVariable Integer id,
                                                     @RequestBody Map<String, String> updateMap){
        System.out.println("[Update attributes admin] parameters: " + id);

        //id is not match
        String idStr = Integer.toString(id);
        if(!updateMap.getOrDefault("adminid", idStr).equals(idStr))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        return new ResponseEntity<>(adminServices.updateAttrById(id, updateMap), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/admin/deletebyid/{id}
    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<Admin> deleteAdminById(@PathVariable Integer id){ //pathvariable here gaurantee id will mapping to variable in path
        System.out.println("[Delete one admin] | parameters: " + id);
        return new ResponseEntity<>(adminServices.deleteById(id), HttpStatus.OK);
    }

}
