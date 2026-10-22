package com.fuao.fajxc.vo;

public class NewDocument implements java.io.Serializable{
	/**
	 * 项目文档
	 */
	private Integer id;
	private String filepath; // 文件路径
	private String filename;//文件原名
	private Integer pid; //文档所属项目
	private NewProject newProject;//文档对项目
	
	public NewProject getNewProject() {
		return newProject;
	}
	public void setNewProject(NewProject newProject) {
		this.newProject = newProject;
	}
	public NewDocument(){}
	public NewDocument(Integer id, String filepath, String filename,Integer pid) {
		this.id = id;
		this.filepath = filepath;
		this.filename=filename;
		this.pid = pid;
	}
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
}
