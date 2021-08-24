package com.example.fishnprawn.orderRefund;

import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.services.Services;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
@Transactional
public class OrderRefundServices implements Services<OrderRefund> {

    @Autowired
    private OrderRefundDao orderRefundDao;

    @Override
    public OrderRefund addOne(OrderRefund anObj) {
        return null;
    }

    @Override
    public OrderRefund getById(Integer anId) {
        return null;
    }

    @Override
    public List<OrderRefund> getAll(Map<String, String> aFilter) {
        return null;
    }

    @Override
    public OrderRefund updateById(Integer id, OrderRefund orderRefund) {
        if(!orderRefundDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            OrderRefund orderRefundId = orderRefundDao.findById(id).orElse(null);
            orderRefund.setOrder_refund_id(id);

            orderRefund.setOrder_refund_time(LocalDateTime.now());
            save(orderRefund);
            return orderRefund;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public OrderRefund updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public OrderRefund save(OrderRefund orderRefund) {
        try {
            orderRefund.setOrder_refund_time(LocalDateTime.now());
            orderRefundDao.save(orderRefund);
            return orderRefund;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public OrderRefund deleteById(Integer id) {
        /*Validation*/
        if (!orderRefundDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try{
            OrderRefund orderRefund = orderRefundDao.findById(id).orElse(null);
            orderRefundDao.deleteById(id);
            return orderRefund;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }
}
