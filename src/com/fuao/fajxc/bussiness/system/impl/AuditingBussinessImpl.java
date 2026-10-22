package com.fuao.fajxc.bussiness.system.impl;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.fuao.fajxc.action.cdn.FindXMLMake;
import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.system.AuditingOrderDao;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.fuao.fajxc.vo.RuinInfo;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.VerifyOrderDepartment;
import com.fuao.fajxc.vo.VerifyOrderEmployee;
import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;

public class AuditingBussinessImpl implements AuditingBussiness {
	Logger logg=Logger.getLogger(AuditingBussinessImpl.class);
	private AuditingOrderDao audd;
	private SaleOrder saleorder;
	private CommonBiz formbiz;
	Cookies ck = new Cookies();
	
	public CommonBiz getFormbiz() {
		return formbiz;
	}

	public void setFormbiz(CommonBiz formbiz) {
		this.formbiz = formbiz;
	}

	public AuditingOrderDao getAudd() {
		return audd;
	}

	public void setAudd(AuditingOrderDao audd) {
		this.audd = audd;
	}

	
	/**
	 * 查看是否是分公司的审核流程
	 * @param filialemark
	 * @param otype
	 * @return
	 */
	public VerifyOrder gettVerifyOrder(String filialemark,String otype){
		VerifyOrder ver=null;
		if(filialemark!=null && !filialemark.equals(""))
		{
			Object[] obj=filialemark.split("-");
			for(int i=obj.length-1;i>=0;i--)
			{
				String ping=obj[i]+"-"+otype;
				ver=audd.oneOrder(ping);
				if(ver!=null)
					return ver;
			}
		}

		ver=(VerifyOrder)audd.oneOrder(otype);
		return ver;
	}

	public List someauditingOrder(String addhql) {
		// TODO Auto-generated method stub
		return audd.someauditingOrder(addhql);
	}

	public int AudtintingRound(String hql,AuditingOrderTab aot,String tab,String afiled,String orderName) {
		int i=0;
		boolean flag1=false;
		try
		{
			flag1 = audd.updateAuditing(hql);
			if (flag1) {
				boolean aot1 = audd.selLastAot(aot.getOrderNo());

				// 吴伦清修改的地方。 如果审核通过则执行原来的操作
				if (aot.getAuditingFlag() == 1) {
					if (aot1) {
						// 入库成功修改商品状态为2未使用
						if (tab.equals("Storage")) {
							// 拿出入库的ID
							int storageId = audd.selectStorageId(aot
									.getOrderNo());
							List list = new ArrayList();
							list = audd.selectStrorageinfoId(storageId);
							String aa = "";
							for (int j = 0; j < list.size(); j++) {
								// 循环拿出storageinfoId
								int storageInfoId = ((StorageInfo) list.get(j))
										.getStorageInfoId();
								if (j < (list.size() - 1))
									aa += storageInfoId + ",";
								else {
									aa += storageInfoId;
								}
							}
							String hql1 = "update Product set usestate=2 where storageInfoId in("
									+ aa + ")";
							String hql2 = "update " + tab + " set " + afiled
									+ "=1 where " + orderName + "='"
									+ aot.getOrderNo() + "'";

							boolean flag2 = audd.updateAuditing(hql1);
							boolean flag3 = audd.updateAuditing(hql2);

							if (flag2 && flag3)
								i = 1;
						}
						// 报损审核成功删除商品
						if (tab.equals("Ruin")) {
							int ruinId = audd.selectRuinId(aot.getOrderNo());
							List list = new ArrayList();
							list = audd.selectRuininfoId(ruinId);
							String aa = "";
							for (int j = 0; j < list.size(); j++) {
								int productId = ((RuinInfo) list.get(j))
										.getProduct().getId();
								if (j < (list.size() - 1))
									aa += productId + ",";
								else {
									aa += productId;
								}
							}
							String hql1 = "update Product set delflag=1 where id in("
									+ aa + ")";
							String hql2 = "update " + tab + " set " + afiled
									+ "=1 where " + orderName + "='"
									+ aot.getOrderNo() + "'";

							boolean flag2 = audd.updateAuditing(hql1);
							boolean flag3 = audd.updateAuditing(hql2);

							if (flag2 && flag3)
								i = 1;
						}
						if (tab.equals("ReturnOrder")) {
							int toOrderID = audd.selectToOrderID(aot
									.getOrderNo());
							int purOrderID = audd.selectPurOrderID(aot
									.getOrderNo());
							String hql1 = "update ToOrder set toOrderVerify=3 where id='"
									+ toOrderID + "'";
							String hql2 = "update PurOrder set auditingState=3 where id='"
									+ purOrderID + "'";
							String hql3 = "update " + tab + " set " + afiled
									+ "=1 where " + orderName + "='"
									+ aot.getOrderNo() + "'";

							boolean flag2 = audd.updateAuditing(hql1);
							boolean flag3 = audd.updateAuditing(hql2);
							boolean flag4 = audd.updateAuditing(hql3);
							if (flag2 && flag3 && flag4) {
								i = 1;
							}
						} else if (tab != null && afiled != null) {
							String hql1 = "update " + tab + " set " + afiled
									+ "=1 where " + orderName + "='"
									+ aot.getOrderNo() + "'";
							boolean flag2 = audd.updateAuditing(hql1);
							if (flag2)
							{
								i = 1;
								///根据订单编号前三个字符，判断是否为CDN 订单
								String cdnNO=aot.getOrderNo().substring(0, 4);
								if(cdnNO.equals("CDN"))
								{
									//修改配置文件      
									FindXMLMake fk=new FindXMLMake();
									
								}
								
							}
						}
					} else {
						List<AuditingOrderTab> aotlist = this
								.someauditingOrder(" and orderNo='"
										+ aot.getOrderNo()
										+ "' and handlestate=1");
						int j = 0;
						for (int k = 0; k < aotlist.size(); k++) {
							if (aotlist.get(k).getAuditingFlag() != 0) {
								j++;
							}
						}
						if (j <= 0) {
							int aorder = aot.getAuditingOrder() + 1;
							String hql2 = "update AuditingOrderTab set handlestate=1 where auditingOrder="
									+ aorder + "";
							boolean flag3 = audd.updateAuditing(hql2);
							i = 0;
						}
					}

					// 如果审核不通过则修改单据的审核状态为不通过
				} else {
					String hql1 = "update " + tab + " set " + afiled + "="
							+ aot.getAuditingFlag() + " where " + orderName
							+ "='" + aot.getOrderNo() + "'";
					boolean flag2 = audd.updateAuditing(hql1);
					if (flag2)
						i = 1;
				}
			}
			else
				i=2;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return i;
	}
	public int AudtintingRound2(String hql,AuditingOrderTab aot,String tab,String afiled,String orderName,String marks) {
		boolean flag1 = audd.updateAuditing(hql);
		int i=0;
		if(flag1)
		{
			boolean aot1 = audd.selLastAot1(aot.getRvid());//是否是最后一个部门
			String hql11="from AuditingOrderTab where rvid='"+aot.getRvid()+"' order by auditingOrder asc ";
			List<AuditingOrderTab> ado=audd.execHQL(hql11);
			//  如果审核通过则执行的操作
			System.out.println(aot.getId());
			
			System.out.println(ado.get(ado.size()-1).getId());
			
			//审核成功执行的操作
			if (marks.equals("1")) {
				//判断是否是最后一个部门（多人不分顺序审核除外）
				if(aot.getId()!=ado.get(ado.size()-1).getId()&&(aot.getMark().equals("2")==false))
				{
					
					if(ado.size()>0)
					{	
						
							int b=0;
							for(int ii=0;ii<ado.size();ii++)
							{
								//审核完成改变下一条的处理状态如果审核顺序相同的就改变几条数据的状态
								if(ado.get(ii).getAuditingOrder()>aot.getAuditingOrder() ){
									
										
										String hql2="update AuditingOrderTab set handlestate=1 where rvid='"+aot.getRvid()+"' and auditingOrder="+ado.get(ii).getAuditingOrder()+"";
										boolean flag2 = audd.updateAuditing(hql2);
										if(flag2)
										i=1;
										b=ado.get(ii).getAuditingOrder();
										break;
									}
								
								
							}
						
							
						}
					
				}
				else if(aot.getMark().equals("2"))
				{
					String hql111="from AuditingOrderTab where rvid='"+aot.getRvid()+"' and auditingOrder="+aot.getAuditingOrder()+"";
					List<AuditingOrderTab> ao=audd.execHQL(hql111);
					boolean aa=true;
					//循环判断是否多人不分顺序全部审核完成
					for(int ai=0;ai<ao.size();ai++)
					{
						System.out.println(ao.get(ai).getAuditingFlag());
						if(ao.get(ai).getAuditingFlag()==0&&ao.get(ai).getId()!=aot.getId())
						{
							aa=false;
							break;
						}
					}
					//如果多人审核完成改变下一条数据的处理状态，没有不改变
					if(aa)
					{
						boolean flag2=false;
						for(int ii=0;ii<ado.size();ii++)
						{
							if(ado.get(ii).getAuditingOrder()>aot.getAuditingOrder()){
								
								String hql2="update AuditingOrderTab set handlestate=1 where orderNo='"+aot.getOrderNo()+"' and auditingOrder="+ado.get(ii).getAuditingOrder()+"";
								 flag2 = audd.updateAuditing(hql2);
								if(flag2)
								i=1;
								break;
								
							}
						}
						if(flag2==false)
						{
							String hql1 = "update " + tab + " set " + afiled+ "=1 where " + orderName + "='"+ aot.getOrderNo() + "'";
							boolean flag = audd.updateAuditing(hql1);
							//*************************************
							
									//*************************************
									// 吴伦清修改的地方。 如果审核通过则执行原来的操作
									if (aot.getAuditingFlag() == 1) {
										if (aot1) {
											// 入库成功修改商品状态为2未使用
											
											// 报损审核成功删除商品
											
											
							}
							//***************************************
							
						}
					}
					
				}
				else
				{
					String hql1 = "update " + tab + " set " + afiled+ "=1 where " + orderName + "='"+ aot.getRvid() + "'";
					boolean flag21 = audd.updateAuditing(hql1);
					if(flag21)
						i=1;
					
					//*************************************
					// 吴伦清修改的地方。 如果审核通过则执行原来的操作
					if (aot.getAuditingFlag() == 1) {
						if (aot1) {
							// 入库成功修改商品状态为2未使用
							
							// 报损审核成功删除商品
							
							
						}
			}
			//***************************************
			
					
				}
			}
			//审核拒绝的操作
			else {
				String hql1 = "update " + tab + " set " + afiled + "="
						+ aot.getAuditingFlag() + " where " + orderName
						+ "='" + aot.getRvid() + "'";
				boolean flag22 = audd.updateAuditing(hql1);
				if (flag22)
					i = 1;
			}}
		}	
		return i;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 *(non-Javadoc)审批
	 */
	public int AudtintingRound1(String hql,AuditingOrderTab aot,String tab,String afiled,String orderName,String marks) {
		boolean flag1 = audd.updateAuditing(hql);
		logg.info("hql"+flag1+"审批的过程");
		int i=0;
		if(flag1)
		{
			boolean aot1 = audd.selLastAot(aot.getOrderNo());//是否是最后一个部门
			String hql11="from AuditingOrderTab where orderNo='"+aot.getOrderNo()+"' order by auditingOrder asc ";
			List<AuditingOrderTab> ado=audd.execHQL(hql11);
			//  如果审核通过则执行的操作
			System.out.println(aot.getId());
			
			System.out.println(ado.get(ado.size()-1).getId());
			logg.info(ado.get(ado.size()-1).getId());
			logg.info(marks);
			//审核成功执行的操作
			if (marks.equals("1")) {
				//判断是否是最后一个部门（多人不分顺序审核除外）
				if(aot.getId()!=ado.get(ado.size()-1).getId()&&(aot.getMark().equals("2")==false))
				{
					
					if(ado.size()>0)
					{	
						
							int b=0;
							for(int ii=0;ii<ado.size();ii++)
							{
								//审核完成改变下一条的处理状态如果审核顺序相同的就改变几条数据的状态
								if(ado.get(ii).getAuditingOrder()>aot.getAuditingOrder() ){
									
										
										String hql2="update AuditingOrderTab set handlestate=1 where orderNo='"+aot.getOrderNo()+"' and auditingOrder="+ado.get(ii).getAuditingOrder()+"";
										boolean flag2 = audd.updateAuditing(hql2);
										if(flag2)
										i=1;
										b=ado.get(ii).getAuditingOrder();
										break;
									}
								
								
							}
						
							
						}
					
				}
				else if(aot.getMark().equals("2"))
				{
					String hql111="from AuditingOrderTab where orderNo='"+aot.getOrderNo()+"' and auditingOrder="+aot.getAuditingOrder()+"";
					List<AuditingOrderTab> ao=audd.execHQL(hql111);
					boolean aa=true;
					//循环判断是否多人不分顺序全部审核完成
					for(int ai=0;ai<ao.size();ai++)
					{
						System.out.println(ao.get(ai).getAuditingFlag());
						if(ao.get(ai).getAuditingFlag()==0&&ao.get(ai).getId()!=aot.getId())
						{
							aa=false;
							break;
						}
					}
					//如果多人审核完成改变下一条数据的处理状态，没有不改变
					if(aa)
					{
						boolean flag2=false;
						for(int ii=0;ii<ado.size();ii++)
						{
							if(ado.get(ii).getAuditingOrder()>aot.getAuditingOrder()){
								
								String hql2="update AuditingOrderTab set handlestate=1 where orderNo='"+aot.getOrderNo()+"' and auditingOrder="+ado.get(ii).getAuditingOrder()+"";
								 flag2 = audd.updateAuditing(hql2);
								if(flag2)
								i=1;
								break;
								
							}
						}
						if(flag2==false)
						{
							String hql1 = "update " + tab + " set " + afiled+ "=1 where " + orderName + "='"+ aot.getOrderNo() + "'";
							boolean flag = audd.updateAuditing(hql1);
							//*************************************
							
									//*************************************
									// 吴伦清修改的地方。 如果审核通过则执行原来的操作
									if (aot.getAuditingFlag() == 1) {
										if (aot1) {
											// 入库成功修改商品状态为2未使用
											if (tab.equals("Storage")) {
												// 拿出入库的ID
												int storageId = audd.selectStorageId(aot
														.getOrderNo());
												List list = new ArrayList();
												list = audd.selectStrorageinfoId(storageId);
												String aa22 = "";
												for (int j = 0; j < list.size(); j++) {
													// 循环拿出storageinfoId
													int storageInfoId = ((StorageInfo) list.get(j))
															.getStorageInfoId();
													if (j < (list.size() - 1))
														aa22 += storageInfoId + ",";
													else {
														aa22 += storageInfoId;
													}
												}
												String hql221 = "update Product set usestate=2 where storageInfoId in("
														+ aa22 + ")";
												String hql222 = "update " + tab + " set " + afiled
														+ "=1 where " + orderName + "='"
														+ aot.getOrderNo() + "'";

												boolean flag222 = audd.updateAuditing(hql221);
												boolean flag322 = audd.updateAuditing(hql222);

												if (flag222 && flag322)
													i = 1;
											}
											// 报损审核成功删除商品
											if (tab.equals("Ruin")) {
												int ruinId = audd.selectRuinId(aot.getOrderNo());
												List list = new ArrayList();
												list = audd.selectRuininfoId(ruinId);
												String aa22 = "";
												for (int j = 0; j < list.size(); j++) {
													int productId = ((RuinInfo) list.get(j))
															.getProduct().getId();
													if (j < (list.size() - 1))
														aa22 += productId + ",";
													else {
														aa22 += productId;
													}
												}
												String hql221 = "update Product set delflag=1 where id in("
														+ aa22 + ")";
												String hql222 = "update " + tab + " set " + afiled
														+ "=1 where " + orderName + "='"
														+ aot.getOrderNo() + "'";

												boolean flag222 = audd.updateAuditing(hql221);
												boolean flag322 = audd.updateAuditing(hql222);

												if (flag222 && flag322)
													i = 1;
											}
											if (tab.equals("ReturnOrder")) {
												int toOrderID = audd.selectToOrderID(aot
														.getOrderNo());
												int purOrderID = audd.selectPurOrderID(aot
														.getOrderNo());
												String hql221 = "update ToOrder set toOrderVerify=3 where id='"
														+ toOrderID + "'";
												String hql222 = "update PurOrder set auditingState=3 where id='"
														+ purOrderID + "'";
												String hql322 = "update " + tab + " set " + afiled
														+ "=1 where " + orderName + "='"
														+ aot.getOrderNo() + "'";

												boolean flag222 = audd.updateAuditing(hql221);
												boolean flag322 = audd.updateAuditing(hql222);
												boolean flag422 = audd.updateAuditing(hql322);
												if (flag222 && flag322 && flag422) {
													i = 1;
												}
											}
										}
							}
							//***************************************
							
						}
					}
					
				}
				else
				{
					String hql1 = "update " + tab + " set " + afiled+ "=1 where " + orderName + "='"+ aot.getOrderNo() + "'";
					boolean flag21 = audd.updateAuditing(hql1);
					logg.info(flag21+"第二个。");
					if(flag21)
						i=1;
					
					//*************************************
					// 吴伦清修改的地方。 如果审核通过则执行原来的操作
					if (aot.getAuditingFlag() == 1) {
						if (aot1) {
							// 入库成功修改商品状态为2未使用
							if (tab.equals("Storage")) {
								// 拿出入库的ID
								int storageId = audd.selectStorageId(aot
										.getOrderNo());
								List list = new ArrayList();
								list = audd.selectStrorageinfoId(storageId);
								String aa22 = "";
								for (int j = 0; j < list.size(); j++) {
									// 循环拿出storageinfoId
									int storageInfoId = ((StorageInfo) list.get(j))
											.getStorageInfoId();
									if (j < (list.size() - 1))
										aa22 += storageInfoId + ",";
									else {
										aa22 += storageInfoId;
									}
								}
								String hql221 = "update Product set usestate=2 where storageInfoId in("
										+ aa22 + ")";
								String hql222 = "update " + tab + " set " + afiled
										+ "=1 where " + orderName + "='"
										+ aot.getOrderNo() + "'";

								boolean flag222 = audd.updateAuditing(hql221);
								boolean flag322 = audd.updateAuditing(hql222);

								if (flag222 && flag322)
									i = 1;
							}
							// 报损审核成功删除商品
							if (tab.equals("Ruin")) {
								int ruinId = audd.selectRuinId(aot.getOrderNo());
								List list = new ArrayList();
								list = audd.selectRuininfoId(ruinId);
								String aa22 = "";
								for (int j = 0; j < list.size(); j++) {
									int productId = ((RuinInfo) list.get(j))
											.getProduct().getId();
									if (j < (list.size() - 1))
										aa22 += productId + ",";
									else {
										aa22 += productId;
									}
								}
								String hql221 = "update Product set delflag=1 where id in("
										+ aa22 + ")";
								String hql222 = "update " + tab + " set " + afiled
										+ "=1 where " + orderName + "='"
										+ aot.getOrderNo() + "'";

								boolean flag222 = audd.updateAuditing(hql221);
								boolean flag322 = audd.updateAuditing(hql222);

								if (flag222 && flag322)
									i = 1;
							}
							if (tab.equals("ReturnOrder")) {
								int toOrderID = audd.selectToOrderID(aot
										.getOrderNo());
								int purOrderID = audd.selectPurOrderID(aot
										.getOrderNo());
								String hql221 = "update ToOrder set toOrderVerify=3 where id='"
										+ toOrderID + "'";
								String hql222 = "update PurOrder set auditingState=3 where id='"
										+ purOrderID + "'";
								String hql322 = "update " + tab + " set " + afiled
										+ "=1 where " + orderName + "='"
										+ aot.getOrderNo() + "'";

								boolean flag222 = audd.updateAuditing(hql221);
								boolean flag322 = audd.updateAuditing(hql222);
								boolean flag422 = audd.updateAuditing(hql322);
								if (flag222 && flag322 && flag422) {
									i = 1;
								}
							}
						}
			}
			//***************************************
			
					
				}
			}
			//审核拒绝的操作
			else {
				String hql1 = "update " + tab + " set " + afiled + "="
						+ aot.getAuditingFlag() + " where " + orderName
						+ "='" + aot.getOrderNo() + "'";
				boolean flag22 = audd.updateAuditing(hql1);
				if (flag22)
					i = 1;
			}
		}	
		return i;
	}
	public List someVerifyOrderEmployee(String addhql) {
		
		return audd.someVerifyOrderEmployee(addhql);
	}
	
	public boolean checkemp(String orderNo,String empid){
		boolean flag=false;
		List<AuditingOrderTab> alist=audd.someauditingOrder(" and orderNo='"+orderNo+"' and handlestate=1 and (incepttime='' or incepttime=null )");
		if(alist!=null && alist.size()>0)
		{

			for(int i=0;i<alist.size();i++)
			{
				if(alist.get(i).getEmployees().equals(empid))
				{
					flag=true;
				}
			}
		}
		return flag;
	}
	public boolean state(String tab,String orderNo,String order,String state)
	{	
		String hql="from "+tab+" where "+order+"='"+orderNo+"' and "+state+"=3";
		List list=new ArrayList();
		list=audd.state(hql);
		if(list.size()>0)
			return true;
		return false;
	}
	public boolean checkemp1(String orderNo,String empid){
		boolean flag=false;
		List alist=audd.someauditingOrder(" and orderNo='"+orderNo+"'");
		if(alist!=null && alist.size()>0){
			for(int j=0;j<alist.size();j++)
			{
				if(((AuditingOrderTab)alist.get(j)).getEmployees().equals(empid))
				{
					return flag=true;
					
				}
			}
		}
		return flag;
	}
	public boolean checkemp2(String rvid,String empid)
	{
		boolean flag=false;
		List alist=audd.someauditingOrder(" and rvid='"+rvid+"'");
		if(alist!=null && alist.size()>0){
			for(int j=0;j<alist.size();j++)
			{
				if(((AuditingOrderTab)alist.get(j)).getEmployees().equals(empid))
				{
					return flag=true;
				}
			}
		}
		return flag;
	}
	
	public boolean updatehql(String hql){
		boolean flag=false;
		flag=audd.updateAuditing(hql);
		return flag;
	}

	/**
	 * 获得某种类型单的单号集合
	 * @param orderType	 实体名
	 * @param empid		当前登录员工id
	 * @return
	 */
	public String getOrderNOList(String orderType,String empid ,String orderNo ,String state)
	{
		String str = "";
		List<VerifyOrder> orderlist = audd.execHQL(" from VerifyOrder where ordertype.aname = '"+orderType+"'");
		if(orderlist.size()>0)
		{
			String hql = " and  handlestate = "+state+" and verifyOrder.id = '"+orderlist.get(0).getId()+"' and employees like '%"+empid.trim()+"%'";
			if(orderNo!=null&&!orderNo.equals(""))
			{
				hql += " and orderNo like '%"+orderNo.trim()+"%'";
			}
			List<AuditingOrderTab> tablist = this.someauditingOrder(hql);
			if(tablist.size()>0)
			{
				for(int i=0;i<tablist.size();i++)
				{
					str += "'"+tablist.get(i).getOrderNo() + "',";
				}
			}
		}
		return str;
	}
	
	

	public List getObjectList(String entityName,String condition)
	{
		String hql = "from "+entityName+" where 1=1 "+condition;
		return audd.getObjectList(hql);
	}
	/**
	 * 0.该单据不存在审核机制 1.操作失败  2.添加审核机制成功
	 * 添加下架单
	 * @return
	 */
	public int addAuditingOrder(String otype,String oNo,String entityName,String filialemark){
		boolean flag=false;
		try
		{
			VerifyOrder ver=this.gettVerifyOrder(filialemark, otype);
			if(ver!=null){
				String allDepart=(ver.getDepartments());
				Object[] depId=allDepart.split(",");
				for(int i=0;i<depId.length;i++)
				{
					List<VerifyOrderEmployee> emplist = audd.execHQL(" from VerifyOrderEmployee where verifyOrder.id = "+ver.getId()+"  and department.id = "+Integer.parseInt(depId[i].toString()));
					List<VerifyOrder> orderlist = audd.execHQL(" from VerifyOrder where ordertype.aname = '"+entityName+"'");
					//获得部门
					Department dep=new Department();
					//dep.setId(Integer.parseInt(depId[i].toString()));
					List<Department> ll=audd.execHQL("from Department where id="+Integer.parseInt(depId[i].toString()));
					dep=ll.get(0);
					//获得AuditingOrderTab
					AuditingOrderTab aot=new AuditingOrderTab();
					aot.setAuditingFlag(0);
					aot.setAuditingOrder(i+1);
					aot.setDepartment(dep);
					aot.setOrderNo(oNo);
					
					aot.setMark("0");

					aot.setEmpOrdept("emp");

					aot.setSbh(UUID.randomUUID().toString());
					if(orderlist.size()>0)
					{
						aot.setVerifyOrder(orderlist.get(0));
					}
					if(i==0)
					{
						aot.setHandlestate(1);
					}
					else
					{
						aot.setHandlestate(0);
					}
					
					if(emplist.size()>0)
					{
						aot.setEmployees(emplist.get(0).getEmployees());
					}
					flag=audd.addAuditingOrder(aot);
				}
				if(flag)
					return 2;
				else
					return 1;
			}
			else
				return 0;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return 1;
		}
	}
	
	
	public int addAuditingOrder2(String otype,String oNo,String entityName,String filialemark){
		System.out.println("aaaaaaaaa");
		System.out.println(oNo);
		logg.info(oNo+entityName+filialemark);
		//定义查询出该种单据的审核流程列表hql
		String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='"+otype+"'";
		// 从部门审核里查询有没有
		String depthql=" from VerifyOrderDepartment where verifyOrder.ordertype.mark='"+otype+"'";
		//执行hql返回审核流程中的审核员工
		List<VerifyOrderEmployee> list = null;//
		List<VerifyOrderDepartment> deptlist=null;
		try{
			list = audd.execHQL(hql);
			deptlist=audd.execHQL(depthql);
		}catch(Exception e){
			e.printStackTrace();
		}
		//如果list为null表示该种类型的单据无需审核
		if(null == list && list.size()<=0 && deptlist==null && deptlist.size()<=0){
			return 0;
			//如果审核流程不为null则向审核表中插入数据
		}else{
			if(list!=null && list.size()>0){
				String aa="0";
				for(int i=0; i<list.size(); i++){					
					//创建审核表对象
					AuditingOrderTab aot = new AuditingOrderTab();					
					aot.setAuditingFlag(0);
					aot.setAuditingOrder(Integer.parseInt(list.get(i).getOrderVerify()));
					aot.setDepartment(list.get(i).getDepartment());
					aot.setOrderNo(oNo);
					aot.setMark(list.get(i).getVerifyState());
					aot.setEmployees(list.get(i).getEmployees());
					TimePattern tp=new TimePattern();
					Date date=new Date();
					String nowtime=tp.doTimeDf3(date);
					aot.setAuditingtime(Timestamp.valueOf(nowtime));
					aot.setEmpOrdept("emp");
					aot.setPrice(0d);
					if(i==0 ||list.get(i).getOrderVerify().equals(aa))
					{
						aot.setHandlestate(1);
						aa=list.get(i).getOrderVerify();
					}
					else
					{
						aot.setHandlestate(0);
					}
					audd.addAuditingOrder(aot);
				}			
			}
			if(deptlist!=null && deptlist.size()>0){
				String aa="0";
				for(int i=0; i<deptlist.size(); i++){					
					//创建审核表对象
					AuditingOrderTab aot = new AuditingOrderTab();					
					aot.setAuditingFlag(0);
					aot.setAuditingOrder(Integer.parseInt(deptlist.get(i).getOrderVerify()));
					aot.setDepartment(deptlist.get(i).getDepartment());
					aot.setOrderNo(oNo);
					aot.setMark(deptlist.get(i).getVerifyState());
					// 如果是部门审核则接收人就是部门主管或是授权后的人。
					Employee employee=new Employee();
					int deptid=deptlist.get(i).getDepartment().getId();
					Department dept =(Department) audd.getObj(Department.class, deptid);
					// 首先要判断的是这个部门有没有给授权？
					// 找到当前采购单所属类型
					Docmark docmark=audd.typeBymark("PurOrder");
					OperationEmployeematch operemp=audd.operEmp(docmark.getOtype(), dept.getId());
					if(operemp.getEmployee()!=null){
						employee=operemp.getEmployee();// 得到授权以后的人员
					}
					else{
						employee=dept.getEmployee();
					}
					aot.setEmployees(employee.getId()+"");
					TimePattern tp=new TimePattern();
					Date date=new Date();
					String nowtime=tp.doTimeDf3(date);
					aot.setAuditingtime(Timestamp.valueOf(nowtime));
					aot.setEmpOrdept("dept");
					aot.setPrice(0d);
					if(i==0 ||deptlist.get(i).getOrderVerify().equals(aa))
					{
						aot.setHandlestate(1);
						aa=deptlist.get(i).getOrderVerify();
					}
					else
					{
						aot.setHandlestate(0);
					}
					audd.addAuditingOrder(aot);
				}
			}
			return 2;
		}
	}
	
	/**
	 * 审核流程---公告模块
	 * @author 袁天龙
	 * @param otype
	 * @param oNo
	 * @param entityName
	 * @param filialemark
	 * @return
	 */
	public int addAuditingOrderNotice(String otype,String oNo,String entityName,String filialemark){
		System.out.println("aaaaaaaaa");
		System.out.println(oNo);

		//定义查询出该种单据的审核流程列表hql
		String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='"+otype+"'";
		// 从部门审核里查询有没有
		String depthql=" from VerifyOrderDepartment where verifyOrder.ordertype.mark='"+otype+"'";
		//执行hql返回审核流程中的审核员工
		List<VerifyOrderEmployee> list = null;//
		List<VerifyOrderDepartment> deptlist=null;
		try{
			list = audd.execHQL(hql);
			deptlist=audd.execHQL(depthql);
		}catch(Exception e){
			e.printStackTrace();
		}
		//如果list为null表示该种类型的单据无需审核
		if(null == list && list.size()<=0 && deptlist==null && deptlist.size()<=0){
			return 0;
			//如果审核流程不为null则向审核表中插入数据
		}else{
			if(list!=null && list.size()>0){
				String aa="0";
				for(int i=0; i<list.size(); i++){					
					//创建审核表对象
					AuditingOrderTab aot = new AuditingOrderTab();					
					aot.setAuditingFlag(0);
					aot.setAuditingOrder(Integer.parseInt(list.get(i).getOrderVerify()));
					aot.setDepartment(list.get(i).getDepartment());
					aot.setOrderNo(oNo);
					aot.setMark(list.get(i).getVerifyState());
					aot.setEmployees(list.get(i).getEmployees());
					TimePattern tp=new TimePattern();
					Date date=new Date();
					String nowtime=tp.doTimeDf3(date);
					aot.setAuditingtime(Timestamp.valueOf(nowtime));
					aot.setEmpOrdept("emp");
					aot.setPrice(0d);
					if(i==0 ||list.get(i).getOrderVerify().equals(aa))
					{
						aot.setHandlestate(1);
						aa=list.get(i).getOrderVerify();
					}
					else
					{
						aot.setHandlestate(0);
					}
					audd.addAuditingOrder(aot);
				}			
			}
			if(deptlist!=null && deptlist.size()>0){
				String aa="0";
				for(int i=0; i<deptlist.size(); i++){					
					//创建审核表对象
					AuditingOrderTab aot = new AuditingOrderTab();					
					aot.setAuditingFlag(0);
					aot.setAuditingOrder(Integer.parseInt(deptlist.get(i).getOrderVerify()));
					aot.setDepartment(deptlist.get(i).getDepartment());
					aot.setOrderNo(oNo);
					aot.setMark(deptlist.get(i).getVerifyState());
					// 如果是部门审核则接收人就是部门主管或是授权后的人。
					Employee employee=new Employee();
					int deptid=deptlist.get(i).getDepartment().getId();
					Department dept =(Department) audd.getObj(Department.class, deptid);
					// 首先要判断的是这个部门有没有给授权？
					// 找到当前采购单所属类型
					Docmark docmark=audd.typeBymark("PurOrder");
					OperationEmployeematch operemp=audd.operEmp(docmark.getOtype(), dept.getId());
					if(operemp.getEmployee()!=null){
						employee=operemp.getEmployee();// 得到授权以后的人员
					}
					else{
						employee=dept.getEmployee();
					}
					aot.setEmployees(employee.getId()+"");
					TimePattern tp=new TimePattern();
					Date date=new Date();
					String nowtime=tp.doTimeDf3(date);
					aot.setAuditingtime(Timestamp.valueOf(nowtime));
					aot.setEmpOrdept("dept");
					aot.setPrice(0d);
					if(i==0 ||deptlist.get(i).getOrderVerify().equals(aa))
					{
						aot.setHandlestate(1);
						aa=deptlist.get(i).getOrderVerify();
					}
					else
					{
						aot.setHandlestate(0);
					}
					audd.addAuditingOrder(aot);
				}
			}
			return 2;
		}
	}
	
	
	
	/*
	 * 资源核实单
	 * 王雄
	 * email：wangxiong@fuao.com
	 */
	public int addAuditingOrderRC(String otype,String rcid,String entityName1,String filialemark){
		System.out.println("aaaaaaaaa");
		
		//定义查询出该种单据的审核流程列表hql
		String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='"+otype+"'";
		//执行hql返回审核流程中的审核员工
		List<VerifyOrderEmployee> list = null;
		try{
			list = audd.execHQL(hql);
		}catch(Exception e){
			e.printStackTrace();
		}
		//如果list为null表示该种类型的单据无需审核
		if(null == list || list.size()<=0){
			return 0;
			//如果审核流程不为null则向审核表中插入数据
		}else{
			String aa="0";
			for(int i=0; i<list.size(); i++){
				
				//创建审核表对象
				AuditingOrderTab aot = new AuditingOrderTab();
				
				aot.setAuditingFlag(0);
				aot.setAuditingOrder(Integer.parseInt(list.get(i).getOrderVerify()));
				aot.setDepartment(list.get(i).getDepartment());
				aot.setRvid(rcid);
				aot.setMark(list.get(i).getVerifyState());
				aot.setEmployees(list.get(i).getEmployees());
				if(i==0 ||list.get(i).getOrderVerify().equals(aa))
				{
					aot.setHandlestate(1);
					aa=list.get(i).getOrderVerify();
				}
				else
				{
					aot.setHandlestate(0);
				}
				audd.addAuditingOrder(aot);
			}
			
			return 2;
			}				
	}
	/**
	 * 日子模块的审批流程添加
	 * @param otype
	 * @param oNo
	 * @param entityName
	 * @param filialemark
	 * @return
	 */
	public int addAuditingOrder3(Employee emp,String oNo,String entityName,String filialemark){
		int marker = 2;
		logg.error("aaaaaaaaa");
		//是否审核 如果需要审核 则提醒上级必须审核 暂时不考虑
		//获得他上级 如果是普通员工-> 当前部门主管审核 如果部门主管-> 部门的上级部门主管审核
		//上上级是否需要审核则在此人登陆时进行判断 
		int deptid = emp.getDepartment().getId();//获得部门id
		List list = audd.execHQL("from Department where 1=1  and delflag = 0 and  id="+deptid);
//		List list = formbiz.getForm("Department", " and delflag = 0 and  id="+deptid);
		Department  dept  = null;
		if(list != null && list.size()>0){
		  dept = (Department)list.get(0);
		  Employee manager = dept.getEmployee();
//		  logg.info("1workinfo:"+manager);
//		  logg.info("2workinfo:"+manager.getIsLeave());
//		  logg.info("3workinfo:"+manager.getId());
		  if(manager == null || manager.getIsLeave() == 0 || manager.getId().equals(emp.getId())){
			  logg.error("log if.................");
			  //该部门没有主管 或者部门有主管 不过主管已离职 或者主管是你
			  list = audd.execHQL("from Department where 1=1  and delflag = 0 and  id="+dept.getParentId());
			  if( list !=null && list.size()>0){
			  dept  = (Department)list.get(0);
			  manager = getDeptMananger(dept);
			  if(manager != null && manager.getId()!=null && manager.getId()>0){
				//创建审核表对象
					AuditingOrderTab aot = new AuditingOrderTab();
					
					aot.setAuditingFlag(0);
					aot.setAuditingOrder(1);
					aot.setDepartment(dept);
					aot.setOrderNo(oNo);
					aot.setMark("0");//默认0一人审核
					aot.setEmployees(manager.getId().toString());
//					logg.info("4workinfo:"+manager.getId());
					aot.setHandlestate(1);
					TimePattern tp=new TimePattern();
					Date date=new Date();
					String nowtime=tp.doTimeDf3(date);
					aot.setIncepttime(Timestamp.valueOf(nowtime));
					aot.setEmployeeByInceptemp(manager);
					audd.addAuditingOrder(aot);
			  }
			  }else{
				  //没有父部门了 错误
				  logg.info("无上级部门");
				  marker = 1;
			  }
			  
		  }else{
			  AuditingOrderTab aot = new AuditingOrderTab();
				
				aot.setAuditingFlag(0);
				aot.setAuditingOrder(1);
				aot.setDepartment(dept);
				aot.setOrderNo(oNo);
				aot.setMark("0");//默认0一人审核
				aot.setEmployees(manager.getId().toString());
//				logg.info("4workinfo:"+manager.getId());
				aot.setHandlestate(1);
				TimePattern tp=new TimePattern();
				Date date=new Date();
				String nowtime=tp.doTimeDf3(date);
				aot.setIncepttime(Timestamp.valueOf(nowtime));
				aot.setEmployeeByInceptemp(manager);
				audd.addAuditingOrder(aot);
				logg.error("log else.................");
		  }
		}else{
			//该部门不存在
			logg.info("员工部门不存在");
			 marker = 1;
		}
		logg.error("log end.................");
			return marker;
	}
	public void addAuditingOrder(AuditingOrderTab aot){
		audd.addAuditingOrder(aot);
	}
	/**
	 * lzy modifies 2013-5-21
	 * 由于权限由角色变更为岗位 主管的定义也随之变更 
	 * 旧部门主管定义 dept.getEmployee() 去部门表查
	 * 新部门主管定义 担任该部门主管岗位的员工(只有一个)
	 * @param dept
	 * @return
	 */
	private Employee getDeptMananger(Department dept) {
		
		Employee manager = dept.getEmployee();
		if(manager != null && manager.getIsLeave() != 0){
			
		}else{
			List list = audd.execHQL("from Department where 1=1  and delflag = 0 and  id="+dept.getParentId());
			if(list != null && list.size()>0){
			dept  = (Department)list.get(0);
			getDeptMananger(dept);
			}else{
				logg.info("无上级部门!");
			}
		}
		return manager;
	}
	
	/***
	 * 根据编号得到对象
	 */
	public Object getObj(Class clazz,Integer id){
		return audd.getObj(clazz, id);
	}
	
	/**********
	 * 根据采购单去查找审核类型
	 */
	public Docmark typeBymark(String mark){
		return audd.typeBymark(mark);
	}
	
	/***********
	 * 根据业务类型，当前登录人，单据标识对象查找得到员工审核业务对象
	 */
	public OperationEmployeematch getOper(Docmark docmark,int empid){
		return audd.operByemp(Integer.parseInt(docmark.getOtype()), empid);
	}
	/**
	 * 根据业务类型与员工编号得到OperationDepartmentmatch对象
	 */
	public OperationDepartmentmatch operBydept(int typeid,int empid){
		return audd.operBydept(typeid, empid);
	}
	/***********
	 * 根据订单编号和表查找出对应的审核金额，暂时只用purorder表做示例.
	 */
	public double objByprice(String tab,String orderNo,String orderName,String priceFiled){
		return audd.objByprice(tab, orderNo,orderName,priceFiled);
	}
	
	/*****************
	 * 得到月，季，半年，年金额，员工
	 */
	public Map<String, Double> yjnByemp(int empid){
		return audd.yjnByemp(empid);
	}
	/*****************
	 * 得到月，季，半年，年金额，部门
	 */
	public Map<String, Double> yjnBydept(int empid){
		return audd.yjnBydept(empid);
	}
	/************
	 * 找到员工每月，年，半年，季度的业务审核金额
	 */
	public Map<String, Double> empByprice(OperationEmployeematch operemp){
		return audd.empByprice(operemp);
	}
	/************
	 * 找到部门每月，年，半年，季度的业务审核金额
	 */
	public Map<String, Double> deptByprice(OperationDepartmentmatch operdept){
		return audd.deptByprice(operdept);
	}
	/********
	 * 根据当前登录人找到主管编号
	 */
	public String getZG(int empid){
		return audd.getZG(empid);
	}

	public Object updAllObj(Object obj) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public List getAll(String hql){
		return audd.getAll(hql);
	}
	public void updObj(Object obj){
		audd.updObj(obj);
	}

	public void add(Object obj) {
		try {
			audd.add(obj);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
