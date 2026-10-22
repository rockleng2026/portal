package com.fuao.fajxc.bussiness.system.impl;

import java.io.File;
import java.util.List;

import com.fuao.fajxc.bussiness.system.UploadBussiness;
import com.fuao.fajxc.dao.system.UploadDao;
import com.fuao.fajxc.vo.EmployeeFjfb;


/**
 * 表单附件操作实现类
 * @author Administrator
 *
 */
public class UploadBussinessImpl implements UploadBussiness {

	private UploadDao uploaddao;
	public boolean del(String ids,List filepath) {
		
		 boolean b = uploaddao.del(ids);
		if(b){
			for(int i=0;i<filepath.size();i++){
				
		String s =filepath.get(i).toString();//文件的绝对路径
		   File file = new File(s);
		   if(file.exists()){
		    boolean d = file.delete();
		   }
		   }  
		   return true;
		}
		   return false;
	}
	public boolean del(String tableName,String ids,List filepath) {
		
		 boolean b = uploaddao.del(tableName,ids);
		if(b){
			for(int i=0;i<filepath.size();i++){
				
		String s =filepath.get(i).toString();//文件的绝对路径
		   File file = new File(s);
		   if(file.exists()){
		    boolean d = file.delete();
		   }
		   }  
		   return true;
		}
		   return false;
	}
	//查询附件
	public List<EmployeeFjfb> select(String ids) {
		 
		return uploaddao.select(ids);
	}
	
	public List<EmployeeFjfb> selectEmpById(String strEmpId){
		return uploaddao.selectEmpById(strEmpId);
	}
	
	
	//查询附件 带参数表名
	public List<EmployeeFjfb> select(String tableName,String ids) {
		 
		return uploaddao.select(tableName,ids);
	}
	public UploadDao getUploaddao() {
		return uploaddao;
	}
	public void setUploaddao(UploadDao uploaddao) {
		this.uploaddao = uploaddao;
	}
	public static void main(String[] args) {
		 File file = new File("F:/file/swdjgr.jsp.bak");
		   if(file.exists()){
		    boolean d = file.delete();
		    System.out.println(d);
		   }
	}
}
