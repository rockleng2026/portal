package com.fuao.fajxc.bussiness.impl.stockpile;

import java.util.List;




import com.fuao.fajxc.bussiness.stockpile.IncomeBussiness;
import com.fuao.fajxc.dao.stockpile.IncomeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Income;
import com.fuao.fajxc.vo.IncomeInfo;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.PurOrderInfo;

public class IncomeInfoBussinessImpl implements IncomeBussiness {

	public IncomeDao incomeDao;



	public IncomeDao getIncomeDao() {
		return incomeDao;
	}

	public void setIncomeDao(IncomeDao incomeDao) {
		this.incomeDao = incomeDao;
	}

	public List someIncomeInfo(String addhql) {
		// TODO Auto-generated method stub
		return incomeDao.someIncomeInfo(addhql);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return incomeDao.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List selIncome(String addhql) {
		// TODO Auto-generated method stub
		return incomeDao.selIncome(addhql);
	}

	public boolean addOredit(String mark,Income income, String models, String price,
			String count, String sum) {
		boolean flag=false;
		boolean flag2=false;
		
			if(mark=="add"){
				flag=incomeDao.addIncome(income);
			}
			else{
				flag=incomeDao.editIncome(income);
				if(flag){
					flag=incomeDao.delIncomeInfo(" and incomeId="+income.getId());
					System.out.println("删除："+flag);
				}
			}
			if(flag)
			{
				System.out.println("进入Info");
				if(models!=null&&price!=null&&count!=null&&sum!=null){
					String[] modes=models.split(",");
					System.out.println(modes.length);
					String[] infoprices=price.split(",");
					String[] counts=count.split(",");
					String[] sums=sum.split(",");
					System.out.println("priceLeng"+infoprices.length);
					for(int i=0;i<modes.length;i++)
					{
						System.out.println("进入循环");
						IncomeInfo incomeInfo=new IncomeInfo();
						Model mod=new Model();
						mod.setModel(Integer.parseInt(modes[i]));
						incomeInfo.setModel(mod);
						incomeInfo.setIncome(income);
						incomeInfo.setCount(Integer.parseInt(counts[i]));
						incomeInfo.setSum(Double.parseDouble(sums[i]));
						incomeInfo.setPrice(Double.parseDouble(infoprices[i]));
						
						flag2=incomeDao.addIncomeInfo(incomeInfo);
						System.out.println("info:"+flag);
					}
				} else
					throw new RuntimeException();
			}
			if(flag&&flag2)
				return true;
			else
				return false;
	}

	public boolean upstatu(Income income) {
		try {
			incomeDao.update(income);
			return true;
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return false;
	}

	public boolean delIncome(Object[] obj) {
		Object[] ids=new Object[obj.length];
		for(int i=0;i<obj.length;i++)
		{
			ids[i]=Integer.parseInt(obj[i].toString());
		}
		return incomeDao.delIncome(ids);
	}
}
