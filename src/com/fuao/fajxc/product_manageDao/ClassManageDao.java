package com.fuao.fajxc.product_manageDao;

import java.util.List;

import com.fuao.fajxc.util.Page;
import com.fuao.fajxc.util.Pager;

public interface ClassManageDao extends product_CommentDao{
      
	public Page doSplit(int pageNo, int pagesize);
	public Page doSplit(int pageNo,int pagesize,String name);
	
}
