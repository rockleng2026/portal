package com.fuao.fajxc.vo;



/**
 * VerifyOrderEmployee entity. @author MyEclipse Persistence Tools
 */

public class VerifyOrderEmployee  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Department department;
     private VerifyOrder verifyOrder;
     private String employees;
     private String remark;
     private String orderVerify;
     private String verifyState;


    // Constructors

    public String getOrderVerify() {
		return orderVerify;
	}

	public void setOrderVerify(String orderVerify) {
		this.orderVerify = orderVerify;
	}

	public String getVerifyState() {
		return verifyState;
	}

	public void setVerifyState(String verifyState) {
		this.verifyState = verifyState;
	}

	/** default constructor */
    public VerifyOrderEmployee() {
    }

	/** minimal constructor */
    public VerifyOrderEmployee(Department department, VerifyOrder verifyOrder, String employees) {
        this.department = department;
        this.verifyOrder = verifyOrder;
        this.employees = employees;
    }
    
    /** full constructor */
    public VerifyOrderEmployee(Department department, VerifyOrder verifyOrder, String employees, String remark) {
        this.department = department;
        this.verifyOrder = verifyOrder;
        this.employees = employees;
        this.remark = remark;
    }

   
    // Property accessors

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Department getDepartment() {
        return this.department;
    }
    
    public void setDepartment(Department department) {
        this.department = department;
    }

    public VerifyOrder getVerifyOrder() {
        return this.verifyOrder;
    }
    
    public void setVerifyOrder(VerifyOrder verifyOrder) {
        this.verifyOrder = verifyOrder;
    }

    public String getEmployees() {
        return this.employees;
    }
    
    public void setEmployees(String employees) {
        this.employees = employees;
    }

    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
   








}