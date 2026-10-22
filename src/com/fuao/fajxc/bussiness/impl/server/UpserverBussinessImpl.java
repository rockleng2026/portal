package com.fuao.fajxc.bussiness.impl.server;

import java.util.Iterator;
import java.util.List;
import java.util.ResourceBundle;

import com.fuao.fajxc.bussiness.server.UpserverBussiness;
import com.fuao.fajxc.dao.server.UpserverDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.UpServer;

public class UpserverBussinessImpl implements UpserverBussiness {

	private UpserverDao upd;
	private ResourceBundle rb = ResourceBundle.getBundle("proper");
	
	
	
	public UpserverDao getUpd() {
		return upd;
	}

	public void setUpd(UpserverDao upd) {
		this.upd = upd;
	}

	/**
	 * 增加上架单
	 * 
	 * 最后发现----增加上架单、修改上架单、删除上架单时，不需要相互绑定，只要设置使用状态
	 * 只有在----执行上架时，才进行相互绑定，
	 * */
	public boolean addupServer(UpServer us) {
		boolean flag=false;
		try
		{
			us.setUpFlag(0);
			flag=upd.addupServer(us);
			if(flag){
				//设置商品（服务器、零件、IP）的使用状态    1，使用   2，未使用，  3，入库未审核    4.出库未审核   5.已审核但商品没有动
				//增加上架单，即商品的状态为   出库未审核
				String hql=" update Product set usestate=4 where id="+us.getProduct().getId()+" or parentId="+us.getProduct().getId();
				flag=upd.executeHql(hql);
				//设置订单状态
				String salehql = " update SaleOrder set auditingState = 2 where saleOrderNo = '"+us.getSaleOrder().getSaleOrderNo()+"'";
				flag = upd.executeHql(salehql);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	/**
	 * 增加上架单
	 * 
	 * 最后发现----增加上架单、修改上架单、删除上架单时，不需要相互绑定，只要设置使用状态
	 * 只有在----执行上架时，才进行相互绑定，
	 * */
	public UpServer addReturnUpServer(UpServer us) {
		PropertyEditor proEdit=new PropertyEditor();
		UpServer upServer = null;
		boolean flag = false;
		try
		{
			us.setUpFlag(0);
			//System.out.println(us.getSaleOrder().getId());
			upServer = (UpServer) upd.addReturnObject(us);
			
			if(null != upServer){
				//设置商品（服务器、零件）的使用状态    1，使用   2，未使用，  3，入库未审核    4.出库未审核   5.已审核但商品没有动
				//增加上架单，即商品的状态为   出库未审核
				//上架成功后设置服务器为使用状态(vps服务器单独处理) 
//				String hqll=" from Product p where p.property.model.commodityTpye.id='"+Integer.parseInt((String)proEdit.getID("vpsid"))+"'";
//				Boolean flag1=true;
//				List<Product> p=upd.execHQL(hqll);
//				for(int i=0;i<p.size();i++)
//				{
//					System.out.println(us.getProduct().getId());
//					System.out.println(p.get(i).getId());
//				if(us.getProduct().getId().equals(p.get(i).getId()))
//				{
//					 flag1=false;
//					 break;
//				}
//				}
//				if(flag1)
//				{
////					产品状态等到审核通过后才置为使用状态
////					String hql=" update Product set usestate=4 where id="+us.getProduct().getId()+" or parentId="+us.getProduct().getId();
////					flag = upd.executeHql(hql);
//				}
				//设置订单状态
				String salehql = " update Sale_orders set soCheckStat = 1  where  soNums = '"+us.getSoOrders().getSoNums()+"'";
				flag = upd.executeHql(salehql);
				
			}
//			if(flag == false){
//				return null;
//			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			return null;
		}
		return upServer;
	}
	
	/**
	 * 删除上架单
	 * 如果已经上架，则直接标记删除
	 * 如果没有上架，则要修改商品属性
	 * */
	public boolean delupServer(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return upd.delupServer(obj);
	}
	
	/**
	 * 修改上架单
	 *    ipidflag 是ip在商品属性里的标记，
	 * @throws Exception 
	 * */
	public boolean editupServer(UpServer us)  {
		// TODO Auto-generated method stub
		//先取得数据库的原始数据，与更新数据进行比较
//		UpServer oldus=(UpServer)upd.execHQL(" from UpServer where id="+us.getId());
//		oldus.setMarknum(null);
//		upd.addupServer(oldus);
		///服务器ID查找
		List<Integer> oli=upd.execHQL(" select u.product.id  from UpServer u where u.id="+us.getId());
		Integer olproid=0;
		if(oli!=null)
			olproid=oli.get(0);

		//判断服务器有没有修改    有
		if(olproid!=us.getProduct().getId())
		{
			///服务器，组装服务器的零件不解绑        设置使用状态
			String hql2=" update Product set usestate=2 where id="+olproid+" or parentId="+olproid;
			upd.executeHql(hql2);
			//2.再重新         设置使用状态
			String hql1=" update Product set usestate=1 where id="+us.getProduct().getId()+" or parentId="+us.getProduct().getId();
			upd.executeHql(hql1);
		}
		try {
			UpServer uServer=upd.upmerger(us);
			String arr[] = uServer.getServerIp().split(",");
			for (String string : arr) {
				List list = this.findByIPs("from IPConfiguration p where p.ipcaddress='"+string+"'");
				for (Iterator iterator = list.iterator(); iterator.hasNext();) {
					IPConfiguration ips = (IPConfiguration) iterator.next();
					ips.setUpNo(uServer);
					ips.setIpcstate(1+"");
					upd.updIPs(ips);
				}
			}
			if(uServer!=null){
				return true;
			}else{
				return false;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return upd.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List someupServer(String addhql) {
		// TODO Auto-generated method stub
		return upd.someupServer(addhql);
	}

	/**
	 * 上架单服务器执行上架
	 * */
	public boolean executeUpserver(String proId,String upId) {
		PropertyEditor proEdit=new PropertyEditor();
		///设置服务器商品属性
		//1.把上架单设置属性   2.先把ip和服务器绑定           3.把服务器和机房地址绑定        4.服务器等  useSum=useSum+1 , usestate=1 
		boolean flag=false;
		try
		{
			//1.把上架单设置属性 暂无  
			boolean flag1=false;
		
			// 2.先把ip和服务器绑定 
			UpServer ups=(UpServer)upd.execHQL(" from UpServer  where  id="+upId).get(0);
			// 3.把服务器和机房地址绑定 暂无
			System.out.println(ups.getServerLocation());
			String hqll=" from Product p where id="+proId+"";
			List<Product> p=upd.execHQL(hqll);
			if(p.size()>0)
			{
				String hql=" update UpServer set upFlag=1 where id="+upId;
				flag1=upd.executeHql(hql);	
			Product  serverroom=p.get(0);
			System.out.println(serverroom.getId());
			upd.executeHql(" update Product set parentId="+serverroom.getId()+"  where id="+proId); 
			// 4.服务器等  useSum=useSum+1 , usestate=1 
			
			if(flag1){
				String vpsid=(String) proEdit.getID("vpsid");
				String vid=serverroom.getProperty().getModel().getCommodityTpye().getId()+"";
				if(vpsid.equals(vid))
				{
					boolean flag2=false;
					String hql1="update Product set useSum=useSum+1  where id="+proId+"  or  parentId="+proId;
					flag2=upd.executeHql(hql1);
					if(flag2)
					{
						flag=true;
					}
				}
				else
				{
					boolean flag2=false;
					String hql1="update Product set useSum=useSum+1 , usestate=1  where id="+proId+"  or  parentId="+proId;
					flag2=upd.executeHql(hql1);
					if(flag2)
					{
						flag=true;
					}
				}
			}
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean executeHql(String hql) {
		boolean flag = upd.executeHql(hql);
		return flag;
		
	}

	public List findByIPs(String hql) {
	
		return upd.findByIPs(hql);
	}

	public void updIPs(IPConfiguration ipc) {
		upd.updIPs(ipc);
		
	}
	
	/**
	 * 根据仓库id查询其下面的服务器
	 * @author 袁天龙 
	 * 2012-12-12
	 */
	public List getServersByDepotid(int depotid) {
		return upd.getServersByDepotid(depotid);
	}

	/**
     * 根据机房id查询机柜信息
     * @author 袁天龙
     * 2012-12-12
     * @param cabinetid
     * @return
     */
	public List getCabinetByElecthouse(int cabinetid) {
		return upd.getCabinetByElecthouse(cabinetid);
	}
	
	public List getCustomers(){
		return upd.getCustomers();
	}

	public List getElectHouse() {
		return upd.getElectHouse();
	}
	
	public List getSaleorderBySaleorderId(int saleorderId){
		return upd.getSaleorderBySaleorderId(saleorderId);
	}
	
	public Object getCustomerByPK(Class clazz,int customerid){
		return upd.getCustomerByPK(clazz, customerid);
	}
	
	public void addUpserver(Object obj){
		upd.addUpserver(obj);
	}
	
	public List getAll(String hql){
		return upd.getAll(hql);
	}
	
	public Object getObjectById(Class clazz,Integer id){
		return upd.getObjectById(clazz, id);
	}
	
	public List getUpserverByServerId(int serverid){
		return upd.getUpserverByServerId(serverid);
	}
	
	/**
	 * 根据上架单号查询对象
	 */
	public List getUpserverByUpNo(String upNo){
		return upd.getUpserverByUpNo(upNo);
	}
	
	public void updateObj(Object obj){
		upd.updateObj(obj);
	}
	
	public boolean updObject(Object obj){
		upd.updObject(obj);
		return true;
	}

	public List exeHql(String prohql2) {
		// TODO Auto-generated method stub
		return upd.execHQL(prohql2);
	}
}
