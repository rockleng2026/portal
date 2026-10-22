package com.fuao.fajxc.bussiness.impl.stockpile;

import java.util.List;

import com.fuao.fajxc.bussiness.stockpile.ProfitOrlossBussiness;
import com.fuao.fajxc.dao.impl.stockpile.ProfitOrlossDaoImpl;
import com.fuao.fajxc.dao.stockpile.OutboundDao;
import com.fuao.fajxc.dao.stockpile.ProfitOrlossDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Outbound;
import com.fuao.fajxc.vo.OutboundInfo;
import com.fuao.fajxc.vo.Ruin;
import com.fuao.fajxc.vo.RuinInfo;

public class ProfitOrlossBussinessImpl implements ProfitOrlossBussiness {

	private ProfitOrlossDao prob;
	private OutboundDao obd;


	

	

	public OutboundDao getObd() {
		return obd;
	}

	public void setObd(OutboundDao obd) {
		this.obd = obd;
	}

	/**
	 * @return the prob
	 */
	public ProfitOrlossDao getProb() {
		return prob;
	}

	/**
	 * @param prob the prob to set
	 */
	public void setProb(ProfitOrlossDao prob) {
		this.prob = prob;
	}

	/**
	 * 添加报损单
	 */
	public boolean addPorLoss(Ruin ruin) {
		return prob.addPorLoss(ruin);
	}

	/**
	 * 添加报损单
	 * 返回对象
	 */
	public Ruin addReturnPorLoss(Ruin ruin) {
		try {
			return (Ruin) prob.addReturnObject(ruin);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean addPorLossInfo(RuinInfo rinfo) {
		// TODO Auto-generated method stub
		return prob.addPorLossInfo(rinfo);
	}

	public boolean delPorLoss(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return prob.delPorLoss(obj);
	}

	public boolean delPorLossInfo(String addhql) {
		// TODO Auto-generated method stub
		return prob.delPorLossInfo(addhql);
	}

	public boolean editPorLoss(Ruin ruin) {
		// TODO Auto-generated method stub
		return prob.editPorLoss(ruin);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return prob.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List somePorLoss(String addhql) {
		// TODO Auto-generated method stub
		return prob.somePorLoss(addhql);
	}

	public List somePorLossInfo(String addhql) {
		// TODO Auto-generated method stub
		return prob.somePorLossInfo(addhql);
	}

	@SuppressWarnings("finally")
	public boolean auditingPass(String orderNo) {
		System.out.println(11111);
		System.out.println(222);
		boolean flag=false;
		System.out.println("orderNo"+orderNo);
		try
		{
			if(orderNo!=null){
				List list=prob.somePorLossInfo(" and ruin.ruinNo='"+orderNo+"'");
				System.out.println("List.size:"+list.size());
				if(list.size()>0){
							Object[] obj=new Object[list.size()];
							for(int i=0;i<list.size();i++){
								obj[i]=((RuinInfo)list.get(i)).getProduct().getId();
							}
							flag=obd.delProduct(obj);
							if(flag){
								String hql="update Ruin set delflag=2 where ruinNo='"+orderNo+"'";
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

}
