package com.example.fishnprawn.wxorder;

import com.example.fishnprawn.good.Good;
import com.example.fishnprawn.good.GoodDao;
import com.example.fishnprawn.utils.ExcelExport;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;


@Service
@Slf4j
public class WxOrderUtils {

    @Autowired
    private GoodDao goodDao;

    @Autowired
    private OrderDetailDao orderDetailDao;

    @Autowired
    private OrderRootDao orderRootDao;


    public WxOrderResponse createOrder(WxOrderResponse orderBean){

        WxOrderRoot wxOrderRoot = new WxOrderRoot();
        BeanUtils.copyProperties(orderBean, wxOrderRoot);

        WxOrderRoot orderRoot = orderRootDao.save(wxOrderRoot);

        for (WxOrderDetail orderDetail : orderBean.getOrderDetailList()) {
            Good foodInfo = goodDao.findById(orderDetail.getGood_id()).orElse(null);
            //订单详情入库
//            orderDetail.setGood_id(orderRoot.getOrder_id());
            orderDetail.setOrderId(orderRoot.getOrderId());
            BeanUtils.copyProperties(foodInfo, orderDetail);
            orderDetailDao.save(orderDetail);
        }

        log.info("[添加订单成功={}]", orderBean);

        return orderBean;
    }

    //查询单个订单
    public WxOrderResponse findOne(Integer order_id) {

        WxOrderRoot wxOrderRoot = orderRootDao.findById(order_id).orElse(null);

        List<WxOrderDetail> orderDetailList = orderDetailDao.findByOrderId(order_id);

        WxOrderResponse orderDTO = new WxOrderResponse();
        BeanUtils.copyProperties(wxOrderRoot, orderDTO);
        orderDTO.setOrderDetailList(orderDetailList);

        return orderDTO;
    }

    //导出订单数据到excel
    public void exportOrderToExcel(HttpServletResponse response) throws IOException {
        String fileName = "订单导出";
        String[] titles = {"订单id","订单编号", "姓名", "地址", "手机", "订单金额", "订单状态", "下单时间"};
        List<WxOrderRoot> rootList = orderRootDao.findAll();
        int size = rootList.size();
        String[][] dataList = new String[size][titles.length];
        for (int i = 0; i < size; i++) {
            WxOrderRoot orderRoot = rootList.get(i);
            dataList[i][0] = "" + orderRoot.getOrderId();
            dataList[i][1] = orderRoot.getOrder_number();
            dataList[i][2] = orderRoot.getUser_name();
            dataList[i][3] = orderRoot.getUser_address();
            dataList[i][4] = "" + orderRoot.getUser_phone();
            dataList[i][5] = "" + orderRoot.getOrder_total_price();
            dataList[i][6] = "" + orderRoot.getOrderStatus();
            dataList[i][7] = "" + orderRoot.getOrder_create_time();
        }
        ExcelExport.createWorkbook(fileName, titles, dataList, response);
    }

    //查询不同订单状态列表
    public List<WxOrderResponse> findListStats(String open_id, Integer order_status) {

        List<WxOrderRoot> orderMasters;

        if(order_status == null){
            orderMasters = orderRootDao.findByOpenId(open_id);
        }else{
            orderMasters = orderRootDao.findByOpenIdAndOrderStatus(open_id, order_status);
        }


        return orderResponse(orderMasters);
    }

    public List<WxOrderResponse> findListByOrderId(Integer order_id){
        List<WxOrderRoot> orderMasters = orderRootDao.findByOrderId(order_id);
        return orderResponse(orderMasters);
    }

    /*
     * 类型转换的工具类
     * */
    private WxOrderResponse convert1(WxOrderRoot orderMaster) {
        WxOrderResponse orderDTO = new WxOrderResponse();
        BeanUtils.copyProperties(orderMaster, orderDTO);
        return orderDTO;
    }

    private List<WxOrderResponse> orderResponse(List<WxOrderRoot> orderMasterList) {
        return orderMasterList.stream().map(e ->
                convert1(e)
        ).collect(Collectors.toList());
    }


}
