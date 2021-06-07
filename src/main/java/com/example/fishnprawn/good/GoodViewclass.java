package com.example.fishnprawn.good;

public class GoodViewclass {
    private int good_id;
    private String good_name;
    private String cat_name;
    public GoodViewclass(){}
    public void setAttributes(Good good)
    {
        this.setGood_id(good.getGood_id());
        this.setGood_name(good.getGood_name());
        this.setCat_name(good.getCat_name());
    }
    public int getGood_id() {
        return good_id;
    }

    public void setGood_id(int good_id) {
        this.good_id = good_id;
    }

    public String getGood_name() {
        return good_name;
    }

    public void setGood_name(String good_name) {
        this.good_name = good_name;
    }

    public String getCat_name() {
        return cat_name;
    }

    public void setCat_name(String cat_name) {
        this.cat_name = cat_name;
    }
}
