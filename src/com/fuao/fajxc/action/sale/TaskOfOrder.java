package com.fuao.fajxc.action.sale;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;

import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.AllType;
import com.fuao.fajxc.vo.Reminders;
import com.fuao.fajxc.vo.SaleOrder;

public class TaskOfOrder extends TimerTask{
	private BaseDao basedao;
	private HttpServletRequest request;
	@Override
	public void run() {
		//取出月付的客户
		String sql1 = "select e.name, datediff(endtime,begintime) from saleorder s,employee e where s.pay_style=15 and s.empid=e.id";
		//季付
//		String hql2 = "select datediff(endtime,begintime) from saleorder s where s.pay_style=16";
//		//半年付
//		String hql3 = "select datediff(endtime,begintime) from saleorder s where s.pay_style=17";
//		//年付
//		String hql4 = "select datediff(endtime,begintime) from saleorder s where s.pay_style=18";
		List list1 = basedao.execSQL(sql1);	
		String username = list1.get(0).toString();  //订单到期的用户名
		int ts = (Integer)list1.get(1);  //距离订单到期的天数
		if(ts>=23 && ts<=30){ // 提前一周提醒客户			
//			Reminders re = new Reminders();
//			re.setName("客户订单即将到期");
//			re.setEnitName("SaleOrder");
//			re.setNumber("list1.size()");
//			re.setIds(list1.toString());
//			listOrder.add(re);
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("ts", ts);
		}
	}
	
	public BaseDao getBasedao() {
		return basedao;
	}
	public void setBasedao(BaseDao basedao) {
		this.basedao = basedao;
	}
}
