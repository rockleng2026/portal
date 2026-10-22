package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Depot entity. @author MyEclipse Persistence Tools
 */

public class Depot implements java.io.Serializable {

	// Fields ²Ö¿â

	private Integer id;
	private Employee employee;
	private String name;
	private Integer capacity;
	private String address;
	private String time;
	private String del;
	private Set storages = new HashSet(0);
	private Set products = new HashSet(0);
	private Set outbounds = new HashSet(0);
	private Set stats = new HashSet(0);
	private Set assemblyServers = new HashSet(0);
	private Set tresourceCheck = new HashSet(0);

	// Constructors

	/** default constructor */
	public Depot() {
	}

	/** full constructor */
	public Depot(Employee employee, String name, Integer capacity,
			String address, String time, String del, Set storages,
			Set products, Set outbounds, Set stats, Set assemblyServers) {
		this.employee = employee;
		this.name = name;
		this.capacity = capacity;
		this.address = address;
		this.time = time;
		this.del = del;
		this.storages = storages;
		this.products = products;
		this.outbounds = outbounds;
		this.stats = stats;
		this.assemblyServers = assemblyServers;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getCapacity() {
		return this.capacity;
	}

	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public Set getStorages() {
		return this.storages;
	}

	public void setStorages(Set storages) {
		this.storages = storages;
	}

	public Set getProducts() {
		return this.products;
	}

	public void setProducts(Set products) {
		this.products = products;
	}

	public Set getOutbounds() {
		return this.outbounds;
	}

	public void setOutbounds(Set outbounds) {
		this.outbounds = outbounds;
	}

	public Set getStats() {
		return this.stats;
	}

	public void setStats(Set stats) {
		this.stats = stats;
	}

	public Set getAssemblyServers() {
		return this.assemblyServers;
	}

	public void setAssemblyServers(Set assemblyServers) {
		this.assemblyServers = assemblyServers;
	}

	public Set getTresourceCheck() {
		return tresourceCheck;
	}

	public void setTresourceCheck(Set tresourceCheck) {
		this.tresourceCheck = tresourceCheck;
	}
	
}