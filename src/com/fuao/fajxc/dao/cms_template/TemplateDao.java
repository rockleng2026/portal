package com.fuao.fajxc.dao.cms_template;

import java.util.List;

import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Template;

public interface TemplateDao {
	
	// 查询所有模板列表
	public List<Fa_Cms_Template> getAllTemplate();
	public Object getTempById(Class clazz, Integer id);
	/**
	 * 得到类型
	 */
	public List<Fa_Cms_Classes> getClasses();
	/***
	 * 修改模板 
	 * @param template
	 */
	public void updateTemp(Fa_Cms_Template template);
	public void delTemp(int tempid);
	public void addTemp(Fa_Cms_Template template);

}
