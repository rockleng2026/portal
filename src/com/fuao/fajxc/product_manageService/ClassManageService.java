package com.fuao.fajxc.product_manageService;

import com.fuao.fajxc.util.Page;
import com.fuao.fajxc.util.Pager;
import com.fuao.fajxc.vo.GoodsClass_expand;

public interface ClassManageService extends product_CommentService{
     
	public String createCodes(String codes,String supers);
	public GoodsClass_expand comentContent(String jsonStr);
	public Page doSplit(int pageNo,int pagesize);
	public Page doSplit(int pageNo,int pagesize,String name);
}
