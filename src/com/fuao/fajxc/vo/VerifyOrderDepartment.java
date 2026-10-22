package com.fuao.fajxc.vo;



/**
 * VerifyOrderEmployee entity. @author MyEclipse Persistence Tools
 */

public class VerifyOrderDepartment  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Department department;
     private VerifyOrder verifyOrder;
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
    public VerifyOrderDepartment() {
    }

	/** minimal constructor */
    public VerifyOrderDepartment(Department department, VerifyOrder verifyOrder) {
        this.department = department;
        this.verifyOrder = verifyOrder;
    }
    
    /** full constructor */
    public VerifyOrderDepartment(Department department, VerifyOrder verifyOrder, String remark) {
        this.department = department;
        this.verifyOrder = verifyOrder;
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

    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
}