package com.example.fishnprawn.utils;

import com.example.fishnprawn.admin.Admin;
import lombok.NoArgsConstructor;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class FieldMethods<T> {
    final Class<T> TClass; //for type safe, here should be Class<T>

    public FieldMethods(Class<T> TClass) {
        this.TClass = TClass;
    }

    /*
      @Desc   : get a field by its name
      @Author : Mark Lin
      @Time   : 2021/4/5 1:52 AM
      @Param  :
        fieldName :
        searchSuperclass : true, if want to search super classes
      @Return :
        java.lang.reflect.Field
    */
    public Field getFieldByName(String fieldName, Boolean searchSuperclass) throws NoSuchFieldException{
        Field targetField = null;
        for (Field field : Collections.unmodifiableList(getAllFields(TClass, searchSuperclass))) {
            if (field.getName().equals(fieldName))
                targetField = field;
        }

        if (targetField == null)
            throw new NoSuchFieldException();
        return targetField;
    }
    /*
      @Desc   : default getAllField method
      @Author : Mark Lin
      @Time   : 2021/4/6 10:27 PM
      @Param  :
        searchSuperclass :
      @Return :
        java.util.List<java.lang.reflect.Field>
    */
    public List<Field> getAllFields(Boolean searchSuperclass) {
        return getAllFields(TClass, searchSuperclass);
    }

    /*
      @Desc   : get all fields(private fields included) of given class type
      @Author : Mark Lin
      @Time   : 2021/4/5 1:54 AM
      @Param  :
        type :
        searchSuperclass : true, if want to search super classes
      @Return :
        java.util.List<java.lang.reflect.Field>
    */
    public List<Field> getAllFields(Class<?> type, Boolean searchSuperclass) {
        List<Field> fields = new ArrayList<>(Arrays.asList(type.getDeclaredFields()));

        if (type.getSuperclass() != null && searchSuperclass) {
            fields.addAll(getAllFields(type.getSuperclass(), true));
        }

        return fields;
    }

    /*
      @Desc   : set a field(private fields included) of the given object through its name
      @Author : Mark Lin
      @Time   : 2021/4/5 1:56 AM
      @Param  :
        fieldName : the name of the field to be modified
        object : the object which field is going to be modified
        value : the value to set(the function will convert the string value to its corresponding field type)
                field type: String, Integer, Float, Double are supported!
      @Return :
        void
    */
    public void setField(String fieldName, T object, String value) throws IllegalAccessException, NoSuchFieldException {
        Field fieldToUpdate = getFieldByName(fieldName, true);
        setField(fieldToUpdate, object, value);
    }

    /*
      @Desc   : set the given field(private fields included) of the given object.
      @Author : Mark Lin
      @Time   : 2021/4/5 2:00 AM
      @Param  :
        field : the field to be modified
        object : the object which field is going to be modified
        value : the value to set
      @Return :
        void
    */
    private void setField(Field field, T object, String value) throws IllegalAccessException {
        if(field == null)
            throw new IllegalStateException("Field is null");
        field.setAccessible(true);

        if (Integer.TYPE.equals(field.getType()) || Integer.class.equals(field.getType())) {
            field.set(object, Integer.parseInt(value));
        } else if (String.class.equals(field.getType())) {
            field.set(object, value);
        } else if (Double.TYPE.equals(field.getType()) || Double.class.equals(field.getType())) {
            field.set(object, Double.parseDouble(value));
        } else if (Float.TYPE.equals(field.getType()) || Float.class.equals(field.getType())) {
            field.set(object, Float.parseFloat(value));
        }else {
            throw new IllegalStateException("Unexpected value type: " + field.getType());
        }
        field.setAccessible(false);
    }
}
