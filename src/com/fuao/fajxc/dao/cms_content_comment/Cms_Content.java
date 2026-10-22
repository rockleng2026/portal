package com.fuao.fajxc.dao.cms_content_comment;

import java.util.List;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Content_Comments;
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_News;

public interface Cms_Content{
	
	public int  countData(String sql);
	public List splitPages(int current,int row,String sql);
	/**
	 * ÐÞ¸Ä
	 */
	public void updDate(Fa_Cms_Content_Comments news);
	
	/**
	 * ÐÂÔö
	 * @param obj
	 */
	/**
	 * É¾³ý
	 */
	public void delDate(Fa_Cms_Content_Comments news);
	public void addDate(Fa_Cms_Content_Comments news);
    public List getid(int id);
    public Fa_Cms_Content_Comments getById(int id);
}
