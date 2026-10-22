package com.fuao.fajxc.vo;
// default package

import java.util.Date;


/**
 * LogTab entity. @author MyEclipse Persistence Tools
 */

public class LogTab  implements java.io.Serializable {


    // Fields    

     private Integer loid;
     private String looper;
     private String loadmin;
     private Date loTime;
     private UpServer Tupve;


    // Constructors
     
    /** default constructor */
    public LogTab() {
    }

    
    public UpServer getTupve() {
		return Tupve;
	}


	public void setTupve(UpServer tupve) {
		Tupve = tupve;
	}


	/** full constructor */
    public LogTab(String looper, String loadmin, Date loTime) {
        this.looper = looper;
        this.loadmin = loadmin;
        this.loTime = loTime;
    }

   
    // Property accessors

    public Integer getLoid() {
        return this.loid;
    }
    
    public void setLoid(Integer loid) {
        this.loid = loid;
    }

    public String getLooper() {
        return this.looper;
    }
    
    public void setLooper(String looper) {
        this.looper = looper;
    }

    public String getLoadmin() {
        return this.loadmin;
    }
    
    public void setLoadmin(String loadmin) {
        this.loadmin = loadmin;
    }

    public Date getLoTime() {
        return this.loTime;
    }
    
    public void setLoTime(Date loTime) {
        this.loTime = loTime;
    }
   








}