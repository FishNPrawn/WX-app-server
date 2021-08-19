package com.example.fishnprawn.promocode;

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
public class PromoCodeServices implements Services<PromoCode> {


    @Autowired
    private PromoCodeDao promocodeDao;

    @Override
    public PromoCode addOne(PromoCode promoCode) {
        return null;
    }

    @Override
    public PromoCode getById(Integer anId) {
        return null;
    }

    @Override
    public List<PromoCode> getAll(Map<String, String> aFilter) {
        List all = promocodeDao.findAll();
        return all;
    }

    @Override
    public PromoCode updateById(Integer id, PromoCode promoCode) {
        /*Validation*/
        if(!promocodeDao.existsById(id)){
            throw new NotFoundException();
        }
        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            PromoCode promoCodeId = promocodeDao.findById(id).orElse(null);
            promoCode.setPromoCodeHeaderId(id);
            save(promoCode);
            return promoCode;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public PromoCode updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public PromoCode save(PromoCode promoCode) {
        try {

            promoCode.setCommission_rate(0.02);
            promoCode.setDiscount_rate(0.98);
            String city = promoCode.getCity();
            System.out.println("city" + city);
            String phoneNumber = promoCode.getPhone();
            String promo_code = "abc";
            if(city.equals("广州")){
                promo_code = "01" + phoneNumber.substring(phoneNumber.length() - 3);
            }else if(city.equals("深圳")){
                promo_code = "02" + phoneNumber.substring(phoneNumber.length() - 3);
            } else if(city.equals("佛山")){
                promo_code = "03" + phoneNumber.substring(phoneNumber.length() - 3);
            }else if(city.equals("潮汕")){
                promo_code = "04" + phoneNumber.substring(phoneNumber.length() - 3);
            }else if(city.equals("其他")){
                promo_code = "20" + phoneNumber.substring(phoneNumber.length() - 3);
            }
            promoCode.setPromoCode(promo_code);

            promocodeDao.save(promoCode);
            return promoCode;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public PromoCode deleteById(Integer id) {

        if(!promocodeDao.existsById(id)){
            throw new NotFoundException();
        }

        try {
            PromoCode promoCode = promocodeDao.findById(id).orElse(null);
            promocodeDao.deleteById(id);
            return promoCode;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }
}
