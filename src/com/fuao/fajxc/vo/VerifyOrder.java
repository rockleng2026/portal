package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;


/**
 * VerifyOrder entity. @author MyEclipse Persistence Tools
 */

public class VerifyOrder  implements java.io.Serializable {


    // Fields    
     private Integer id;
     private Docmark ordertype;
     private String departments;
     private String empOrdept;
    
     public Docmark getOrdertype() {
		return ordertype;
	}

	public void setOrdertype(Docmark ordertype) {
		this.ordertype = ordertype;
	}

	private Set verifyOrderEmployees = new HashSet(0);


    // Constructors

    /** default constructor */
    public VerifyOrder() {
    }

	/** minimal constructor */
    public VerifyOrder(Docmark ordertype, String departments) {
        this.ordertype = ordertype;
        this.departments = departments;
    }
    
    /** full constructor */
    public VerifyOrder(Docmark ordertype, String departments, Set verifyOrderEmployees) {
        this.ordertype = ordertype;
        this.departments = departments;
        this.verifyOrderEmployees = verifyOrderEmployees;
    }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public String getDepartments() {
		return departments;
	}

	public void setDepartments(String departments) {
		this.departments = departments;
	}

	public Set getVerifyOrderEmployees() {
		return verifyOrderEmployees;
	}

	public void setVerifyOrderEmployees(Set verifyOrderEmployees) {
		this.verifyOrderEmployees = verifyOrderEmployees;
	}

	public String getEmpOrdept() {
		return empOrdept;
	}

	public void setEmpOrdept(String empOrdept) {
		this.empOrdept = empOrdept;
	}


}