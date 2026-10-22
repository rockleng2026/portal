package com.fuao.fajxc.dao.impl.message;
import java.util.List;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.message.MessagetypeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messagetype;

public class MessagetypeDaoImpl extends BaseDaoImpl implements MessagetypeDao{

	public boolean addData(Messagetype data) throws Exception {
		super.add(data);
		return true;
	}

	public List<Messagetype> exHql(String hql) {
		List<Messagetype> datas=null;
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

	public Messagetype getMessagetypedata(String id) {
		try {
			return (Messagetype) super.select(Messagetype.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(Messagetype data)throws Exception  {
			super.update(data);
			return true;
	}
	
}
