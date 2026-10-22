package com.fuao.fajxc.dao.form;


import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.FormTemp;

/**
 * 单据模板表
 */
public interface FormTempDao extends BaseDao{

	
	/*
	 * 查询一个单据模板
	 * */
	public FormTemp selectFormTemp(Integer id);
	

}
