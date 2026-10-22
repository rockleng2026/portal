package com.fuao.fajxc.dao.pageFunction;

import java.util.List;

import com.fuao.fajxc.vo.pagefunction;

public interface PageFunctionDAO {

	//添加
	public boolean addPageFunction(pagefunction pagefunction);
	
	//公用的查询
	public List find(String tableName,String andhql);
	
	//删除
	public boolean delPF(Integer id);
	
}
