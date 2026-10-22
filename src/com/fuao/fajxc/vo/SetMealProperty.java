package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;



/**
 * Setmealproperty entity. @author MyEclipse Persistence Tools
 */

public class SetMealProperty  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String name;
     private String flow;//带宽大小
     private String bandwidth;//单价
     private String hitnum;//原价
     private String flow1;//优惠价
     private String flow2;//线路
     private float flow3;
     private float flow4;
     private float bandwidth1;
     private float bandwidth2;
     private float bandwidth3;
     private float bandwidth4;
     private float hitnum1;
     private float hitnum2;
     private float hitnum3;
     private float hitnum4;
     private Integer delflag;
     private String temp;
     private Set setmealcenters = new HashSet(0);

    // Constructors

    /** default constructor */
    public SetMealProperty() {
    }

    
    /** full constructor */
    public SetMealProperty(String name, String flow,String bandwidth,String hitnum, String flow1, String flow2, float flow3, float flow4, float bandwidth1, float bandwidth2, float bandwidth3, float bandwidth4, float hitnum1, float hitnum2, float hitnum3, float hitnum4, Integer delflag, Set setmealcenters,String temp) {
        this.name = name;
        this.flow=flow;
        this.bandwidth=bandwidth;
        this.hitnum=hitnum;
        this.flow1 = flow1;
        this.flow2 = flow2;
        this.flow3 = flow3;
        this.flow4 = flow4;
        this.bandwidth1 = bandwidth1;
        this.bandwidth2 = bandwidth2;
        this.bandwidth3 = bandwidth3;
        this.bandwidth4 = bandwidth4;
        this.hitnum1 = hitnum1;
        this.hitnum2 = hitnum2;
        this.hitnum3 = hitnum3;
        this.hitnum4 = hitnum4;
        this.delflag = delflag;
        this.temp=temp;
        this.setmealcenters = setmealcenters;
    }

   
    // Property accessors

    public String getTemp() {
		return temp;
	}


	public void setTemp(String temp) {
		this.temp = temp;
	}


	public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

   

    public String getFlow() {
		return flow;
	}


	public void setFlow(String flow) {
		this.flow = flow;
	}


	public String getBandwidth() {
		return bandwidth;
	}


	public void setBandwidth(String bandwidth) {
		this.bandwidth = bandwidth;
	}


	public String getHitnum() {
		return hitnum;
	}


	public void setHitnum(String hitnum) {
		this.hitnum = hitnum;
	}


	public String getFlow1() {
		return flow1;
	}


	public void setFlow1(String flow1) {
		this.flow1 = flow1;
	}


	public String getFlow2() {
        return this.flow2;
    }
    
    public void setFlow2(String flow2) {
        this.flow2 = flow2;
    }

    public float getFlow3() {
        return this.flow3;
    }
    
    public void setFlow3(float flow3) {
        this.flow3 = flow3;
    }

    public float getFlow4() {
        return this.flow4;
    }
    
    public void setFlow4(float flow4) {
        this.flow4 = flow4;
    }

    public float getBandwidth1() {
        return this.bandwidth1;
    }
    
    public void setBandwidth1(float bandwidth1) {
        this.bandwidth1 = bandwidth1;
    }

    public float getBandwidth2() {
        return this.bandwidth2;
    }
    
    public void setBandwidth2(float bandwidth2) {
        this.bandwidth2 = bandwidth2;
    }

    public float getBandwidth3() {
        return this.bandwidth3;
    }
    
    public void setBandwidth3(float bandwidth3) {
        this.bandwidth3 = bandwidth3;
    }

    public float getBandwidth4() {
        return this.bandwidth4;
    }
    
    public void setBandwidth4(float bandwidth4) {
        this.bandwidth4 = bandwidth4;
    }

    public float getHitnum1() {
        return this.hitnum1;
    }
    
    public void setHitnum1(float hitnum1) {
        this.hitnum1 = hitnum1;
    }

    public float getHitnum2() {
        return this.hitnum2;
    }
    
    public void setHitnum2(float hitnum2) {
        this.hitnum2 = hitnum2;
    }

    public float getHitnum3() {
        return this.hitnum3;
    }
    
    public void setHitnum3(float hitnum3) {
        this.hitnum3 = hitnum3;
    }

    public float getHitnum4() {
        return this.hitnum4;
    }
    
    public void setHitnum4(float hitnum4) {
        this.hitnum4 = hitnum4;
    }

    public Integer getDelflag() {
        return this.delflag;
    }
    
    public void setDelflag(Integer delflag) {
        this.delflag = delflag;
    }
    public Set getSetmealcenters() {
		return this.setmealcenters;
	}

	public void setSetmealcenters(Set setmealcenters) {
		this.setmealcenters = setmealcenters;
	}
}