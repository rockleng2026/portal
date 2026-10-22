package com.fuao.fajxc.dao.cms_classesdao;

import java.util.List;

import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_Member;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;

public interface ClassesDao {
	/**
	 * 执行hql语句
	 * 返回list集合
	 * @param hql
	 * @return
	 */
	public List getObjects(String hql);
	/**
	 * 添加栏目
	 * @param part
	 */
	public void addClasses(Fa_Cms_Classes classes);
	/**
	 * 根据传进来的ID查询对象信息
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getPartById(Class clazz,Integer id);
	
	/**
	 * 修改栏目
	 * @param part
	 */
	public void updateClasses(Fa_Cms_Classes classes);
	/**
	 * 删除栏目
	 * @param part
	 */
	public void delClasses(Fa_Cms_Classes classes);
	
	/**
	 * 分页
	 * @param pg
	 * @return
	 */
	public List splitPages(int current,int row);
	
	/**
	 * 根据条件分页 默认条件 showflag =1 delfl = 0
	 * @param current
	 * @param row
	 * @param andsql 带and的Sql条件
	 * @return
	 */
	public List splitPagesByAndsql(int current,int row,String andsql);
	/**
	 * 得到总记录数s
	 * @param andsql 带and的条件 默认条件 showflag = 1 delflag = 0
	 * @return
	 */
	public int countDataByAndsql(String andsql);
	/**
	 * 得到总记录数s
	 * @return
	 */
	public int  countData();
	
	/**
	 * 得到Member信息(添加、修改时用)
	 * @return
	 */
	public List<Fa_Cms_Member> getMembers();
	
	public void hiddenNews(int cid,int flag);
	
	/**
	 * 
	 * @param superid 父类id
	 * @return  栏目id组合的字符串
	 */
	public String getClassesIdStr(String superid);
}
