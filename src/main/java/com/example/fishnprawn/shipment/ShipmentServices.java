package com.example.fishnprawn.shipment;

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
public class ShipmentServices implements Services<Shipment> {

    @Autowired
    private ShipmentDao shipmentDao;

    @Override
    public Shipment addOne(Shipment anObj) {
        return null;
    }

    @Override
    public Shipment getById(Integer anId) {
        return null;
    }

    @Override
    public List<Shipment> getAll(Map<String, String> aFilter) {
        return null;
    }

    @Override
    public Shipment updateById(Integer anId, Shipment anObj) {
        return null;
    }

    @Override
    public Shipment updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public Shipment save(Shipment shipment) {
        try {
            shipmentDao.save(shipment);
            return shipment;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public Shipment deleteById(Integer anId) {
        return null;
    }
}
