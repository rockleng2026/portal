package com.fuao.fajxc.vo;

import java.util.Date;


/**
 * Messagehistory entity. @author MyEclipse Persistence Tools
 */

public class Messagehistory  implements java.io.Serializable {


    // Fields    

     private Integer mhistoryid;
     private Messagereceiver messagereceiver;
     private Integer receivertype;
     private Date contactTime;
     private String tmp1;
     private String tmp2;
     private String tmp3;


    // Constructors

    /** default constructor */
    public Messagehistory() {
    }

    
    /** full constructor */
    public Messagehistory(Messagereceiver messagereceiver, Integer receivertype, Date contactTime, String tmp1, String tmp2, String tmp3) {
        this.messagereceiver = messagereceiver;
        this.receivertype = receivertype;
        this.contactTime = contactTime;
        this.tmp1 = tmp1;
        this.tmp2 = tmp2;
        this.tmp3 = tmp3;
    }

   
    // Property accessors

    public Integer getMhistoryid() {
        return this.mhistoryid;
    }
    
    public void setMhistoryid(Integer mhistoryid) {
        this.mhistoryid = mhistoryid;
    }

    public Messagereceiver getMessagereceiver() {
        return this.messagereceiver;
    }
    
    public void setMessagereceiver(Messagereceiver messagereceiver) {
        this.messagereceiver = messagereceiver;
    }

    public Integer getReceivertype() {
        return this.receivertype;
    }
    
    public void setReceivertype(Integer receivertype) {
        this.receivertype = receivertype;
    }

    public Date getContactTime() {
        return this.contactTime;
    }
    
    public void setContactTime(Date contactTime) {
        this.contactTime = contactTime;
    }

    public String getTmp1() {
        return this.tmp1;
    }
    
    public void setTmp1(String tmp1) {
        this.tmp1 = tmp1;
    }

    public String getTmp2() {
        return this.tmp2;
    }
    
    public void setTmp2(String tmp2) {
        this.tmp2 = tmp2;
    }

    public String getTmp3() {
        return this.tmp3;
    }
    
    public void setTmp3(String tmp3) {
        this.tmp3 = tmp3;
    }
   








}