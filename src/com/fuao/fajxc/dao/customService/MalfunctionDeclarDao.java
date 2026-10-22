package com.fuao.fajxc.dao.customService;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Sendmessage;
/**
 * 客服中心Dao
 * @author 14012
 * 
 *
 */
public interface MalfunctionDeclarDao extends BaseDao {

	
	public int exehqlupdate(String hql);
	
	/**
	 * 添加故障申报后台返回添加后的对象
	 */
	public ConkOut addconkOut(ConkOut co);
	
	/**
	 * 添加故障申报问答
	 */
	public Conkoutask addCoa(Conkoutask coa);
	
	
	public Object getObj(Class clazz,Integer id);
	public void updObj(Object obj);
	
	public void addObje(Object obj);
	
	public void addBySQL(String sql);
	
	public List queryBySQL(String sql);
	
	public void exeSQL(String sql);
	
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
}
