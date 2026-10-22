package com.fuao.fajxc.dao.servers;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.BaseDao;

import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.ElectHouse;

import com.fuao.fajxc.vo.City;
import com.fuao.fajxc.vo.ElectHouse;


public class ServerDaoImpl extends BaseDaoImpl implements ServerDao{
	
	//根据机房名查询
	public List getProvinceAndCity(String name,int start,int pasize) {
	    String hql="from ElectHouse where electName like '%"+name+"%'  and superid=0";
	    Query query=this.getSession().createQuery(hql);
	    query.setFirstResult(start);
	    query.setMaxResults(pasize);
	    List list= query.list();
	    System.out.println(list.size());
	    return list;
	}
	//根据机房名查询2
	@SuppressWarnings("unchecked")
	public List getHousefromnames(String name){
		String hql="from ElectHouse where electName like '%"+name+"%'  and superid=0";
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	// 根据客户名称查
	public List customer(String name){
		String hql="from Customer where realName='"+name+"'";
	    List list = this.getHibernateTemplate().find(hql);
	    System.out.println(list.size());
	    return list;
	}
	// 根据前台管理员
	public List cityByname(String name,int start,int pasize){
		String hql="from ElectHouse where electAdmin like '%"+name+"%'";
		Query query=this.getSession().createQuery(hql);
	    query.setFirstResult(start);
	    query.setMaxResults(pasize);
	    List list= query.list();
		return list;
	}
	// 根据前台管理员
	public List getCityByNames(String name){ 
		String hql="from ElectHouse where electAdmin like '%"+name+"%'";
		Query query=this.getSession().createQuery(hql);
		return query.list();
		
	}
	// 根据城市编号得到机房
	public List houseByCityid(int cityid){
		String hql="from ElectHouse where city.id="+cityid;
		List list=this.getHibernateTemplate().find(hql);
		return list;
	}
	// 根据IP得到upserver
	public List ipByupserver(String ip,int start,int pasize){
		String hql="from UpServer where serverIp like '"+ip+"%'";
		Query query=this.getSession().createQuery(hql);
	    query.setFirstResult(start);
	    query.setMaxResults(pasize);
	    List list= query.list();
		return list;
	}
	//IP得到upserver2
	public List getIpByupservers(String ip){
		String hql="from UpServer where serverIp like '"+ip+"%'";
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	// 根据机房得到机柜ID
	public List cardByHouse(int houseid){
		String hql="from Cabinet where Telecthouse.electId="+houseid;
		List list=this.getHibernateTemplate().find(hql);
		return list;
	}
	// 根据机柜ID 得到机柜
	public Object getObj(Class cla,int id){
		return this.getHibernateTemplate().get(cla, id);
	}
	// 根据客户得到上架单
	public List customerByKh(int customerid,int start,int pasize){
		String hql="from UpServer where customer.customerId="+customerid;
		Query query=this.getSession().createQuery(hql);
		query.setFirstResult(start);
		query.setMaxResults(pasize);
		List list= query.list();
		return list;
	}
	// 根据客户得到上架单2
	public List getCustomerByKHs(int customerid){
		String hql="from UpServer where customer.customerId="+customerid;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	public List getCity() {
		Session session = this.getSession();
		String sql = "select temp from t_city where superid in (select id from t_city)";
		Query query = session.createSQLQuery(sql);
		List citylist = query.list();
		return citylist;
	}
	//取到所有地区
	public List getProvince() {
		String hql = "from City";
		return this.getHibernateTemplate().find(hql);
	}
	
	//查询地区下的机房名字
	public List getElectByCity(String cityname) {
		String sql = "select electID,electName from t_electHouse h,t_city c where h.cityid=c.id and c.name='"+cityname+"'";
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		List electlist = query.list();
		return electlist;
	}
	
	//根据机房查询机房下机柜信息
	public List getCabinetByHouse(Integer id) {
		String sql = "select c.* from t_electHouse h,t_cabinet c where c.electID = h.electID and h.electName="+id;
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		List calist = query.list();
		return calist;
	}

	public Cabinet getCabinetDaos(int cid) {
		return (Cabinet) this.getHibernateTemplate().get(Cabinet.class,cid);
	}

	public ElectHouse getElectHouseDaos(int eid) {
		return (ElectHouse) this.getHibernateTemplate().get(ElectHouse.class,eid);
	}
	
	
	//查询所有地区的同时查出其机房名称
	public List getCandH() {
		String sql = "select c.name,e.electName from t_city c left join t_electHouse e on c.id=e.cityid";
		Session session = this.getSession();
		List chlist = session.createSQLQuery(sql).list();
		return chlist;
	}
	public List getSuper() {
		String hql = "from City";
		List list = this.getHibernateTemplate().find(hql);
		return list;
	}
	public List getCityBySuperid(Integer superid){
		String hql = "from City where superid="+superid;
		List list= this.getHibernateTemplate().find(hql);
		return list;
	}
    //  得到所有省份
	public List getAllSheng(){
		List list= this.getHibernateTemplate().find("from City where superid=-1 or superid=0 ");
		System.out.println(list.size());
		return list;
	}
	//根据城市名字查询ID
	public List getElectByCityid(Integer cityid) {
		String hql = "from ElectHouse where cityid="+cityid;
		return this.getHibernateTemplate().find(hql);
	}
	
	public List get(Integer id) {
		String hql = "from Cabinet where electId ="+id;
		Query query = this.getSession().createQuery(hql);
		List list = query.list();
		return list;
	}
	
	//根据省份ID查询其城市
	public List getCityBySuperid(int superid){
		Session session = this.getSession();
		String hql = "from City where superid="+superid;
		List list = this.getHibernateTemplate().find(hql);
		return list;
	}
	public int countSql(String sql){
		Query query = this.getSession().createQuery(sql);
		int cout = Integer.parseInt(query.uniqueResult().toString());
		System.out.println("cout="+cout);
		return cout;
	}
	public List selElects(String stg){
		return super.getHibernateTemplate().find(stg);
	}
}
