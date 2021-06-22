package com.example.fishnprawn.freemarker;


import com.example.fishnprawn.admin.Admin;
import com.example.fishnprawn.admin.AdminDao;
import com.example.fishnprawn.utils.JsonBodyHandler;
import com.example.fishnprawn.category.Category;
import com.example.fishnprawn.category.CategoryDao;
import com.example.fishnprawn.good.Good;
import com.example.fishnprawn.good.GoodDao;
import com.example.fishnprawn.wxorder.*;
import com.lly835.bestpay.rest.HttpsClient;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.*;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.time.LocalDateTime;
import java.util.*;

@Controller
public class FreeMarkerController {
    private final String COOKIE = "Cookie";
    private final String JSESSIONID = "JSESSIONID";

    //---------------------------------------- Repository ------------------------------------------------//

    @Autowired
    private CategoryDao repositoryCat;

    @Autowired
    private GoodDao repositoryGood;

    @Autowired
    private OrderRootDao repositoryOrderRoot;

    @Autowired
    private WxOrderUtils wxOrder;

    @GetMapping("/")
    public String indexPage(){
        return "index/index";
    }

    //----------------------------------------category------------------------------------------------//
    // http://localhost:8080/fishnprawn/category
    @GetMapping("/category")
    public String category(ModelMap map){
        List<Category> categoryList = repositoryCat.findAll();
        map.put("categoryList", categoryList);
        return "/category/category";
    }

    @GetMapping("/category/remove")
    public String remove(@RequestParam(value = "catid", required = false) Integer catid, ModelMap map){
        repositoryCat.deleteById(catid);
        map.put("url", "/category");
        return "/operation/success";
    }

    @GetMapping("/category/addsuccess")
    public String addsuccess(ModelMap map){
        map.put("url", "/category");
        return "/operation/success";
    }

    @GetMapping("/category/categoryExcel")
    public String categoryExcel(ModelMap map){
        map.put("url", "/category");
        return "/category/excel";
    }

    //----------------------------------------good---------------------------------------------------//
    // http://localhost:8080/fishnprawn/menulist
    @GetMapping("/menulist")
    public String menulist(ModelMap map){
        List<Good> menulist = repositoryGood.findAll();
        map.put("menulist", menulist);
        return "/menulist/menulist";
    }
    @GetMapping("/goodlist/addgoodsuccess")
    public String addGoodSuccess(ModelMap map){
        map.put("url", "/menulist");
        return "/operation/success";
    }
    @GetMapping("/goodlist/removegoodlist")
    public String removegoodlist(@RequestParam(value = "goodid", required = false) Integer goodid, ModelMap map){
        repositoryGood.deleteById(goodid);
        map.put("url", "/menulist");
        return "/operation/success";
    }


    //----------------------------------------admin---------------------------------------------------//
    //http://localhost:8080/fishnprawn/admin
    @GetMapping("/admin")
    public String admin(ModelMap map,
                        @CookieValue(value = JSESSIONID, defaultValue = "No session id") String aToken) {
        // create a client
        HttpClient client = HttpClient.newHttpClient();
        System.out.println("session id: " + aToken);
        // create a request
        HttpRequest request = HttpRequest.newBuilder(
                //https://fishnprawn.cn
                URI.create("http://localhost:8080/admin/getall"))
                .headers("accept", "application/json",
                        COOKIE, JSESSIONID + "=" + aToken)
                .build();

        // use the client to send the request
        List adminList = new ArrayList<>();
        try {
            adminList = client.send(request, new JsonBodyHandler<>(List.class)).body();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //List<Admin> adminList = response;
        map.put("adminlist", adminList);
        return "/admin/admin";
    }

    @GetMapping("/admin/addadminsuccess")
    public String addAdminSuccess(ModelMap map){
        map.put("url", "/admin"); //go back to original tab
        return "/operation/success";
    }

    //----------------------------------------Wechat order lsit---------------------------------------------------//

    // http://localhost:8080/orderlist
    @GetMapping("/orderlist")
    public String orderlist(ModelMap map){
        List<WxOrderRoot> orderlist = repositoryOrderRoot.findAll();
        map.put("orderlist", orderlist);
        return "/wxorder/wxorderlist";
    }

    // http://localhost:8080/detail?orderId=...
    @GetMapping("/detail")
    public String detail(@RequestParam("orderId") int orderId,
                         ModelMap map) {
        WxOrderResponse orderDTO = new WxOrderResponse();
        orderDTO = wxOrder.findOne(orderId);

        map.put("orderDTO", orderDTO);
        return "wxorder/wxorderdetail";
    }




    //----------------------------------------Page---------------------------------------------------//

    // http://localhost:8080/login
    @GetMapping("/login")
    public String login(){
        return "/login/login";
    }

    // http://localhost:8080/home
    @GetMapping("/home")
    public String home(){
        return "/home/home";
    }

    @GetMapping("/menulist/menulistExcel")
    public String menulistExcel(ModelMap map){
        map.put("url", "/category");
        return "/menulist/excel";
    }



}

