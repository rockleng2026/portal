package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * Messagereceiver entity. @author MyEclipse Persistence Tools
 */

public class Messagereceiver  implements java.io.Serializable {


    // Fields    

     private Integer receiverid;
     private Message message;
     private Messagetype messagetype;
     private String receiverer;
     private Date receivetime;
     private String readfalg;
     private String delfalg;
     private Date requestTime;
     private String tmp1;
     private String tmp2;
     private String tmp3;
     private Integer planid;

     private Set messagehistories = new HashSet(0);
     //信息所属项目
     private NewProject project;
    // Constructors

    /** default constructor */
    public Messagereceiver() {
    }

    
    /** full constructor */
    public Messagereceiver(Message message, Messagetype messagetype, String receiverer, Date receivetime, String readfalg, String delfalg, Date requestTime, String tmp1, String tmp2, String tmp3, Set messagehistories) {
        this.message = message;
        this.messagetype = messagetype;
        this.receiverer = receiverer;
        this.receivetime = receivetime;
        this.readfalg = readfalg;
        this.delfalg = delfalg;
        this.requestTime = requestTime;
        this.tmp1 = tmp1;
        this.tmp2 = tmp2;
        this.tmp3 = tmp3;
        
        this.messagehistories = messagehistories;
    }

   
    // Property accessors

    public Integer getReceiverid() {
        return this.receiverid;
    }
    
    public void setReceiverid(Integer receiverid) {
        this.receiverid = receiverid;
    }

    public Message getMessage() {
        return this.message;
    }
    
    public void setMessage(Message message) {
        this.message = message;
    }

    public Messagetype getMessagetype() {
        return this.messagetype;
    }
    
    public void setMessagetype(Messagetype messagetype) {
        this.messagetype = messagetype;
    }

    public String getReceiverer() {
        return this.receiverer;
    }
    
    public void setReceiverer(String receiverer) {
        this.receiverer = receiverer;
    }

    public Date getReceivetime() {
        return this.receivetime;
    }
    
    public void setReceivetime(Date receivetime) {
        this.receivetime = receivetime;
    }

    public String getReadfalg() {
        return this.readfalg;
    }
    
    public void setReadfalg(String readfalg) {
        this.readfalg = readfalg;
    }

    public String getDelfalg() {
        return this.delfalg;
    }
    
    public void setDelfalg(String delfalg) {
        this.delfalg = delfalg;
    }

    public Date getRequestTime() {
        return this.requestTime;
    }
    
    public void setRequestTime(Date requestTime) {
        this.requestTime = requestTime;
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

    public Set getMessagehistories() {
        return this.messagehistories;
    }
    
    public void setMessagehistories(Set messagehistories) {
        this.messagehistories = messagehistories;
    }


	public NewProject getProject() {
		return project;
	}


	public void setProject(NewProject project) {
		this.project = project;
	}


	public Integer getPlanid() {
		return planid;
	}


	public void setPlanid(Integer planid) {
		this.planid = planid;
	}
   



}