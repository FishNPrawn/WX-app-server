package com.example.fishnprawn.good;
import com.example.fishnprawn.category.Category;
import com.example.fishnprawn.category.CategoryDao;
import com.example.fishnprawn.utils.ExcelImport;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.*;

@RequestMapping(GoodController.BASE_URL)
@RestController
@Slf4j
public class GoodController {
    public static final String BASE_URL = "/good";
    @Autowired
    private GoodServices goodServices;
    @Autowired
    private GoodServices goodDao;
    @Autowired
    private CategoryDao categoryDao;

    //http://localhost:8080/fishnprawn/good/getAllgood
    @GetMapping(path = "/getAllgood", produces= MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, List<Map<String, Object>>>> getAllGood(){
        log.info("[Get All goods]");
        Map<String, String> filter = new HashMap<>();
        filter.put("filter", "");
        List<Good> all = goodServices.getAll(filter);
        Map<String, List<Map<String, Object>>> result = new HashMap<>();
        Map<String, List<Good>> goods = new HashMap<>();
        //Object
        for(Good g: all){
            String cat = g.getCat_name();
            goods.putIfAbsent(cat, new ArrayList<>());
            goods.get(cat).add(g);
        }
        //data
        result.put("data", new ArrayList<>());
        List<Map<String, Object>> current = result.get("data");
        for(String cat: goods.keySet()){
            Map<String, Object> element = new HashMap<>();
            ArrayList<Good> allGood = new ArrayList<>();
            element.put("cat_name", cat);
            element.put("array", allGood);
            for(Good g: goods.get(cat)){
                if(g.getGood_status()==1){
                    allGood.add(g);
                }
            }
            current.add(element);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    //http://localhost:8080/good/getGoodByCatetory
    @GetMapping(path = "/getGoodByCatetory", produces= MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> getGoodByCatetory(){

        Map<String, String> filter = new HashMap<>();
        filter.put("filter", "");
        List<Good> all = goodServices.getAll(filter);

        Map<String, Object> result = new HashMap<>();
        Map<String, List<Good>> goods = new HashMap<>();
        //Object
        for(Good g: all){
            String cat = g.getCat_name();
            goods.putIfAbsent(cat, new ArrayList<>());
            goods.get(cat).add(g);
        }
        //data
        result.put("data", new HashMap<String, Object>());
        Map<String, Object> current = (Map<String, Object>) result.get("data");

        for(String cat: goods.keySet()){
            ArrayList<Good> allGood = new ArrayList<>();
            current.put(cat, allGood);
            for(Good g: goods.get(cat)){
                allGood.add(g);
            }
        }

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    //http://localhost:8080/fishnprawn/good/getbyid/{id}
    @GetMapping(path="/getbyid/{id}", produces = "application/json")
    public ResponseEntity<Good> getByGoodId(@NotNull @PathVariable Integer id){//if id is not integer type, it will return 400
        log.info("[Get one good] | parameters: " + id);
        return new ResponseEntity<>(goodServices.getById(id), HttpStatus.OK);
    }

    //http://localhost:8080/fishnprawn/good/add
    //add new good into database
    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<Good> saveGood(@Valid @RequestBody Good good){ //if any attribute in v is not valid type, it will return 400
        log.info("[Create one good]");
        return new ResponseEntity<>(goodServices.save(good), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/good/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<Good> updateGoodById(@NotNull @PathVariable Integer id,
                                                 @Valid @RequestBody Good good){
        //id is not match
        if(!id.equals(good.getGood_id()))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        log.info("[Update one good] parameters: " + id);
        return new ResponseEntity<>(goodServices.updateById(id, good), HttpStatus.CREATED);
    }
    //http://localhost:8080/fishnprawn/good/updateattrbyid/{id}
    @PutMapping(path="/updateattrbyid/{id}", produces = "application/json")
    public ResponseEntity<Good> updateGoodAttrById(@NotNull @PathVariable Integer id,
                                                     @RequestBody Map<String, String> updateMap){
        //id is not match
        String idStr = Integer.toString(id);
        if(!updateMap.getOrDefault("goodid", idStr).equals(idStr))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        log.info("[Update attributes good] parameters: " + id);
        return new ResponseEntity<>(goodServices.updateAttrById(id, updateMap), HttpStatus.CREATED);
    }
    //http://localhost:8080/fishnprawn/good/deletebyid/{id}
    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<Good> deleteGoodById(@PathVariable Integer id){ //pathvariable here gaurantee id will mapping to variable in path
        log.info("[Delete good] parameters: " + id);
        return new ResponseEntity<>(goodServices.deleteById(id), HttpStatus.OK);
    }

//    http://localhost:8080/good/good_filter
//    search example: http://localhost:8080/fishnprawn/good/good_filter?filter=KEYWORD
//    filter by good_name, cat_name
    @GetMapping(path="/good_filter", produces = "application/json")
    public ResponseEntity<Map<String, List<GoodViewclass>>>  filterGood( @RequestParam(required = false) Map<String, String> filter){ //if any attribute in v is not valid type, it will return 400
        log.info("[Get filter_request]");
//        sanity check
        Map<String, List<GoodViewclass>> result = new HashMap<>();
        result.put("data", new ArrayList<>());
        try{
            List<Good> goods = goodServices.getAll(filter);
            for(Good good: goods)
            {
                GoodViewclass goodViewclass = new GoodViewclass();
                goodViewclass.setAttributes(good);
                result.get("data").add(goodViewclass);
            }
        } catch (Exception e)
        {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }


    @RequestMapping("/uploadGoodByExcel")
    public ModelAndView uploadExcel(@RequestParam("file") MultipartFile file, ModelMap map){
        ModelAndView modelAndView = new ModelAndView();
        String name = file.getOriginalFilename();

        List<Good> list;

        try {
            list = ExcelImport.excelToMenulistList(file.getInputStream());
            log.info("excel导入的menulist={}", list);
            try {
                for(Good excel:list){
                    if(excel != null){
                        goodDao.save(excel);
                    }
                }
            }catch (Exception e){
                log.error("某一行存入数据库失败={}", e);
            }
        }catch (Exception e){
            log.error("失败", e);
        }

        modelAndView.setViewName("/operation/success");
        map.put("url", "/menulist");
        return modelAndView;

    }

    @PostMapping("/deleteGoodSelected")
    public ModelAndView delete(@RequestParam("idChecked") List<String> good_id, ModelMap map){

        ModelAndView modelAndView = new ModelAndView();

        if(good_id != null){
            for(String good_idStr : good_id){
                int good_id_idx = Integer.parseInt(good_idStr);
                goodServices.deleteById(good_id_idx);
            }
        }
        modelAndView.setViewName("/operation/success");
        map.put("url", "/menulist");
        return modelAndView;
    }

}
