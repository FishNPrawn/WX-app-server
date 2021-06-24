package com.example.fishnprawn.swiper;

import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.services.Services;
import com.example.fishnprawn.validation.CategoryArgumentValidation;
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
public class SwiperImgServices implements Services<SwiperImg> {

    @Autowired
    private SwiperImgDao swiperImgDao;

    @Autowired
    CategoryArgumentValidation categoryArgumentValidation;

    @Override
    public SwiperImg addOne(SwiperImg anObj) {
        return null;
    }

    @Override
    public SwiperImg getById(Integer anId) {
        return null;
    }

    @Override
    public List<SwiperImg> getAll(Map<String, String> aFilter) {
        List<SwiperImg> list = swiperImgDao.findAll();
        return list;
    }

    @Override
    public SwiperImg updateById(Integer id, SwiperImg swiperImg) {
        /*Validation*/
        if(!swiperImgDao.existsById(id)){
            throw new NotFoundException();
        }
        /*Operation*/
        try {
            //must use findById, or we cannot update field by reflection
            SwiperImg swiperImgId = swiperImgDao.findById(id).orElse(null);
            swiperImg.setSwiper_img_id(id);
            save(swiperImg);
            return swiperImg;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage()); //Exception from repository
        }
    }

    @Override
    public SwiperImg updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public SwiperImg save(SwiperImg swiperImg) {
        try {
            swiperImgDao.save(swiperImg);
            return swiperImg;
        }catch (RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public SwiperImg deleteById(Integer id) {

        /*Validation*/
        if (!swiperImgDao.existsById(id))
            throw new NotFoundException();

        /*Operation*/
        try{
            SwiperImg swiperImg = swiperImgDao.findById(id).orElse(null);
            swiperImgDao.deleteById(id);
            return swiperImg;
        }catch(RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }
}
