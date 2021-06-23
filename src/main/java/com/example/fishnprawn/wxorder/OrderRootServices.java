package com.example.fishnprawn.wxorder;

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
public class OrderRootServices implements Services<WxOrderRoot> {

    @Autowired
    private GoodArgumentValidation goodArgumentValidation;

    @Autowired
    private OrderRootDao orderRootDao;

    @Override
    public WxOrderRoot addOne(WxOrderRoot anObj) {
        return null;
    }

    @Override
    public WxOrderRoot getById(Integer anId) {
        return null;
    }

    @Override
    public List<WxOrderRoot> getAll(Map<String, String> filter) {

        if(!goodArgumentValidation.checkFilter(filter)){
            throw new ServiceValidationException("Illegal field in filter");
        }
        try {
            WxOrderRoot wxOrderRoot = new WxOrderRoot();
            wxOrderRoot.setOpen_id(filter.get("filter"));

            ExampleMatcher customExampleMatcher = ExampleMatcher.matchingAny()
                    .withMatcher("open_id", ExampleMatcher.GenericPropertyMatchers.exact());


            Example<WxOrderRoot> orderRootExample = Example.of(wxOrderRoot, customExampleMatcher);
            return orderRootDao.findAll(orderRootExample);
        }catch (RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public WxOrderRoot updateById(Integer anId, WxOrderRoot anObj) {
        return null;
    }

    @Override
    public WxOrderRoot updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public WxOrderRoot save(WxOrderRoot anObj) {
        return null;
    }

    @Override
    public WxOrderRoot deleteById(Integer anId) {
        return null;
    }
}
