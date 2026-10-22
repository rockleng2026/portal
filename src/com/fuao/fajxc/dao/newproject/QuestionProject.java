package com.fuao.fajxc.dao.newproject;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewProblem;
import com.fuao.fajxc.vo.NewQuestion;

/*******
 * 项目问题处理。
 * @author wangxiong
 * Email :wangxiong@fuaotech.com
 * 
 */

public interface QuestionProject {
	
	// 创建问题
	public List select();
	
	//查询已经已经在进行中的项目
	public List findBynewPro();
	
	//分页
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	//查询所有的邀请人（以邀请成功的人s）
	public List findByPart();
	
	//查询每个问题的所有评论
	public List getObject(String tableName,Integer id);
	public List getObject2(String tableName,Integer id);

	//添加一个评论
	public boolean saveProblem(NewProblem newProblem);
	
	//通用查询List
	public List findObj(String hql);
	public String findObj1();
	
	//根据ID查询一个List
	public List findById(Integer id);
	//查询回复数

	public List findByCount(Integer id);
	
	public List findByCount1(Integer id);
	
	//添加项目问题
	public boolean saveQuestion(NewQuestion newQuestion);
	
//	/修改项目问题
	public boolean updateQuestion(NewQuestion newQuestion);
	
	//删除项目问题
	public boolean del(NewQuestion newQuestion);

	//提交问题
	public boolean updatastate(Integer state,Integer questid);
	
	//查询评论次数
	public Integer findBycount(Integer questid);
	
	//修改浏览次数
	public boolean updatequsetion(Integer count,Integer id);
	
	//历史记录
	public List findByAll();
	//查询出功能下任务
	public List findBytask(String id);
	
	//查询单个function
	public NewFunction findfunction(String entityName,Integer id);
	/************
	 * 根据任务编号得到对象
	 */
	public Object getObj(Class clazz,Integer id);
}
