package com.fuao.fajxc.bussiness.impl.form;

import java.util.Date;
import java.util.List;

import com.fuao.fajxc.bussiness.form.FormDetailBussiness;
import com.fuao.fajxc.dao.form.FormDetailDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.FormDetail;

public class FormDetailBussinessImpl implements FormDetailBussiness {
	
	private FormDetailDao  formdetaildao;
	
	

	public FormDetailDao getFormdetaildao() {
		return formdetaildao;
	}

	public void setFormdetaildao(FormDetailDao formdetaildao) {
		this.formdetaildao = formdetaildao;
	}

	
	
	
	/**
	 * 增加具体单据
	 **/
	public boolean addFormDetail(FormDetail formdetail) {
		boolean flag=false;
		try {
			formdetail.setDelflag(0);
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			formdetail.setTime(formatter.format(new Date()));
			formdetaildao.add(formdetail);
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 增加具体单据
	 * @return 对象
	 */
	public FormDetail addReturn(FormDetail formDetail){
		formDetail.setDelflag(0);
		formDetail.setTime(TimePattern.doTimeDf3(new Date()));
		FormDetail fDetail = null;
		try {
			fDetail = (FormDetail) formdetaildao.addReturnObject(formDetail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fDetail;
	}
	
	/**
	 *软删除具体单据  删除单个
	 */
	public boolean delruanFormDetail(FormDetail formdetail) {
		boolean flag=false;
		try {
			formdetail.setDelflag(1);
			formdetaildao.update(formdetail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 *硬删除具体单据   删除彻底
	 */
	public boolean delyingFormDetail(FormDetail formdetail) {
		boolean flag=false;
		try {
			formdetaildao.delete(formdetail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	/**
	 * 修改具体单据
	 **/
	public boolean editFormDetail(FormDetail formdetail) {
		boolean flag=false;
		try {
			formdetaildao.update(formdetail);
			flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages page=null;
		try {
			 page=formdetaildao.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	/**
	 * 查找具体单据列表
	 * **/
	public List<FormDetail> selectFormDetail(String hql) {
		List<FormDetail> datas=null;
		try {
		datas=formdetaildao.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

	/**
	 * 查找单个具体单据   根据id
	 * **/
	public FormDetail selectFormDetail(Integer id) {
		FormDetail formdetail=null;
		try {
			formdetail=formdetaildao.selectFormDetail(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return formdetail;
	}

}
