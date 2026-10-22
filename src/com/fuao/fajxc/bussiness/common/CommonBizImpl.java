package com.fuao.fajxc.bussiness.common;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.fuao.fajxc.dao.cms_news.NewsDaoImpl;
import com.fuao.fajxc.dao.common.CommonDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.CommonScfjb;
import com.fuao.fajxc.vo.Fa_Cms_News;


public class CommonBizImpl implements CommonBiz{
	//日志记录
	private static Logger logger = Logger.getLogger(CommonBizImpl.class);
	private List list=new ArrayList();
	//注入表单操作DAO
	private CommonDao commondao;
	
	public CommonDao getCommondao() {
		return commondao;
	}
	public void setCommondao(CommonDao commondao) {
		this.commondao = commondao;
	}
	
	/**
	 * 添加表单saveOrUpdate方法
	 * @param entity 要添加或者更新表单实体
	 * @return Object 添加成功后的表单对象
	 */
	public Object addForm(Object obj, List fb,HttpServletRequest request) {
		
		//定义要返回的对象并初始化
		Object returnobj = null;
		try{
			
		    //添加对象后并返回该对象
			returnobj = commondao.addForm(obj);
	
		}catch (Exception e) {
			
			//有异常便记录日志返回NULL
			logger.debug(e);
			return null;
		}
		return returnobj;
	}
	/**
	 * @param hql 根据hql语句修改相应的对象
	 * @return rowcount 返回执行成功的条数
	 */
	public int updateBills(String hql)
	{
		return commondao.updateBills(hql);
	}
	/**
	 * 根据表名和条件查询相应列表集合
	 * @param tableName  表名
	 * @param andhql     条件
	 * @return
	 */
	public List getForm(String tableName,String andhql)
	{
		List list = new ArrayList();
		try
		{
			list = commondao.getForm(tableName, andhql);
		}
		catch(Exception e)
		{
			logger.debug(e);
		}
		return list;
	}
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,Object... values) 
	{
		return commondao.exHqlPages(hql, pageNo, pageSize, values);
	}
	/**
	 * 添加附件
	 * @param fbsbh
	 * @param beanName
	 * @param request
	 * @return
	 */
	public boolean addFJ(String fbsbh, String beanName, HttpServletRequest request) {
		Map<String,String> map=new HashMap<String,String>();      
        map = (Map)request.getSession().getAttribute("sczj");
        if(map != null){
        	for(Map.Entry<String, String> entry: map.entrySet()) {  
 			CommonScfjb scfjb = new CommonScfjb();
 			scfjb.setFjmc(entry.getKey());
 			scfjb.setFjlj(entry.getValue());
 			String fjhz = StringUtil.getExtension(entry.getValue());
 			System.out.println("附件后缀:"+fjhz);
 			scfjb.setFjhz(fjhz);
 			scfjb.setSbh(UUID.randomUUID().toString());
 			scfjb.setFbsbh(fbsbh);
 			scfjb.setTmp(beanName);
 			scfjb.setBuildTime(new Date());
 			try {
 				commondao.addObject(scfjb);
			} catch (Exception e) {
				logger.error(e);
				return false;
			}finally{
				logger.info("我最后都要执行");
				request.getSession().removeAttribute("sczj");
			}
 			} 
        }
        return true;
	}
	
	/**
	 * 添加附件2--
	 * @param fbsbh
	 * @param beanName
	 * @param request
	 * @return
	 */
	public void addFJ2(String fjlj,String beanName,String fjmc,String fjhz, String functionid,HttpServletRequest request) {
		
        	 
 			CommonScfjb scfjb = new CommonScfjb();
 			scfjb.setFjmc(fjmc);
 			scfjb.setFjlj(fjlj);
 			scfjb.setFjhz(fjhz);
 			scfjb.setSbh(UUID.randomUUID().toString());
 			scfjb.setTmp(beanName);
 			scfjb.setTmp1(functionid);
 			scfjb.setBuildTime(new Date());
 			try {
 				commondao.addObject(scfjb);
			} catch (Exception e) {
				logger.error(e);
			}finally{
				logger.info("我最后都要执行");
				request.getSession().removeAttribute("sczj");
			
			}
 	
     
	}
	public Object getForm(Class cls, Serializable primaryKey) {
		return commondao.getForm(cls, primaryKey);
	}
	//统计总数
	public int countData() {
		return commondao.countData();
	}
	//组装数据
	@SuppressWarnings("unchecked")
	public List printList(List liss){
		System.out.println(""+liss.size());
		
		Fa_Cms_News fcn = new Fa_Cms_News();		
		for(int i=0;i<liss.size();i++){
			    fcn=(Fa_Cms_News)liss.get(i);			 
				Map m=new HashMap();
				m.put("cid",fcn.getCid());
				m.put("classid",fcn.getClasses().getClassid());
				m.put("readnum",fcn.getReadnum());
				m.put("keyboard",fcn.getKeyboard());
				m.put("userid",fcn.getUserid());
				m.put("username",fcn.getUsername());
				m.put("status",fcn.getStatus());
				m.put("author",fcn.getAuthor());
				m.put("istop",fcn.getIstop());
				m.put("ismember",fcn.getIsmember());
				m.put("ftitle",fcn.getFtitle());
				m.put("smalltext",fcn.getSmalltext());
				m.put("contents",fcn.getContents());
				m.put("source",fcn.getSource());
				m.put("contents",fcn.getContents());
				m.put("senddate",fcn.getSenddate());
				m.put("newsdate",fcn.getNewsdate());
				m.put("editdate",fcn.getEditdate());
				m.put("hasFile",fcn.getHasFile());
				list.add(m);
		}
			    return list;
	}
	//分页
	public List splitPages(int current,int row) {
		return this.printList(commondao.splitPages(current,row));
	}
	public String executeSql(String sql) {
		return commondao.executeSql(sql);
	}
	public List executeHql(String hql) {
		
		return commondao.executeHql(hql);
	}
	
	// 文章列表方法
//	public List getList(){
//		return newsdao.getObjects("from Fa_Cms_News n and Fa_Cms_Classes c where n.classid=c.classid");
//	}
}
