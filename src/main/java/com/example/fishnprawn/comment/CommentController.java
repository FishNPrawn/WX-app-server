package com.example.fishnprawn.comment;


import com.example.fishnprawn.category.Category;
import com.example.fishnprawn.utils.ExcelImport;
import com.example.fishnprawn.wxorder.OrderRootDao;
import com.example.fishnprawn.wxorder.WxOrderResponse;
import com.example.fishnprawn.wxorder.WxOrderRoot;
import com.example.fishnprawn.wxorder.WxOrderUtils;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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

    @Autowired
    private WxOrderUtils wxOrder;

    @Autowired
    private OrderRootDao orderRootDao;

//    添加评论
    @PostMapping(path="/createComment")
    public String createComment(@RequestParam("orderId") int orderId, @Valid CommentReq commentReq){ //if any attribute in v is not valid type, it will return 400

        CommentResponse commentBean = new CommentResponse();
        List<Comment> commentList = new ArrayList<>();

        try{
            commentList = new Gson().fromJson(commentReq.getItems(), new TypeToken<List<Comment>>(){}.getType());
            System.out.println("order_Detail: " +commentList);

        }catch (Exception e){
            log.error("【对象转换】错误, string={}", commentReq.getItems());
        }

        commentBean.setCommentList(commentList);

        //修改订单状态
        WxOrderResponse orderDTO = wxOrder.findOne(orderId);
        orderDTO.setOrderStatus(0);
        WxOrderRoot orderMaster = new WxOrderRoot();
        BeanUtils.copyProperties(orderDTO, orderMaster);
        WxOrderRoot updateResult = orderRootDao.save(orderMaster);

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

    @RequestMapping("/uploadCommentByExcel")
    public ModelAndView uploadExcel(@RequestParam("file") MultipartFile file, ModelMap map){
        ModelAndView modelAndView = new ModelAndView();
        String name = file.getOriginalFilename();

        List<Comment> list;
        try {
            list = ExcelImport.excelToCommentList(file.getInputStream());
            log.info("excel导入的list={}", list);

            //excel的数据保存到数据库
            try {
                for(Comment excel:list){
                    if(excel != null){
                        commentDao.save(excel);
                    }
                }
            }catch (Exception e){
                log.error("某一行存入数据库失败={}", e);
            }

        }catch (Exception e){
            log.error("失败", e);
        }


        modelAndView.setViewName("/operation/success");
        map.put("url", "/commentList");
        return modelAndView;
    }

}
