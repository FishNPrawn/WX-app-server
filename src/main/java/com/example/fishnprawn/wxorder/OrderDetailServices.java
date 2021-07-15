package com.example.fishnprawn.wxorder;

import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.exception.ServiceValidationException;
import com.example.fishnprawn.services.Services;
import com.example.fishnprawn.validation.GoodArgumentValidation;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
@Transactional
public class OrderDetailServices implements Services<WxOrderDetail> {

    @Autowired
    private GoodArgumentValidation goodArgumentValidation;

    @Autowired
    private OrderDetailDao orderDetailDao;


    @Override
    public WxOrderDetail addOne(WxOrderDetail anObj) {
        return null;
    }

    @Override
    public WxOrderDetail getById(Integer anId) {
        return null;
    }

    @Override
    public List<WxOrderDetail> getAll(Map<String, String> filter) {

        if(!goodArgumentValidation.checkFilter(filter)){
            throw new ServiceValidationException("Illegal field in filter");
        }
        try {
            WxOrderDetail wxOrderDetail = new WxOrderDetail();
            wxOrderDetail.setOrderId(Integer.parseInt(filter.get("filter")));

            ExampleMatcher customExampleMatcher = ExampleMatcher.matchingAny()
                    .withMatcher("order_id", ExampleMatcher.GenericPropertyMatchers.exact());


            Example<WxOrderDetail> orderRootExample = Example.of(wxOrderDetail, customExampleMatcher);
            return orderDetailDao.findAll(orderRootExample);
        }catch (RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public WxOrderDetail updateById(Integer anId, WxOrderDetail anObj) {
        return null;
    }

    @Override
    public WxOrderDetail updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public WxOrderDetail save(WxOrderDetail wxOrderDetail) {
        try{
            orderDetailDao.save(wxOrderDetail);
            return wxOrderDetail;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public WxOrderDetail deleteById(Integer id) {

        if(!orderDetailDao.existsById(id)){
            throw new NotFoundException();
        }

        try{
            WxOrderDetail wxOrderDetail = orderDetailDao.findById(id).orElse(null);
            orderDetailDao.deleteById(id);
            return wxOrderDetail;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }

    }
}
