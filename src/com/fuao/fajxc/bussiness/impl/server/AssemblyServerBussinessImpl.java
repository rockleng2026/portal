package com.fuao.fajxc.bussiness.impl.server;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.fuao.fajxc.bussiness.server.AssemblyServerBussiness;
import com.fuao.fajxc.dao.server.AssemblyServerDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.AssemblyServer;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;

public class AssemblyServerBussinessImpl implements AssemblyServerBussiness {

	private AssemblyServerDao asd;
	
	
	
	public AssemblyServerDao getAsd() {
		return asd;
	}

	public void setAsd(AssemblyServerDao asd) {
		this.asd = asd;
	}


	public boolean delassemblyServer(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return asd.delassemblyServer(obj);
	}

	public boolean editassemblyServer(AssemblyServer assS) {
		// TODO Auto-generated method stub
		return asd.editassemblyServer(assS);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return asd.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List someassemblyServer(String addhql) {
		// TODO Auto-generated method stub
		return asd.someassemblyServer(addhql);
	}

	
	public boolean addServerControl(AssemblyServer assemb,String no)
	{
		boolean flag3=false;
		try
		{
				Product pro=new Product();
				pro.setDepot(assemb.getDepot());
				pro.setDelflag("0");
				pro.setParentId(0);
				pro.setUsestate(2);
				pro.setUseSum(0);
				pro.setBarcode(no);
				Property property=asd.selPro(assemb.getModel().getModel());
				System.out.println("property:"+property);
				pro.setProperty(property);
				
				boolean flag2=asd.addServer(pro);
				if(flag2){
					assemb.setProductByServerId(pro);
					asd.addassemblyServer(assemb);
					Object[] allProId=new Object[7];
					allProId[0]=assemb.getProductByCpuId().getId();
					allProId[1]=assemb.getProductByCrateId().getId();
					allProId[2]=assemb.getProductByHdId().getId();
					allProId[3]=assemb.getProductByMainBoardId().getId();
					allProId[4]=assemb.getProductByMemoryId().getId();
					allProId[5]=assemb.getProductByNetworkCardId().getId();
					allProId[6]=assemb.getProductByPowerId().getId();
					flag3=asd.updateProduct(allProId, pro.getId());
				}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag3;
	}

	public boolean editServerControl(AssemblyServer assemb) {
		boolean flag3=false;
		try
		{
			Product pro=(Product) asd.selProduct(" and id="+Integer.parseInt(assemb.getProductByServerId().getId().toString())).get(0);
			System.out.println("server::::::::::::::::::"+pro);
			System.out.println("id::::::::::::::::::"+pro.getId());
			System.out.println("name:::::::::::::::"+pro.getProperty().getName());
			System.out.println("Borddddddd::::::::::::"+pro.getBarcode());
			pro.setDepot(assemb.getDepot());
			
			pro.setDepot(assemb.getDepot());
			Property property=asd.selPro(assemb.getModel().getModel());
			pro.setProperty(property);
			boolean flag=asd.editServer(pro);
			
			if(flag){
				asd.editassemblyServer(assemb);
				asd.updateparentId(pro.getId());
				Object[] allProId=new Object[7];
				allProId[0]=assemb.getProductByCpuId().getId();
				allProId[1]=assemb.getProductByCrateId().getId();
				allProId[2]=assemb.getProductByHdId().getId();
				allProId[3]=assemb.getProductByMainBoardId().getId();
				allProId[4]=assemb.getProductByMemoryId().getId();
				allProId[5]=assemb.getProductByNetworkCardId().getId();
				allProId[6]=assemb.getProductByPowerId().getId();
				flag3=asd.updateProduct(allProId, pro.getId());
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag3;
	}

}
