package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

import org.jboss.cache.util.setCache;
// default package

import com.sun.org.apache.bcel.internal.generic.NEW;



/**
 * Cabinet entity. @author MyEclipse Persistence Tools
 */

public class Cabinet  implements java.io.Serializable {


    // Fields    

     private Integer caid;
	 private String caname;
     private Integer casz;
     private Integer pmax;
     private Integer bwmax;
     private Integer maches;
     private Integer useSize;
     private String description;
     private ElectHouse Telecthouse;
     //private Integer elehouse;

	public ElectHouse getTelecthouse() {
		return Telecthouse;
	}

	public void setTelecthouse(ElectHouse telecthouse) {
		Telecthouse = telecthouse;
	}


	/** default constructor */
    public Cabinet() {
    }
    
    /** full constructor */
    public Cabinet(String caname, Integer casz, Integer pmax, Integer bwmax, Integer maches, Integer useSize, String description) {
        this.caname = caname;
        this.casz = casz;
        this.pmax = pmax;
        this.bwmax = bwmax;
        this.maches = maches;
        this.useSize = useSize;
        this.description = description;
    }

   
    // Property accessors

    public Integer getCaid() {
        return this.caid;
    }
    
    public void setCaid(Integer caid) {
        this.caid = caid;
    }

    public String getCaname() {
        return this.caname;
    }
    
    public void setCaname(String caname) {
        this.caname = caname;
    }

    public Integer getCasz() {
        return this.casz;
    }
    
    public void setCasz(Integer casz) {
        this.casz = casz;
    }

    public Integer getPmax() {
        return this.pmax;
    }
    
    public void setPmax(Integer pmax) {
        this.pmax = pmax;
    }

    public Integer getBwmax() {
        return this.bwmax;
    }
    
    public void setBwmax(Integer bwmax) {
        this.bwmax = bwmax;
    }

    public Integer getMaches() {
        return this.maches;
    }
    
    public void setMaches(Integer maches) {
        this.maches = maches;
    }

    public Integer getUseSize() {
        return this.useSize;
    }
    
    public void setUseSize(Integer useSize) {
        this.useSize = useSize;
    }

    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
   








}