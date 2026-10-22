package com.fuao.fajxc.dao.cms_template;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.vo.Fa_Cms_Classes;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Fa_Cms_Template;

public class TemplateDaoImpl extends BaseDao  implements TemplateDao {

	// 返回所有数据
	public List<Fa_Cms_Template> getAllTemplate() {
		return this.getHibernateTemplate().find("from Fa_Cms_Template where delflag=0");
	}

	/**
	 * 点击修改,页面传id过来,根据传过来的id从数据库取到当前
	 */
	public Object getTempById(Class clazz, Integer id) {
		return super.getHibernateTemplate().get(Fa_Cms_Template.class, id);
	}
	
	/**
	 * 得到类型
	 */
	public List<Fa_Cms_Classes> getClasses(){
		String sql="from Fa_Cms_Classes where delflag=0";
		return this.getHibernateTemplate().find(sql);
	}
	
	/**
	 * 修改
	 */
	public void updateTemp(Fa_Cms_Template template){
        // HTML单引号转义 &acute;
		template.setContents(template.getContents().replaceAll("'", "&acute"));
		// 设置读取到的页面编码格式
		template.setContents(template.getContents().replaceAll("utf-8", "GBK"));
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = dateFormat2.format(template.getEditdate());
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		String sql="update Fa_Cms_Template set name='"+template.getName()+"',classid="+template.getClasses().getClassid()+",editdate='"+now+"',temp='"+template.getTemp()+"',contents='"+template.getContents()+"',fdir='"+template.getFdir()+"',fname='"+template.getFname()+"',do_action='"+template.getDo_action()+"',mid="+template.getMid()+" where id="+template.getId();
		 Query query = session.createQuery(sql);
		 query.executeUpdate();
	}
	
	/**
	 * 删除
	 */
	public void delTemp(int tempid){
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		String sql="update Fa_Cms_Template set delflag=1 where id="+tempid;
		System.out.println(sql);
		 Query query = session.createQuery(sql);
		 query.executeUpdate();
	}
	
	/***
	 * 添加模板 
	 */
	public void addTemp(Fa_Cms_Template template){
		this.getHibernateTemplate().save(template);
	}
}
