package com.example.fishnprawn.wxorder;

import com.example.fishnprawn.exception.ServiceException;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(WxOrderController.BASE_URL)
@RestController
@Slf4j
public class WxOrderController {

    public static final String BASE_URL = "/order";

    @Autowired
    private WxOrderUtils wxOrder;

    @Autowired
    private OrderRootServices orderRootServices;

    @Autowired
    private OrderDetailServices orderDetailServices;

    @Autowired
    private OrderRootDao orderRootDao;

    /* 创建订单 */
    @PostMapping("/create")
    public void create(@Valid OrderReq orderReq){
        //数据转换
        WxOrderResponse orderBean = new WxOrderResponse();
        orderBean.setOrder_number(orderReq.getOrder_number());
        orderBean.setOpenId(orderReq.getOpenId());
        orderBean.setAccess_token(orderReq.getAccess_token());
        orderBean.setUser_name(orderReq.getUser_name());
        orderBean.setUser_address(orderReq.getUser_address());
        orderBean.setUser_phone(orderReq.getUser_phone());
        orderBean.setOrder_total_price(orderReq.getOrder_total_price());
        orderBean.setOrder_create_time(LocalDateTime.now());
        orderBean.setOrder_comment(orderReq.getOrder_comment());
        orderBean.setOrderStatus(orderReq.getOrderStatus());
        orderBean.setOrder_total_weight(orderReq.getOrder_total_weight());
        orderBean.setOrder_express_fee(orderReq.getOrder_express_fee());
        orderBean.setOrder_total_price_with_express_fee(orderReq.getOrder_total_price_with_express_fee());
        orderBean.setPromoCodeHeaderId(orderReq.getPromoCodeHeaderId());
        orderBean.setOrder_total_discount(orderReq.getOrder_total_discount());
        List<WxOrderDetail> orderDetailList = new ArrayList<>();

        try{
            orderDetailList = new Gson().fromJson(orderReq.getItems(), new TypeToken<List<WxOrderDetail>>(){}.getType());
            orderBean.setOrderDetailList(orderDetailList);
            wxOrder.createOrder(orderBean);
            System.out.println("order_Detail: " +orderDetailList);
        }catch (Exception e){
            log.error("【对象转换】错误, string={}", orderReq.getItems());
        }
    }

    /* 创建订单 */
    @PostMapping("/createByOwn")
    public String createByOwn(@Valid @RequestBody OrderReq orderReq){
        //数据转换
        WxOrderResponse orderBean = new WxOrderResponse();
        orderBean.setOrder_number(orderReq.getOrder_number());
        orderBean.setOpenId(orderReq.getOpenId());
        orderBean.setAccess_token(orderReq.getAccess_token());
        orderBean.setUser_name(orderReq.getUser_name());
        orderBean.setUser_address(orderReq.getUser_address());
        orderBean.setUser_phone(orderReq.getUser_phone());
        orderBean.setOrder_total_price(orderReq.getOrder_total_price());
        orderBean.setOrder_create_time(LocalDateTime.now());
        orderBean.setOrder_comment(orderReq.getOrder_comment());
        orderBean.setOrderStatus(orderReq.getOrderStatus());
        orderBean.setOrder_total_weight(orderReq.getOrder_total_weight());
        orderBean.setOrder_express_fee(orderReq.getOrder_express_fee());
        orderBean.setOrder_total_price_with_express_fee(orderReq.getOrder_total_price_with_express_fee());
        orderBean.setPromoCodeHeaderId(orderReq.getPromoCodeHeaderId());
        orderBean.setOrder_total_discount(orderReq.getOrder_total_discount());
        List<WxOrderDetail> orderDetailList = new ArrayList<>();

        try{
            orderDetailList = new Gson().fromJson(orderReq.getItems(), new TypeToken<List<WxOrderDetail>>(){}.getType());
            System.out.println("order_Detail: " +orderDetailList);

        }catch (Exception e){
            log.error("【对象转换】错误, string={}", orderReq.getItems());
        }

        orderBean.setOrderDetailList(orderDetailList);

        wxOrder.createOrder(orderBean);


        return "success";
    }


    // 给某个订单添加订单商品
    @PostMapping(path="/add", produces="application/json")
    public ResponseEntity<WxOrderDetail> addGoodInOrderDetail(@RequestParam("order_id") int order_id,
                                                              @RequestParam("good_quantity") double good_quantity,
                                                              @RequestParam("good_price") double good_price,
                                                              @Valid @RequestBody WxOrderDetail wxOrderDetail){
        System.out.println("[add one good]");

        WxOrderResponse orderDTO = wxOrder.findOne(order_id);
        double order_total_price_with_express_fee = orderDTO.getOrder_total_price_with_express_fee();
        double order_total_price = orderDTO.getOrder_total_price();

        order_total_price_with_express_fee = order_total_price_with_express_fee + good_quantity * good_price;
        order_total_price = order_total_price + good_quantity * good_price;
        orderDTO.setOrder_total_price_with_express_fee(order_total_price_with_express_fee);
        orderDTO.setOrder_total_price(order_total_price);

        WxOrderRoot orderMaster = new WxOrderRoot();
        BeanUtils.copyProperties(orderDTO, orderMaster);
        orderRootDao.save(orderMaster);

        return new ResponseEntity<>(orderDetailServices.save(wxOrderDetail), HttpStatus.CREATED);
    }

    //取消订单
    @PostMapping("/confirm")
    public String confirmOrder(@RequestParam("openid") String openid,
                              @RequestParam("orderId") int orderId){
        WxOrderResponse orderDTO = wxOrder.findOne(orderId);
        if (orderDTO == null) {
            log.error("【取消订单】查不到改订单, orderId={}", orderId);
        }
        //判断是否是自己的订单
        wxOrder.confirmOrder(orderDTO);

        return "Confirm Success";
    }

    //取消订单
    @PostMapping("/cancel")
    public String cancelOrder(@RequestParam("openid") String openid,
                              @RequestParam("orderId") int orderId){
        WxOrderResponse orderDTO = wxOrder.findOne(orderId);
        if (orderDTO == null) {
            log.error("【取消订单】查不到改订单, orderId={}", orderId);
        }
        //判断是否是自己的订单
        wxOrder.cancelOrder(orderDTO);

        return "Cancel Success";
    }

    //取消订单
    @GetMapping("/cancelOrderServer")
    public ModelAndView cancelOrderServer(@RequestParam("orderId") int orderId,  ModelMap map){
        ModelAndView modelAndView = new ModelAndView();

        WxOrderResponse orderDTO = wxOrder.findOne(orderId);
        if (orderDTO == null) {
            log.error("【取消订单】查不到改订单, orderId={}", orderId);
        }

        wxOrder.cancelOrder(orderDTO);

        modelAndView.setViewName("/operation/success");
        map.put("url", "/orderlist");
        return modelAndView;
    }

    //http://localhost:8080/order/deletebyid/{id}
    @DeleteMapping(path="/deletebyid/{id}", produces = "application/json")
    public ResponseEntity<WxOrderDetail> deleteOrderDetailById(@PathVariable Integer id,
                                                               @RequestParam("order_id") int order_id,
                                                               @RequestParam("good_price") double good_price){

        WxOrderResponse orderDTO = wxOrder.findOne(order_id);
        double order_total_price_with_express_fee = orderDTO.getOrder_total_price_with_express_fee();
        double order_total_price = orderDTO.getOrder_total_price();

        order_total_price_with_express_fee = order_total_price_with_express_fee - good_price;
        order_total_price = order_total_price - good_price;
        orderDTO.setOrder_total_price_with_express_fee(order_total_price_with_express_fee);
        orderDTO.setOrder_total_price(order_total_price);

        WxOrderRoot orderMaster = new WxOrderRoot();
        BeanUtils.copyProperties(orderDTO, orderMaster);
        orderRootDao.save(orderMaster);

        System.out.println("[Delete one Order detail] parameters: "+ id);
        return new ResponseEntity<>(orderDetailServices.deleteById(id), HttpStatus.OK);
    }

    /*订单详情*/
    @GetMapping("/detail")
    public String detail(@RequestParam("orderId") int orderId) {

        wxOrder.findOne(orderId);
        return "success";
    }


    /* 导出菜品订单到excel */
    @GetMapping("/export")
    public void export(HttpServletResponse response, ModelMap map) {
        ModelAndView modelAndView = new ModelAndView();
        try {
            wxOrder.exportOrderToExcel(response);
        } catch (Exception e) {
            System.out.println("导出excel失败");
        }
        map.put("url", "/orderlist");
    }


    /* filter by open_id get user order */
    /* http://localhost:8080/order/order_filter?filter=??? */
    @GetMapping(path="/order_filter", produces = "application/json")
    public ResponseEntity<Map<String, List<OrderReq>>> filterOrder(@RequestParam(required = false) Map<String,String> filter){
        log.info("[Get Filter_Order_Request]");

        Map<String, List<OrderReq>> result = new HashMap<>();
        result.put("data", new ArrayList<>());
        try {
            List<WxOrderRoot> wxOrderRoots = orderRootServices.getAll(filter);
            for(WxOrderRoot order: wxOrderRoots){
                OrderReq orderReq = new OrderReq();
                orderReq.setAttributes(order);
                result.get("data").add(orderReq);
            }
        }catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(result, HttpStatus.OK);
    }


    /* filter by order_id to get specific order list */
    /* http://localhost:8080/order/order_detail_filter?filter=??? */
    @GetMapping(path="/order_detail_filter", produces = "application/json")
    public ResponseEntity<Map<String, List<WxOrderDetailView>>> filterOrderDetail(@RequestParam(required = false) Map<String,String> filter){
        log.info("[Get Filter_Order_Detail_Request]");

        Map<String, List<WxOrderDetailView>> result = new HashMap<>();
        result.put("data", new ArrayList<>());
        try {
            List<WxOrderDetail> wxOrderDetail = orderDetailServices.getAll(filter);
            for(WxOrderDetail order : wxOrderDetail){
                WxOrderDetailView wxOrderDetailView = new WxOrderDetailView();
                wxOrderDetailView.setAttributes(order);
                result.get("data").add(wxOrderDetailView);
            }
        }catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    /* 拿到订单列表by open_id 和 order_status */
    /* http://localhost:8080/order/listByStatus?openid=?&orderStatus=? */
    @GetMapping("/listByStatus")
    public List<WxOrderResponse> listByStatus(@RequestParam("openid") String openid,
                                                        @RequestParam(value = "orderStatus", required = false) Integer orderStatus) {
        if (StringUtils.isEmpty(openid)) {
            log.error("[查询订单列表]openid为空");
        }

        List<WxOrderResponse> list = new ArrayList<>();
        list.clear();
        List<WxOrderResponse> listStats;
        if(orderStatus == null){
            listStats = wxOrder.findListStats(openid, null);
        }else{
            listStats = wxOrder.findListStats(openid, orderStatus);
        }



        listStats.forEach((orderBean) -> {
            WxOrderResponse one = wxOrder.findOne(orderBean.getOrderId());
            list.add(one);
        });

        return list;
    }

    /* 拿到订单列表by open_id 和 order_status */
    /* http://localhost:8080/order/listByStatus?openid=?&orderStatus=? */
    @GetMapping("/listByOrderId")
    public List<WxOrderResponse> listByOrderId(@RequestParam("orderid") int orderid) {
        if (StringUtils.isEmpty(orderid)) {
            log.error("[查询订单列表]openid为空");
        }

        List<WxOrderResponse> list = new ArrayList<>();
        list.clear();

        List<WxOrderResponse> listStats = wxOrder.findListByOrderId(orderid);
        listStats.forEach((orderBean) -> {
            WxOrderResponse one = wxOrder.findOne(orderBean.getOrderId());
            list.add(one);
        });

        return list;
    }

    //修改wxOrderRoot 的运费和价格
    @PutMapping("/updateExpressFeeAndTotalPrice")
    public String updateExpressFeeAndTotalPrice(@RequestParam("order_id") int order_id,
                                                @RequestParam("order_express_fee") double order_express_fee,
                                                @RequestParam("order_total_price") double order_total_price){

        double order_total_price_with_express_fee = order_express_fee + order_total_price;
        WxOrderResponse orderDTO = wxOrder.findOne(order_id);
        orderDTO.setOrder_express_fee(order_express_fee);
        orderDTO.setOrder_total_price(order_total_price);
        orderDTO.setOrder_total_price_with_express_fee((order_total_price_with_express_fee));

        WxOrderRoot orderMaster = new WxOrderRoot();
        BeanUtils.copyProperties(orderDTO, orderMaster);
        WxOrderRoot updateResult = orderRootDao.save(orderMaster);

        return "success";
    }



}
