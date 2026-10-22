package com.fuao.fajxc.dao.cms_website;

import java.util.List;

import com.fuao.fajxc.vo.Fa_Cms_Rec_Info;
import com.fuao.fajxc.vo.Fa_Cms_Rec_Part;

public interface WebSiteDAO {


	/**
	 * @param sitekey 当前站点ID xml配置文件中设置
	 * @param mid 页面类型id 0 首页 1 栏目页 2 内容页 
	 * @return 获得推荐模板的集合 
	 */
	List getRecPartList(int sitekey, int mid);

	/**
	 * 
	 * @param rpid 推荐类目ID 
	 * @param topnum 最新几条
	 * @return 根据获得指定推荐类目的推荐的内容
	 */
	List<Fa_Cms_Rec_Info> getRecInfoList(String andhql,int topnum);
	

}
