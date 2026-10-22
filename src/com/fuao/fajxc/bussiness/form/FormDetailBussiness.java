package com.fuao.fajxc.bussiness.form;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.FormDetail;

/**
 * 具体单据
 * */
public interface FormDetailBussiness {
	/**
	 * 分页具体单据
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 增加具体单据
	 **/
	public boolean addFormDetail(FormDetail formdetail);
	
	/**
	 * 增加具体单据
	 * @return 对象
	 */
	public FormDetail addReturn(FormDetail formDetail);
	
	/**
	 *软删除具体单据  删除单个
	 */
	public boolean delruanFormDetail(FormDetail formdetail);
	
	/**
	 *硬删除具体单据   删除彻底
	 */
	public boolean delyingFormDetail(FormDetail formdetail);
	
	/**
	 * 修改具体单据
	 **/
	public boolean editFormDetail(FormDetail formdetail);
	
	/**
	 * 查找具体单据列表
	 * **/
	public List<FormDetail> selectFormDetail(String hql);
	
	/**
	 * 查找单个具体单据   根据id
	 * **/
	public FormDetail selectFormDetail(Integer id);

}
