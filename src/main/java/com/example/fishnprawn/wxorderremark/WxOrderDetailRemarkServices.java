package com.example.fishnprawn.wxorderremark;

import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.services.Services;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
@Transactional
public class WxOrderDetailRemarkServices implements Services<WxOrderDetailRemark> {

    @Autowired
    private WxOrderDetailRemarkDao wxOrderDetailRemarkDao;

    @Override
    public WxOrderDetailRemark addOne(WxOrderDetailRemark anObj) {
        return null;
    }

    @Override
    public WxOrderDetailRemark getById(Integer anId) {
        return null;
    }

    @Override
    public List<WxOrderDetailRemark> getAll(Map<String, String> aFilter) {
        return null;
    }

    @Override
    public WxOrderDetailRemark updateById(Integer id, WxOrderDetailRemark wxOrderDetailRemark) {
        if(!wxOrderDetailRemarkDao.existsById(id)){
            throw new NotFoundException();
        }
        try {
            WxOrderDetailRemark wxOrderDetailRemarkID = wxOrderDetailRemarkDao.findById(id).orElse(null);
            wxOrderDetailRemark.setWx_order_detail_remark_id(id);
            save(wxOrderDetailRemark);
            return wxOrderDetailRemark;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public WxOrderDetailRemark updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public WxOrderDetailRemark save(WxOrderDetailRemark wxOrderDetailRemark) {
        try {
            wxOrderDetailRemarkDao.save(wxOrderDetailRemark);
            return wxOrderDetailRemark;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public WxOrderDetailRemark deleteById(Integer anId) {
        return null;
    }
}
