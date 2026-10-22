package com.fuao.fajxc.vo;



/**
 * SetmealProperty entity. @author MyEclipse Persistence Tools
 */

public class SetmealPropertyComm  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private SetmealComm setmealComm;
     private Product product;
     private String uuid;
     private String name;
     private Integer num;
     private String unit;
     private Float price;
     private Integer delflag;
     private String delDescribe;
     private Integer existScfj;
     private String temp;
     private String temp1;
     private String temp2;
     private String temp3;


    // Constructors

    /** default constructor */
    public SetmealPropertyComm() {
    }

    
    /** full constructor */
    public SetmealPropertyComm(SetmealComm setmealComm, Product product, String uuid, String name, Integer num, String unit, Float price, Integer delflag, String delDescribe, Integer existScfj, String temp, String temp1, String temp2, String temp3) {
        this.setmealComm = setmealComm;
        this.product = product;
        this.uuid = uuid;
        this.name = name;
        this.num = num;
        this.unit = unit;
        this.price = price;
        this.delflag = delflag;
        this.delDescribe = delDescribe;
        this.existScfj = existScfj;
        this.temp = temp;
        this.temp1 = temp1;
        this.temp2 = temp2;
        this.temp3 = temp3;
    }

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public SetmealComm getSetmealComm() {
        return this.setmealComm;
    }
    
    public void setSetmealComm(SetmealComm setmealComm) {
        this.setmealComm = setmealComm;
    }

    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }

    public String getUuid() {
        return this.uuid;
    }
    
    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    public Integer getNum() {
        return this.num;
    }
    
    public void setNum(Integer num) {
        this.num = num;
    }

    public String getUnit() {
        return this.unit;
    }
    
    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Float getPrice() {
        return this.price;
    }
    
    public void setPrice(Float price) {
        this.price = price;
    }

    public Integer getDelflag() {
        return this.delflag;
    }
    
    public void setDelflag(Integer delflag) {
        this.delflag = delflag;
    }

    public String getDelDescribe() {
        return this.delDescribe;
    }
    
    public void setDelDescribe(String delDescribe) {
        this.delDescribe = delDescribe;
    }

    public Integer getExistScfj() {
        return this.existScfj;
    }
    
    public void setExistScfj(Integer existScfj) {
        this.existScfj = existScfj;
    }

    public String getTemp() {
        return this.temp;
    }
    
    public void setTemp(String temp) {
        this.temp = temp;
    }

    public String getTemp1() {
        return this.temp1;
    }
    
    public void setTemp1(String temp1) {
        this.temp1 = temp1;
    }

    public String getTemp2() {
        return this.temp2;
    }
    
    public void setTemp2(String temp2) {
        this.temp2 = temp2;
    }

    public String getTemp3() {
        return this.temp3;
    }
    
    public void setTemp3(String temp3) {
        this.temp3 = temp3;
    }
   








}