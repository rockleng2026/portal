package com.fuao.fajxc.vo;

/**
 * CustomerMove entity. @author MyEclipse Persistence Tools
 */

public class CustomerMove implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employeeByOldPrincipal;
	private Employee employeeByNewPrincipal;
	private Customer customer;
	private String moveCause;
	private String movetime;
	private String delflag;

	// Constructors

	/** default constructor */
	public CustomerMove() {
	}

	/** full constructor */
	public CustomerMove(Employee employeeByOldPrincipal,
			Employee employeeByNewPrincipal, Customer customer,
			String moveCause, String movetime, String delflag) {
		this.employeeByOldPrincipal = employeeByOldPrincipal;
		this.employeeByNewPrincipal = employeeByNewPrincipal;
		this.customer = customer;
		this.moveCause = moveCause;
		this.movetime = movetime;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployeeByOldPrincipal() {
		return this.employeeByOldPrincipal;
	}

	public void setEmployeeByOldPrincipal(Employee employeeByOldPrincipal) {
		this.employeeByOldPrincipal = employeeByOldPrincipal;
	}

	public Employee getEmployeeByNewPrincipal() {
		return this.employeeByNewPrincipal;
	}

	public void setEmployeeByNewPrincipal(Employee employeeByNewPrincipal) {
		this.employeeByNewPrincipal = employeeByNewPrincipal;
	}

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getMoveCause() {
		return this.moveCause;
	}

	public void setMoveCause(String moveCause) {
		this.moveCause = moveCause;
	}

	public String getMovetime() {
		return this.movetime;
	}

	public void setMovetime(String movetime) {
		this.movetime = movetime;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

}