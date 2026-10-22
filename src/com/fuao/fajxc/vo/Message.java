package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * Message entity. @author MyEclipse Persistence Tools
 */

public class Message  implements java.io.Serializable {


    // Fields    

     private Integer messageid;
     private Messagetype messagetypeByMessagetype;
     private Messagetype messagetypeBySendertype;
     private String sender;
     private String messagecontent;
     private String accessory;
     private String titleweb;
     private String repealfalg;
     private String delfalg;
     private String draftfalg;
     private Timestamp releasetime;
     private Date deltime;
     private Integer priority;
     private String tmp1;
     private String tmp2;
     private String tmp3;
     private Integer superid;
     private Set messagereceivers = new HashSet(0);

     private String helloWorld;


    // Constructors

    public String getHelloWorld() {
		return helloWorld;
	}


	public void setHelloWorld(String helloWorld) {
		this.helloWorld = helloWorld;
	}


	/** default constructor */
    public Message() {
    }

    
    /** full constructor */
    public Message(Messagetype messagetypeByMessagetype, Messagetype messagetypeBySendertype, String sender, String messagecontent, String accessory, String title, String repealfalg, String delfalg, String draftfalg, Timestamp releasetime, Date deltime, Integer priority, String tmp1, String tmp2, String tmp3, Set messagereceivers) {
        this.messagetypeByMessagetype = messagetypeByMessagetype;
        this.messagetypeBySendertype = messagetypeBySendertype;
        this.sender = sender;
        this.messagecontent = messagecontent;
        this.accessory = accessory;
        this.titleweb = title;
        this.repealfalg = repealfalg;
        this.delfalg = delfalg;
        this.draftfalg = draftfalg;
        this.releasetime = releasetime;
        this.deltime = deltime;
        this.priority = priority;
        this.tmp1 = tmp1;
        this.tmp2 = tmp2;
        this.tmp3 = tmp3;
        this.messagereceivers = messagereceivers;
    }

   
    // Property accessors

    public Integer getMessageid() {
        return this.messageid;
    }
    
    public void setMessageid(Integer messageid) {
        this.messageid = messageid;
    }

    public Messagetype getMessagetypeByMessagetype() {
        return this.messagetypeByMessagetype;
    }
    
    public void setMessagetypeByMessagetype(Messagetype messagetypeByMessagetype) {
    	System.out.println("aaaa"+messagetypeByMessagetype);
        this.messagetypeByMessagetype = messagetypeByMessagetype;
    }

    public Messagetype getMessagetypeBySendertype() {
        return this.messagetypeBySendertype;
    }
    
    public void setMessagetypeBySendertype(Messagetype messagetypeBySendertype) {
        this.messagetypeBySendertype = messagetypeBySendertype;
    }

    public String getSender() {
        return this.sender;
    }
    
    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getMessagecontent() {
        return this.messagecontent;
    }
    
    public void setMessagecontent(String messagecontent) {
        this.messagecontent = messagecontent;
    }

    public String getAccessory() {
        return this.accessory;
    }
    
    public void setAccessory(String accessory) {
        this.accessory = accessory;
    }

   

    public String getTitleweb() {
		return titleweb;
	}


	public void setTitleweb(String titleweb) {
		this.titleweb = titleweb;
	}


	public String getRepealfalg() {
        return this.repealfalg;
    }
    
    public void setRepealfalg(String repealfalg) {
        this.repealfalg = repealfalg;
    }

    public String getDelfalg() {
        return this.delfalg;
    }
    
    public void setDelfalg(String delfalg) {
        this.delfalg = delfalg;
    }

    public String getDraftfalg() {
        return this.draftfalg;
    }
    
    public void setDraftfalg(String draftfalg) {
        this.draftfalg = draftfalg;
    }

   

    public Timestamp getReleasetime() {
		return releasetime;
	}


	public void setReleasetime(Timestamp releasetime) {
		this.releasetime = releasetime;
	}


	public Date getDeltime() {
        return this.deltime;
    }
    
    public void setDeltime(Date deltime) {
        this.deltime = deltime;
    }

    public Integer getPriority() {
        return this.priority;
    }
    
    public void setPriority(Integer priority) {
        this.priority = priority;
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


	public Integer getSuperid() {
		return superid;
	}


	public void setSuperid(Integer superid) {
		this.superid = superid;
	}
   








}