package com.fuao.fajxc.dao.impl.form;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.fuao.fajxc.dao.form.FormTempDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.FormDetail;
import com.fuao.fajxc.vo.FormTemp;

public class FormTempDaoImpl extends BaseDaoImpl implements FormTempDao {
	/*
	 * 查询一个单据模板
	 * */
	public FormTemp selectFormTemp(Integer id) {
		// TODO Auto-generated method stub
		try {
			return (FormTemp) super.select(FormTemp.class,id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


}
