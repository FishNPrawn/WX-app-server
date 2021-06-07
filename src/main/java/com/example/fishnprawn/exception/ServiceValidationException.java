package com.example.fishnprawn.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.BAD_REQUEST)
public class ServiceValidationException extends RuntimeException{
    public ServiceValidationException(){
        super();
        System.out.println("VehicleServiceValidationException");
    }
    public ServiceValidationException(String message){
        super(message);
        System.out.println("VehicleServiceValidationException: "+message);
    }
}
