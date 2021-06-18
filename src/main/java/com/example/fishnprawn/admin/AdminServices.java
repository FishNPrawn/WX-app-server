package com.example.fishnprawn.admin;
import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.exception.ServiceValidationException;
import com.example.fishnprawn.services.Services;
import com.example.fishnprawn.utils.FieldMethods;
import com.example.fishnprawn.utils.PasswordEncrypt;
import com.example.fishnprawn.validation.AdminArgumentValidation;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Field;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
@Transactional
public class AdminServices implements Services<Admin> {
    @Autowired
    private AdminDao adminDao;

    @Autowired
    private AdminArgumentValidation adminArgumentValidation;

    @Override
    public Admin addOne(Admin anAdmin) {
        System.out.println(anAdmin.getPassword());
        anAdmin.setPassword(PasswordEncrypt.encrypt(anAdmin.getPassword()));
        save(anAdmin);
        return anAdmin;
    }

    @Override
    public Admin getById(Integer id) {
        /*Validation*/
        if(!adminDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try{
            return adminDao.findById(id).orElse(null); //must use findById
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());//Exception from repository
        }
    }

    @Override
    public List<Admin> getAll(Map<String, String> filter) {
        /*Validation*/
        //filter has gone through Nullity check, no duplicate key, turned into lowercase
        if(!adminArgumentValidation.checkFilter(filter)) //check whether fields are legal
            throw new ServiceValidationException("Illegal field in filter");

        /*Operation*/
        try {
            FieldMethods<Admin> fieldMethods = new FieldMethods<>(Admin.class);
            Admin admin = new Admin();
            for(Field field: fieldMethods.getAllFields(true)){
                String fieldName = field.getName();
                if(filter.containsKey(fieldName))
                    fieldMethods.setField(fieldName, admin, filter.get(fieldName));
            }

            ExampleMatcher ignoringExampleMatcher = ExampleMatcher.matchingAll()
                    .withIgnorePaths("adminid");
//                    .withMatcher("lastName", ExampleMatcher.GenericPropertyMatchers.startsWith().ignoreCase())
//                    .withIgnorePaths("firstName", "seatNumber").withIgnorePaths();
            Example<Admin> adminExample = Example.of(admin, ignoringExampleMatcher);
            return adminDao.findAll(adminExample);
        } catch (RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository or our logic
        } catch (IllegalAccessException | NoSuchFieldException e) {
            throw new ServiceValidationException("Invalid filter");
        }
    }

    @Override
    public Admin updateById(Integer id, Admin admin) {
        /*Validation*/
        if(!adminDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            Admin adminOld = adminDao.findById(id).orElse(null);
            admin.setAdminid(id);
            admin.setPassword(PasswordEncrypt.encrypt(admin.getPassword()));
            admin.setAdmin_create_time(adminOld.getAdmin_create_time());
            admin.setAdmin_update_time(LocalDateTime.now());
            save(admin); //H2 will overwrite the existing data
            return admin;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Admin updateAttrById(Integer id, Map<String, String> updateMap) {
        /*Validation*/
        if(!adminDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            Admin adminOld = adminDao.findById(id).orElse(null);

            final FieldMethods<Admin> fieldMethods = new FieldMethods<>(Admin.class);
            for(String key: updateMap.keySet()){
                fieldMethods.setField(key, adminOld, updateMap.get(key));
            }

            adminOld.setAdmin_update_time(LocalDateTime.now());

            return updateById(id, adminOld); //let updateById handle
        }catch(RuntimeException | IllegalAccessException | NoSuchFieldException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Admin save(Admin admin) {
        /*Validation*/
//        if (adminDao.existsById(admin.getAdminid()))
//            throw new ServiceValidationException("Queried id is already in the DB");

        /*Operation*/
        try {
            adminDao.save(admin);
            return admin;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public Admin deleteById(Integer id) {
        /*Validation*/
        if (!adminDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try{
            Admin admin = adminDao.findById(id).orElse(null); //item must exist
            adminDao.deleteById(id);
            return admin;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

}
