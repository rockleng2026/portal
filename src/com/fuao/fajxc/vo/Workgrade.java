package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Workgrade entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Workgrade implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String shortname;
	private Integer grade;
	private String description;
	private String edittime;
	private Set workpositions = new HashSet(0);

	// Constructors

	/** default constructor */
	public Workgrade() {
	}

	/** full constructor */
	public Workgrade(String name, String shortname, Integer grade,
			String description, String edittime, Set workpositions) {
		this.name = name;
		this.shortname = shortname;
		this.grade = grade;
		this.description = description;
		this.edittime = edittime;
		this.workpositions = workpositions;
	}

	// Property accessors

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

	public String getShortname() {
		return this.shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}

	public Integer getGrade() {
		return this.grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}


	public String getEdittime() {
		return this.edittime;
	}

	public void setEdittime(String edittime) {
		this.edittime = edittime;
	}

	public Set getWorkpositions() {
		return this.workpositions;
	}

	public void setWorkpositions(Set workpositions) {
		this.workpositions = workpositions;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}


}