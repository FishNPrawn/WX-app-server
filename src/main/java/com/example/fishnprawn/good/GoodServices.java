package com.example.fishnprawn.good;
import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.exception.ServiceValidationException;
import com.example.fishnprawn.services.Services;
import com.example.fishnprawn.utils.FieldMethods;
import com.example.fishnprawn.validation.GoodArgumentValidation;
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
public class GoodServices implements Services<Good>{

    @Autowired
    private GoodDao goodDao;

    @Autowired
    private GoodArgumentValidation goodArgumentValidation;

    @Override
    public Good addOne(Good anObj) {
        return null;
    }

    @Override
    public Good getById(Integer id) {
        /*Validation*/
        if(!goodDao.existsById(id)){
            throw new NotFoundException();
        }
        /*Operation*/
        try{
            return goodDao.findById(id).orElse(null); //must use findById
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());//Exception from repository
        }
    }

    @Override
    public List<Good> getAll(Map<String, String> filter) {
        /*Validation*/
        //filter has gone through Nullity check, no duplicate key, turned into lowercase
        if(!goodArgumentValidation.checkFilter(filter)) //check whether fields are legal
            throw new ServiceValidationException("Illegal field in filter");
        /*Operation*/
        try {
            Good good = new Good();
            good.setGood_name(filter.get("filter"));
            good.setCat_name(filter.get("filter"));
            ExampleMatcher customExampleMatcher = ExampleMatcher.matchingAny()
                    .withMatcher("good_name", ExampleMatcher.GenericPropertyMatchers.contains().ignoreCase())
                    .withMatcher("cat_name", ExampleMatcher.GenericPropertyMatchers.contains().ignoreCase());
            Example<Good> goodExample = Example.of(good, customExampleMatcher);
            return goodDao.findAll(goodExample);
        } catch (RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository or our logic
        }
    }

    @Override
    public Good updateById(Integer id, Good good) {
        /*Validation*/
        if(!goodDao.existsById(id))
            throw new NotFoundException();
        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            Good goodID = goodDao.findById(id).orElse(null);
            good.setGood_id(id);
            good.setGood_create_time(goodID.getGood_create_time());
            good.setGood_update_time(LocalDateTime.now());
            save(good); //H2 will overwrite the existing data
            return good;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Good updateAttrById(Integer id, Map<String, String> updateMap) {
        /*Validation*/
        if(!goodDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            Good goodID = goodDao.findById(id).orElse(null);

            final FieldMethods<Good> fieldMethods = new FieldMethods<>(Good.class);
            for(String key: updateMap.keySet()){
                fieldMethods.setField(key, goodID, updateMap.get(key));
            }
            goodID.setGood_update_time(LocalDateTime.now());
            return updateById(id, goodID); //let updateById handle
        }catch(RuntimeException | IllegalAccessException | NoSuchFieldException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Good save(Good good) {
        /*Operation*/
        try {
            goodDao.save(good);
            return good;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Good deleteById(Integer id) {
        /*Validation*/
        if (!goodDao.existsById(id))
            throw new NotFoundException();
        /*Operation*/
        try{
            Good good = goodDao.findById(id).orElse(null); //item must exist
            goodDao.deleteById(id);
            return good;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }
}
