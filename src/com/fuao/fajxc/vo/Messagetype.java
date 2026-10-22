package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;


/**
 * Messagetype entity. @author MyEclipse Persistence Tools
 */

public class Messagetype  implements java.io.Serializable {


    // Fields    

     private Integer messagetypeid;
     private Integer superid;
     private String type;
     private String describetype;
     private String voname;
     private String tablename;
     private String delflag;
     private String tmp1;
     private String tmp2;
     private String tmp3;
     private Set messagereceivers = new HashSet(0);
     private Set messagesForMessagetype = new HashSet(0);
     private Set messagesForSendertype = new HashSet(0);
  

    // Constructors

    /** default constructor */
    public Messagetype() {
    }

    
    /** full constructor */
    public Messagetype(Integer superid, String type, String describetype, String tmp1, String tmp2, String tmp3, Set messagereceivers, Set messagesForMessagetype, Set messagesForSendertype) {
        this.superid = superid;
        this.type = type;
        this.describetype = describetype;
        this.tmp1 = tmp1;
        this.tmp2 = tmp2;
        this.tmp3 = tmp3;
        this.messagereceivers = messagereceivers;
        this.messagesForMessagetype = messagesForMessagetype;
        this.messagesForSendertype = messagesForSendertype;
        
    }

   
    // Property accessors

    public Integer getMessagetypeid() {
        return this.messagetypeid;
    }
    
    public void setMessagetypeid(Integer messagetypeid) {
        this.messagetypeid = messagetypeid;
    }

    public Integer getSuperid() {
        return this.superid;
    }
    
    public void setSuperid(Integer superid) {
        this.superid = superid;
    }

    public String getType() {
        return this.type;
    }
    
    public void setType(String type) {
        this.type = type;
    }

    public String getDescribetype() {
        return this.describetype;
    }
    
    public void setDescribetype(String describetype) {
        this.describetype = describetype;
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

    public Set getMessagereceivers() {
        return this.messagereceivers;
    }
    
    public void setMessagereceivers(Set messagereceivers) {
        this.messagereceivers = messagereceivers;
    }

    public Set getMessagesForMessagetype() {
        return this.messagesForMessagetype;
    }
    
    public void setMessagesForMessagetype(Set messagesForMessagetype) {
        this.messagesForMessagetype = messagesForMessagetype;
    }

    public Set getMessagesForSendertype() {
        return this.messagesForSendertype;
    }
    
    public void setMessagesForSendertype(Set messagesForSendertype) {
        this.messagesForSendertype = messagesForSendertype;
    }


	public String getVoname() {
		return voname;
	}


	public void setVoname(String voname) {
		this.voname = voname;
	}


	public String getTablename() {
		return tablename;
	}


	public void setTablename(String tablename) {
		this.tablename = tablename;
	}


	public String getDelflag() {
		return delflag;
	}


	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}
   


 





}