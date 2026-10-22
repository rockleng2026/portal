package com.fuao.fajxc.dao.cms_rec_part;

import java.util.List;

import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;

public interface Rec_PartDao {
	/**
	 * 执行hql语句
	 * 返回list集合
	 * @param hql
	 * @return
	 */
	public List getObjects(String hql);
	/**
	 * 分页
	 * @param pg
	 * @return
	 */
	public List splitPages(int current,int row);
	/**
	 * 分页带参数
	 * @param current
	 * @param row
	 * @param andhql
	 * @return
	 */
	public List splitPages(int current,int row,String andhql);
	/**
	 * 得到总记录数s
	 * @return
	 */
	public int  countData(String sql);
	
	/**
	 * 得到所有的推荐位置(part_desc)
	 * @return
	 */

	public List getAllPart(String hql);

	public void updPart(Fa_Cms_Rec_Part part);
	/**
	 * 删除栏目
	 * @param part
	 */
	public void delPart(Fa_Cms_Rec_Part part) throws Exception;
	
	/**
	 * 新增
	 * @param part
	 */
	public void addPart(Fa_Cms_Rec_Part part);
	
	/**
	 * 根据主键加载
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getPartById(Class clazz,Integer id);
	
	/**
	 * 根据主键查询文章的标题
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Fa_Cms_News getNewsById(Class clazz,Integer id);
	
	/**
	 * 提交推荐时,要向info表写入数据(文章id,推荐id,是否为图片0是,1不是,图片路径,日期,temp)
	 * @param info
	 */
	public void addRec_info(Fa_Cms_Rec_Info info);
 }
