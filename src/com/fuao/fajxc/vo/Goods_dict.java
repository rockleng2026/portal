package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


/**
 * Goods_dict entity. @author MyEclipse Persistence Tools
 */

public class Goods_dict  implements java.io.Serializable {


    // Fields    

     private Integer gdId;
     private Integer gdSuperId;
     private String gdnames;
     private String gdcodes;
     private Integer gdSchilds;
     private String gdWritename;//ÊÇ·ñÓÐÌí¼Ó×Ö¶Î
     private Date gdWriteTime;
     private Set sale_goodses = new HashSet(0);
     private Set goodsClass_expands = new HashSet(0);
	  private String fatherName;
	
	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

    // Constructors

    /** default constructor */
    public Goods_dict() {
    }

    
    /** full constructor */
    public Goods_dict(Integer gdSuperId, String gdnames, String gdcodes, Integer gdSchilds, String gdWritename, Date gdWriteTime, Set sale_goodses, Set goodsClass_expands) {
        this.gdSuperId = gdSuperId;
        this.gdnames = gdnames;
        this.gdcodes = gdcodes;
        this.gdSchilds = gdSchilds;
        this.gdWritename = gdWritename;
        this.gdWriteTime = gdWriteTime;
        this.sale_goodses = sale_goodses;
        this.goodsClass_expands = goodsClass_expands;
    }

   
    // Property accessors

    public Integer getGdId() {
        return this.gdId;
    }
    
    public void setGdId(Integer gdId) {
        this.gdId = gdId;
    }

    public Integer getGdSuperId() {
        return this.gdSuperId;
    }
    
    public void setGdSuperId(Integer gdSuperId) {
        this.gdSuperId = gdSuperId;
    }

    public String getGdnames() {
        return this.gdnames;
    }
    
    public void setGdnames(String gdnames) {
        this.gdnames = gdnames;
    }

    public String getGdcodes() {
        return this.gdcodes;
    }
    
    public void setGdcodes(String gdcodes) {
        this.gdcodes = gdcodes;
    }

    public Integer getGdSchilds() {
        return this.gdSchilds;
    }
    
    public void setGdSchilds(Integer gdSchilds) {
        this.gdSchilds = gdSchilds;
    }

    public String getGdWritename() {
        return this.gdWritename;
    }
    
    public void setGdWritename(String gdWritename) {
        this.gdWritename = gdWritename;
    }

    public Date getGdWriteTime() {
        return this.gdWriteTime;
    }
    
    public void setGdWriteTime(Date gdWriteTime) {
        this.gdWriteTime = gdWriteTime;
    }

    public Set getSale_goodses() {
        return this.sale_goodses;
    }
    
    public void setSale_goodses(Set sale_goodses) {
        this.sale_goodses = sale_goodses;
    }

    public Set getGoodsClass_expands() {
        return this.goodsClass_expands;
    }
    
    public void setGoodsClass_expands(Set goodsClass_expands) {
        this.goodsClass_expands = goodsClass_expands;
    }
   








}