package com.example.fishnprawn.studylist;

import java.util.ArrayList;
import java.util.List;

public class ListStudy {
    public static void main(String[] args) {

//        ArrayList<Integer> list = new ArrayList<>();
//        list.add(1);
//        list.add(2);
//        list.add(3);
//        list.add(4);
//        list.add(5);
//        list.add(6);
//        list.add(7);
//
//        for(int i = 0; i<list.size();i++){
//            System.out.println(list.get(i));
//        }
        List<Car> carList = new ArrayList<>();
        carList.add(new Car("Tesla", 5000));
        carList.add(new Car("Benz", 10000));
        carList.add(new Car("Honda", 10000));

        for(int i = 0; i<carList.size();i++){
            System.out.println(carList.get(i).getPinpai() + "," + carList.get(i).getJiage());
        }

    }
}
