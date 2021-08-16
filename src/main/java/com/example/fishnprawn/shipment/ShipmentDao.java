package com.example.fishnprawn.shipment;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ShipmentDao extends JpaRepository<Shipment, Integer> {
    Shipment findByOrderNumber(String oder_number);
}
