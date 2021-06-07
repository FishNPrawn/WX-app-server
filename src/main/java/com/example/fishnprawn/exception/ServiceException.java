package com.example.fishnprawn.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
public class ServiceException extends RuntimeException{
    //Including the error caused by our in-mem DB(i.e. VehicleRepository)//
    public ServiceException(){
        super("Meet unexpected exception");
        System.out.println("ServiceException: " + "Meet unexpected exception");
    }
    public ServiceException(String message){
        super(message);
        System.out.println("ServiceException: "+message);
    }
}
