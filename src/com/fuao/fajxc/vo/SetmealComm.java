package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;


/**
 * SetmealComm entity. @author MyEclipse Persistence Tools
 */

public class SetmealComm  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Ordertype ordertype;
     private String uuid;
     private String name;
     private String startTime;
     private String endTime;
     private String describe;
     private Integer chargeMode;
     private Float totalPrice;
     private Float payPrice;
     private Integer delflag;
     private String delDescribe;
     private Integer auditState;
     private String auditEmp;
     private String buildTime;
     private Integer exitScfj;
     private String temp;
     private String temp1;
     private String temp2;
     private String temp3;
     private Set setmealProperties = new HashSet(0);
     private Set saleorderComms = new HashSet(0);


    // Constructors

    /** default constructor */
    public SetmealComm() {
    }

    
    /** full constructor */
    public SetmealComm(Ordertype ordertype, String uuid, String name, String startTime, String endTime, String describe, Integer chargeMode, Float totalPrice, Float payPrice, Integer delflag, String delDescribe, Integer auditState, String auditEmp, String buildTime, Integer exitScfj, String temp, String temp1, String temp2, String temp3, Set setmealProperties, Set saleorderComms) {
        this.ordertype = ordertype;
        this.uuid = uuid;
        this.name = name;
        this.startTime = startTime;
        this.endTime = endTime;
        this.describe = describe;
        this.chargeMode = chargeMode;
        this.totalPrice = totalPrice;
        this.payPrice = payPrice;
        this.delflag = delflag;
        this.delDescribe = delDescribe;
        this.auditState = auditState;
        this.auditEmp = auditEmp;
        this.buildTime = buildTime;
        this.exitScfj = exitScfj;
        this.temp = temp;
        this.temp1 = temp1;
        this.temp2 = temp2;
        this.temp3 = temp3;
        this.setmealProperties = setmealProperties;
        this.saleorderComms = saleorderComms;
    }

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Ordertype getOrdertype() {
        return this.ordertype;
    }
    
    public void setOrdertype(Ordertype ordertype) {
        this.ordertype = ordertype;
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

    public String getStartTime() {
        return this.startTime;
    }
    
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return this.endTime;
    }
    
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getDescribe() {
        return this.describe;
    }
    
    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public Integer getChargeMode() {
        return this.chargeMode;
    }
    
    public void setChargeMode(Integer chargeMode) {
        this.chargeMode = chargeMode;
    }

    public Float getTotalPrice() {
        return this.totalPrice;
    }
    
    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Float getPayPrice() {
        return this.payPrice;
    }
    
    public void setPayPrice(Float payPrice) {
        this.payPrice = payPrice;
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

    public Integer getAuditState() {
        return this.auditState;
    }
    
    public void setAuditState(Integer auditState) {
        this.auditState = auditState;
    }

    public String getAuditEmp() {
        return this.auditEmp;
    }
    
    public void setAuditEmp(String auditEmp) {
        this.auditEmp = auditEmp;
    }

    public String getBuildTime() {
        return this.buildTime;
    }
    
    public void setBuildTime(String buildTime) {
        this.buildTime = buildTime;
    }

    public Integer getExitScfj() {
        return this.exitScfj;
    }
    
    public void setExitScfj(Integer exitScfj) {
        this.exitScfj = exitScfj;
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

    public Set getSetmealProperties() {
        return this.setmealProperties;
    }
    
    public void setSetmealProperties(Set setmealProperties) {
        this.setmealProperties = setmealProperties;
    }

    public Set getSaleorderComms() {
        return this.saleorderComms;
    }
    
    public void setSaleorderComms(Set saleorderComms) {
        this.saleorderComms = saleorderComms;
    }
   








}