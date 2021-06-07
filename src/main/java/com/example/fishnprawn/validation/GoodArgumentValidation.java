package com.example.fishnprawn.validation;
import org.springframework.stereotype.Component;
import java.util.Map;

@Component
public class GoodArgumentValidation extends ArgumentValidation{
    @Override
    public Boolean checkFilter(Map<String, String> filter) {
        if(filter == null || filter.size()==0 ) return true;
        if(filter.size() > 1 || !filter.containsKey("filter"))
        {
            return false;
        }
        return true;
    }
}