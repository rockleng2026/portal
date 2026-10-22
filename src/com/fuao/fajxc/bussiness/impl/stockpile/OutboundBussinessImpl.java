package com.fuao.fajxc.bussiness.impl.stockpile;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionTemplate;

import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.bussiness.stockpile.OutboundBussiness;
import com.fuao.fajxc.dao.impl.stockpile.OutBoundDaoImpl;
import com.fuao.fajxc.dao.stockpile.OutboundDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.StatInfo;

public class OutboundBussinessImpl implements OutboundBussiness {

	private OutboundDao obd;
	private static Logger logger = Logger.getLogger(OutboundBussinessImpl.class);
	


	/**
	 * @return the obd
	 */
	public OutboundDao getObd() {
		return obd;
	}

	/**
	 * @param obd the obd to set
	 */
	public void setObd(OutboundDao obd) {
		this.obd = obd;
	}

	//添加出库单
	public boolean addOutBound(Outbound ob) {
		System.out.println("Biz");
		boolean flag=obd.addOutBound(ob);
		System.out.println("Biz:"+flag);
		return flag;
	}

	/**
	 * 添加出库单
	 * 返回对象
	 */
	public Outbound addReturnOutBound(Outbound ob) {
		Outbound outbound = null;
		try {
			outbound = (Outbound) obd.addReturnObject(ob);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return outbound;
	}
	
	//删除出库单
	public boolean delOutBound(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return obd.delOutBound(obj);
	}

	public boolean editOutBound(Outbound ob) {
		return obd.editOutBound(ob);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages pages=null;
		try
		{
			pages=obd.exHqlPages(hql, pageNo, pageSize, values);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return pages;
	}

	public List someOutBound(String addhql) {
		// TODO Auto-generated method stub
		return obd.someOutBound(addhql);
	}
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		OutboundBussiness pb=(OutboundBussiness)ac.getBean("outboundBussiness");
//		String hql="from Outbound where delflag=0 order by id desc";
//		System.out.println(pb.exHqlPages(hql, 1, 3, null));
//		Outbound ob=new Outbound();
//		ob.setDelflag("0");
//		System.out.println(pb.addOutBound(ob));
		//System.out.println((Outbound)pb.someOutBound(" and id=15").get(0));
		System.out.println(pb.auditingPass("CK-2011083100004"));
		//System.out.println(pb.delOutInfo(" and outbound.id=58"));
	}

	public boolean addOutInfo(OutboundInfo ob) {
		// TODO Auto-generated method stub
		return obd.addOutInfo(ob);
	}

	public boolean delOutInfo(String addhql) {
		// TODO Auto-generated method stub
		return obd.delOutInfo(addhql);
	}

	public List someOutInfo(String addhql) {
		// TODO Auto-generated method stub
		return obd.someOutInfo(addhql);
	}

	public List selType(String addhql) {
		// TODO Auto-generated method stub
		return obd.selType(addhql);
	}

	@SuppressWarnings("finally")
	public boolean auditingPass(String orderNo) {
		System.out.println(11111);
		//TransactionStatus status = txManager.getTransaction(txDefinition);
		System.out.println(222);
		boolean flag=false;
		System.out.println("orderNo"+orderNo);
		try
		{
			if(orderNo!=null){
				List list=obd.someOutInfo(" and outbound.outboundNo='"+orderNo+"'");
				System.out.println("List.size:"+list.size());
				if(list.size()>0){
							Object[] obj=new Object[list.size()];
							for(int i=0;i<list.size();i++){
								obj[i]=((OutboundInfo)list.get(i)).getProduct().getId();
							}
							flag=obd.delProduct(obj);
							if(flag){
								String hql="update Outbound set delflag=2 where outboundNo='"+orderNo+"'";
								flag=obd.exeHql(hql);
								System.out.println("delflag:"+flag);
							}
							System.out.println("Flag"+flag);
					}
			}
		}
		catch(RuntimeException ex){
			System.out.println("BussinessException");
			ex.printStackTrace();
		}
		finally{
			return flag;
		}	
	}
	public List selectInfo(String hql)
	{
		return obd.selectInfo(hql);
	}
}
