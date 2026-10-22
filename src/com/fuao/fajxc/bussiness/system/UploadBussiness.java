package com.fuao.fajxc.bussiness.system;

import java.util.List;

import com.fuao.fajxc.vo.EmployeeFjfb;
import com.fuao.fajxc.vo.NewTask;

/**
 * 表单附件操作
 * @author Administrator
 *
 */
public interface UploadBussiness {
	
	/**
	 * 删除附件
	 */
	public boolean del(String ids,List filepath);
	/**
	 * 删除附件
	 */
	public boolean del(String tableName,String ids,List filepath);
	/**
	 * 查询上传附件
	 * @param ids
	 * @return
	 */
	public List select(String ids);

	public List<EmployeeFjfb> selectEmpById(String strEmpId);
	
}
