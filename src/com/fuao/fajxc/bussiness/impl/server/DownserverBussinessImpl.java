package com.fuao.fajxc.bussiness.impl.server;

import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.server.DownserverBussiness;
import com.fuao.fajxc.dao.sale.SaleorderDao;
import com.fuao.fajxc.dao.server.DownserverDao;
import com.fuao.fajxc.dao.server.UpserverDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.UpServer;


public class DownserverBussinessImpl implements DownserverBussiness {
	private static Logger logger  = Logger.getLogger(DownserverBussiness.class);
	private DownserverDao dsd;
	private UpserverDao   usd;
	private SaleorderDao     sod ;
	//获得上架单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");

	public SaleorderDao getSod() {
		return sod;
	}

	public void setSod(SaleorderDao sod) {
		this.sod = sod;
	}

	public UpserverDao getUsd() {
		return usd;
	}

	public void setUsd(UpserverDao usd) {
		this.usd = usd;
	}

	public DownserverDao getDsd() {
		return dsd;
	}

	public void setDsd(DownserverDao dsd) {
		this.dsd = dsd;
	}

	public boolean adddownServer(DownServer ds) {
		boolean flag=false;
		try
		{
			ds.setDelflag(0);//设置没有删除
			ds.setDownFlag(0);//设置没有下架
			flag=dsd.adddownServer(ds);
			if(flag){
				String hql="update Product set usestate=4 where id="+ds.getProduct().getId()+" or parentId="+ds.getProduct().getId();
				flag=dsd.executeHql(hql);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}
	/**
	 * 添加 返回对象
	 */
	public DownServer addReturndownServer(DownServer ds) {
		PropertyEditor proEdit=new PropertyEditor();
		DownServer downserver=null;
		try
		{
			ds.setDelflag(0);//设置没有删除
			ds.setDownFlag(0);//设置没有下架
			ds.setAuditingFlag(0);
			downserver=(DownServer)dsd.addReturnObject(ds);
			if(downserver!=null){
				//将上架的状态置为下架审核中
				String hql1 = " update UpServer set upFlag = 3 where upNo = '"+downserver.getUpNo()+"'";
				dsd.executeHql(hql1);
				
//				String vpsid=(String) proEdit.getID("vpsid");
//				String hqll=" from Product  where id="+ds.getProduct().getId()+"";
//				List<Product> p=dsd.execHQL(hqll);
//				if(p.size()>0)
//				{
////					String vid=p.get(0).getProperty().getModel().getCommodityTpye().getId()+"";
////					if(!vpsid.equals(vid))
////					{
////					String hql="update Product set usestate=4 where id="+ds.getProduct().getId()+" or parentId="+ds.getProduct().getId();
////					dsd.executeHql(hql);
////					}
//				}
			}
		}
		catch(Exception ex)
		{
			logger.error("downServerBissinees Error:"+ex.getMessage());
			ex.printStackTrace();
		}
		return downserver;
	}

	public boolean deldownServer(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return dsd.deldownServer(obj);
	}

	public boolean editdownServer(DownServer ds) {
		// TODO Auto-generated method stub
		return dsd.adddownServer(ds);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return dsd.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List somedownServer(String addhql) {
		// TODO Auto-generated method stub
		return dsd.somedownServer(addhql);
	}

	public List someType(String addhql) {
		// TODO Auto-generated method stub
		return dsd.someType(addhql);
	}

	/**
	 * 审核后操作  点击下架的操作
	 * @return
	 */
	public boolean executeUpserver(String proId, String downId) {
		//一    、  如果服务器没有完全下架，服务器下架操作查找，并生成一个新的子类上架单，
		//要查找原有的上架单，根据在下架单中的产品（服务器）product，的id，到上架单中
		//针对上架单分组查询，找出该服务器的最大的（最新的）开始时间的上架单，找到它的id，把它的id做为parentId,新增加一个订单，
		//还要修改对应的上架中的serverip,可能只是下架其中的一个ip地址，或多个ip地址
		
		//二  、 如果服务器完全下架，则不要生成新上架单，并对Product进行修改，
		PropertyEditor proEdit=new PropertyEditor();
		boolean flag=false;
		try
		{
			//一、 判断是否已经完全下架，找出下架单中的serverip和上架单中的serverip是否相同，如果相同，则为完全下架，
			//1.根据proId找出对应的上架单  已经上架的，并且没有删除的
			String ushql=" from UpServer where product.id="+proId+" and upFlag=3 and delflag=0";
			System.out.println(ushql);
			List<UpServer> u=dsd.execHQL(ushql);
			DownServer ds=(DownServer)(dsd.execHQL("from DownServer where id="+downId).get(0));
			logger.error("ds-----"+ds);
			if(u.size()>0)
			{
				String vpsid=(String) proEdit.getID("vpsid");
				if(vpsid.equals(ds.getProduct().getProperty().getModel().getCommodityTpye().getId()+""))
				{
					for(int i=0;i<u.size();i++)
					{
						int a=0;
						int aa=0;
						String[] serverIp=u.get(i).getServerIp().split("，");//获取上架的ip
						String[] downServerIp=ds.getServerIp().split(",");//获取下架的服务器id和ip
						String[] productid= new String[downServerIp.length] ;//下架的商品id
						String[] dsip= new String[downServerIp.length] ;//下架的商品ip
						for(int j=0;j<downServerIp.length;j++)
						{
							String[] downip=downServerIp[j].split("#");
							if(downip.length == 1){
								productid[a]=downip[0];//无产品id
								dsip[aa]=downip[0];
							}else{
								productid[a]=downip[0];
								dsip[aa]=downip[1];
							}
							
							a++;
							aa++;
						}
						
						for(int j=0;j<serverIp.length;j++)
						{
							ok:for(int c=0;c<dsip.length;c++)
							{
								if(serverIp[j].equals(dsip[c]))//判断下架的ip和上架的ip
								{
									
									String hql2=" update UpServer set serverIp='' ,upFlag=2 where id="+u.get(i).getId()+" ";
									flag=dsd.executeHql(hql2);//vps删除第i条上架单的ip数据的
									break ok;
								}
							}
						}
					}
					if(flag)
					{
						String hql=" update DownServer set downFlag=1 where id="+downId;
						flag=dsd.executeHql(hql);
					}
				}
				else
				{
					for(int i=0;i<u.size();i++)
					{
						int a=0;
						int aa=0;
						String[] serverIp=u.get(i).getServerIp().split("，");//获取上架的ip
						String[] downServerIp=ds.getServerIp().split(",");//获取下架的服务器id和ip
						String[] productid= new String[downServerIp.length] ;//下架的商品id
						String[] dsip= new String[downServerIp.length] ;//下架的商品ip
//						以下部分是IP下架，现在ip没有入库不需要下架 2012-7-25 lzy
//						for(int j=0;j<downServerIp.length;j++)
//						{
//							String[] downip=downServerIp[j].split("#");
//							productid[a]=downip[0];
//							dsip[aa]=downip[1];
//							a++;
//							aa++;
//						}
//						ok:
//						for(int j=0;j<serverIp.length;j++)
//						{
//							for(int c=0;c<dsip.length;c++)
//							{
//								if(serverIp[j].equals(dsip[c]))//判断下架的ip和上架的ip
//								{
//									
//									String hql2=" update UpServer set serverIp='',upFlag=2  where product.id="+Integer.parseInt(productid[c])+" ";
//									
//									flag=dsd.executeHql(hql2);//不是vps就删除所以该商品的ip
//									break ok;
//								}
//							}
//						}
					}
//					if(flag)//先屏蔽掉
					if(true)
					{
						String hql=" update DownServer set downFlag=1 where id="+downId;//将下架单置为下架状态
						flag=dsd.executeHql(hql);
						String iphql=" update Product set usestate=2 , parentId=0  where id="+Integer.parseInt(proId);
						dsd.executeHql(iphql);
					}
				}
				String hql2=" update UpServer set upFlag=4  where upNo='"+ds.getUpNo()+"'";//将上架单置为下架状态
				flag=dsd.executeHql(hql2);
				logger.info("--------"+flag);
				logger.error("-----"+flag);
			}
		}
		catch(Exception ex)
		{
			logger.error("ex-----"+ex);
			ex.printStackTrace();
		}
		logger.info("end-----"+flag);
		return flag;
	}
	public static void main(String[] args) {
		System.out.println("start");
		ok:for(int i = 0;i<10;i++){
			System.out.println(i);
			for(int j = 0 ;j<10;j++){
				System.out.println(j);
				if(j == 2){
					
					break ok;
				}				
					
			}
		}
		System.out.println("end");
	}
}