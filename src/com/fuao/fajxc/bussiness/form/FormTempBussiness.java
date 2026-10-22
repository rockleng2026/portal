package com.fuao.fajxc.bussiness.form;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.FormTemp;

/**
 * 单据模板表
 */
public interface FormTempBussiness {
	/**
	 * 分页单据模板表
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 增加单据模板
	 **/
	public boolean addFormTemp(FormTemp formtemp);
	public FormTemp addReturnFormTemp(FormTemp formtemp);
	
	/**
	 *软删除单据模板   删除单个
	 */
	public boolean delruanFormTemp(FormTemp formtemp);
	
	/**
	 *硬删除单据模板   删除彻底
	 */
	public boolean delyingFormTemp(FormTemp formtemp);
	
	/**
	 * 修改单据模板
	 **/
	public boolean editFormTemp(FormTemp formtemp);
	public FormTemp editReturnFormTemp(FormTemp formtemp);
	
	/**
	 * 查找单据模板列表
	 * **/
	public List<FormTemp> selectFormTemp(String hql);
	
	/**
	 * 查找单个单据模板   根据id
	 * **/
	public FormTemp selectFormTemp(Integer id);

}
