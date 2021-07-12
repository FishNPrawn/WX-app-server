package com.example.fishnprawn.category;

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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(CategoryController.BASE_URL)
@RestController
@Slf4j
public class CategoryController {

    public static final String BASE_URL = "/category";

    @Autowired
    private CategoryDao categoryDao;

    @Autowired
    private CategoryServices categoryServices;

    //http://localhost:8080/category/getAllcategory
    @GetMapping(path = "/json/getAllcategory", produces= MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, List<Map<String, String>>>> getAllCategory(@RequestParam(required = false) Map<String, String> filter) {
        System.out.println("[Get all category] | parameters: " + filter);
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

        List<Category> all = categoryServices.getAll(filterLowercaseKey);
        Map<String, List<Map<String, String>>> result = new HashMap<>();
        result.put("data", new ArrayList<>());
        for(Category c: all){
            Map<String, String> temp = new HashMap<String, String>(1);
            temp.put("cat_name", c.getCatname());
            temp.put("cat_image", c.getCat_image());
            result.get("data").add(temp);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    //http://localhost:8080/fishnprawn/category/getbyid/{id}
    @GetMapping(path="/getbyid/{id}", produces = "application/json")
    public ResponseEntity<Category> getByCategoryId(@NotNull @PathVariable Integer id){//if id is not integer type, it will return 400
        System.out.println("[Get one category] | parameters: " + id);
        return new ResponseEntity<>(categoryServices.getById(id), HttpStatus.OK);
    }



    //http://localhost:8080/fishnprawn/category/add
    @PostMapping(path="/add", produces = "application/json")
    public ResponseEntity<Category> saveCategory(@Valid @RequestBody Category category){ //if any attribute in v is not valid type, it will return 400
        System.out.println("[Create one category]");
        return new ResponseEntity<>(categoryServices.save(category), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/category/updatebyid/{id}
    @PutMapping(path="/updatebyid/{id}", produces = "application/json")
    public ResponseEntity<Category> updateCateogryById(@NotNull @PathVariable Integer id,
                                                 @Valid @RequestBody Category category){
        //id is not match
        if(!id.equals(category.getCat_id()))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        System.out.println("[Update one category] parameters: " + id);
        return new ResponseEntity<>(categoryServices.updateById(id, category), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/category/updateattrbyid/{id}
    @PutMapping(path="/updateattrbyid/{id}", produces = "application/json")
    public ResponseEntity<Category> updateCategoryAttrById(@NotNull @PathVariable Integer id,
                                                     @RequestBody Map<String, String> updateMap){

        //id is not match
        String idStr = Integer.toString(id);
        if(!updateMap.getOrDefault("cat_id", idStr).equals(idStr))
            new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        System.out.println("[Update attributes category] parameters: "+ id);
        return new ResponseEntity<>(categoryServices.updateAttrById(id, updateMap), HttpStatus.CREATED);
    }

    //http://localhost:8080/fishnprawn/category/deletebyid/{id}
    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<Category> deleteCategoryById(@PathVariable Integer id){ //pathvariable here gaurantee id will mapping to variable in path
        System.out.println("[Delete one category] parameters: "+ id);
        return new ResponseEntity<>(categoryServices.deleteById(id), HttpStatus.OK);
    }

    @RequestMapping("/uploadCategoryByExcel")
    public ModelAndView uploadExcel(@RequestParam("file") MultipartFile file, ModelMap map){
        ModelAndView modelAndView = new ModelAndView();
        String name = file.getOriginalFilename();

        List<Category> list;
        try {
            list = ExcelImport.excelToCategoryList(file.getInputStream());
            log.info("excel导入的list={}", list);

            //excel的数据保存到数据库
            try {
                for(Category excel:list){
                    if(excel != null){
                        categoryDao.save(excel);
                    }
                }
            }catch (Exception e){
                log.error("某一行存入数据库失败={}", e);
            }

        }catch (Exception e){
            log.error("失败", e);
        }


        modelAndView.setViewName("/operation/success");
        map.put("url", "/category");
        return modelAndView;
    }

    @PostMapping("/deleteCategorySelected")
    public ModelAndView delete(@RequestParam("idChecked") List<String> cat_id, ModelMap map){
        ModelAndView modelAndView = new ModelAndView();

        if(cat_id != null){
            for(String cat_idStr : cat_id){
                int cat_id_idx = Integer.parseInt(cat_idStr);
                categoryServices.deleteById(cat_id_idx);
            }
        }
        modelAndView.setViewName("/operation/success");
        map.put("url", "/category");
        return modelAndView;
    }

}
