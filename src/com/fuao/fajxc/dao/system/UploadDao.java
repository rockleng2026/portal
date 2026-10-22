package com.fuao.fajxc.dao.system;

import java.util.List;

public interface UploadDao {
	//删除上传附件
	public boolean del(String ids);
	//删除上传附件  带参数表名
	public boolean del(String tableName,String ids);
	
	//查询上传附件
	public List select(String ids);
	/**
	 * 根据Employee表ID 查询所有
	 * @param strEmpId
	 * @return
	 */
	public List selectEmpById(String strEmpId);
	//查询上传附件 带参数表名
	public List select(String tableName,String ids);

}
