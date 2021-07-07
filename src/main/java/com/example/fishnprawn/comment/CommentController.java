package com.example.fishnprawn.comment;


import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(CommentController.BASE_URL)
@RestController
@Slf4j
public class CommentController {
    public static final String BASE_URL = "/comment";

    @Autowired
    private CommentServices commentServices;

    @Autowired
    private CommentDao commentDao;

//    添加评论
    @PostMapping(path="/createComment")
    public String saveGood(@Valid CommentReq commentReq){ //if any attribute in v is not valid type, it will return 400

        CommentResponse commentBean = new CommentResponse();
        List<Comment> commentList = new ArrayList<>();

        try{
            commentList = new Gson().fromJson(commentReq.getItems(), new TypeToken<List<Comment>>(){}.getType());
            System.out.println("order_Detail: " +commentList);

        }catch (Exception e){
            log.error("【对象转换】错误, string={}", commentReq.getItems());
        }

        commentBean.setCommentList(commentList);

        for (Comment commentDetail: commentBean.getCommentList()){
            commentDao.save(commentDetail);
        }

        return "success";
    }

    //    拿到评论
    @GetMapping(path="/comment_filter", produces = "application/json")
    public ResponseEntity<Map<String, List<CommentView>>> comment_filter(@RequestParam(required = false) Map<String,String> filter){
        log.info("[Get Comment_filter_Request]");

        Map<String, List<CommentView>> result = new HashMap<>();
        result.put("data", new ArrayList<>());

        try {
            List<Comment> comment = commentServices.getAll(filter);
            for(Comment commentlist:comment){
                CommentView commentView = new CommentView();
                commentView.setAttributes(commentlist);
                result.get("data").add(commentView);
            }
        }catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<Comment> deleteCommentById(@PathVariable Integer id){
        System.out.println("[Delete one comment] parameters: "+ id);
        return new ResponseEntity<>(commentServices.deleteById(id), HttpStatus.OK);
    }

}
