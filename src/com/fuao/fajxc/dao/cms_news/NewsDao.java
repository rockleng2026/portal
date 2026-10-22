package com.fuao.fajxc.dao.cms_news;

import java.util.List;

import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_News;

public interface NewsDao {
	
	public List getList(String hql);
	
	public List getObjects(String hql);
	/**
	 * 点击隐藏,改变字段
	 * @param flag
	 */
	public void hiddenNews(int cid,int flag);
	/**
	 * 根据主键加载数据
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getNewsById(Class clazz,Integer id);
	
	/**
	 * 修改文章
	 */
	public void updNews(Fa_Cms_News news);
	
	/**
	 * 新增文章
	 * @param obj
	 */
	/**
	 * 删除
	 */
	public void delNews(Fa_Cms_News news);
	
	public void addNews(Fa_Cms_News news);
	public List selectNews(Fa_Cms_News news);
	/**
	 * 分页
	 * @param pg
	 * @return
	 */
	public List splitPages(int current,int row,String sql);
	
	public List splitPagesRecInfo(int current,int row,String andhql);
	
	
	public List splitPagesNews(int current,int row);
	/**
	 * 得到总记录数s
	 * @return
	 */
	public int  countData(String sql);
	/**
	 * 得到类型
	 */
	public List<Fa_Cms_Classes> getClasses();
	public List<Fa_Cms_Member> getMember();

	public void excuteHql(String hql);
}
