package com.example.fishnprawn.paySupplier;

import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.orderRefund.OrderRefund;
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
public class PaySupplierServices implements Services<PaySupplier> {

    @Autowired
    private PaySupplierDao paySupplierDao;

    @Override
    public PaySupplier addOne(PaySupplier anObj) {
        return null;
    }

    @Override
    public PaySupplier getById(Integer anId) {
        return null;
    }

    @Override
    public List<PaySupplier> getAll(Map<String, String> aFilter) {
        return null;
    }

    @Override
    public PaySupplier updateById(Integer id, PaySupplier paySupplier) {
        if(!paySupplierDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try {
            paySupplier.setPay_supplier_id(id);
            save(paySupplier);
            return paySupplier;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public PaySupplier updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public PaySupplier save(PaySupplier paySupplier) {
        try {
            paySupplierDao.save(paySupplier);
            return paySupplier;
        }catch (RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public PaySupplier deleteById(Integer id) {
        if(!paySupplierDao.existsById(id)){
            throw new NotFoundException();
        }

        /*Operation*/
        try{
            PaySupplier paySupplier = paySupplierDao.findById(id).orElse(null);
            paySupplierDao.deleteById(id);
            return paySupplier;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }
}
