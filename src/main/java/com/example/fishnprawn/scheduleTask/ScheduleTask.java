package com.example.fishnprawn.scheduleTask;

import com.example.fishnprawn.wxorder.OrderRootDao;
import com.example.fishnprawn.wxorder.OrderRootServices;
import com.example.fishnprawn.wxorder.WxOrderRoot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Configuration //1.主要用于标记配置类，兼备Component的效果。
@EnableScheduling   // 2.开启定时任务
public class ScheduleTask {

    @Autowired
    private OrderRootDao orderRootDao;

    @Scheduled(cron = "0 59 23 * * ?")
    private void configureTasks() {

        SimpleDateFormat myFormat = new SimpleDateFormat("yyyy-MM-dd");
        List<WxOrderRoot> wxOrderRootList = orderRootDao.findAll();

        try {
            for(WxOrderRoot time : wxOrderRootList){
                if(time.getOrderStatus() == 2){
                    String orderCreateDate = time.getOrder_create_time().toString();
                    String currentDate = LocalDateTime.now().toString();

                    Date dateBefore = myFormat.parse(orderCreateDate);
                    Date dateAfter = myFormat.parse(currentDate);
                    long difference = dateAfter.getTime() - dateBefore.getTime();
                    float daysBetween = (difference / (1000 * 60 * 60 * 24));

                    if(daysBetween >= 8){
                        time.setOrderId(time.getOrderId());
                        time.setOrderStatus(3);
                        orderRootDao.save(time);
                    }
                }

                if(time.getOrderStatus() == 3){
                    String orderCreateDate = time.getOrder_create_time().toString();
                    String currentDate = LocalDateTime.now().toString();

                    Date dateBefore = myFormat.parse(orderCreateDate);
                    Date dateAfter = myFormat.parse(currentDate);
                    long difference = dateAfter.getTime() - dateBefore.getTime();
                    float daysBetween = (difference / (1000 * 60 * 60 * 24));
                    if(time.getOrderId() == 54){
                        System.out.println("hello" + daysBetween);
                    }
                    if(daysBetween >= 30){
                        time.setOrderId(time.getOrderId());
                        time.setOrderStatus(0);
                        orderRootDao.save(time);
                    }

                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }


    }
}
