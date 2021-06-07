package com.example.fishnprawn.studymql;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserController {

    @Autowired
    UserDao userDao;

    //查询数据
    @GetMapping("/getAll")
    public List getAll(){
        List all = userDao.findAll();
        return all;
    }




    //添加数据到数据库
    @GetMapping("/add")
    public User add(@RequestParam("id") int id,
                    @RequestParam("name") String name,
                    @RequestParam("age") int age,
                    @RequestParam("address") String address){
        User user = new User();
        user.setId(id);
        user.setName(name);
        user.setAge(age);
        user.setAddress(address);

        User save = userDao.save(user);
        return save;
    }

    //删除数据库里的单条数据
    @GetMapping("/deleteOne")
    public String deleteOne(@RequestParam("id") int id){
        userDao.deleteById(id);
        return "delete success";
    }

    //删除多条
    @GetMapping("/deleteAll")
    public String deleteAll(){
        userDao.deleteAll();
        return "success delete all";
    }
}

