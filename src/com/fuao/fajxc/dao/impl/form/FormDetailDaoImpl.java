package com.fuao.fajxc.dao.impl.form;

import java.util.List;

import com.fuao.fajxc.dao.form.FormDetailDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.FormDetail;

/**
 * 具体单据
 * */
public class FormDetailDaoImpl extends BaseDaoImpl implements FormDetailDao {

	/*
	 * 查询一个具体单据
	 * */
	public FormDetail selectFormDetail(Integer id) {
		// TODO Auto-generated method stub
		try {
			return (FormDetail) super.select(FormDetail.class,id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
