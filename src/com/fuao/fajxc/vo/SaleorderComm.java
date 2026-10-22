package com.fuao.fajxc.vo;



/**
 * SaleorderComm entity. @author MyEclipse Persistence Tools
 */

public class SaleorderComm  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private SetmealComm setmealComm;
     private String uuid;
     private Integer employeeId;
     private Integer customerId;
     private String orderNo;
     private Integer payStyle;
     private Float price;
     private Integer isDiscount;
     private String discountDescribe;
     private Integer payStatus;
     private Integer auditState;
     private String auditEmp;
     private String payNexttime;
     private String startTime;
     private String describtion;
     private Integer delflag;
     private String delDescribe;
     private String inputAdmin;
     private String buildTime;
     private Integer existScfj;
     private String temp;
     private String temp1;
     private String temp2;
     private String temp3;


    // Constructors

    /** default constructor */
    public SaleorderComm() {
    }

	/** minimal constructor */
    public SaleorderComm(String uuid) {
        this.uuid = uuid;
    }
    
    /** full constructor */
    public SaleorderComm(SetmealComm setmealComm, String uuid, Integer employeeId, Integer customerId, String orderNo, Integer payStyle, Float price, Integer isDiscount, String discountDescribe, Integer payStatus, Integer auditState, String auditEmp, String payNexttime, String startTime, String describtion, Integer delflag, String delDescribe, String inputAdmin, String buildTime, Integer existScfj, String temp, String temp1, String temp2, String temp3) {
        this.setmealComm = setmealComm;
        this.uuid = uuid;
        this.employeeId = employeeId;
        this.customerId = customerId;
        this.orderNo = orderNo;
        this.payStyle = payStyle;
        this.price = price;
        this.isDiscount = isDiscount;
        this.discountDescribe = discountDescribe;
        this.payStatus = payStatus;
        this.auditState = auditState;
        this.auditEmp = auditEmp;
        this.payNexttime = payNexttime;
        this.startTime = startTime;
        this.describtion = describtion;
        this.delflag = delflag;
        this.delDescribe = delDescribe;
        this.inputAdmin = inputAdmin;
        this.buildTime = buildTime;
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

    public String getUuid() {
        return this.uuid;
    }
    
    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public Integer getEmployeeId() {
        return this.employeeId;
    }
    
    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

    public Integer getCustomerId() {
        return this.customerId;
    }
    
    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getOrderNo() {
        return this.orderNo;
    }
    
    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public Integer getPayStyle() {
        return this.payStyle;
    }
    
    public void setPayStyle(Integer payStyle) {
        this.payStyle = payStyle;
    }

    public Float getPrice() {
        return this.price;
    }
    
    public void setPrice(Float price) {
        this.price = price;
    }

    public Integer getIsDiscount() {
        return this.isDiscount;
    }
    
    public void setIsDiscount(Integer isDiscount) {
        this.isDiscount = isDiscount;
    }

    public String getDiscountDescribe() {
        return this.discountDescribe;
    }
    
    public void setDiscountDescribe(String discountDescribe) {
        this.discountDescribe = discountDescribe;
    }

    public Integer getPayStatus() {
        return this.payStatus;
    }
    
    public void setPayStatus(Integer payStatus) {
        this.payStatus = payStatus;
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

    public String getPayNexttime() {
        return this.payNexttime;
    }
    
    public void setPayNexttime(String payNexttime) {
        this.payNexttime = payNexttime;
    }

    public String getStartTime() {
        return this.startTime;
    }
    
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getDescribtion() {
        return this.describtion;
    }
    
    public void setDescribtion(String describtion) {
        this.describtion = describtion;
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

    public String getInputAdmin() {
        return this.inputAdmin;
    }
    
    public void setInputAdmin(String inputAdmin) {
        this.inputAdmin = inputAdmin;
    }

    public String getBuildTime() {
        return this.buildTime;
    }
    
    public void setBuildTime(String buildTime) {
        this.buildTime = buildTime;
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