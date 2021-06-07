package com.example.fishnprawn.category;
import com.example.fishnprawn.admin.Admin;
import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.exception.ServiceValidationException;
import com.example.fishnprawn.services.Services;
import com.example.fishnprawn.utils.FieldMethods;
import com.example.fishnprawn.validation.CategoryArgumentValidation;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
@Transactional
public class CategoryServices implements Services<Category> {

    @Autowired
    CategoryDao categoryDao;

    @Autowired
    CategoryArgumentValidation categoryArgumentValidation;

    @Override
    public Category addOne(Category anObj) {
        save(anObj);
        return null;
    }

    @Override
    public Category getById(Integer id) {
        /*Validation*/
        if(!categoryDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try{
            return categoryDao.findById(id).orElse(null); //must use findById
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());//Exception from repository
        }
    }

    @Override
    public List<Category> getAll(Map<String, String> filter) {
        /*Validation*/
        //filter has gone through Nullity check, no duplicate key, turned into lowercase
        if(!categoryArgumentValidation.checkFilter(filter)) //check whether fields are legal
            throw new ServiceValidationException("Illegal field in filter");

        /*Operation*/
        try {
            Category category = new Category();
            if (filter.get("cat_id") != null)
                category.setCat_id(Integer.parseInt(filter.get("cat_id")));
            if (filter.get("cat_name") != null)
                category.setCat_name(filter.get("cat_name"));

            ExampleMatcher ignoringExampleMatcher = ExampleMatcher.matchingAll()
                    .withIgnorePaths("cat_id");
//                    .withMatcher("lastName", ExampleMatcher.GenericPropertyMatchers.startsWith().ignoreCase())
//                    .withIgnorePaths("firstName", "seatNumber").withIgnorePaths();
            Example<Category> categoryExample = Example.of(category, ignoringExampleMatcher);
            return categoryDao.findAll();
        } catch (RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository or our logic
        }
    }

    @Override
    public Category updateById(Integer id, Category category) {
        /*Validation*/
        if(!categoryDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            Category categoryld = categoryDao.findById(id).orElse(null);
            category.setCat_id(id);
            category.setCat_create_time(categoryld.getCat_create_time());
            category.setCat_update_time(LocalDateTime.now());
            save(category); //H2 will overwrite the existing data
            return category;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Category updateAttrById(Integer id, Map<String, String> updateMap) {
        /*Validation*/
        if(!categoryDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            Category categoryid = categoryDao.findById(id).orElse(null);

            final FieldMethods<Category> fieldMethods = new FieldMethods<>(Category.class);
            for(String key: updateMap.keySet()){
                fieldMethods.setField(key, categoryid, updateMap.get(key));
            }

            categoryid.setCat_update_time(LocalDateTime.now());

            return updateById(id, categoryid); //let updateById handle
        }catch(RuntimeException | IllegalAccessException | NoSuchFieldException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Category save(Category category) {
        try {
            categoryDao.save(category);
            return category;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Category deleteById(Integer id) {
        /*Validation*/
        if (!categoryDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try{
            Category category = categoryDao.findById(id).orElse(null); //item must exist
            categoryDao.deleteById(id);
            return category;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }
}
