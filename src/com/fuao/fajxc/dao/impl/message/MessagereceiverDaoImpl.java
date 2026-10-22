package com.fuao.fajxc.dao.impl.message;
import java.util.List;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.message.MessagereceiverDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messagereceiver;

public class MessagereceiverDaoImpl extends BaseDaoImpl implements MessagereceiverDao{

	public boolean addData(Messagereceiver data) throws Exception {
		super.add(data);
		return true;
	}

	public List<Messagereceiver> exHql(String hql) {
		List<Messagereceiver> datas=null;
		try {
		datas=super.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public Messagereceiver getMessagereceiverdata(String id) {
		try {
			return (Messagereceiver) super.select(Messagereceiver.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(Messagereceiver data)throws Exception  {
			super.update(data);
			return true;
	}
	
}
