package com.example.fishnprawn.freemarker;


import com.example.fishnprawn.admin.Admin;
import com.example.fishnprawn.admin.AdminDao;
import com.example.fishnprawn.comment.Comment;
import com.example.fishnprawn.comment.CommentDao;
import com.example.fishnprawn.global.GlobalConst;
import com.example.fishnprawn.orderRefund.OrderRefund;
import com.example.fishnprawn.orderRefund.OrderRefundDao;
import com.example.fishnprawn.paySupplier.PaySupplier;
import com.example.fishnprawn.paySupplier.PaySupplierDao;
import com.example.fishnprawn.promocode.PromoCode;
import com.example.fishnprawn.promocode.PromoCodeDao;
import com.example.fishnprawn.shipment.Shipment;
import com.example.fishnprawn.shipment.ShipmentDao;
import com.example.fishnprawn.swiper.SwiperImg;
import com.example.fishnprawn.swiper.SwiperImgDao;
import com.example.fishnprawn.userinfo.UserInfo;
import com.example.fishnprawn.userinfo.UserInfoDao;
import com.example.fishnprawn.utils.JsonBodyHandler;
import com.example.fishnprawn.category.Category;
import com.example.fishnprawn.category.CategoryDao;
import com.example.fishnprawn.good.Good;
import com.example.fishnprawn.good.GoodDao;
import com.example.fishnprawn.wxorder.*;
import com.example.fishnprawn.wxorderremark.WxOrderDetailRemark;
import com.example.fishnprawn.wxorderremark.WxOrderDetailRemarkDao;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.net.*;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.util.*;

@Controller
@CrossOrigin
public class FreeMarkerController {
    private final String COOKIE = "Cookie";
    private final String JSESSIONID = "JSESSIONID";

    //---------------------------------------- Repository ------------------------------------------------//
    @Autowired
    private AdminDao adminDao;

    @Autowired
    private UserInfoDao repositoryUserInfo;

    @Autowired
    private CategoryDao repositoryCat;

    @Autowired
    private GoodDao repositoryGood;

    @Autowired
    private OrderRootDao repositoryOrderRoot;

    @Autowired
    private OrderDetailDao repositoryorderDetail;

    @Autowired
    private SwiperImgDao repositorySwiperImg;

    @Autowired
    private CommentDao repositoryComment;

    @Autowired
    private WxOrderUtils wxOrder;

    @Autowired
    private WxOrderDetailRemarkDao repositorywxorderDetailRemark;

    @Autowired
    private ShipmentDao repositoryShipment;

    @Autowired
    private PromoCodeDao repositoryPromoCode;

    @Autowired
    private OrderRefundDao repositoryOrderRefund;

    @Autowired
    private PaySupplierDao repositoryPaySupplier;


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

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }

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

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }
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

    @GetMapping("/goodlist/deletesuccess")
    public String deleteGoodSuccess(ModelMap map){
        map.put("url", "/menulist");
        return "/operation/success";
    }


    //----------------------------------------admin---------------------------------------------------//
    //http://localhost:8080/fishnprawn/admin
    @GetMapping("/admin")
    public String admin(ModelMap map,
                        @CookieValue(value = JSESSIONID, defaultValue = "No session id") String aToken) {

        // get the get all admin: https://fishnprawn.cn/admin/getall
        String BASE_DOMAIN = GlobalConst.BASE_DOMAIN;
        String getAllUrl = BASE_DOMAIN + "/admin/getall";

        // create a client
        HttpClient client = HttpClient.newHttpClient();
        System.out.println("session id: " + aToken);
        // create a request
        HttpRequest request = HttpRequest.newBuilder(
                URI.create(getAllUrl))
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

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }

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

        List<Good> menulist = repositoryGood.findAll();
        map.put("menulist", menulist);

        List<WxOrderDetailRemark> wxOrderDetailRemarks = repositorywxorderDetailRemark.findAll();
        map.put("wxOrderDetailRemarks", wxOrderDetailRemarks);

        List<Category> categoryList = repositoryCat.findAll();
        map.put("categoryList", categoryList);

        return "/wxorder/wxorderlist";
    }

    // http://localhost:8080/detail?orderId=...
    @GetMapping("/detail")
    public String detail(@RequestParam("orderId") int orderId,
                         ModelMap map) {
        WxOrderResponse orderDTO = new WxOrderResponse();
        orderDTO = wxOrder.findOne(orderId);
        map.put("orderDTO", orderDTO);

        List<WxOrderRoot> orderlist = repositoryOrderRoot.findAll();
        map.put("orderlist", orderlist);

        List<Good> menulist = repositoryGood.findAll();
        map.put("menulist", menulist);

        List<WxOrderDetailRemark> wxOrderDetailRemarks = repositorywxorderDetailRemark.findAll();
        map.put("wxOrderDetailRemarks", wxOrderDetailRemarks);

        List<Shipment> shipments = repositoryShipment.findAll();
        map.put("shipments", shipments);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }

        return "wxorder/wxorderdetail";
    }

    // http://localhost:8080/orderlist
    @GetMapping("/cancelorder")
    public String cancelorder(ModelMap map){
        List<WxOrderRoot> cancelorder = repositoryOrderRoot.findAll();
        map.put("cancelorder", cancelorder);
        return "/wxorder/cancelorder";
    }

    //----------------------------------------轮播图---------------------------------------------------//
    // http://localhost:8080/swiper
    @GetMapping("/swiper")
    public String swiper(ModelMap map){
        List<SwiperImg> swiperImgList = repositorySwiperImg.findAll();
        map.put("swiperImgList", swiperImgList);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }
        return "/swiper/swiper";
    }

    @GetMapping("/swiper/addsuccess")
    public String addSwipersuccess(ModelMap map){
        map.put("url", "/swiper");
        return "/operation/success";
    }


    //----------------------------------------所有订单---------------------------------------------------//
    // http://localhost:8080/allorder
    @GetMapping("/allorder")
    public String allorder(ModelMap map){

        List<WxOrderRoot> orderlist = repositoryOrderRoot.findAll();
        map.put("orderlist", orderlist);

        List<Shipment> shipments = repositoryShipment.findAll();
        map.put("shipments", shipments);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }

        return "/wxorder/allorder";
    }

    //----------------------------------------下单成功---------------------------------------------------//
    @GetMapping("/order/createOrderSuccess")
    public String createOrderSuccess(ModelMap map){
        map.put("url", "/orderlist");
        return "/operation/success";
    }

    //----------------------------------------Page---------------------------------------------------//

    // http://localhost:8080/login
    @GetMapping("/login")
    public String login(){
        return "/login/login";
    }

    // http://localhost:8080/home
    @GetMapping("/home")
    public String home(ModelMap map){
        // 未发货订单
        List<WxOrderRoot> orderlist = repositoryOrderRoot.findAll();
        map.put("orderlist", orderlist);

        // 总交易金额
        List<WxOrderDetail> orderdetailist = repositoryorderDetail.findAll();
        map.put("orderdetailist", orderdetailist);

        // 用户量
        List<UserInfo> userInfoList = repositoryUserInfo.findAll();
        map.put("userInfoList", userInfoList);

        List<OrderRefund> orderRefundList = repositoryOrderRefund.findAll();
        map.put("orderRefundList", orderRefundList);

        List<PaySupplier> paySupplierList = repositoryPaySupplier.findAll();
        map.put("paySupplierList", paySupplierList);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }

        return "/home/home";
    }

    @GetMapping("/menulist/menulistExcel")
    public String menulistExcel(ModelMap map){
        map.put("url", "/category");
        return "/menulist/excel";
    }


    @GetMapping("/commentList")
    public String comment(ModelMap map){
        List<Comment> commentList = repositoryComment.findAll();
        map.put("commentList", commentList);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }
        return "/comment/comment";
    }

    @GetMapping("/comment/deletesuccess")
    public String commentDeleteSuccess(ModelMap map){
        map.put("url", "/commentList");
        return "/operation/success";
    }

    @GetMapping("/comment/commentExcel")
    public String commentExcel(ModelMap map){
        map.put("url", "/comment");
        return "/comment/excel";
    }

    @GetMapping("/userInfoList")
    public String userinfo(ModelMap map){
        List<UserInfo> userInfoList = repositoryUserInfo.findAll();
        map.put("userInfoList", userInfoList);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }

        return "/userinfo/userinfo";
    }

//    promo code
    @GetMapping("/promocode")
    public String promocode(ModelMap map){
        List<PromoCode> promocode = repositoryPromoCode.findAll();
        map.put("promocode", promocode);

        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        Admin admin = adminDao.findByUsername(username);
        if(admin.getAdmintype() == 2){
            map.put("isAdmin", true);
        }

        return "/promocode/promocode";
    }

    @GetMapping("/promocode/addsuccess")
    public String addPromoCodeSuccess(ModelMap map){
        map.put("url", "/promocode");
        return "/operation/success";
    }

    // http://localhost:8080/promocode/detail?promoCodeHeaderId=...
    @GetMapping("/promocode/detail")
    public String promoCodeDetail(@RequestParam("promoCodeHeaderId") int promo_code_header_id,
                         ModelMap map) {
        List<PromoCode> promocode = repositoryPromoCode.findAll();
        map.put("promocode", promocode);
        map.put("promo_code_header_id", promo_code_header_id);

        List<WxOrderRoot> orderlist = repositoryOrderRoot.findAll();
        map.put("orderlist", orderlist);

        List<Good> menulist = repositoryGood.findAll();
        map.put("menulist", menulist);

        List<WxOrderDetailRemark> wxOrderDetailRemarks = repositorywxorderDetailRemark.findAll();
        map.put("wxOrderDetailRemarks", wxOrderDetailRemarks);

        List<Category> categoryList = repositoryCat.findAll();
        map.put("categoryList", categoryList);

        return "/promocode/promoCodeDetail";
    }


    @GetMapping("/orderRefund")
    public String orderRefund(ModelMap map){
        List<OrderRefund> orderRefundList = repositoryOrderRefund.findAll();
        map.put("orderRefundList", orderRefundList);
        return "/orderRefund/orderRefund";
    }

    @GetMapping("/paySupplier")
    public String paySupplier(ModelMap map){
        List<PaySupplier> paySupplierList = repositoryPaySupplier.findAll();
        map.put("paySupplierList", paySupplierList);

        return "/orderRefund/paySupplier";
    }

    @GetMapping("/orderRefund/addsuccess")
    public String addOrderRefundSuccess(ModelMap map){
        map.put("url", "/orderRefund");
        return "/operation/success";
    }

    @GetMapping("/paySupplier/addsuccess")
    public String addPaySupplierSuccess(ModelMap map){
        map.put("url", "/paySupplier");
        return "/operation/success";
    }


}

