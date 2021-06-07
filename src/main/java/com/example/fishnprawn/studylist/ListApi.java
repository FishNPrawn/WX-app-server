package com.example.fishnprawn.studylist;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedList;
import java.util.List;

@RestController
public class ListApi {

    //返回列表数据给前端
    @GetMapping("/getList")
    public List getList(){
        List<String> list = new LinkedList<>();
        list.add("coding Yang1");
        list.add("coding Yang2");
        list.add("coding Yang3");
        return list;
    }

}