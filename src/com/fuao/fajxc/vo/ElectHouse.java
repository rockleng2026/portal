package com.fuao.fajxc.vo;



import java.util.HashSet;
import java.util.Set;

import com.sun.org.apache.bcel.internal.generic.NEW;

// default package



/**
 * ElectHouse entity. @author MyEclipse Persistence Tools
 */

public class ElectHouse  implements java.io.Serializable {


    // Fields    

     private Integer electId;
     private Integer superid; //父类ID
     private String electName;
     private String electPosition;
     private String electTel;
     private String electAdmPhone;
     private String electAdmin;
     private String showcode;
     private String electCode;
     //机房对城市  多对一 
     private City city;
     Set cabit ;
     private Set tresourceCheck = new HashSet(0);

    // Constructors
    
    public Set getCabit() {
		return cabit;
	}


	public String getElectCode() {
		return electCode;
	}


	public void setElectCode(String electCode) {
		this.electCode = electCode;
	}


	public void setCabit(Set cabit) {
		this.cabit = cabit;
	}


	/** default constructor */
    public ElectHouse() {
    }

    
    /** full constructor */
    public ElectHouse(String electName, String electPosition, String electTel, String electAdmPhone, String electAdmin, String showcode,City city) {
        this.electName = electName;
        this.electPosition = electPosition;
        this.electTel = electTel;
        this.electAdmPhone = electAdmPhone;
        this.electAdmin = electAdmin;
        this.showcode = showcode;
        this.city=city;
    }

   
    // Property accessors

    public Integer getElectId() {
        return this.electId;
    }
    
    public void setElectId(Integer electId) {
        this.electId = electId;
    }

    public String getElectName() {
        return this.electName;
    }
    
    public void setElectName(String electName) {
        this.electName = electName;
    }

    public String getElectPosition() {
        return this.electPosition;
    }
    
    public void setElectPosition(String electPosition) {
        this.electPosition = electPosition;
    }

    public String getElectTel() {
        return this.electTel;
    }
    
    public void setElectTel(String electTel) {
        this.electTel = electTel;
    }

    public String getElectAdmPhone() {
        return this.electAdmPhone;
    }
    
    public void setElectAdmPhone(String electAdmPhone) {
        this.electAdmPhone = electAdmPhone;
    }

    public String getElectAdmin() {
        return this.electAdmin;
    }
    
    public void setElectAdmin(String electAdmin) {
        this.electAdmin = electAdmin;
    }

    public String getShowcode() {
        return this.showcode;
    }
    
    public void setShowcode(String showcode) {
        this.showcode = showcode;
    }


	public Integer getSuperid() {
		return superid;
	}


	public void setSuperid(Integer superid) {
		this.superid = superid;
	}
	public City getCity() {
		return city;
	}
	public void setCity(City city) {
		this.city = city;
	}


	public Set getTresourceCheck() {
		return tresourceCheck;
	}


	public void setTresourceCheck(Set tresourceCheck) {
		this.tresourceCheck = tresourceCheck;
	}

}