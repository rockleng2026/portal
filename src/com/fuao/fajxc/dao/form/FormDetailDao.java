package com.fuao.fajxc.dao.form;


import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.FormDetail;

/*
 * 具体单据
 * */
public interface FormDetailDao extends BaseDao{
	
	/*
	 * 查询一个具体单据
	 * */
	public FormDetail selectFormDetail(Integer id);


}
