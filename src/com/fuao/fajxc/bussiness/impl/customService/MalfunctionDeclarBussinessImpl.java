package com.fuao.fajxc.bussiness.impl.customService;

import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.customService.MalfunctionDeclarBussiness;
import com.fuao.fajxc.bussiness.customService.SendRefurbishBussiness;
import com.fuao.fajxc.bussiness.impl.commodity.CommodityBusssinessImpl;
import com.fuao.fajxc.dao.customService.MalfunctionDeclarDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Sendmessage;
/**
 * 故障申报业务层
 * @author 14012
 *
 */
public class MalfunctionDeclarBussinessImpl implements	MalfunctionDeclarBussiness {

	private static Logger logger = Logger.getLogger(MalfunctionDeclarBussinessImpl.class);
	//注入DAO
	MalfunctionDeclarDao mddao;
	
	SendRefurbishBussiness srbiz;
	
	public MalfunctionDeclarDao getMddao() {
		return mddao;
	}

	public void setMddao(MalfunctionDeclarDao mddao) {
		this.mddao = mddao;
	}

	
	public SendRefurbishBussiness getSrbiz() {
		return srbiz;
	}

	public void setSrbiz(SendRefurbishBussiness srbiz) {
		this.srbiz = srbiz;
	}

	/**
	 * 添加故障信息
	 */
	public boolean addorupdate(ConkOut co,Conkoutask coa) {
		try {
			ConkOut cout = mddao.addconkOut(co);
			
			coa.setConkout(cout);
			
			mddao.addCoa(coa);
			
			return true;
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			logger.error("添加或者修改故障信息错误："+e);
		}
		return false;
	}

	/**
	 * 查询故障信息
	 */
	public Pages get(String hql, int pageNo, int pageSize, Object... values) {
		
		return mddao.paginationQuery(hql, pageNo, pageSize, values);
	}
	/**
	 * 查询单个故障信息
	 */
	public ConkOut getco ( Class cls,String id)
	{
		try {
			return (ConkOut)mddao.select(cls, Integer.parseInt(id));
		} catch (Exception e) {
			
			e.printStackTrace();
		}return null;
	}

	public boolean addResult(ConkOut co) {
		String sql = "update conkOut set EndTim = "+"'"+co.getEndTim()+"'"+", solveDepict = "+"'"+co.getSolveDepict()+"'"+", State = "+co.getState()+" where id ="+co.getId();

		try{
		mddao.execSQLUpdate(sql);
		return true;
		}
		catch (Exception e) {
			return false;
		}
	}

	public Employee getEmp(String loginName) {
		
		return (Employee)mddao.getObj(loginName);
	}
	
	public List somelist(String hql){
		return mddao.execHQL(hql);
	}
	
	public int updateConkout(String hql)
	{
		int i=0;
		i=mddao.exehqlupdate(hql);
		return i;
	}

	public boolean addorupdate(ConkOut co) {
		try {
			mddao.update(co);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("添加或者修改故障信息错误："+e);
		}
		return false;
	}

	public ConkOut getConkOut(String id){
		
		try {
			return (ConkOut)mddao.select(ConkOut.class, Integer.parseInt(id));
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return null;
		}
	}

	public boolean addorupdate(Conkoutask coa) {
		try{
			
		mddao.addCoa(coa);
		
		return true;
		
		}catch (Exception e) {
			
			e.printStackTrace();
			
			return false;			
		}

	}
	
	public Object getObj(Class clazz,Integer id){
		return mddao.getObj(clazz, id);
	}
	
	public void updObj(Object obj){
		mddao.updObj(obj);
	}
	
	public void addObje(Object obj){
		mddao.addObje(obj);
	}
	
	public void addBySQL(String sql){
		mddao.addBySQL(sql);
	}
	
	public List queryBySQL(String sql){
		return mddao.queryBySQL(sql);
	}
	
	public void exeSQL(String sql){
		mddao.exeSQL(sql);
	}
	
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values){
		Pages pages=null;
		try {
			pages=mddao.exHqlPages(hql, pageNo, pageSize, values);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pages;
	}
	
}
