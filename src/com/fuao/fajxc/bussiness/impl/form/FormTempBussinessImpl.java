package com.fuao.fajxc.bussiness.impl.form;

import java.util.Date;
import java.util.List;

import com.fuao.fajxc.bussiness.form.FormTempBussiness;
import com.fuao.fajxc.dao.form.FormTempDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.FormTemp;


/**
 * 单据模板表
 */
public class FormTempBussinessImpl implements FormTempBussiness {
	
	private FormTempDao formtempdao;
	

	public FormTempDao getFormtempdao() {
		return formtempdao;
	}

	public void setFormtempdao(FormTempDao formtempdao) {
		this.formtempdao = formtempdao;
	}

	
	
	/**
	 * 增加单据模板
	 **/
	public boolean addFormTemp(FormTemp formtemp) {
		boolean flag=false;
		try {
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			formtemp.setTime(formatter.format(new Date()));
			formtemp.setDelflag(new Integer(0));
			formtempdao.add(formtemp);
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * 增加单据模板
	 **/
	public FormTemp addReturnFormTemp(FormTemp formtemp) {
		FormTemp ft=null;
		try {
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			formtemp.setTime(formatter.format(new Date()));
			formtemp.setDelflag(new Integer(0));
			ft=(FormTemp)formtempdao.addReturnObject(formtemp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ft;
	}
	/**
	 *软删除单据模板   删除单个
	 */
	public boolean delruanFormTemp(FormTemp formtemp) {
		boolean flag=false;
		try {
			formtemp.setDelflag(1);
			formtempdao.update(formtemp);
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 *硬删除单据模板   删除彻底
	 */
	public boolean delyingFormTemp(FormTemp formtemp) {
		boolean flag=false;
		try {
			formtempdao.delete(formtemp);
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * 修改单据模板
	 **/
	public boolean editFormTemp(FormTemp formtemp) {
		boolean flag=false;
		try {
			formtempdao.update(formtemp);
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;	
	}

	/**
	 * 修改单据模板
	 **/
	public FormTemp editReturnFormTemp(FormTemp formtemp) {
		FormTemp ft=null;
		try {
			ft=(FormTemp)formtempdao.addReturnObject(formtemp);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ft;	
	}
	/**
	 * 分页单据模板表
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages page=null;
		try {
			 page=formtempdao.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	/**
	 * 查找单据模板列表
	 * **/
	public List<FormTemp> selectFormTemp(String hql) {
		List<FormTemp> datas=null;
		try {
		datas=formtempdao.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

	/**
	 * 查找单个单据模板   根据id
	 * **/
	public FormTemp selectFormTemp(Integer id) {
		FormTemp formtemp=null;
		try {
			formtemp=formtempdao.selectFormTemp(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return formtemp;
	}

}
